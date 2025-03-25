/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package bookstore.dao;

import bookstore.entity.Book;
import bookstore.entity.Cart;
import bookstore.entity.CartDetail;
import java.util.List;
import javax.ejb.Stateful;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;

/**
 *
 * @author pkstr
 */
@Stateless
public class CartDetailDAO {

    @PersistenceContext(unitName = "BookStorePU")
    private EntityManager entityManager;

    /**
     * Creates a new CartDetail in the database.
     */
    public void create(CartDetail cartDetail) {
        entityManager.persist(cartDetail);
    }

    /**
     * Finds a CartDetail by its ID.
     */
    public CartDetail findById(Long id) {
        return entityManager.find(CartDetail.class, id);
    }

    /**
     * Updates an existing CartDetail in the database.
     */
    public void update(CartDetail cartDetail) {
        entityManager.merge(cartDetail);
    }

    /**
     * Deletes a CartDetail from the database.
     */
    public void delete(CartDetail cartDetail) {
        if (cartDetail != null) {
            entityManager.remove(entityManager.merge(cartDetail));
        }
    }

    /**
     * Finds a CartDetail by cart ID and book ID.
     * Returns null if not found.
     */
    public CartDetail findByCartAndBook(Long cartId, Long bookId) {
        try {
            return entityManager.createQuery(
                    "SELECT cd FROM CartDetail cd WHERE cd.cart.id = :cartId AND cd.book.id = :bookId", CartDetail.class)
                    .setParameter("cartId", cartId)
                    .setParameter("bookId", bookId)
                    .getSingleResult();
        } catch (javax.persistence.NoResultException e) {
            return null;
        }
    }
}