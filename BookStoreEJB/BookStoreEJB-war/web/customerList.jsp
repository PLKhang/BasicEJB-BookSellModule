<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="bookstore.entity.Customer" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách khách hàng</title>
    <style>
        table {
            width: 50%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 8px;
            text-align: left;
        }
    </style>
</head>
<body>

<h2>Danh sách khách hàng</h2>

<table>
    <tr>
        <th>ID</th>
        <th>Tên khách hàng</th>
    </tr>
    <%
        List<Customer> customers = (List<Customer>) request.getAttribute("customers");
        if (customers != null) {
            for (Customer customer : customers) {
    %>
    <tr>
        <td><%= customer.getId() %></td>
        <td><%= customer.getName() %></td>
    </tr>
    <%
            }
        } else {
    %>
    <tr>
        <td colspan="2">Không có dữ liệu khách hàng.</td>
    </tr>
    <%
        }
    %>
</table>

</body>
</html>
