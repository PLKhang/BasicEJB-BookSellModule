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
import bookstore.util.NotificationManager;
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
    private BillService billService;

    @EJB
    private CartService cartService;

    @EJB
    private BookService bookService; 

    public Order findById(Long orderId) {
        if (orderId == null) {
            return null;
        }
        return orderDAO.findById(orderId);
    }

    public List<Order> getOrdersByCustomer(Customer customer) {
        if (customer == null) {
            throw new IllegalArgumentException("Customer cannot be null");
        }

        return orderDAO.findByCustomerId(customer.getId());
    }

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

        // Update book stock
        List<OrderDetail> items = order.getOrderDetails();
        for (OrderDetail item: items){
            Book book = item.getBook();
            bookService.updateStock(book.getId(), book.getStock() - item.getQuantity());
        }
        
        // Create bill use factory method
        billService.createBillFromOrder(orderId);
        
        // Update order status to confirmed (1)
        order.setStatus(1);
        orderDAO.update(order);

        // Send confirmation notification
        NotificationManager.getInstance().sendOrderConfirmation(customer, order);

        // Clear the customer's cart
        cartService.clearCart(cartService.getOrCreateCart(customer));
    }
}
