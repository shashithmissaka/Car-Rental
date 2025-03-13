package com.carrental.dao;

import com.carrental.model.Driver;
import com.carrental.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DriverDAO {
	public static void deleteDriverAssignmentsByUsername(String username) {
	    String query = "UPDATE cars SET driver_id = NULL WHERE driver_id IN (SELECT id FROM drivers WHERE username = ?)";
	    try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(query)) {
	        ps.setString(1, username);
	        ps.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}

    private static final Logger logger = Logger.getLogger(DriverDAO.class.getName());

    // Get a driver by their ID
    public static Driver getDriverById(int driverId) {
        String query = "SELECT * FROM drivers WHERE driver_id = ? LIMIT 1";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, driverId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Driver(
                        rs.getInt("driver_id"),
                        rs.getString("driver_name"),
                        rs.getString("phone")
                    );
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error fetching driver by ID: {0}", e);
        }
        return null;
    }

    // Get driver name by ID
    public static String getDriverNameById(int driverId) {
        String query = "SELECT driver_name FROM drivers WHERE driver_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, driverId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("driver_name");
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error fetching driver name by ID: {0}", e);
        }
        return "Unknown Driver";
    }

    // Add a new driver to the database
    public static boolean addDriver(Driver driver) {
        String query = "INSERT INTO drivers (driver_name, phone) VALUES (?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, driver.getDriverName());
            ps.setString(2, driver.getPhone());
            
            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        driver.setDriverId(rs.getInt(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error adding driver: {0}", e);
        }
        return false;
    }

    // Update an existing driver's details
    public static boolean updateDriver(Driver driver) {
        String query = "UPDATE drivers SET driver_name = ?, phone = ? WHERE driver_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, driver.getDriverName());
            ps.setString(2, driver.getPhone());
            ps.setInt(3, driver.getDriverId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error updating driver: {0}", e);
        }
        return false;
    }

    // Delete a driver from the database
    public static boolean deleteDriver(int driverId) {
        String query = "DELETE FROM drivers WHERE driver_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, driverId);
            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                logger.log(Level.INFO, "Driver with ID {0} deleted successfully.", driverId);
                return true;
            } else {
                logger.log(Level.WARNING, "No driver found with ID {0}. Deletion failed.", driverId);
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error deleting driver: {0}", e);
        }
        return false;
    }

    // Get a list of all drivers
    public static List<Driver> getAllDrivers() {
        List<Driver> driverList = new ArrayList<>();
        String query = "SELECT * FROM drivers";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Driver driver = new Driver(
                    rs.getInt("driver_id"),
                    rs.getString("driver_name"),
                    rs.getString("phone")
                );
                driverList.add(driver);
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error retrieving driver list: {0}", e);
        }
        return driverList;
    }
}
