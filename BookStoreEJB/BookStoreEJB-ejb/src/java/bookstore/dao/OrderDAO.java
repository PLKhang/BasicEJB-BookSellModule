/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/J2EE/EJB30/StatelessEjbClass.java to edit this template
 */
package bookstore.dao;

import bookstore.entity.Order;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author pkstr
 */
@Stateless
public class OrderDAO {

    @PersistenceContext(unitName = "BookStorePU")
    private EntityManager entityManager;

    /**
     * Creates a new Order in the database.
     */
    public void create(Order order) {
        entityManager.persist(order);
    }

    /**
     * Finds an Order by its ID.
     */
    public Order findById(Long id) {
        return entityManager.find(Order.class, id);
    }

    /**
     * Updates an existing Order in the database.
     */
    public void update(Order order) {
        entityManager.merge(order);
    }

    /**
     * Deletes an Order from the database.
     */
    public void delete(Order order) {
        if (order != null) {
            entityManager.remove(entityManager.merge(order));
        }
    }
    
    /**
     * Finds all Orders by customer ID.
     *
     * @param customerId The ID of the customer
     * @return List of Orders for the customer
     */
    public List<Order> findByCustomerId(Long customerId) {
        return entityManager.createQuery(
                "SELECT o FROM Order o WHERE o.customer.id = :customerId ORDER BY o.createdAt DESC", Order.class)
                .setParameter("customerId", customerId)
                .getResultList();
    }
}

