<%@ page import="java.util.List" %>
<%@ page import="com.carrental.dao.CarDAO" %>
<%@ page import="com.carrental.model.Car" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Manage Cars</title>
    
    <!-- Bootstrap & CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/admin.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>

<%@ include file="admin_header.jsp" %>

<div class="container mt-4">
    <h2 class="mb-4 text-center">Manage Cars</h2>

    <!-- Search Input -->
    <!-- Search Input -->
<div class="mb-4">
    <input type="text" id="searchInput" class="form-control form-control-sm w-50 mx-auto" placeholder="Search by car name or type">
</div>
    <!-- Centered Add Car Button -->
<div class="d-flex justify-content-center mb-3">
    <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addCarModal">
        <i class="bi bi-plus-circle"></i> Add Car
    </button>
</div>
    

    <div class="table-container">
    <div class="table-responsive">
        <table class="table table-bordered text-center" id="bookingsTable">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Car Name</th>
                    <th>Car Type</th>
                    <th>Start Location</th>
                    <th>Destination</th>
                    <th>Availability</th>
                    <th>Price (Rs.)</th>
                    <th>Driver ID</th>
                    <th>Distance</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% List<Car> cars = CarDAO.getAllCars();
                   for (Car car : cars) { %>
                <tr>
                    <td><%= car.getId() %></td>
                    <td><%= car.getCarName() %></td>
                    <td><%= car.getCarType() %></td>
                    <td><%= car.getStartLocation() %></td>
                    <td><%= car.getDestination() %></td>
                    <td><%= car.isAvailable() ? "Available" : "Not Available" %></td>
                    <td>Rs. <%= car.getPrice() %></td>
                    <td><%= car.getDriverId() %></td>
                    <td><%= car.getDistance() %></td>
                    <td>
                        <button class="btn btn-primary btn-sm" onclick="openUpdateModal('<%= car.getId() %>', '<%= car.getCarName() %>', '<%= car.getCarType() %>', '<%= car.getStartLocation() %>', '<%= car.getDestination() %>', '<%= car.isAvailable() %>', '<%= car.getPrice() %>', '<%= car.getDriverId() %>', '<%= car.getDistance() %>')">Update</button>
                        
                        <form id="deleteCarForm-<%= car.getId() %>" action="DeleteCarServlet" method="post" style="display: none;">
                            <input type="hidden" name="carId" value="<%= car.getId() %>">
                        </form>
                        <button class="btn btn-danger btn-sm" onclick="confirmDelete('<%= car.getId() %>')">Delete</button>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>
<!-- Update Modal -->
<div class="modal fade" id="updateCarModal" tabindex="-1" aria-labelledby="updateCarModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="updateCarModalLabel">Update Car</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form id="editCarForm" action="UpdateCarServlet" method="post">
                    <input type="hidden" id="carId" name="carId">

                    <div class="mb-3">
                        <label class="form-label">Car Name</label>
                        <input type="text" class="form-control" id="carName" name="carName" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Car Type</label>
                        <input type="text" class="form-control" id="carType" name="carType" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Start Location</label>
                        <input type="text" class="form-control" id="startLocation" name="startLocation" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Destination</label>
                        <input type="text" class="form-control" id="destination" name="destination" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Availability</label>
                        <select class="form-select" id="availability" name="availability" required>
                            <option value="1">Available</option>
                            <option value="0">Not Available</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Price (Rs.)</label>
                        <input type="number" step="0.01" class="form-control" id="price" name="price" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Driver ID</label>
                        <input type="number" class="form-control" id="driverId" name="driverId" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Distance (Km)</label>
                        <input type="number" class="form-control" id="distance" name="distance" required>
                    </div>

                    <button type="submit" class="btn btn-success w-100">Save Changes</button>
                </form>
            </div>
        </div>
    </div>
</div>


<!-- Add Car Modal -->
<div class="modal fade" id="addCarModal" tabindex="-1" aria-labelledby="addCarModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addCarModalLabel">Add New Car</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="addCarForm" action="AddCarServlet" method="post">
                    <div class="mb-3">
                        <label class="form-label">Car Name</label>
                        <input type="text" class="form-control" name="carName" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Car Type</label>
                        <input type="text" class="form-control" name="carType" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Start Location</label>
                        <input type="text" class="form-control" name="startLocation" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Destination</label>
                        <input type="text" class="form-control" name="destination" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Availability</label>
                        <select class="form-select" name="availability" required>
                            <option value="1">Available</option>
                            <option value="0">Not Available</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Price (Rs.)</label>
                        <input type="number" step="0.01" class="form-control" name="price" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Driver ID</label>
                        <input type="number" class="form-control" name="driverId" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Distance (Km)</label>
                        <input type="number" class="form-control" name="distance" required>
                    </div>

                    <button type="submit" class="btn btn-primary w-100">Add Car</button>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    $(document).ready(function() {
        // Search Functionality
        $("#searchInput").on("keyup", function() {
            var value = $(this).val().toLowerCase();
            $("#bookingsTable tbody tr").filter(function() {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
            });
        });

        // Modal and Form Submission
        $("#editCarForm").submit(function (e) {
            e.preventDefault();
            
            $.ajax({
                type: "POST",
                url: "UpdateCarServlet",
                data: $(this).serialize(),
                success: function (response) {
                    console.log("Server response:", response); // Debugging
                    
                    if (response.trim() === "success") {
                        Swal.fire({
                            title: "Updated!",
                            text: "Car details updated successfully.",
                            icon: "success"
                        }).then(() => location.reload());
                    } else {
                        Swal.fire("Error!", "Failed to update car.", "error");
                    }
                },
                error: function () {
                    Swal.fire("Error!", "Request failed.", "error");
                }
            });
        });
    });

    // Open Update Modal
    function openUpdateModal(carId, carName, carType, startLocation, destination, availability, price, driverId, distance) {
        $("#carId").val(carId);
        $("#carName").val(carName);
        $("#carType").val(carType);
        $("#startLocation").val(startLocation);
        $("#destination").val(destination);
        $("#price").val(price);
        $("#availability").val(availability === "true" ? "1" : "0");
        $("#driverId").val(driverId);
        $("#distance").val(distance);  // Added this line
        new bootstrap.Modal($("#updateCarModal")).show();
    }

    // Confirm Delete
    function confirmDelete(carId) {
        Swal.fire({
            title: "Are you sure?",
            text: "This car will be permanently deleted!",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#d33",
            cancelButtonColor: "#3085d6",
            confirmButtonText: "Yes, delete it!"
        }).then((result) => {
            if (result.isConfirmed) {
                $.post("DeleteCarServlet", { carId: carId }, function (response) {
                    if (response.trim() === "success") {
                        Swal.fire({
                            title: "Deleted!",
                            text: "Car deleted successfully.",
                            icon: "success"
                        }).then(() => location.reload());
                    } else if (response.trim() === "has_bookings") {
                        Swal.fire("Cannot Delete", "This car has active bookings.", "warning");
                    } else {
                        Swal.fire("Cannot Delete", "This car has active bookings.", "warning");
                    }
                }).fail(() => Swal.fire("Error!", "Request failed.", "error"));
            }
        });
    }
</script>

</body>
</html>
