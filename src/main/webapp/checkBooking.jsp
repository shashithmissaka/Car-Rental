<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="java.util.List, com.carrental.dao.UserDAO, com.carrental.dao.CarDAO, com.carrental.dao.BookingDAO, com.carrental.dao.DriverDAO, com.carrental.dao.PaymentDAO" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="com.carrental.model.Booking, com.carrental.model.Driver, com.carrental.model.Payment" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <style>
        ..table {
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.15);
        }
        .table th {
            background-color: #343a40 !important;
            color: white !important;
            text-transform: uppercase;
        }
        .table tbody tr:hover {
            background-color: #f8f9fa;
        }
        .badge {
            font-size: 0.9em;
            padding: 5px 10px;
        }
        html, body {
            height: 100%;
            margin: 0;
            display: flex;
            flex-direction: column;
        }
        main {
            flex: 1;
        }
        .footer {
            background-color: #343a40;
            color: white;
            text-align: center;
            padding: 15px 0;
            margin-top: auto;
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

    // Fetch user bookings from the database
    List<Booking> userBookings = BookingDAO.getBookingsByUsername(sessionUsername);
%>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark py-4">

    <div class="container">
        <a class="navbar-brand" href="index.jsp">MegaCityCab</a>
        <a class="navbar-brand ps-5">My Bookings</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link active" href="index.jsp">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="dashboard.jsp">Book a Car</a></li>
                <li class="nav-item">
    <a class="nav-link" href="#" data-bs-toggle="modal" data-bs-target="#helpModal">Help</a>
</li>
                <li class="nav-item"><a class="nav-link" href="logout.jsp">Logout</a></li>

                <!-- Username with Bootstrap User Icon -->
                <li class="nav-item d-flex align-items-center ms-3 text-white">
                    <i class="bi bi-person-circle me-1"></i>
                    <strong><%= (fullName != null) ? fullName.toUpperCase() : "USER" %></strong>
                </li>
            </ul>
        </div>
    </div>
</nav>

<main class="container mt-5">
    <% if (userBookings == null || userBookings.isEmpty()) { %>
        <div class="alert alert-warning text-center fw-bold shadow-sm rounded">
            <i class="bi bi-exclamation-circle"></i> No available bookings yet.
        </div>
    <% } else { %>
        <div class="container mt-4">
            <form action="DeleteAllBookingsServlet" method="post" onsubmit="return confirm('Are you sure you want to delete all bookings?');">
                <button type="submit" class="btn btn-danger mb-3">
                    <i class="bi bi-trash"></i> Delete All Bookings
                </button>
            </form>
        </div>
        <table class="table table-hover table-striped text-center align-middle shadow-lg rounded overflow-hidden">
            <thead class="table-dark">
                <tr>
                    <th scope="col">Car Name</th>
                    <th scope="col">Car Type</th>
                    <th scope="col">Start Location</th>
                    <th scope="col">Destination</th>
                    <th scope="col">Base Price</th>
                    <th scope="col">Amount to Pay/Paid</th>
                    <th scope="col">Payment Status</th>
                    <th scope="col">Driver Name</th>
                    <th scope="col">Driver Phone</th>
                    <th scope="col">Payment Method</th>
                    <th scope="col">Payment Date</th>
                    <th scope="col">Download Receipt</th>
                    <th scope="col">Action</th>
                </tr>
            </thead>
            <tbody class="table-light">
                <% for (Booking booking : userBookings) { 
                    Driver driver = DriverDAO.getDriverById(booking.getDriverId());
                    Payment payment = PaymentDAO.getPaymentByBookingId(booking.getId());
                %>
                <tr class="border-bottom">
                    <td><strong><%= booking.getCarName() %></strong></td>
                    <td><span class="badge bg-primary"><%= booking.getCarType() %></span></td>
                    <td><%= booking.getStartLocation() %></td>
                    <td><%= booking.getDestination() %></td>
                    <td><strong>Rs. <%= booking.getPrice() %></strong></td>
                    <td><strong class="text-success">Rs. <%= booking.getFinalPrice() %></strong></td>
                    <td>
                        <% if ("Completed".equalsIgnoreCase(booking.getPaymentStatus())) { %>
                            <span class="badge bg-success">Completed</span>
                        <% } else { %>
                            <span class="badge bg-warning text-dark">Pending</span>
                        <% } %>
                    </td>
                    <td><%= (driver != null) ? driver.getDriverName() : "<span class='text-muted'>No Driver Assigned</span>" %></td>
                    <td><%= (driver != null) ? driver.getPhone() : "<span class='text-muted'>N/A</span>" %></td>
                    <td><%= (payment != null) ? payment.getPaymentMethod() : "<span class='text-muted'>N/A</span>" %></td>
                    <td><%= (payment != null) ? payment.getCreatedAt() : "<span class='text-muted'>N/A</span>" %></td>
                    <td>
                        <% if ("Completed".equalsIgnoreCase(booking.getPaymentStatus())) { %>
                            <a href="DownloadReceiptServlet?bookingId=<%= booking.getId() %>" class="btn btn-outline-primary btn-sm">
                                <i class="bi bi-file-earmark-pdf"></i> Download
                            </a>
                        <% } else { %>
                            <span class="text-danger"><i class="bi bi-exclamation-circle"></i> Pending</span>
                        <% } %>
                    </td>
                    <td>
                        <form action="DeleteOneBooking" method="post" style="display:inline;">
                            <input type="hidden" name="bookingId" value="<%= booking.getId() %>" />
                            <button type="submit" class="btn btn-outline-danger btn-sm">
                                <i class="bi bi-trash"></i> Delete
                            </button>
                        </form>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    <% } %>
</main>
<footer class="footer mt-auto">
    <jsp:include page="footer.jsp"/>
</footer>
</body>
</html>
