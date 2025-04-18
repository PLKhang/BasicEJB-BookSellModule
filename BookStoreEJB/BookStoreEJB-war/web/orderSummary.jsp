<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, bookstore.entity.OrderDetail" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đơn hàng</title>
</head>
<body>
    <h2>Chi tiết đơn hàng</h2>
    <table border="1">
        <tr>
            <th>Tên sách</th>
            <th>Số lượng</th>
            <th>Giá</th>
        </tr>
        <%
            List<OrderDetail> orderItems = (List<OrderDetail>) request.getAttribute("orderItems");
            double totalAmount = 0;
            if (orderItems != null) {
                for (OrderDetail item : orderItems) {
                    totalAmount += item.getQuantity() * item.getBook().getPrice();
        %>
        <tr>
            <td><%= item.getBook().getTitle() %></td>
            <td><%= item.getQuantity() %></td>
            <td><%= item.getBook().getPrice() %> VND</td>
        </tr>
        <% }} %>
    </table>
    <h3>Tổng tiền: <%= totalAmount %> VND</h3>
    <p>Cảm ơn bạn đã mua hàng!</p>
</body>
</html>