/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package bookstore.util;

import bookstore.entity.Customer;
import bookstore.entity.Order;
import java.text.DecimalFormat;

public class NotificationManager {
    private static volatile NotificationManager instance;

    private NotificationManager() {
        if (instance != null) {
            throw new RuntimeException("Use getInstance() method to get the single instance of this class.");
        }
        System.out.println("New NotificationManager instance created: " + this.hashCode());
    }

    public static NotificationManager getInstance() {
        if (instance == null) {
            synchronized (NotificationManager.class) {
                if (instance == null) {
                    instance = new NotificationManager();
                }
            }
        }
        System.out.println("Returning NotificationManager instance: " + instance.hashCode());
        return instance;
    }

    public void sendOrderConfirmation(Customer customer, Order order) {
        DecimalFormat formatter = new DecimalFormat("###,###");
        String formattedPrice = formatter.format(order.getTotalPrice()) + " VND";

        String message = String.format(
            "Dear %s, your order #%d has been successfully confirmed. Total: %s. Thank you for shopping with us!",
            customer.getName(), order.getId(), formattedPrice
        );
        sendNotification(customer, message);
    }


    private void sendNotification(Customer customer, String message) {
        System.out.println(String.format(
            "Sending notification to %s (Email: %s, Phone: %s): %s",
            customer.getName(), customer.getEmail(), customer.getPhone(), message
        ));
    }
}