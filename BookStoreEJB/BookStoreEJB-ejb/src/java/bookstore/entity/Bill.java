/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package bookstore.entity;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;

@Entity
@Table(name = "bill")
public class Bill {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @OneToOne
    @JoinColumn(name = "order_id", nullable = false, unique = true)
    private Order order;

    @Min(0)
    @Max(3)
    @Column(name = "paymentMethod", nullable = false)
    private int paymentMethod;

    @Min(0)
    @Column(name = "amount", nullable = false)
    private double amount;

    @Min(0)
    @Max(4)
    @Column(name = "status", nullable = false)
    private int status;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "createdAt", nullable = false, updatable = false)
    private Date createdAt;

    @PrePersist
    protected void onCreate() {
        createdAt = new Date();
    }

    public Bill() {
    }

    public Bill(Order order, int paymentMethod, double amount, int status) {
        this.order = order;
        this.paymentMethod = paymentMethod;
        this.amount = amount;
        this.status = status;
    }
    
    //Factory method
    public static Bill create(Order order, int paymentMethod, double amount) {
        Bill bill = new Bill();
        bill.setOrder(order);
        bill.setPaymentMethod(paymentMethod);
        bill.setAmount(amount);
        bill.setStatus(0); // Mặc định: chưa thanh toán
        return bill;
    }
    
    //Factory method
    public static Bill fromOrder(Order order) {
        double amount = 0;
        for (OrderDetail od : order.getOrderDetails()) {
            amount += od.getAmount() * od.getQuantity();
        }
        return create(order, 0, amount);
    }
    
    // Getters và Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public int getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(int paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

}
