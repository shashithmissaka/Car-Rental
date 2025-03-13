<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*, com.carrental.model.Booking, com.carrental.dao.BookingDAO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Bookings</title>

    <!-- Bootstrap & CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/admin.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>

<%@ include file="admin_header.jsp" %>

<div class="container mt-4">
    <h2 class="mb-4 text-center">Manage Bookings</h2>

    <!-- Search Bar -->
    <div class="d-flex justify-content-center mb-4">
        <div class="input-group" style="max-width: 400px;">
            <input type="text" class="form-control form-control-sm" id="searchInput" placeholder="Search Bookings by ID, Username, Car Name, or Driver ID">
        </div>
    </div>

    <div class="table-container">
        <div class="table-responsive">
            <table class="table table-bordered text-center" id="bookingsTable">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Username</th>
                        <th>Car Name</th>
                        <th>Car Type</th>
                        <th>Start Location</th>
                        <th>Destination</th>
                        <th>Price</th>
                        <th>Payment Status</th>
                        <th>Payment Method</th>
                        <th>Transaction ID</th>
                        <th>Driver ID</th>
                        <th>Created At</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        BookingDAO bookingDAO = new BookingDAO();
                        List<Booking> bookings = bookingDAO.getAllBookings();
                        for (Booking booking : bookings) {
                    %>
                    <tr>
                        <td><%= booking.getId() %></td>
                        <td><%= booking.getUsername() %></td>
                        <td><%= booking.getCarName() %></td>
                        <td><%= booking.getCarType() %></td>
                        <td><%= booking.getStartLocation() %></td>
                        <td><%= booking.getDestination() %></td>
                        <td>Rs.<%= booking.getPrice() %></td>
                        <td><%= booking.getPaymentStatus() %></td>
                        <td><%= booking.getPaymentMethod() %></td>
                        <td><%= booking.getTransactionId() %></td>
                        <td><%= booking.getDriverId() != 0 ? booking.getDriverId() : "Not Assigned" %></td>
                        <td><%= booking.getCreatedAt() %></td>
                        <td>
                                        <% 
                if ("Completed".equals(booking.getPaymentStatus())) { 
            %>
                <form action="DeleteBooking" method="post">
                    <input type="hidden" name="bookingId" value="<%= booking.getId() %>">
                    <button type="submit" class="btn btn-danger">Delete</button>
                </form>
            <% 
                } else if ("Pending".equals(booking.getPaymentStatus())) {
            %>
                <span class="text-danger">unpaid Bookings</span>
            <% 
                }
            %>

                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
// Auto Search functionality for bookings table
$(document).ready(function() {
    $("#searchInput").on("keyup", function() {
        var value = $(this).val().toLowerCase();
        $("#bookingsTable tbody tr").filter(function() {
            $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
        });
    });

    // Show success message for booking deletion
    <% if ("Booking deleted successfully!".equals(request.getAttribute("success"))) { %>
        Swal.fire({
            icon: 'success',
            title: 'Booking deleted successfully!',
            showConfirmButton: false,
            timer: 1500
        });
    <% } %>
});
</script>

</body>
</html>
