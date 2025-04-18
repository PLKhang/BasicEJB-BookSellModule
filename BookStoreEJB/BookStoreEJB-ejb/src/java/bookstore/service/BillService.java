/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/J2EE/EJB30/StatelessEjbClass.java to edit this template
 */
package bookstore.service;

import bookstore.dao.BillDAO;
import bookstore.dao.OrderDAO;
import bookstore.entity.Bill;
import bookstore.entity.Order;
import java.math.BigDecimal;
import java.util.List;
import javax.ejb.Stateless;
import javax.ejb.EJB;

@Stateless
public class BillService {
    @EJB
    private BillDAO billDAO;

    @EJB
    private OrderDAO orderDAO;
    
    // use factory method
    public void createBillFromOrder(Long orderId) {
        Order order = orderDAO.findById(orderId);
        if (order == null) {
            throw new IllegalArgumentException("Đơn hàng không tồn tại");
        }

        Bill bill = Bill.fromOrder(order);
        billDAO.create(bill);
    }
    
    // use factory method
    public void createBill(Long orderId, int paymentMethod, double amount) {
        Order order = orderDAO.findById(orderId);
        if (order == null) {
            throw new IllegalArgumentException("Đơn hàng không tồn tại");
        }

        Bill bill = Bill.create(order, paymentMethod, amount);
        billDAO.create(bill);
    }
//    public void createBill(Long orderId, int paymentMethod, double amount) {
//        Order order = orderDAO.findById(orderId);
//        if (order == null) {
//            throw new IllegalArgumentException("Đơn hàng không tồn tại");
//        }
//
//        Bill bill = new Bill(order, paymentMethod, amount, 0); // 0: Chưa thanh toán
//        billDAO.create(bill);
//    }
    public Bill getBillByOrderId(Long orderId) {
        return billDAO.findByOrderId(orderId);
    }

    public void updatePaymentStatus(Long billId, int status) {
        Bill bill = billDAO.findById(billId);
        if (bill != null) {
            bill.setStatus(status);
            billDAO.update(bill);
        } else {
            throw new IllegalArgumentException("Hóa đơn không tồn tại");
        }
    }

    public List<Bill> getAllBills() {
        return billDAO.getAll();
    }
}
