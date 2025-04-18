/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package bookstore.service;
import bookstore.dao.BookDAO;
import bookstore.entity.Book;
import javax.ejb.Stateless;
import javax.ejb.EJB;
import java.util.List;

@Stateless
public class BookService {
    @EJB
    private BookDAO bookDAO;

    public void addBook(Book book) {
        bookDAO.create(book);
    }

    public Book getBookById(Long id) {
        return bookDAO.findById(id);
    }

    public List<Book> getAllBooks() {
        return bookDAO.findAll();
    }

    public void updateBook(Book book) {
        bookDAO.update(book);
    }

    public void deleteBook(Long id) {
        bookDAO.delete(id);
    }

    public void updateStock(Long bookId, int newStock) {
        bookDAO.updateStock(bookId, newStock);
    }
    
    public int getStock(Long bookId) {
        return getBookById(bookId).getStock();
    }
}