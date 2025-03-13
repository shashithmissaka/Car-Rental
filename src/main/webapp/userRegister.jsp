<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Registration</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <style>
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            background-color: #f8f9fa;
        }

        .main-content {
            flex-grow: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .form-container {
            width: 100%;
            max-width: 350px;
            padding: 25px;
            background: white;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }

        .form-group {
            margin-bottom: 15px;
        }

        .footer {
            background-color: #343a40;
            color: white;
            text-align: center;
            padding: 15px 0;
        }

        .register-text {
            text-align: center;
            margin-top: 10px;
        }
    </style>   
</head>
<body>
<jsp:include page="header.jsp"/>

<div class="main-content">
    <div class="form-container">
        <h3 class="text-center mb-3">Register</h3>
        <form action="RegisterServlet" method="POST">
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" name="username" id="username" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" name="password" id="password" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="phone">Phone:</label>
                <input type="text" name="phone" id="phone" class="form-control" placeholder="07XXXXXXXX" required pattern="^\d{10}$">
            </div>
            <div class="form-group">
                <label for="nic">NIC:</label>
                <input type="text" name="nic" id="nic" class="form-control" placeholder="123456789V or 123456789012" required pattern="^\d{9}[Vv]|\d{12}$" title="Enter 9 digits followed by 'V' or 'v' (e.g., 123456789V) or a full 12-digit number (e.g., 123456789012)">
            </div>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" name="email" id="email" class="form-control" required>
            </div>
            <div class="form-group">
                <input type="submit" value="Register" class="btn btn-primary w-100">
            </div>
        </form>
        <p class="register-text">
            Already Have An Account? <a href="userLogin.jsp" class="register-link">Log In</a>
        </p>
    </div>
</div>

<jsp:include page="footer.jsp"/>

<span id="error-message-data" style="display: none;">
    <%= (request.getAttribute("errorMessage") != null) ? request.getAttribute("errorMessage") : "" %>
</span>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="js/login.js"></script>
</body>
</html>
