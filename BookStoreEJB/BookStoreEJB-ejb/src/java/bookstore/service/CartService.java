package bookstore.service;

import bookstore.dao.CartDAO;
import bookstore.dao.CartDetailDAO;
import bookstore.entity.Book;
import bookstore.entity.Cart;
import bookstore.entity.CartDetail;
import bookstore.entity.Customer;
import java.util.ArrayList;
import javax.ejb.Stateless;
import javax.inject.Inject;

/**
 * Stateless EJB to manage Cart operations. All changes are persisted to the database immediately.
 */
@Stateless
public class CartService {

    @Inject
    private CartDAO cartDAO;

    @Inject
    private CartDetailDAO cartDetailDAO;

    @Inject
    private BookService bookService; // Assuming this exists to fetch Book

    /**
     * Gets or creates a Cart for the customer.
     *
     * @param customer The customer whose cart is needed
     * @return The customer's Cart
     */
    public Cart getOrCreateCart(Customer customer) {
        if (customer == null) {
            throw new IllegalArgumentException("Customer cannot be null");
        }

        Cart cart = cartDAO.findByCustomerId(customer.getId());
        if (cart == null) {
            cart = new Cart(customer, 0.0);
            cart.setCartDetails(new ArrayList<>());
            cartDAO.create(cart);
        }
        return cart;
    }

    /**
     * Adds a new item to the customer's cart.
     *
     * @param customer The customer
     * @param bookId The ID of the book to add
     * @param quantity The quantity to add
     */
    public void addItemToCart(Customer customer, Long bookId, int quantity) {
        if (customer == null || bookId == null || quantity <= 0) {
            throw new IllegalArgumentException("Invalid customer, bookId, or quantity");
        }

        Cart cart = getOrCreateCart(customer);
        Book book = bookService.getBookById(bookId);
        if (book == null) {
            throw new IllegalArgumentException("Book with ID " + bookId + " not found");
        }

        // Check if book already exists in cart
        CartDetail existingDetail = findCartDetailByBookId(cart, bookId);
        if (existingDetail != null) {
            existingDetail.setQuantity(existingDetail.getQuantity() + quantity);
            cartDetailDAO.update(existingDetail);
        } else {
            CartDetail newDetail = new CartDetail(cart, book, quantity);
            cart.getCartDetails().add(newDetail);
            cartDetailDAO.create(newDetail);
        }

        updateTotalPrice(cart);
        cartDAO.update(cart);
    }

    /**
     * Updates the quantity of an item in the customer's cart.
     *
     * @param customer The customer
     * @param bookId The ID of the book to update
     * @param quantityChange The amount to change (+1 or -1)
     */
    public void updateItemQuantity(Customer customer, Long bookId, int quantityChange) {
        if (customer == null || bookId == null) {
            throw new IllegalArgumentException("Customer or bookId cannot be null");
        }

        Cart cart = getOrCreateCart(customer);
        CartDetail detail = findCartDetailByBookId(cart, bookId);
        if (detail == null) {
            addItemToCart(customer, bookId, quantityChange);
            detail = findCartDetailByBookId(cart, bookId);
        } else {
            int newQuantity = detail.getQuantity() + quantityChange;
            if (newQuantity <= 0) {
                cart.getCartDetails().remove(detail);
                cartDetailDAO.delete(detail);
            } else {
                detail.setQuantity(newQuantity);
                cartDetailDAO.update(detail);
            }
        }

        updateTotalPrice(cart);
        cartDAO.update(cart);
    }

    /**
     * Gets the customer's current cart.
     *
     * @param customer The customer
     * @return The Cart object
     */
    public Cart getCart(Customer customer) {
        return getOrCreateCart(customer);
    }

    /**
     * Helper method to find CartDetail by bookId.
     */
    private CartDetail findCartDetailByBookId(Cart cart, Long bookId) {
        if (cart.getCartDetails() != null) {
            for (CartDetail detail : cart.getCartDetails()) {
                if (detail.getBook() != null && detail.getBook().getId().equals(bookId)) {
                    return detail;
                }
            }
        }
        return null;
    }

    /**
     * Updates the total price of the cart and persists it.
     */
    private void updateTotalPrice(Cart cart) {
        double total = 0.0;
        if (cart.getCartDetails() != null) {
            for (CartDetail detail : cart.getCartDetails()) {
                total += detail.calculateSubtotal();
            }
        }
        cart.setTotalPrice(total);
    }

    public void removeItem(Customer customer, Long bookId) {
        if (customer == null || bookId == null) {
            throw new IllegalArgumentException("Customer or bookId cannot be null");
        }

        Cart cart = getOrCreateCart(customer);
        CartDetail detail = findCartDetailByBookId(cart, bookId);
        if (detail == null) {
            throw new IllegalArgumentException("Item with book ID " + bookId + " not found in cart");
        }

        cart.getCartDetails().remove(detail);
        cartDetailDAO.delete(detail);

        updateTotalPrice(cart);
        cartDAO.update(cart);
    }

    public int getItemQuantity(Customer customer, Long bookId) {
        CartDetail cartDetail = findCartDetailByBookId(getOrCreateCart(customer), bookId);
        if (cartDetail != null) {
            return cartDetail.getQuantity();
        }
        return 0;
    }
}
