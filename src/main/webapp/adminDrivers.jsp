<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*, com.carrental.model.Driver, com.carrental.dao.DriverDAO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Drivers</title>

    <!-- Bootstrap & FontAwesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>

<%@ include file="admin_header.jsp" %>

<%
    // Fetching all drivers using the DriverDAO
    List<Driver> driverList = DriverDAO.getAllDrivers();
%>

<div class="container mt-4">
    <h2 class="mb-4 text-center">Manage Drivers</h2>

    <!-- Centering the search input and add driver button -->
    <div class="d-flex flex-column align-items-center mb-4">
        <!-- Search Input -->
        <div class="mb-3" style="max-width: 300px;">
            <input type="text" class="form-control form-control-sm" id="searchInput" placeholder="Search by ID, Name, or Phone...">
        </div>

        <!-- Add Driver Button with Icon -->
        <button class="btn btn-success btn-sm mb-3" data-bs-toggle="modal" data-bs-target="#addDriverModal">
            <i class="fas fa-user-plus"></i> Add Driver
        </button>
    </div>

    <div class="table-responsive">
        <table class="table table-bordered text-center" id="driverTable">
            <thead class="table-dark">
                <tr>
                    <th>Driver ID</th>
                    <th>Driver Name</th>
                    <th>Driver Phone</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    for (Driver driver : driverList) {
                %>
                <tr>
                    <td><%= driver.getDriverId() %></td>
                    <td><%= driver.getDriverName() %></td>
                    <td><%= driver.getPhone() %></td>
                    <td>
                        <!-- Edit Button -->
                        <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#editDriverModal"
                            data-driver-id="<%= driver.getDriverId() %>"
                            data-driver-name="<%= driver.getDriverName() %>"
                            data-phone="<%= driver.getPhone() %>">
                            <i class="fas fa-edit"></i> Edit
                        </button>

                        <!-- Delete Button -->
                        <button class="btn btn-danger btn-sm" onclick="deleteDriver('<%= driver.getDriverId() %>')">
                            <i class="fas fa-trash-alt"></i> Delete
                        </button>
                    </td>
                </tr>
                <% 
                    }
                %>
            </tbody>
        </table>
    </div>
</div>

<!-- Modal for Add Driver -->
<div class="modal fade" id="addDriverModal" tabindex="-1" aria-labelledby="addDriverModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addDriverModalLabel">Add Driver</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="addDriverForm" action="AddDriverServlet" method="post">
                    <div class="mb-3">
                        <label for="newDriverName" class="form-label">Driver Name</label>
                        <input type="text" class="form-control" id="newDriverName" name="driverName" required>
                    </div>
                    <div class="mb-3">
                        <label for="newPhone" class="form-label">Phone</label>
                        <input type="text" class="form-control" id="newPhone" name="phone" required>
                    </div>
                    <button type="submit" class="btn btn-success">
                        <i class="fas fa-user-plus"></i> Add Driver
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Modal for Edit Driver -->
<div class="modal fade" id="editDriverModal" tabindex="-1" aria-labelledby="editDriverModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editDriverModalLabel">Edit Driver</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="editDriverForm" action="UpdateDriverServlet" method="post">
                    <input type="hidden" id="driverId" name="driverId">
                    
                    <div class="mb-3">
                        <label for="driverName" class="form-label">Driver Name</label>
                        <input type="text" class="form-control" id="driverName" name="driverName" required>
                    </div>
                    <div class="mb-3">
                        <label for="phone" class="form-label">Phone</label>
                        <input type="text" class="form-control" id="phone" name="phone" required>
                    </div>
                    <button type="submit" class="btn btn-success">
                        <i class="fas fa-save"></i> Save Changes
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
// Handle Edit Modal population
var editDriverModal = document.getElementById('editDriverModal');
editDriverModal.addEventListener('show.bs.modal', function (event) {
    var button = event.relatedTarget;
    var driverId = button.getAttribute('data-driver-id');
    var driverName = button.getAttribute('data-driver-name');
    var phone = button.getAttribute('data-phone');

    editDriverModal.querySelector('#driverId').value = driverId;
    editDriverModal.querySelector('#driverName').value = driverName;
    editDriverModal.querySelector('#phone').value = phone;
});
$(document).ready(function () {
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.has('success')) {
        Swal.fire({
            icon: 'success',
            title: 'Success!',
            text: urlParams.get('success'),
            confirmButtonText: 'OK'
        }).then(() => {
            window.history.replaceState({}, document.title, window.location.pathname);
        });
    }
});
function deleteDriver(driverId) {
    Swal.fire({
        title: 'Are you sure?',
        text: 'You won\'t be able to revert this!',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Yes, delete it!',
        cancelButtonText: 'No, cancel!'
    }).then((result) => {
        if (result.isConfirmed) {
            window.location.href = "DeleteDriverServlet?driverId=" + driverId;
        }
    })
}

// Search Functionality
$(document).ready(function () {
    $("#searchInput").on("keyup", function () {
        var value = $(this).val().toLowerCase();
        $("#driverTable tbody tr").filter(function () {
            $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
        });
    });
});
</script>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
