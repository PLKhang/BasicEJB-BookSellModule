/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package bookstore.service;

import bookstore.dao.CustomerDAO;
import bookstore.entity.Customer;
import javax.ejb.Stateless;
import java.util.List;
import javax.ejb.EJB;

@Stateless
public class CustomerService {

    @EJB
    private CustomerDAO customerDAO;

    public void register(String name, String username, String email, String password, String phone, String address) {
        // Check for existing username or email
        if (customerDAO.findByUsername(username) != null) {
            throw new IllegalArgumentException("Tên người dùng đã tồn tại!");
        }
        if (customerDAO.findByEmail(email) != null) {
            throw new IllegalArgumentException("Email đã được sử dụng!");
        }

        // Create new Customer
        Customer customer = new Customer();
        customer.setName(name);
        customer.setUsername(username);
        customer.setEmail(email);
        customer.setPassword(password);
        customer.setPhone(phone);
        customer.setAddress(address);

        // Persist to database
        customerDAO.create(customer);
    }

    public Customer login(String username, String password) {
        Customer customer = customerDAO.findByUsername(username);
        if (customer != null && customer.getPassword().equals(password)) {
            return customer; // Đăng nhập thành công
        }
        return null; // Đăng nhập thất bại
    }

    public Customer getCustomerById(Long id) {
        return customerDAO.findById(id);
    }

    public List<Customer> getAllCustomers() {
        return customerDAO.getAll();
    }

    public void updateCustomer(Customer customer) {
        customerDAO.update(customer);
    }

    public void deleteCustomer(Long id) {
        customerDAO.delete(id);
    }
}
