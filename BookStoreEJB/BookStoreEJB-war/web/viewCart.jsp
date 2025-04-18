<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Giỏ hàng của bạn</title>
        <link rel="stylesheet" href="styles.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f5f5f5;
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
            }
            .cart-container {
                width: 80%;
                background: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                text-align: center;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            th, td {
                padding: 10px;
                border: 1px solid #ddd;
                text-align: center;
            }
            th {
                background-color: #007BFF;
                color: white;
            }
            .quantity-btn {
                background-color: #007BFF;
                color: white;
                border: none;
                padding: 5px 10px;
                border-radius: 5px;
                cursor: pointer;
            }
            .quantity-btn:hover {
                background-color: #0056b3;
            }
            .remove-btn {
                background-color: #dc3545;
                color: white;
                border: none;
                padding: 5px 10px;
                border-radius: 5px;
                cursor: pointer;
            }
            .remove-btn:hover {
                background-color: #c82333;
            }
            .btn {
                display: inline-block;
                margin-top: 20px;
                text-decoration: none;
                background-color: #28a745;
                color: white;
                padding: 10px 15px;
                border-radius: 5px;
            }
            .btn:hover {
                background-color: #218838;
            }
            .empty-cart {
                font-size: 18px;
                color: red;
                margin-top: 20px;
            }
        </style>
    </head>
    <body>
        <div class="cart-container">
            <h2>Giỏ hàng của bạn</h2>
            <c:if test="${not empty param.success}">
                <p style="color: green;">Giỏ hàng đã được cập nhật!</p>
            </c:if>
            <c:if test="${not empty param.error}">
                <p style="color: red;">${param.error}</p>
            </c:if> 
            <c:if test="${not empty cartDetails}">
                <table>
                    <thead>
                        <tr>
                            <th>STT</th>
                            <th>Tên sách</th>
                            <th>Giá (VND)</th>
                            <th>Số lượng</th>
                            <th>Tổng cộng</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:set var="totalPrice" value="0"/>
                        <c:forEach var="item" items="${cartDetails}" varStatus="status">
                            <c:set var="itemTotal" value="${item.book.price * item.quantity}"/>
                            <c:set var="totalPrice" value="${totalPrice + itemTotal}"/>
                            <tr>
                                <td>${status.index + 1}</td>
                                <td>${item.book.title}</td>
                                <td>${item.book.price}</td>
                                <td>
                                    <form action="cart" method="post" style="display: inline;">
                                        <input type="hidden" name="bookId" value="${item.book.id}">
                                        <input type="hidden" name="action" value="decrease">
                                        <button type="submit" class="quantity-btn">-</button>
                                    </form>
                                    ${item.quantity}
                                    <form action="cart" method="post" style="display: inline;">
                                        <input type="hidden" name="bookId" value="${item.book.id}">
                                        <input type="hidden" name="action" value="increase">
                                        <button type="submit" class="quantity-btn">+</button>
                                    </form>
                                </td>
                                <td>${itemTotal}</td>
                                <td>
                                    <form action="cart" method="post">
                                        <input type="hidden" name="bookId" value="${item.book.id}">
                                        <input type="hidden" name="action" value="remove">
                                        <button type="submit" class="remove-btn">Xóa</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <c:if test="${not empty cartDetails}">
                    <h3>Tổng tiền: <c:out value="${totalPrice}"/> VND</h3>

                    <form action="cart" method="post">
                        <input type="hidden" name="action" value="order">
                        <button type="submit" class="btn">Đặt hàng</button>
                    </form>
                </c:if>
            </c:if>

            <c:if test="${empty cartDetails}">
                <p class="empty-cart">Giỏ hàng của bạn đang trống!</p>
            </c:if>
            <a href="books" class="btn">Xem sách</a>
            <a href="index.html" class="btn">Về trang chủ</a>
        </div>
    </body>
</html>
