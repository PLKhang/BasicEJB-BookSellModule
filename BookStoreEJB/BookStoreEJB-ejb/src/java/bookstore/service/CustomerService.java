/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package bookstore.service;

/**
 *
 * @author pkstr
 */
import bookstore.dao.CustomerDAO;
import bookstore.entity.Customer;
import javax.ejb.Stateless;
import javax.inject.Inject;
import java.util.List;

@Stateless
public class CustomerService {
    @Inject
    private CustomerDAO customerDAO;

    public void registerCustomer(Customer customer) {
        customerDAO.createCustomer(customer);
    }

    public Customer getCustomerById(Long id) {
        return customerDAO.findById(id);
    }

    public Customer getCustomerByEmail(String email) {
        return customerDAO.findByEmail(email);
    }

    public List<Customer> getAllCustomers() {
        return customerDAO.getAllCustomers();
    }

    public void updateCustomer(Customer customer) {
        customerDAO.updateCustomer(customer);
    }

    public void deleteCustomer(Long id) {
        customerDAO.deleteCustomer(id);
    }
}
