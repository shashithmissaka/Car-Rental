<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="com.carrental.dao.BookingDAO, com.carrental.model.Booking" %>
<%@ page import="com.carrental.dao.UserDAO" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <link rel="stylesheet" href="source/css/main.css">
    
    <style>
        /* Custom Styling */
        body {
            background-color: #f8f9fa;
        }
        .payment-container {
            max-width: 550px;
            background: #ffffff;
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            padding: 30px;
        }
        .form-select {
            border-radius: 10px;
        }
        .btn-custom {
            border-radius: 50px;
            padding: 10px 20px;
            font-weight: bold;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
        }
        .icon {
            font-size: 1.2rem;
            margin-right: 8px;
        }
        .footer {
            background-color: #343a40;
            color: white;
            text-align: center;
            padding: 15px 0;
        }
    </style>
</head>
<body>

<%
    // Retrieve user session
    HttpSession userSession = request.getSession(false);
    String sessionUsername = (userSession != null) ? (String) userSession.getAttribute("user") : null;
    String fullName = UserDAO.getUsernameBySession(sessionUsername);

    // Get bookingId from request
    String bookingId = request.getParameter("bookingId");

    if (sessionUsername == null || bookingId == null) {
        response.sendRedirect("userLogin.jsp");
        return;
    }

    // Fetch booking details
    Booking booking = BookingDAO.getBookingById(Integer.parseInt(bookingId));
    if (booking == null) {
        response.sendRedirect("checkBookings.jsp?error=invalidBooking");
        return;
    }
%>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark py-4">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">MegaCityCab</a>
        <a class="navbar-brand ps-5">Secure Payment</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link active" href="dashboard.jsp">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="checkBooking.jsp">My Bookings</a></li>
                <li class="nav-item">
    <a class="nav-link" href="#" data-bs-toggle="modal" data-bs-target="#helpModal">Help</a>
</li>
<jsp:include page="helpModal.jsp"/>
                <li class="nav-item"><a class="nav-link" href="LogoutServlet">Logout</a></li>
                <li class="nav-item d-flex align-items-center ms-3 text-white">
                    <i class="bi bi-person-circle me-1"></i>
                    <strong><%= (fullName != null) ? fullName.toUpperCase() : "USER" %></strong>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Payment Card -->
<div class="container mt-5 d-flex justify-content-center">
    <div class="payment-container">
        <h3 class="text-center mb-3">Complete Your Payment</h3>
        <hr>

        <!-- Booking Details -->
        <div class="mb-3">
            <p><i class="bi bi-receipt-cutoff icon text-primary"></i> <strong>Booking ID:</strong> <%= booking.getId() %></p>
            <p><i class="bi bi-car-front icon text-success"></i> <strong>Car:</strong> <%= booking.getCarName() %></p>
            <p><i class="bi bi-geo-alt icon text-danger"></i> <strong>From:</strong> <%= booking.getStartLocation() %></p>
            <p><i class="bi bi-geo icon text-info"></i> <strong>To:</strong> <%= booking.getDestination() %></p>
            <p><i class="bi bi-cash-coin icon text-warning"></i> <strong>Total cost:</strong> Rs. <%= booking.getFinalPrice() %></p>
        </div>

        <!-- Payment Form -->
        <form action="PaymentServlet" method="POST">
            <input type="hidden" name="bookingId" value="<%= booking.getId() %>">
            <input type="hidden" name="amount" value="<%= booking.getFinalPrice() %>">

            <!-- Payment Method Selection -->
            <div class="mb-3">
                <label for="paymentMethod" class="form-label"><strong>Select Payment Method</strong></label>
                <select name="paymentMethod" class="form-select" required>
                    <option value="Stripe"><i class="bi bi-credit-card-2-front"></i> Pay with Stripe</option>
                    <option value="PayPal"><i class="bi bi-paypal"></i> Pay with PayPal</option>
                </select>
            </div>

            <!-- Action Buttons -->
            <div class="d-flex justify-content-between">
                <button type="submit" class="btn btn-warning btn-custom">
                    <i class="bi bi-arrow-right-circle"></i> Proceed to Payment
                </button>
                <a href="checkBooking.jsp" class="btn btn-danger btn-custom">
                    <i class="bi bi-x-circle"></i> Cancel
                </a>
            </div>
        </form>
    </div>
</div>
<br>
<jsp:include page="footer.jsp"/>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
