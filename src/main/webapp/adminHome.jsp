<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Panel</title>

    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <link rel="stylesheet" href="css/admin.css">
</head>
<body>

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg">
        <div class="container-fluid">
            <a class="navbar-brand" href="admin.jsp">
                <i class="bi bi-car-front-fill"></i> Admin Panel
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <!-- Dynamic Greeting -->
                    <li class="nav-item">
                        <span class="nav-link text-white" id="greeting"></span>
                    </li>
                    
                    <!-- Dropdown Menu -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle text-white" href="#" role="button" data-bs-toggle="dropdown">
                            <i class="bi bi-person-circle"></i> Admin
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" href="index.jsp" id="logoutBtn"><i class="bi bi-box-arrow-right"></i> Logout</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Sidebar -->
    <div class="sidebar">
        <div>
            <a href="adminUsers.jsp" id="usersLink" class="nav-link">
                <i class="bi bi-people-fill"></i> <span>Users</span>
            </a>
            <a href="adminBookings.jsp" id="bookingsLink" class="nav-link">
                <i class="bi bi-calendar-check-fill"></i> <span>Bookings</span>
            </a>
            <a href="adminCars.jsp" id="carsLink" class="nav-link">
                <i class="bi bi-car-front-fill"></i> <span>Cars</span>
            </a>
            <a href="adminPayments.jsp" id="paymentsLink" class="nav-link">
                <i class="bi bi-credit-card-fill"></i> <span>Payments</span>
            </a>
            <a href="adminDrivers.jsp" id="driversLink" class="nav-link">
                <i class="bi bi-person-fill-gear"></i> <span>Drivers</span>
            </a>
            <a href="adminBills.jsp" id="billsLink" class="nav-link">
                <i class="bi bi-receipt"></i> <span>Bills</span>
            </a>
            <a href="index.jsp" class="logout-btn nav-link">
                <i class="bi bi-box-arrow-right"></i> <span>Logout</span>
            </a>
        </div>
    </div>

    <!-- JavaScript for Greeting & Logout -->
    <script>
    window.onload = function() {
        // Greeting Message
        function getGreeting() {
            const hours = new Date().getHours();
            if (hours < 12) return "Good Morning,";
            else if (hours < 18) return "Good Afternoon,";
            else return "Good Evening,";
        }

        // Check if the element exists before updating
        let greetingElement = document.getElementById("greeting");
        if (greetingElement) {
            greetingElement.innerText = getGreeting();
        }
    };
    </script>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        // Get current page name
        const currentPage = window.location.pathname.split("/").pop();

        // Map pages to sidebar links
        const pageMapping = {
            "adminUsers.jsp": "usersLink",
            "adminBookings.jsp": "bookingsLink",
            "adminCars.jsp": "carsLink",
            "adminPayments.jsp": "paymentsLink",
            "adminDrivers.jsp": "driversLink",
            "adminBills.jsp": "billsLink"
        };

        // Add "active" class to the correct sidebar link
        if (pageMapping[currentPage]) {
            document.getElementById(pageMapping[currentPage]).classList.add("active");
        }
    </script>
</body>
</html>
