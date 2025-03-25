<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đặt hàng thành công</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            text-align: center;
            padding: 50px;
        }
        .container {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            display: inline-block;
        }
        h1 {
            color: #28a745;
        }
        p {
            font-size: 18px;
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
        .btn-success {
            background-color: #28a745;
        }
        .btn-success:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>

    <div class="container">
        <h1>🎉 Đặt hàng thành công!</h1>
        <p>Cảm ơn bạn đã mua hàng. Đơn hàng của bạn đã được ghi nhận.</p>

        <a href="orderHistory" class="btn btn-success">Xem đơn hàng</a>
        <a href="books" class="btn">Tiếp tục mua</a>
        <a href="index.html" class="btn">Về trang chủ</a>
    </div>

</body>
</html>
