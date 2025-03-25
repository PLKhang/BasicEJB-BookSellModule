/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/J2EE/EJB30/StatelessEjbClass.java to edit this template
 */
package bookstore.service;

import bookstore.dao.CartDAO;
import bookstore.dao.CartDetailDAO;
import bookstore.entity.Book;
import bookstore.entity.Cart;
import bookstore.entity.CartDetail;
import bookstore.entity.Customer;
import java.util.ArrayList;
import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.ejb.LocalBean;
import javax.ejb.Remove;
import javax.ejb.Stateful;

/**
 *
 * @author pkstr
 */
@Stateful
@LocalBean
public class CartService {

    @EJB
    private CartDAO cartDAO;

    @EJB
    private CartDetailDAO cartDetailDAO;

    @EJB
    private BookService bookService; // Assuming this exists to fetch Book

    private Cart cart; // Holds the cart in memory during session

    /**
     * Initializes or retrieves the cart for the customer. Loads from DB if exists, otherwise
     * creates a new in-memory cart.
     */
    public void initializeCart(Customer customer) {
        if (customer == null) {
            throw new IllegalArgumentException("Customer cannot be null");
        }
        // Check if cart exists in DB
        cart = cartDAO.findByCustomerId(customer.getId());
        if (cart == null) {
            // Create new in-memory cart
            cart = new Cart(customer, 0.0);
            cart.setCartDetails(new ArrayList<>());
        }
    }

    /**
     * Adds a new item to the cart (in memory). Updates total price in memory.
     *
     * @param bookId The ID of the book to add
     * @param quantity The quantity to add
     */
    public void addItemToCart(Long bookId, int quantity) {
        if (cart == null) {
            throw new IllegalStateException("Cart not initialized. Call initializeCart first.");
        }
        if (bookId == null || quantity <= 0) {
            throw new IllegalArgumentException("Invalid bookId or quantity");
        }

        Book book = bookService.getBookById(bookId);
        if (book == null) {
            throw new IllegalArgumentException("Book with ID " + bookId + " not found");
        }

        // Check if book already exists in cart
        CartDetail existingDetail = findCartDetailByBookId(bookId);
        if (existingDetail != null) {
            // Update quantity if item exists
            existingDetail.setQuantity(existingDetail.getQuantity() + quantity);
        } else {
            // Add new CartDetail
            CartDetail newDetail = new CartDetail(cart, book, quantity);
            cart.getCartDetails().add(newDetail);
        }

        // Update total price in memory
        updateTotalPrice();
    }

    /**
     * Updates the quantity of an existing CartDetail (in memory). Removes the item if quantity
     * becomes 0 or less.
     *
     * @param bookId The ID of the book to update
     * @param quantityChange The amount to change (+1 or -1)
     */
    public void updateItemQuantity(Long bookId, int quantityChange) {
        if (cart == null) {
            throw new IllegalStateException("Cart not initialized. Call initializeCart first.");
        }

        CartDetail detail = findCartDetailByBookId(bookId);
        if (detail == null) {
            throw new IllegalArgumentException("Item with book ID " + bookId + " not found in cart");
        }

        int newQuantity = detail.getQuantity() + quantityChange;
        if (newQuantity <= 0) {
            cart.getCartDetails().remove(detail);
        } else {
            detail.setQuantity(newQuantity);
        }

        // Update total price in memory
        updateTotalPrice();
    }

    public void removeItem(Long bookId) {
        if (cart == null) {
            throw new IllegalStateException("Cart not initialized. Call initializeCart first.");
        }

        CartDetail detail = findCartDetailByBookId(bookId);
        if (detail == null) {
            throw new IllegalArgumentException("Item with book ID " + bookId + " not found in cart");
        }

        cart.getCartDetails().remove(detail);

        // Update total price in memory
        updateTotalPrice();
    }

    /**
     * Gets the current cart (in memory).
     *
     * @return
     */
    public Cart getCart() {
        return cart;
    }

    /**
     * Persists the cart and its details to the database when session ends.
     */
    @Remove
    public void saveAndDestroy() {
        if (cart != null) {
            if (cartDAO.findByCustomerId(cart.getCustomer().getId()) == null) {
                // New cart: persist it
                cartDAO.create(cart);
            } else {
                // Existing cart: update it
                cartDAO.update(cart);
            }
            // Note: CartDetails are automatically persisted due to cascade = CascadeType.ALL
        }
    }

    /**
     * Helper method to find CartDetail by bookId in memory.
     */
    private CartDetail findCartDetailByBookId(Long bookId) {
        if (cart.getCartDetails() != null) {
            for (CartDetail detail : cart.getCartDetails()) {
                if (detail.getBook().getId().equals(bookId)) {
                    return detail;
                }
            }
        }
        return null;
    }

    /**
     * Updates the total price of the cart in memory.
     */
    private void updateTotalPrice() {
        double total = 0.0;
        if (cart.getCartDetails() != null) {
            for (CartDetail detail : cart.getCartDetails()) {
                total += detail.calculateSubtotal();
            }
        }
        cart.setTotalPrice(total);
    }

    public int getItemQuantity(Long bookId) {
        CartDetail detail = findCartDetailByBookId(bookId);
        if (detail == null) {
            return 0;
        }
        
        return detail.getQuantity();
    }
}
