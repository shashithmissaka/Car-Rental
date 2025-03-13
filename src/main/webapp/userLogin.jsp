<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Login</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        /* Ensure body takes full height */
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            background-color: #f8f9fa;
        }

        /* Center login form vertically */
        .main-content {
            flex-grow: 1; 
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        /* Login form container */
        .form-container {
            width: 100%;
            max-width: 350px; /* Reduced width */
            padding: 25px;
            background: white;
            border-radius: 12px;
            box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.15);
        }

        /* Form input fields */
        .form-control {
            border-radius: 8px; /* Smooth edges */
            padding: 10px;
            font-size: 14px;
        }

        /* Spacing between input fields */
        .form-group {
            margin-bottom: 15px;
        }

        /* Styled login button */
        .btn-primary {
            padding: 10px;
            font-size: 16px;
            font-weight: bold;
            border-radius: 8px;
            transition: 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

        /* Footer */
        .footer {
            background-color: #343a40;
            color: white;
            text-align: center;
            padding: 15px 0;
        }
    </style>
</head>
<body>

<jsp:include page="header.jsp"/>

<!-- Centered Login Form -->
<div class="main-content">
    <div class="form-container">
        <h3 class="text-center mb-4">Login</h3>
        <form action="LoginServlet" method="POST">
            <div class="form-group">
                <label for="username" class="form-label">Username:</label>
                <input type="text" name="username" id="username" class="form-control" required>
            </div>

            <div class="form-group">
                <label for="password" class="form-label">Password:</label>
                <input type="password" name="password" id="password" class="form-control" required>
            </div>

            <button type="submit" class="btn btn-primary w-100">Login</button>
        </form>

        <p class="mt-3 text-center">
            New Here? <a href="userRegister.jsp" class="register-link">Create an account</a>
        </p>
    </div>
</div>

<jsp:include page="footer.jsp"/>

<!-- Hidden Error Message -->
<span id="error-message-data" style="display: none;">
    <%= (request.getAttribute("errorMessage") != null) ? request.getAttribute("errorMessage") : "" %>
</span>

<!-- Bootstrap & External Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="js/login.js"></script>

</body>
</html>
