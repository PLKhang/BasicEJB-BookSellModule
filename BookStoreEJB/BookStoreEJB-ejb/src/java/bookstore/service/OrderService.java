/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/J2EE/EJB30/StatelessEjbClass.java to edit this template
 */
package bookstore.service;

import bookstore.dao.BillDAO;
import bookstore.dao.CartDAO;
import bookstore.dao.OrderDAO;
import bookstore.dao.OrderDetailDAO;
import bookstore.entity.Bill;
import bookstore.entity.Book;
import bookstore.entity.Cart;
import bookstore.entity.CartDetail;
import bookstore.entity.Customer;
import bookstore.entity.Order;
import bookstore.entity.OrderDetail;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.Stateless;
import javax.ejb.EJB;
import javax.ejb.EJBs;
import javax.ejb.LocalBean;
import javax.inject.Inject;

/**
 *
 * @author pkstr
 */
@Stateless
public class OrderService {

    @EJB
    private OrderDAO orderDAO;

    @EJB
    private OrderDetailDAO orderDetailDAO;

    @EJB
    private CartDAO cartDAO;

    @EJB
    private BookService bookService; // Assuming this exists to fetch Book

    public Order findById(Long orderId) {
        if (orderId == null) {
            return null;
        }
        return orderDAO.findById(orderId);
    }

    /**
     * Retrieves a list of Orders for a given Customer.
     *
     * @param customer The Customer whose orders are to be retrieved
     * @return List of Orders (containing createdAt, totalPrice, and status)
     * @throws IllegalArgumentException if customer is null
     */
    public List<Order> getOrdersByCustomer(Customer customer) {
        if (customer == null) {
            throw new IllegalArgumentException("Customer cannot be null");
        }

        return orderDAO.findByCustomerId(customer.getId());
    }

    /**
     * Creates an Order from the given Cart's CartDetails.
     *
     * @param cart The Cart to convert to an Order
     * @return The created Order
     * @throws IllegalArgumentException if the cart is null or empty
     */
    public Order createOrderFromCart(Cart cart) {
        if (cart == null || cart.getCartDetails() == null || cart.getCartDetails().isEmpty()) {
            throw new IllegalArgumentException("Cart is empty or null");
        }

        // Create new Order with status 0 (created)
        Order order = new Order(cart.getCustomer(), cart.getTotalPrice(), 0);
        List<OrderDetail> orderDetails = new ArrayList<>();

        // Copy CartDetails to OrderDetails
        for (CartDetail cartDetail : cart.getCartDetails()) {
            if (cartDetail.getBook() == null) {
                throw new IllegalStateException("CartDetail contains null Book reference");
            }
            double amount = cartDetail.calculateSubtotal();
            OrderDetail orderDetail = new OrderDetail(order, cartDetail.getBook(), cartDetail.getQuantity(), amount);
            orderDetails.add(orderDetail);
        }

        order.setOrderDetails(orderDetails);
        orderDAO.create(order); // Persists Order and OrderDetails due to cascade

        return order;
    }

    /**
     * Confirms an Order and clears all CartDetails from the Customer's Cart.
     *
     * @param orderId The ID of the Order to confirm
     * @param customer The Customer whose Cart should be cleared
     * @throws IllegalArgumentException if orderId or customer is null, or order not found
     * @throws IllegalStateException if order is not in 'created' status
     */
    public void confirmOrder(Long orderId, Customer customer) {
        if (orderId == null || customer == null) {
            throw new IllegalArgumentException("Order ID or Customer cannot be null");
        }

        Order order = orderDAO.findById(orderId);
        if (order == null) {
            throw new IllegalArgumentException("Order with ID " + orderId + " not found");
        }
        if (order.getStatus() != 0) {
            throw new IllegalStateException("Order is not in 'created' status");
        }

        // Update order status to confirmed (1)
        order.setStatus(1);
        orderDAO.update(order);

        // Clear the customer's cart
        Cart cart = cartDAO.findByCustomerId(customer.getId());
        if (cart != null && cart.getCartDetails() != null) {
            cart.getCartDetails().clear();
            cart.setTotalPrice(0.0);
            cartDAO.update(cart);
        }
    }
}
