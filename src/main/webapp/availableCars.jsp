<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="java.util.List, com.carrental.dao.UserDAO, com.carrental.dao.CarDAO, com.carrental.dao.DriverDAO, com.carrental.model.Car, com.carrental.model.Driver" %>
<%@ page import="javax.servlet.http.HttpSession, javax.servlet.http.Cookie" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Available Cars</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <style>
        .footer {
            background-color: #343a40;
            color: white;
            text-align: center;
            padding: 15px 0;
        }
        .car-type-purple { color: purple; font-weight: bold; }
        .car-type-red { color: red; font-weight: bold; }
        .car-type-brown { color: brown; font-weight: bold; }
        .car-type-pink { color: pink; font-weight: bold; }
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
   
    // Retrieve stored locations from cookies
    String startLocation = request.getParameter("startLocation");
    String destination = request.getParameter("destination");
    if (startLocation == null || startLocation.isEmpty() || destination == null || destination.isEmpty()) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("startLocation".equals(cookie.getName())) {
                    startLocation = cookie.getValue();
                } else if ("destination".equals(cookie.getName())) {
                    destination = cookie.getValue();
                }
            }
        }
    }

    if (startLocation == null || startLocation.isEmpty() || destination == null || destination.isEmpty()) {
        response.sendRedirect("payment.jsp?error=missingParams");
        return;
    }// Store selected locations in cookies for future visits
    Cookie startLocationCookie = new Cookie("startLocation", startLocation);
    Cookie destinationCookie = new Cookie("destination", destination);
    startLocationCookie.setMaxAge(60 * 60 * 24);
    destinationCookie.setMaxAge(60 * 60 * 24); 
    response.addCookie(startLocationCookie);
    response.addCookie(destinationCookie);


    // Normalize input to match the database case-insensitively
    List<Car> availableCars = CarDAO.getAvailableCars(startLocation.trim().toLowerCase(), destination.trim().toLowerCase());
%>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark py-4">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">MegaCityCab</a>
        <a class="navbar-brand ps-5">Available Cars</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link active" href="dashboard.jsp">Home</a></li>
 <li class="nav-item">
                    <a class="nav-link" href="dashboard.jsp?startLocation=<%= startLocation %>&destination=<%= destination %>">
                        Back to Booking
                    </a>
                </li> 
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

<div class="container mt-4">
    <div class="row justify-content-center">
        <div class="col-md-8 text-center">
            <div class="p-4 bg-dark text-white rounded-3 shadow">
                <h2 class="fw-bold">
                    <i class="bi bi-car-front-fill text-warning"></i> Available Cars
                </h2>
                <p class="fs-5 text-light mb-0">
                    <span class="text-warning fw-bold"><%= startLocation.toUpperCase() %></span> 
                    <i class="bi bi-arrow-right text-light"></i> 
                    <span class="text-warning fw-bold"><%= destination.toUpperCase() %></span>
                </p>
            </div>
        </div>
    </div>
</div>


<% if (availableCars.isEmpty()) { %>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6 text-center">
                <div class="p-4 bg-danger text-white rounded-3 shadow">
                    <h3 class="fw-bold">
                        <i class="bi bi-exclamation-circle-fill"></i> No Cars Available
                    </h3>
                    <p class="fs-5">Sorry, there are no cars available for the selected route.</p>
 <a class="btn btn-warning"href="dashboard.jsp?startLocation=<%= startLocation %>&destination=<%= destination %>">
                        Back to Booking
                    </a>
                </div>
            </div>
        </div>
    </div>
<% } else { %>
    <div class="container mt-4">
        <div class="table-responsive" style="max-height: 400px; overflow-y: auto;">
            <table class="table table-bordered table-hover custom-table">
                <thead class="table-dark">
                    <tr>
                        <th>Car Name</th>
                        <th>Car Type</th>
                        <th>Driver Name</th>
                        <th>Driver Phone</th>
                        <th>Price</th>
                        <th>Distance</th>
                        <th>Availability</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Car car : availableCars) {
                        Driver driver = DriverDAO.getDriverById(car.getDriverId());

                        // Assign color class based on car type
                        String carTypeClass = "text-warning"; // Default yellow
                        if ("Normal".equalsIgnoreCase(car.getCarType())) {
                            carTypeClass = "text-purple"; // Purple
                        } else if ("Luxury".equalsIgnoreCase(car.getCarType())) {
                            carTypeClass = "text-danger"; // Red
                        } else if ("Semi Luxury".equalsIgnoreCase(car.getCarType())) {
                            carTypeClass = "text-orange"; // Orange
                        }
                    %>
                        <tr>
                            <td><%= car.getCarName() %></td>
                            <td class="<%= carTypeClass %> fw-bold"><%= car.getCarType() %></td>
                            <td><%= (driver != null) ? driver.getDriverName() : "No Driver Assigned" %></td>
                            <td><%= (driver != null) ? driver.getPhone() : "N/A" %></td>
                            <td>Rs.<%= car.getPrice() %></td>
                            <td><%= car.getDistance() %> km</td>
                            <td>
                                <% if (car.isAvailable()) { %>
                                    <span class="text-success fw-bold">Available</span>
                                <% } else { %>
                                    <span class="text-danger fw-bold">Not Available</span>
                                <% } %>
                            </td>
                            <td>
                                <% if (car.isAvailable()) { %>
                                    <form action="confirmBooking.jsp" method="GET">
                                        <input type="hidden" name="carId" value="<%= car.getId() %>">
                                        <input type="hidden" name="startLocation" value="<%= startLocation %>">
                                        <input type="hidden" name="destination" value="<%= destination %>">
                                        <button type="submit" class="btn btn-primary fw-bold">
                                            <i class="bi bi-check-circle"></i> Book Now
                                        </button>
                                    </form>
                                <% } else { %>
                                    <button class="btn btn-secondary" disabled>Not Available</button>
                                <% } %>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
<% } %>



<!-- Footer -->
<footer class="footer fixed-bottom">
    <div class="container">
        <p>&copy; 2025 MegaCityCab. All Rights Reserved.</p>
    </div>
</footer>

</body>
</html>
