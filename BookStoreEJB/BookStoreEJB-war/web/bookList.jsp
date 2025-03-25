<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="bookstore.entity.Book" %>
<html>
<head>
    <title>Book List</title>
</head>
<body>
    <h2>Book List</h2>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Author</th>
            <th>Publisher</th>
            <th>Price</th>
            <th>Stock</th>
            <th>Actions</th>
        </tr>
        <%
            List<Book> books = (List<Book>) request.getAttribute("books");
            for (Book book : books) {
        %>
        <tr>
            <td><%= book.getId() %></td>
            <td><%= book.getTitle() %></td>
            <td><%= book.getAuthor() %></td>
            <td><%= book.getPublisher() %></td>
            <td><%= book.getPrice() %></td>
            <td><%= book.getStock() %></td>
            <td>
                <form action="book" method="post" style="display:inline;">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="id" value="<%= book.getId() %>">
                    <input type="submit" value="Delete">
                </form>
            </td>
        </tr>
        <% } %>
    </table>
    
    <h2>Add Book</h2>
    <form action="book" method="post">
        <input type="hidden" name="action" value="add">
        Title: <input type="text" name="title" required><br>
        Author: <input type="text" name="author" required><br>
        Publisher: <input type="text" name="publisher"><br>
        Price: <input type="number" name="price" step="0.01" required><br>
        Stock: <input type="number" name="stock" required><br>
        <input type="submit" value="Add Book">
    </form>
</body>
</html>
