/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package bookstore.servlet;

import bookstore.dao.OrderDAO;
import bookstore.entity.Customer;
import bookstore.entity.Order;
import bookstore.service.CartService;
import bookstore.service.OrderService;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author pkstr
 */
@WebServlet(name = "OrderServlet", urlPatterns = {"/order"})
public class OrderServlet extends HttpServlet {

    @EJB
    private OrderService orderService;
    @EJB
    private CartService cartService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("loggedInCustomer");

        if (customer == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Long orderId = (Long) session.getAttribute("currentOrderId");

        if (orderId == null) {
            response.sendRedirect("cart?error=" + URLEncoder.encode("Không có đơn hàng nào để xem!", "UTF-8"));
            return;
        }

        Order order = orderService.findById(orderId);
        if (order == null || !order.getCustomer().getId().equals(customer.getId())) {
            session.removeAttribute("currentOrderId");
            response.sendRedirect("cart?error=" + URLEncoder.encode("Đơn hàng không hợp lệ!", "UTF-8"));
            return;
        }

        request.setAttribute("order", order);
        request.getRequestDispatcher("/orderConfirmation.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("loggedInCustomer");

        if (customer == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        Long orderId = (Long) session.getAttribute("currentOrderId");

        try {
            if ("confirm".equals(action) && orderId != null) {
                orderService.confirmOrder(orderId, customer);
                session.removeAttribute("currentOrderId");
                response.sendRedirect("orderSuccess.jsp");
            } else {
                String message = "Hành động không hợp lệ!";
                String encodedMessage = URLEncoder.encode(message, StandardCharsets.UTF_8.toString());
                response.sendRedirect("order?error=" + URLEncoder.encode(encodedMessage, "UTF-8"));
            }
        } catch (Exception e) {
            response.sendRedirect("order?error=" + URLEncoder.encode(e.getMessage(), "UTF-8"));
        }
    }
}
