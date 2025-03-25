<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Xác nhận đơn hàng</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            text-align: center;
        }
        .cart-container {
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
        h3 {
            margin-top: 20px;
            color: #333;
        }
        .order-btn, .back-btn, .home-btn {
            display: inline-block;
            margin: 10px;
            padding: 10px 15px;
            font-size: 16px;
            text-decoration: none;
            color: white;
            background-color: #28a745;
            border-radius: 5px;
            border: none;
            cursor: pointer;
        }
        .order-btn:hover {
            background-color: #218838;
        }
        .back-btn {
            background-color: #007BFF;
        }
        .back-btn:hover {
            background-color: #0056b3;
        }
        .home-btn {
            background-color: #6c757d;
        }
        .home-btn:hover {
            background-color: #5a6268;
        }
        .error {
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>

    <div class="cart-container">
        <h2>Xác nhận đơn hàng</h2>

        <c:if test="${not empty error}">
            <p class="error">${error}</p>
        </c:if>

        <c:if test="${not empty order}">
            <table>
                <thead>
                    <tr>
                        <th>STT</th>
                        <th>Tên sách</th>
                        <th>Giá (VND)</th>
                        <th>Số lượng</th>
                        <th>Tổng cộng</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${order.orderDetails}" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td>${item.book.title}</td>
                            <td>${item.book.price}</td>
                            <td>${item.quantity}</td>
                            <td>${item.amount}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <h3>Tổng tiền: <c:out value="${order.totalPrice}"/> VND</h3>

            <form action="order" method="post">
                <input type="hidden" name="action" value="confirm">
                <button type="submit" class="order-btn">Xác nhận</button>
            </form>
        </c:if>

        <a href="cart" class="back-btn">Quay lại giỏ hàng</a>
        <a href="index.html" class="home-btn">Về trang chủ</a>
    </div>

</body>
</html>
