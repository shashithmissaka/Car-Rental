package com.carrental.dao;

import com.carrental.model.Car;
import com.carrental.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CarDAO {

    // Get distinct start locations
    public static List<String> getDistinctStartLocations() {
        List<String> locations = new ArrayList<>();
        String query = "SELECT DISTINCT LOWER(start_location) as start_location FROM cars";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                locations.add(capitalizeFirstLetter(rs.getString("start_location")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return locations;
    }
    public static int getCarDistance(String startLocation, String destination) {
        int distance = 0;
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT distance FROM cars WHERE start_location = ? AND destination = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, startLocation);
            pst.setString(2, destination);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                distance = rs.getInt("distance");
            } else {
                System.out.println("No distance found for startLocation: " + startLocation + " and destination: " + destination);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        System.out.println("Fetched distance: " + distance);  // Debug log
        return distance;
    }


    // Get distinct destinations
    public static List<String> getDistinctDestinations() {
        List<String> destinations = new ArrayList<>();
        String query = "SELECT DISTINCT LOWER(destination) as destination FROM cars";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                destinations.add(capitalizeFirstLetter(rs.getString("destination")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return destinations;
    }

    public static boolean hasActiveBookings(int carId) {
        String query = "SELECT COUNT(*) FROM bookings WHERE car_id = ? AND payment_status = 'Paid'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, carId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next() && rs.getInt(1) > 0) {
                return true; // Car has active bookings
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get available cars
    public static List<Car> getAvailableCars(String startLocation, String destination) {
        List<Car> cars = new ArrayList<>();
        String query = "SELECT * FROM cars WHERE LOWER(start_location) = LOWER(?) AND LOWER(destination) = LOWER(?) AND availability = 1";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, startLocation.toLowerCase());
            stmt.setString(2, destination.toLowerCase());

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    cars.add(mapCarFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cars;
    }

    // Get a car by ID
    public static Car getCarById(int carId) {
        String query = "SELECT * FROM cars WHERE id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, carId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapCarFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Update car availability
    public static boolean updateCarAvailability(int carId, int availability) {
        String sql = "UPDATE cars SET availability = ? WHERE id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, availability);
            stmt.setInt(2, carId);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete a car (Ensure no dependent bookings or payments exist)
    public static boolean deleteCar(int carId) {
        String checkQuery = "SELECT COUNT(*) FROM bookings WHERE car_id = ?";
        String deleteQuery = "DELETE FROM cars WHERE id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement checkStmt = con.prepareStatement(checkQuery);
             PreparedStatement deleteStmt = con.prepareStatement(deleteQuery)) {

            checkStmt.setInt(1, carId);
            try (ResultSet rs = checkStmt.executeQuery()) {
                if (rs.next() && rs.getInt(1) > 0) {
                    System.out.println("Cannot delete car. It has active bookings.");
                    return false;
                }
            }

            deleteStmt.setInt(1, carId);
            return deleteStmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Update car details
    public static boolean updateCar(Car car) {
        String query = "UPDATE cars SET car_name=?, car_type=?, start_location=?, destination=?, price=?, availability=?, driver_id=?, distance=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, car.getCarName());
            ps.setString(2, car.getCarType());
            ps.setString(3, car.getStartLocation());
            ps.setString(4, car.getDestination());
            ps.setBigDecimal(5, car.getPrice());
            ps.setBoolean(6, car.isAvailable());
            ps.setInt(7, car.getDriverId());
            ps.setInt(8, car.getDistance());  // Set the distance value
            ps.setInt(9, car.getId());    // Update WHERE condition (carId)

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    // Get all cars
    public static List<Car> getAllCars() {
        List<Car> carList = new ArrayList<>();
        String query = "SELECT * FROM cars";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                carList.add(mapCarFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return carList;
    }

    // Helper method to map a ResultSet row to a Car object
    private static Car mapCarFromResultSet(ResultSet rs) throws SQLException {
        return new Car(
            rs.getInt("id"),
            rs.getString("car_name"),
            rs.getString("car_type"),
            capitalizeFirstLetter(rs.getString("start_location")),
            capitalizeFirstLetter(rs.getString("destination")),
            rs.getBigDecimal("price"),
            rs.getBoolean("availability"),
            rs.getInt("driver_id"),
            rs.getInt("distance") 
        );
    }

    private static String capitalizeFirstLetter(String text) {
        if (text == null || text.isEmpty()) return text;
        String[] words = text.split("\\s+");
        for (int i = 0; i < words.length; i++) {
            if (words[i].length() > 1) {
                words[i] = Character.toUpperCase(words[i].charAt(0)) + words[i].substring(1).toLowerCase();
            } else {
                words[i] = words[i].toUpperCase();
            }
        }
        return String.join(" ", words);
    }
    


    public static boolean addCar(Car newCar) {
        // Include the distance field in the SQL INSERT statement
        String sql = "INSERT INTO cars (car_name, car_type, start_location, destination, price, availability, driver_id, distance) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, newCar.getCarName());
            stmt.setString(2, newCar.getCarType());
            stmt.setString(3, newCar.getStartLocation());
            stmt.setString(4, newCar.getDestination());
            stmt.setBigDecimal(5, newCar.getPrice());
            stmt.setBoolean(6, newCar.isAvailable());
            stmt.setInt(7, newCar.getDriverId());
            stmt.setInt(8, newCar.getDistance()); // Set the distance value

            int affectedRows = stmt.executeUpdate();

            if (affectedRows > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        newCar.setId(generatedKeys.getInt(1));
                    }
                }
                return true; // Car added successfully
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // Failed to add car
    }
}