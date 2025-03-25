<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng ký</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            text-align: center;
        }
        .container {
            width: 350px;
            background: white;
            padding: 20px;
            border-radius: 10px;
            margin: 50px auto;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        input {
            width: 90%;
            padding: 8px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        button {
            background-color: #28a745;
            color: white;
            padding: 10px;
            border: none;
            width: 100%;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: #218838;
        }
        .error {
            color: red;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Đăng ký tài khoản</h2>
        <% String error = (String) request.getAttribute("error"); %>
        <% if (error != null) { %>
            <p class="error"><%= error %></p>
        <% } %>
        <form action="RegisterServlet" method="post">
            <input type="text" name="name" placeholder="Họ và tên" required>
            <input type="text" name="username" placeholder="Tên đăng nhập" required>
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Mật khẩu" required>
            <input type="text" name="phone" placeholder="Số điện thoại" required>
            <input type="text" name="address" placeholder="Địa chỉ" required>
            <button type="submit">Đăng ký</button>
        </form>
        <p>Đã có tài khoản? <a href="login">Đăng nhập</a></p>
    </div>
</body>
</html>
