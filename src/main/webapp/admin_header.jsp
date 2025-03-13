<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="css/admin.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="admin.jsp"><i class="bi bi-car-front-fill"></i> Admin Panel</a>
<a class="navbar-brand">
                <i>&nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;Welcome To Admin Panel</i> 
            </a>        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <span class="nav-link text-white" id="greeting"></span>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle text-white" href="#" role="button" data-bs-toggle="dropdown">
                        <i class="bi bi-person-circle"></i> Admin
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><a class="dropdown-item" href="userLogin.jsp"><i class="bi bi-box-arrow-in-right"></i> Login</a></li>
                        <li><a class="dropdown-item" href="index.jsp"><i class="bi bi-box-arrow-right"></i> Logout</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="sidebar">
    <div>
        <a href="adminUsers.jsp" id="usersLink" class="nav-link"><i class="bi bi-people-fill"></i> <span>Users</span></a>
        <a href="adminBookings.jsp" id="bookingsLink" class="nav-link"><i class="bi bi-calendar-check-fill"></i> <span>Bookings</span></a>
        <a href="adminCars.jsp" id="carsLink" class="nav-link"><i class="bi bi-car-front-fill"></i> <span>Cars</span></a>
        <a href="adminPayments.jsp" id="paymentsLink" class="nav-link"><i class="bi bi-credit-card-fill"></i> <span>Payments</span></a>
        <a href="adminDrivers.jsp" id="driversLink" class="nav-link"><i class="bi bi-person-fill-gear"></i> <span>Drivers</span></a>
        <a href="adminBills.jsp" id="billsLink" class="nav-link"><i class="bi bi-receipt"></i> <span>Bills</span></a>
        <a href="index.jsp" class="logout-btn nav-link"><i class="bi bi-box-arrow-right"></i> <span>Logout</span></a>
    </div>
</div>

<div class="container mt-4">
    <h2 class="mb-4 text-center" id="pageTitle">Manage Users</h2>
</div>

<script src="js/adminHeader.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</body>
</html>
