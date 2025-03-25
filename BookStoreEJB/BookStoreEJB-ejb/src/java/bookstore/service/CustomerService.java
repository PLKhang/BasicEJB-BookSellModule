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
import java.util.List;
import javax.ejb.EJB;

@Stateless
public class CustomerService {

    @EJB
    private CustomerDAO customerDAO;

    public boolean register(String name, String username, String email, String password, String phone, String address) {
        // Kiểm tra username hoặc email đã tồn tại chưa
        if (customerDAO.findByUsername(username) != null || customerDAO.findByEmail(email) != null) {
            return false; // Đăng ký thất bại do trùng username hoặc email
        }

        // Tạo tài khoản mới
        Customer newCustomer = new Customer(name, username, email, password, phone, address, 1); // 1 = active
        customerDAO.create(newCustomer);
        return true;
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
