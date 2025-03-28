/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package bookstore.servlet;

import bookstore.entity.Customer;
import bookstore.service.CustomerService;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author pkstr
 */
@WebServlet("/customers")
public class CustomerServlet extends HttpServlet {

    @EJB
    private CustomerService customerService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Customer> customers = customerService.getAllCustomers();

            // Gửi danh sách khách hàng đến JSP
            request.setAttribute("customers", customers);
            request.getRequestDispatcher("customerList.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi tải danh sách khách hàng!");
        }
    }
}

