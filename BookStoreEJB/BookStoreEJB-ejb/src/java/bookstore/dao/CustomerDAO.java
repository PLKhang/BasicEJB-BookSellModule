/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package bookstore.dao;

/**
 *
 * @author pkstr
 */
import bookstore.entity.Customer;
import javax.ejb.Stateless;
import javax.persistence.*;
import java.util.List;

@Stateless
public class CustomerDAO {
    @PersistenceContext(unitName = "BookStorePU")
    private EntityManager entityManager;

    public void create(Customer customer) {
        entityManager.persist(customer);
    }

    public Customer findById(Long id) {
        return entityManager.find(Customer.class, id);
    }

    public Customer findByUsername(String username) {
        try {
            return entityManager.createQuery("SELECT c FROM Customer c WHERE c.username = :username", Customer.class)
                    .setParameter("username", username)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    public Customer findByEmail(String email) {
        try {
            return entityManager.createQuery("SELECT c FROM Customer c WHERE c.email = :email", Customer.class)
                    .setParameter("email", email)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    public List<Customer> getAll() {
        return entityManager.createQuery("SELECT c FROM Customer c", Customer.class).getResultList();
    }

    public void update(Customer customer) {
        entityManager.merge(customer);
    }

    public void delete(Long id) {
        Customer customer = findById(id);
        if (customer != null) {
            entityManager.remove(customer);
        }
    }
}
