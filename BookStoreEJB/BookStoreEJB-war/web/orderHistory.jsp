<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lịch sử đơn hàng</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            text-align: center;
        }
        .container {
            width: 80%;
            margin: 20px auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #007BFF;
            color: white;
        }
        p {
            font-size: 18px;
            font-weight: bold;
            color: #555;
        }
        .btn {
            display: inline-block;
            margin: 10px;
            padding: 10px 15px;
            font-size: 16px;
            text-decoration: none;
            color: white;
            background-color: #007BFF;
            border-radius: 5px;
        }
        .btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

    <div class="container">
        <h2>Lịch sử đơn hàng</h2>

        <c:if test="${not empty orders}">
            <table>
                <thead>
                    <tr>
                        <th>Ngày đặt</th>
                        <th>Tổng tiền (VND)</th>
                        <th>Trạng thái</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="order" items="${orders}">
                        <tr>
                            <td>${order.createdAt}</td>
                            <td>${order.totalPrice}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${order.status == 0}">Được tạo</c:when>
                                    <c:when test="${order.status == 1}">Được xác nhận</c:when>
                                    <c:otherwise>Không xác định</c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>

        <c:if test="${empty orders}">
            <p>Chưa có đơn hàng nào!</p>
        </c:if>

        <a href="cart" class="btn">Quay lại giỏ hàng</a>
        <a href="index.html" class="btn">Về trang chủ</a>
    </div>

</body>
</html>
