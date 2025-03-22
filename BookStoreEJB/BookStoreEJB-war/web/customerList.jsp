<table>
    <tr><th>Name</th><th>Email</th><th>Phone</th><th>Address</th></tr>
    <c:forEach var="customer" items="${customers}">
        <tr>
            <td>${customer.name}</td>
            <td>${customer.email}</td>
            <td>${customer.phone}</td>
            <td>${customer.address}</td>
        </tr>
    </c:forEach>
</table>