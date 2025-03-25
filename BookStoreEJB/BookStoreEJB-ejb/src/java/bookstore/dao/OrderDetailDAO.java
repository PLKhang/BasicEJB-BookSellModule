/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/J2EE/EJB30/StatelessEjbClass.java to edit this template
 */
package bookstore.dao;

import bookstore.entity.OrderDetail;
import java.util.List;
import javax.ejb.Stateless;
import javax.ejb.LocalBean;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author pkstr
 */
@Stateless
public class OrderDetailDAO {

    @PersistenceContext(unitName = "BookStorePU")
    private EntityManager entityManager;

    /**
     * Creates a new OrderDetail in the database.
     */
    public void create(OrderDetail orderDetail) {
        entityManager.persist(orderDetail);
    }

    /**
     * Finds an OrderDetail by its ID.
     */
    public OrderDetail findById(Long id) {
        return entityManager.find(OrderDetail.class, id);
    }

    /**
     * Updates an existing OrderDetail in the database.
     */
    public void update(OrderDetail orderDetail) {
        entityManager.merge(orderDetail);
    }

    /**
     * Deletes an OrderDetail from the database.
     */
    public void delete(OrderDetail orderDetail) {
        if (orderDetail != null) {
            entityManager.remove(entityManager.merge(orderDetail));
        }
    }
}