/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package bookstore.servlet;

import bookstore.service.CustomerService;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import javax.servlet.RequestDispatcher;

@WebServlet("/register")
public class CustomerRegisterServlet extends HttpServlet {

    @EJB
    private CustomerService customerService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get form parameters
        String name = request.getParameter("name");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        // Basic input validation
        if (name == null || name.trim().isEmpty() ||
            username == null || username.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            phone == null || phone.trim().isEmpty() ||
            address == null || address.trim().isEmpty()) {
            response.sendRedirect("register.jsp?error=" + URLEncoder.encode("Vui lòng điền đầy đủ thông tin!", "UTF-8"));
            return;
        }

        try {
            // Call service to register the customer
            customerService.register(name, username, email, password, phone, address);
            response.sendRedirect("register_success.jsp");
        } catch (IllegalArgumentException e) {
            // Handle specific validation errors from CustomerService (e.g., duplicate username)
            response.sendRedirect("register.jsp?error=" + URLEncoder.encode(e.getMessage(), "UTF-8"));
        } catch (Exception e) {
            // Handle unexpected errors
            response.sendRedirect("register.jsp?error=" + URLEncoder.encode("Đăng ký thất bại: " + e.getMessage(), "UTF-8"));
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet for customer registration";
    }
}
