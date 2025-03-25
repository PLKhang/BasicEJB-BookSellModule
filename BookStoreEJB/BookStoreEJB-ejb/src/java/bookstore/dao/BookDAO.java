/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package bookstore.dao;

import bookstore.entity.Book;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import java.util.List;
import javax.ejb.Stateless;
/**
 *
 * @author pkstr
 */
@Stateless
public class BookDAO {
    @PersistenceContext(unitName = "BookStorePU")
    private EntityManager entityManager;

    public void create(Book book) {
        entityManager.persist(book);
    }

    public Book findById(Long id) {
        return entityManager.find(Book.class, id);
    }

    public List<Book> findAll() {
        return entityManager.createQuery("SELECT b FROM Book b", Book.class).getResultList();
    }

    public void update(Book book) {
        entityManager.merge(book);
    }

    public void delete(Long id) {
        Book book = findById(id);
        if (book != null) {
            entityManager.remove(book);
        }
    }

    public void updateStock(Long bookId, int newStock) {
        Book book = findById(bookId);
        if (book != null) {
            book.setStock(newStock);
            entityManager.merge(book);
        }
    }
}

