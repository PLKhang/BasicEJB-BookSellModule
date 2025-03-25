/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package bookstore.dao;

import bookstore.entity.Book;
import bookstore.entity.Cart;
import bookstore.entity.Customer;
import javax.ejb.Remove;
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
public class CartDAO {

    @PersistenceContext(unitName = "BookStorePU")
    private EntityManager entityManager;

    /**
     * Creates a new Cart in the database.
     */
    public void create(Cart cart) {
        entityManager.persist(cart);
    }

    /**
     * Finds a Cart by customer ID.
     * Returns null if not found.
     */
    public Cart findByCustomerId(Long customerId) {
        try {
            return entityManager.createQuery(
                    "SELECT c FROM Cart c WHERE c.customer.id = :customerId", Cart.class)
                    .setParameter("customerId", customerId)
                    .getSingleResult();
        } catch (javax.persistence.NoResultException e) {
            return null;
        }
    }

    /**
     * Updates an existing Cart in the database.
     */
    public void update(Cart cart) {
        entityManager.merge(cart);
    }

    /**
     * Deletes a Cart from the database.
     */
    public void delete(Cart cart) {
        if (cart != null) {
            entityManager.remove(entityManager.merge(cart));
        }
    }
}
