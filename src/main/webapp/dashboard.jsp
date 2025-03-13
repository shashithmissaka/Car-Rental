<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="java.util.List, com.carrental.dao.UserDAO, com.carrental.dao.CarDAO" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book a Car</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <style>
        body {
            background-color: #f8f9fa;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .main-content {
            flex-grow: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 50px 20px;
        }

        .booking-card {
            width: 100%;
            max-width: 300px;
            padding: 30px;
            background: white;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .booking-card h2 {
            margin-bottom: 20px;
            font-weight: bold;
            color: #343a40;
        }

        .form-label {
            font-weight: bold;
        }

        .swap-btn {
            background: #ffc107;
            border: none;
            border-radius: 50%;
            padding: 10px;
            font-size: 18px;
            margin: 10px 0;
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
    // Fetch start locations and destinations from the database
    List<String> startLocations = CarDAO.getDistinctStartLocations();
    List<String> destinations = CarDAO.getDistinctDestinations();
%>
<%
    HttpSession userSession = request.getSession(false);
    String sessionUsername = (userSession != null) ? (String) userSession.getAttribute("user") : null;

    if (sessionUsername == null) {
        response.sendRedirect("userLogin.jsp");
        return;
    }

    String fullName = UserDAO.getUsernameBySession(sessionUsername);
%>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark py-4">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">MegaCityCab</a>
        <a class="navbar-brand ps-5">Book a Car</a>
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

<!-- Main Content -->
<div class="main-content">
    <div class="booking-card">
        <h2><i class="bi bi-car-front-fill"></i> Book a Car</h2>
        <form action="AvailableCarsServlet" method="post">
            <div class="mb-3">
                <label for="startLocation" class="form-label">Start Location:</label>
                <select class="form-select" id="startLocation" name="startLocation" required>
                    <option value="">Select Start Location</option>
                    <% 
                        String selectedStart = request.getParameter("startLocation");
                        for (String location : startLocations) { 
                    %>
                        <option value="<%= location %>" <%= (location.equals(selectedStart)) ? "selected" : "" %>><%= location %></option>
                    <% } %>
                </select>
            </div>

            <!-- Swap Button -->
            <button type="button" class="swap-btn" onclick="swapLocations()">
                <i class="bi bi-arrow-left-right"></i>
            </button>

            <div class="mb-3">
                <label for="destination" class="form-label">Destination:</label>
                <select class="form-select" id="destination" name="destination" required>
                    <option value="">Select Destination</option>
                    <% 
                        String selectedDest = request.getParameter("destination");
                        for (String destination : destinations) { 
                    %>
                        <option value="<%= destination %>" <%= (destination.equals(selectedDest)) ? "selected" : "" %>><%= destination %></option>
                    <% } %>
                </select>
            </div>

            <button type="submit" class="btn btn-primary w-100">Search Cars</button>
        </form>
    </div>
</div>

<jsp:include page="footer.jsp"/>

<script>
    function swapLocations() {
        var startLocation = document.getElementById("startLocation").value;
        var destination = document.getElementById("destination").value;
        
        // Swap the values of startLocation and destination
        document.getElementById("startLocation").value = destination;
        document.getElementById("destination").value = startLocation;
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
