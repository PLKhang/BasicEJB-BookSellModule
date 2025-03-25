/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package bookstore.servlet;

import bookstore.dao.BookDAO;
import bookstore.entity.Book;
import bookstore.service.BookService;
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
@WebServlet(name = "BookServlet", urlPatterns = {"/books"})
public class BookServlet extends HttpServlet {

    @EJB
    private BookService bookService;

    // Constructor mặc định (có thể giúp tránh lỗi NoSuchMethodException)
    public BookServlet() {}

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (bookService == null) {
            throw new ServletException("BookService chưa được khởi tạo");
        }
        List<Book> books = bookService.getAllBooks();
        request.setAttribute("books", books);
        request.getRequestDispatcher("viewBooks.jsp").forward(request, response);
    }
}
