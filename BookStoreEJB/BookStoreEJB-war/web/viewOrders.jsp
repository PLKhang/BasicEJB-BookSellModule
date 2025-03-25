<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List, bookstore.entity.Order" %>
<!DOCTYPE html>
<html>
<head>
    <title>Danh sách hóa đơn</title>
</head>
<body>
    <h2>Hóa đơn của bạn</h2>
    <table border="1">
        <tr>
            <th>Mã hóa đơn</th>
            <th>Ngày đặt</th>
            <th>Tổng tiền</th>
        </tr>
        <%
            List<Order> orders = (List<Order>) request.getAttribute("orders");
            if (orders != null) {
                for (Order order : orders) {
        %>
        <tr>
            <td><%= order.getId() %></td>
            <td><%= order.getCreatedAt() %></td>
            <td><%= order.getTotalAmount() %> VND</td>
        </tr>
        <% }} %>
    </table>
</body>
</html>