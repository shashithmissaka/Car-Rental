<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*, com.carrental.dao.PaymentDAO, com.carrental.model.Payment, com.carrental.dao.BookingDAO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Payments</title>
    
    <!-- Bootstrap & CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/admin.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>

<%@ include file="admin_header.jsp" %>

<div class="container mt-4">
    <h2 class="mb-4 text-center">Manage Payments</h2>
<!-- Search Bar -->
    <div class="d-flex justify-content-center mb-4">
        <div class="input-group" style="max-width: 400px;">
            <input type="text" class="form-control form-control-sm" id="searchInput" placeholder="Search Payments by ID, Booking ID, or Driver Name">
        </div>
    </div>

    <div class="table-responsive">
        <table class="table table-bordered table-striped" id="paymentsTable">
            <thead class="table-dark">
                <tr>
                    <th>Payment ID</th>
                    <th>Booking ID</th>
                    <th>Payment Status</th>
                    <th>Payment Method</th>
                    <th>Transaction ID</th>
                    <th>Amount</th>
                    <th>Created At</th>
                    <th>Driver ID</th>
                    <th>Driver Name</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Payment> payments = PaymentDAO.getAllPayments();
                    for (Payment payment : payments) {
                %>
                <tr>
                    <td><%= payment.getId() %></td>
                    <td><%= payment.getBookingId() %></td>
                    <td><%= payment.getPaymentStatus() %></td>
                    <td><%= payment.getPaymentMethod() %></td>
                    <td><%= payment.getTransactionId() %></td>
                    <td>Rs.<%= payment.getAmount() %></td>
                    <td><%= payment.getCreatedAt() != null ? payment.getCreatedAt().toString() : "N/A" %></td>
                    <td><%= (payment.getDriverId() != null) ? payment.getDriverId() : "Not Assigned" %></td>
                    <td><%= (payment.getDriverName() != null && !payment.getDriverName().isEmpty()) ? payment.getDriverName() : "Not Assigned" %></td>

                    <td>
                        <% if ("Completed".equals(payment.getPaymentStatus())) { %>
                            <form action="DeletePaymentServlet" method="post" onsubmit="return confirmDelete(<%= payment.getId() %>);">
                                <input type="hidden" name="paymentId" value="<%= payment.getId() %>">
                                <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                            </form>
                        <% } %>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
// Confirm delete action


// Display success message for successful payment deletion
<% if ("Payment deleted successfully!".equals(request.getParameter("success"))) { %>
    $(document).ready(function() {
        Swal.fire({
            icon: 'success',
            title: 'Payment deleted successfully!',
            showConfirmButton: false,
            timer: 1500
        });
    });
<% } %>

// Search functionality for table (Auto search as you type)
$(document).ready(function() {
    $("#searchInput").on("keyup", function() {
        var value = $(this).val().toLowerCase();
        $("#paymentsTable tbody tr").filter(function() {
            $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
        });
    });
});
</script>

</body>
</html>
