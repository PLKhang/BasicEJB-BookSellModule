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

@Stateless
public class CartService {

    @EJB
    private CartDAO cartDAO;

    @EJB
    private CartDetailDAO cartDetailDAO;

    @EJB
    private BookService bookService;

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

    public Cart getCart(Customer customer) {
        return getOrCreateCart(customer);
    }

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

    public void update(Cart cart) {
        cartDAO.update(cart);
    }

    public void clearCart(Cart cart) {
        if (cart != null && cart.getCartDetails() != null) {
            cart.getCartDetails().clear();
            cart.setTotalPrice(0.0);
            cartDAO.update(cart);
        }
    }
}
