<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*, com.carrental.model.User, com.carrental.dao.UserDAO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users</title>
    
    <!-- Bootstrap & CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/admin.css">
    <link rel="stylesheet" href="css/adminUsers.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
<%@ include file="admin_header.jsp" %>

<%
    List<User> userList = UserDAO.getAllUsers();
%>

<div class="container mt-5">
    <!-- Search Bar -->
    <div class="d-flex justify-content-center mb-4">
        <div class="input-group" style="max-width: 400px;">
            <input type="text" class="form-control form-control-sm" id="searchInput" placeholder="Search Users">
        </div>
    </div>

    <div class="row users-container" id="usersContainer">
    <% for (User user : userList) { %>
        <div class="col-lg-2 col-md-3 col-sm-6 mb-2 px-1 user-card">
            <div class="card shadow-sm border-0">
                <div class="card-body text-center">
                    <h5 class="card-title"><%= user.getUsername() %></h5>
                    <p class="text-muted"><i class="fa-solid fa-phone"></i> <%= user.getPhone() %></p>
                    <p class="text-muted"><i class="fa-solid fa-id-card"></i> <%= user.getNic() %></p>
                    <p class="text-muted"><i class="fa-solid fa-envelope"></i> <%= user.getEmail() %></p>

                    <div class="d-flex justify-content-center">
                        <button class="btn btn-primary me-2 edit-user-btn"
                            data-bs-toggle="modal"
                            data-bs-target="#editUserModal"
                            data-username="<%= user.getUsername() %>"
                            data-phone="<%= user.getPhone() %>"
                            data-nic="<%= user.getNic() %>"
                            data-email="<%= user.getEmail() %>">
                            Edit
                        </button>
                        <button class="btn btn-danger" onclick="deleteUser('<%= user.getUsername() %>')">
                            Delete
                        </button>
                    </div>
                </div>
            </div>
        </div>
    <% } %>
</div>
</div>
<!-- Modal for Edit User -->
<div class="modal fade" id="editUserModal" tabindex="-1" aria-labelledby="editUserModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editUserModalLabel">Edit User</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="editUserForm" action="UpdateUserServlet" method="post">
                    <div class="mb-3">
                        <label for="username" class="form-label">Username</label>
                        <input type="text" class="form-control" id="username" name="username" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="phone" class="form-label">Phone</label>
                        <input type="text" class="form-control" id="phone" name="phone">
                    </div>
                    <div class="mb-3">
                        <label for="nic" class="form-label">NIC</label>
                        <input type="text" class="form-control" id="nic" name="nic">
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" class="form-control" id="email" name="email">
                    </div>
                    <button type="submit" class="btn btn-success">Save Changes</button>
                </form>
            </div>
        </div>
    </div>
</div>
<script src="js/adminUsers.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
