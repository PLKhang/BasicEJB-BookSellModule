/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package bookstore.servlet;

import bookstore.dao.BookDAO;
import bookstore.dao.CartDAO;
import bookstore.dao.CustomerDAO;
import bookstore.entity.Book;
import bookstore.entity.Cart;
import bookstore.entity.CartDetail;
import bookstore.entity.Customer;
import bookstore.entity.Order;
import bookstore.service.BookService;
import bookstore.service.CartService;
import bookstore.service.CustomerService;
import bookstore.service.OrderService;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import javax.ejb.EJB;
import javax.ejb.EJBException;
import javax.ejb.EJBs;
import javax.inject.Inject;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "CartServlet", urlPatterns = {"/cart"})
public class CartServlet extends HttpServlet {

    @EJB
    private CartService cartService;
    @EJB
    private OrderService orderService;
    @EJB
    private BookService bookService;
            
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("loggedInCustomer");

        if (customer == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Cart cart = cartService.getCart(customer);
        request.setAttribute("cartDetails", cart.getCartDetails());
        request.getRequestDispatcher("/viewCart.jsp").forward(request, response);
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
        Long bookId = request.getParameter("bookId") != null ? Long.valueOf(request.getParameter("bookId")) : null;

        try {
            if ("order".equals(action)) {
                Order order = orderService.createOrderFromCart(cartService.getCart(customer));
                session.setAttribute("currentOrderId", order.getId());
                response.sendRedirect("order");
            } else if ("add".equals(action) && bookId != null) {
                Book book = bookService.getBookById(bookId);
                if (book == null) {
                    String message = "Không tìm thấy sách!";
                    String encodedMessage = URLEncoder.encode(message, StandardCharsets.UTF_8.toString());
                    response.sendRedirect("books?error=" + encodedMessage);
                    return;
                } else if (bookService.getStock(bookId) == 0) {
                    String message = "Sách không còn trong kho!";
                    String encodedMessage = URLEncoder.encode(message, StandardCharsets.UTF_8.toString());
                    response.sendRedirect("books?error=" + encodedMessage);
                    return;
                } else if (bookService.getStock(bookId) <= cartService.getItemQuantity(customer, bookId)) {
                    String message = "Số lượng sách không còn đủ để thêm nữa!";
                    String encodedMessage = URLEncoder.encode(message, StandardCharsets.UTF_8.toString());
                    response.sendRedirect("books?error=" + encodedMessage);
                    return;
                }
                cartService.updateItemQuantity(customer, bookId, 1);
                response.sendRedirect("books?success=" + URLEncoder.encode("Sách đã được thêm vào giỏ hàng!", StandardCharsets.UTF_8.toString()));
            } else if ("increase".equals(action) && bookId != null) {
                if (bookService.getStock(bookId) == 0) {
                    String message = "Sách không còn trong kho!";
                    String encodedMessage = URLEncoder.encode(message, StandardCharsets.UTF_8.toString());
                    response.sendRedirect("cart?error=" + encodedMessage);
                    return;
                } else if (bookService.getStock(bookId) <= cartService.getItemQuantity(customer, bookId)) {
                    String message = "Số lượng sách không còn đủ để thêm nữa!";
                    String encodedMessage = URLEncoder.encode(message, StandardCharsets.UTF_8.toString());
                    response.sendRedirect("cart?error=" + encodedMessage);
                    return;
                }
                cartService.updateItemQuantity(customer, bookId, 1);
                response.sendRedirect("cart");
            } else if ("decrease".equals(action) && bookId != null) {
                cartService.updateItemQuantity(customer, bookId, -1);
                response.sendRedirect("cart");
            } else if ("remove".equals(action) && bookId != null) {
                cartService.removeItem(customer, bookId);
                response.sendRedirect("cart");
            }
        } catch (IOException e) {
            response.sendRedirect("cart?error=" + URLEncoder.encode(e.getMessage(), "UTF-8"));
        }
    }
}
