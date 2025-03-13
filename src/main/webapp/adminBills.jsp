<%@ page import="java.sql.*" %>
<%@ page import="com.carrental.util.DBConnection" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.carrental.dao.BookingDAO, java.math.BigDecimal" %>
<%@ page import="com.carrental.dao.UserDAO" %>  

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Billing Dashboard</title>
    
    <!-- Bootstrap & FontAwesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/admin.css">
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style>
        .dashboard-container {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
            margin-top: 20px;
        }
        .dashboard-card {
            flex: 1 1 250px;
            max-width: 300px;
        }
    </style>

</head>
<body>

<%@ include file="admin_header.jsp" %>


    <%
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        int totalPayments = 0;
        int completedPayments = 0;
        int pendingPayments = 0;
        int totalBookings = 0;
        double totalRevenue = 0.0;
        int totalCars = 0;
        int totalDrivers = 0;

        try {
            conn = DBConnection.getConnection();

            String[] queries = {
                "SELECT COUNT(*) FROM payments",
                "SELECT COUNT(*) FROM payments WHERE payment_status = 'Completed'",
                "SELECT COUNT(*) FROM bookings WHERE payment_status = 'Pending'",
                "SELECT SUM(amount) FROM payments WHERE payment_status = 'Completed'",
                "SELECT COUNT(*) FROM bookings",
                "SELECT COUNT(*) FROM cars",
                "SELECT COUNT(*) FROM drivers"
            };

            int[] results = {0, 0, 0, 0, 0, 0, 0};
            for (int i = 0; i < queries.length; i++) {
                ps = conn.prepareStatement(queries[i]);
                rs = ps.executeQuery();
                if (rs.next()) {
                    results[i] = (i == 3) ? rs.getInt(1) : rs.getInt(1);
                }
                rs.close();
                ps.close();
            }
            
            totalPayments = results[0];
            completedPayments = results[1];
            pendingPayments = results[2];
            totalRevenue = results[3];
            totalBookings = results[4];
            totalCars = results[5];
            totalDrivers = results[6];

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) conn.close();
        }
    %>

    <%
    BigDecimal totalTaxAmount = BookingDAO.getTotalTaxAmount();
    BigDecimal totalDiscountAmount = BookingDAO.getTotalDiscountAmount();
    int totalDistance=BookingDAO.getTotalDistance();
    int totalUsers = UserDAO.getTotalUsers();

%>
    <div class="dashboard-container">
    <div class="card dashboard-card shadow-lg border-0 bg-primary text-white text-center">
        <div class="card-body">
            <i class="fas fa-wallet fa-3x mb-3"></i>
            <h5>Total Payments</h5>
            <h3><%= totalPayments %></h3>
        </div>
    </div>

    <div class="card dashboard-card shadow-lg border-0 bg-success text-white text-center">
        <div class="card-body">
            <i class="fas fa-check-circle fa-3x mb-3"></i>
            <h5>Completed Payments</h5>
            <h3><%= completedPayments %></h3>
        </div>
    </div>

    <div class="card dashboard-card shadow-lg border-0 bg-info text-white text-center">
        <div class="card-body">
            <i class="fas fa-tags fa-3x mb-3"></i>
            <h5>Total Discounted Amount</h5>
            <h3><%= totalDiscountAmount %> LKR</h3>
        </div>
    </div>

    <div class="card dashboard-card shadow-lg border-0 bg-warning text-dark text-center">
        <div class="card-body">
            <i class="fas fa-exclamation-circle fa-3x mb-3"></i>
            <h5>Pending Payments</h5>
            <h3><%= pendingPayments %></h3>
        </div>
    </div>

    <div class="card dashboard-card shadow-lg border-0 bg-danger text-white text-center">
        <div class="card-body">
            <i class="fas fa-coins fa-3x mb-3"></i>
            <h5>Total Revenue</h5>
            <h3>LKR <%= String.format("%.2f", totalRevenue) %></h3>
        </div>
    </div>

    <div class="card dashboard-card shadow-lg border-0 bg-secondary text-white text-center">
        <div class="card-body">
            <i class="fas fa-calculator fa-3x mb-3"></i>
            <h5>Total Taxed Price</h5>
            <h3>LKR <%= String.format("%.2f", totalTaxAmount) %></h3>
        </div>
    </div>

    <div class="card dashboard-card shadow-lg border-0 bg-dark text-white text-center">
        <div class="card-body">
            <i class="fas fa-book-open fa-3x mb-3"></i>
            <h5>Total Bookings</h5>
            <h3><%= totalBookings %></h3>
        </div>
    </div>

    <div class="card dashboard-card shadow-lg border-0 bg-light text-dark text-center">
        <div class="card-body">
            <i class="fas fa-car fa-3x mb-3"></i>
            <h5>Total Cars</h5>
            <h3><%= totalCars %></h3>
        </div>
    </div>

    <div class="card dashboard-card shadow-lg border-0 bg-primary text-white text-center">
        <div class="card-body">
            <i class="fas fa-user-tie fa-3x mb-3"></i>
            <h5>Total Drivers</h5>
            <h3><%= totalDrivers %></h3>
        </div>
    </div>

    <div class="card dashboard-card shadow-lg border-0 bg-success text-white text-center">
        <div class="card-body">
            <i class="fas fa-road fa-3x mb-3"></i>
            <h5>Total Distance</h5>
            <h3><%= totalDistance %> km</h3>
        </div>
    </div>
    <div class="card dashboard-card shadow-lg border-0 bg-secondary text-white text-center">
    <div class="card-body">
        <i class="fas fa-users fa-3x mb-3"></i>
        <h5>Total Users</h5>
        <h3><%= totalUsers %></h3>
    </div>
</div>
    
</div>


</body>
</html>