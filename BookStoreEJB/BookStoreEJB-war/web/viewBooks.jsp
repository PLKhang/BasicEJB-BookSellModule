<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Danh sách sách</title>
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
            .book-container {
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
            button {
                background-color: #28a745;
                color: white;
                border: none;
                padding: 8px 12px;
                border-radius: 5px;
                cursor: pointer;
            }
            button:hover {
                background-color: #218838;
            }
            a {
                display: inline-block;
                margin-top: 20px;
                text-decoration: none;
                background-color: #007BFF;
                color: white;
                padding: 10px 15px;
                border-radius: 5px;
            }
            a:hover {
                background-color: #0056b3;
            }
        </style>
    </head>
    <body>
        <div class="book-container">
            <h2>Danh sách sách</h2>
            <c:if test="${not empty param.success}">
                <p style="color: green;">Sách đã được thêm vào giỏ hàng!</p>
            </c:if>
            <c:if test="${not empty param.error}">
                <p style="color: red;">${param.error}</p>
            </c:if>
            <table>
                <thead>
                    <tr>
                        <th>STT</th>
                        <th>Tên sách</th>
                        <th>Tác giả</th>
                        <th>Giá (VND)</th>
                        <th>Năm xuất bản</th>
                        <th>Số lượng tồn</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="book" items="${books}" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td>${book.title}</td>
                            <td>${book.author}</td>
                            <td>${book.price}</td>
                            <td>${book.publishDate}</td>                            
                            <td>${book.stock}</td>
                            <td>
                                <form action="cart" method="post">
                                    <input type="hidden" name="action" value="add">
                                    <input type="hidden" name="bookId" value="${book.id}">
                                    <input type="hidden" name="quantity" value="1">
                                    <button type="submit">Thêm vào giỏ hàng</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <br>
            <a href="cart">Xem giỏ hàng</a>
            <a href="index.html" class="btn">Về trang chủ</a>
        </div>
    </body>
</html>
