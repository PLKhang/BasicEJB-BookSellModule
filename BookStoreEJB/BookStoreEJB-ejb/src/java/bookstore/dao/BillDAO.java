/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/J2EE/EJB30/StatelessEjbClass.java to edit this template
 */
package bookstore.dao;

import bookstore.entity.Bill;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;

/**
 *
 * @author pkstr
 */
@Stateless
public class BillDAO {
    @PersistenceContext(unitName = "BookStorePU")
    private EntityManager entityManager;

    public void create(Bill bill) {
        entityManager.persist(bill);
    }

    public Bill findById(Long id) {
        return entityManager.find(Bill.class, id);
    }

    public Bill findByOrderId(Long orderId) {
        try {
            return entityManager.createQuery(
                    "SELECT b FROM Bill b WHERE b.order.id = :orderId", Bill.class)
                    .setParameter("orderId", orderId)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    public List<Bill> getAll() {
        return entityManager.createQuery("SELECT b FROM Bill b", Bill.class).getResultList();
    }

    public void update(Bill bill) {
        entityManager.merge(bill);
    }

    public void delete(Long id) {
        Bill bill = findById(id);
        if (bill != null) {
            entityManager.remove(bill);
        }
    }
}
