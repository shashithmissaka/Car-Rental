<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="com.carrental.dao.CarDAO, com.carrental.dao.DriverDAO, com.carrental.dao.UserDAO" %>
<%@ page import="com.carrental.model.Car, com.carrental.model.Driver" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confirm Booking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <style>
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


    HttpSession userSession = request.getSession(false);
    String sessionUsername = (userSession != null) ? (String) userSession.getAttribute("user") : null;
    if (sessionUsername == null) {
        response.sendRedirect("userLogin.jsp");
        return;
    }

    String fullName = UserDAO.getUsernameBySession(sessionUsername);
    String startLocation = request.getParameter("startLocation");
    String destination = request.getParameter("destination");
    String carIdParam = request.getParameter("carId");

    if (startLocation == null || destination == null || carIdParam == null) {
        response.sendRedirect("availableCars.jsp?error=missingParams");
        return;
    }

    int carId = Integer.parseInt(carIdParam);
    Car car = CarDAO.getCarById(carId);
    if (car == null) {
        response.sendRedirect("availableCars.jsp?error=carNotFound");
        return;
    }
    Driver driver = DriverDAO.getDriverById(car.getDriverId());
    int distance = car.getDistance();
    BigDecimal discountPercentage = new BigDecimal("0.05");
    if ("Luxury".equals(car.getCarType())) discountPercentage = new BigDecimal("0.5");
    else if ("Semi Luxury".equals(car.getCarType())) discountPercentage = new BigDecimal("0.15");
    else if ("Normal".equals(car.getCarType())) discountPercentage = new BigDecimal("0.10");

    BigDecimal discountAmount = car.getPrice().multiply(discountPercentage);
    BigDecimal discountedPrice = car.getPrice().subtract(discountAmount);
    BigDecimal taxAmount = discountedPrice.multiply(new BigDecimal("0.10"));
    BigDecimal finalPrice = discountedPrice.add(taxAmount);

%>

    <!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark py-4">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">MegaCityCab</a>
<a class="navbar-brand ps-5">Confirm Booking</a>
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

                <!-- Username with Bootstrap User Icon -->
                <li class="nav-item d-flex align-items-center ms-3 text-white">
                    <i class="bi bi-person-circle me-1"></i>
                    <strong><%= (fullName != null) ? fullName.toUpperCase() : "USER" %></strong>
                </li>
            </ul>
        </div>
    </div>
</nav>


<div class="container mt-5">

<div class="card">
    <div class="card-header text-center">
        <i class="bi bi-receipt"></i> Booking Summary
    </div>
    <div class="card-body">
        <div class="row summary-box">
            <div class="col-md-6">
                <p><i class="bi bi-person-fill"></i> <strong>Customer:</strong> <%= sessionUsername %></p>
                <p><i class="bi bi-car-front"></i> <strong>Car Name:</strong> <%= car.getCarName() %></p>
                <p><i class="bi bi-star-fill"></i> <strong>Car Type:</strong> <%= car.getCarType() %></p>
                <p><i class="bi bi-geo-alt-fill"></i> <strong>Start Location:</strong> <%= startLocation %></p>
                <p><i class="bi bi-geo-alt"></i> <strong>Destination:</strong> <%= destination %></p>
                <p><i class="bi bi-signpost"></i> <strong>Distance:</strong> <%= distance %> km</p>
<p>
    <img src="images/logo.png" alt="Logo" style="width: 150px; height: 150px; vertical-align: middle; margin-right: 8px;">
</p>
            </div>
            <div class="col-md-6">
                <p><i class="bi bi-person-badge"></i> <strong>Driver Name:</strong> <%= (driver != null) ? driver.getDriverName() : "No Driver Assigned" %></p>
                <p><i class="bi bi-telephone"></i> <strong>Driver Phone:</strong> <%= (driver != null) ? driver.getPhone() : "N/A" %></p>
                <hr>
                <div class="pricing-details">
                    <p><strong>Base Price:</strong> Rs.<%= car.getPrice().setScale(2, BigDecimal.ROUND_HALF_UP) %></p>
                    <p><strong>Discount:</strong> Rs.<%= discountAmount.setScale(2, BigDecimal.ROUND_HALF_UP) %></p>
                    <p><strong>Discounted Price:</strong> Rs.<%= discountedPrice.setScale(2, BigDecimal.ROUND_HALF_UP) %></p>
                    <p><strong>Tax Amount (10%):</strong> Rs.<%= taxAmount.setScale(2, BigDecimal.ROUND_HALF_UP) %></p>
                    <p class="text-danger text-center" style="font-size: 1.2rem; font-weight: bold;"><strong>Final Price:</strong> Rs.<%= finalPrice.setScale(2, BigDecimal.ROUND_HALF_UP) %></p>
                </div>
            </div>
        </div>
       <div class="d-flex justify-content-between mt-3">
        <form action="BookingServlet" method="POST" class="w-50">
            <input type="hidden" name="username" value="<%= sessionUsername %>">
            <input type="hidden" name="carId" value="<%= car.getId() %>">
            <input type="hidden" name="startLocation" value="<%= startLocation %>">
            <input type="hidden" name="destination" value="<%= destination %>">
            <input type="hidden" name="distance" value="<%= distance %>">
            <input type="hidden" name="paymentMethod" value="Stripe">
            <input type="hidden" name="carType" value="<%= car.getCarType() %>">
            <input type="hidden" name="discountedPrice" value="<%= discountedPrice %>">
            <input type="hidden" name="taxAmount" value="<%= taxAmount %>">
            <input type="hidden" name="finalPrice" value="<%= finalPrice %>">
            <button type="submit" class="btn btn-success w-100" style="border-radius: 50px; box-shadow: 0 4px 10px rgba(0,0,0,0.2);">
                Confirm & Proceed
            </button>
        </form>
        <a href="dashboard.jsp?startLocation=<%= startLocation %>&destination=<%= destination %>" class="btn btn-danger w-50 ms-2" style="border-radius: 50px; box-shadow: 0 4px 10px rgba(0,0,0,0.2);">
            Cancel
        </a>
    </div>
</div>
</div>
</div><br>
<jsp:include page="footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>