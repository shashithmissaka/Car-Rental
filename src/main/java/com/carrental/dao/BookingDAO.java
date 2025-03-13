package com.carrental.dao;

import com.carrental.model.Booking;
import com.carrental.util.DBConnection;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

//delete all booking of the user
public class BookingDAO {
	public static boolean deleteAllBookingsByUsername(String username) {
	    String query = "DELETE FROM bookings WHERE username = ?";
	    try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(query)) {
	        ps.setString(1, username);
	        int rowsAffected = ps.executeUpdate();
	        return rowsAffected > 0;
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    }
	}
	public static boolean deleteBookingUser(int bookingId) {
	    boolean isDeleted = false;
	    String query = "DELETE FROM bookings WHERE id = ?";
	    
	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement ps = conn.prepareStatement(query)) {
	        
	        // Debugging: Log the bookingId value before executing the query
	        System.out.println("Attempting to delete booking with ID: " + bookingId);
	        
	        ps.setInt(1, bookingId);
	        int rowsAffected = ps.executeUpdate();
	        
	        // Debugging: Log the result of the query execution
	        System.out.println("Rows affected: " + rowsAffected);
	        
	        if (rowsAffected > 0) {
	            isDeleted = true;
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return isDeleted;
	}

	public static BigDecimal getTotalTaxAmount() {
	    String query = "SELECT SUM(tax_amount) FROM bookings";
	    BigDecimal totalTax = BigDecimal.ZERO;

	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(query);
	         ResultSet rs = ps.executeQuery()) {
	        if (rs.next()) {
	            totalTax = rs.getBigDecimal(1);
	            if (totalTax == null) {
	                totalTax = BigDecimal.ZERO;
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return totalTax;
	}
	public static int getTotalDistance() {
	    int totalDistance = 0;
	    String sql = "SELECT SUM(distance) FROM bookings";

	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql);
	         ResultSet rs = ps.executeQuery()) {

	        if (rs.next()) {
	            totalDistance = rs.getInt(1);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return totalDistance;
	}


	public static BigDecimal getTotalDiscountAmount() {
        BigDecimal totalDiscount = BigDecimal.ZERO;
        String sql = "SELECT SUM(discounted_price) FROM bookings";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                totalDiscount = rs.getBigDecimal(1);
                if (totalDiscount == null) {
                    totalDiscount = BigDecimal.ZERO;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return totalDiscount;
    }


    // Add a new booking
	public static boolean addBooking(Booking booking) {
	    Connection conn = DBConnection.getConnection();
	    String sql = "INSERT INTO bookings (username, car_id, car_name, start_location, destination, price, "
	               + "discounted_price, tax_amount, final_price, payment_status, driver_id, payment_method, "
	               + "car_type, distance) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

	    // Debug: Print values before inserting
	    System.out.println("=== DEBUG: Booking Object Before Insert ===");
	    System.out.println("Username: " + booking.getUsername());
	    System.out.println("Car ID: " + booking.getCarId());
	    System.out.println("Car Name: " + booking.getCarName());
	    System.out.println("Start Location: " + booking.getStartLocation());
	    System.out.println("Destination: " + booking.getDestination());
	    System.out.println("Price: " + booking.getPrice());
	    System.out.println("Discounted Price: " + booking.getDiscountedPrice());
	    System.out.println("Tax Amount: " + booking.getTaxAmount());
	    System.out.println("Final Price: " + booking.getFinalPrice());
	    System.out.println("Payment Status: " + booking.getPaymentStatus());
	    System.out.println("Driver ID: " + booking.getDriverId());
	    System.out.println("Payment Method: " + booking.getPaymentMethod());
	    System.out.println("Car Type: " + booking.getCarType());
	    System.out.println("Distance: " + booking.getDistance());
	    System.out.println("==========================================");

	    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
	        // Ensuring proper decimal format
	        stmt.setString(1, booking.getUsername());
	        stmt.setInt(2, booking.getCarId());
	        stmt.setString(3, booking.getCarName());
	        stmt.setString(4, booking.getStartLocation());
	        stmt.setString(5, booking.getDestination());
	        stmt.setBigDecimal(6, booking.getPrice().setScale(2, RoundingMode.HALF_UP));
	        stmt.setBigDecimal(7, booking.getDiscountedPrice().setScale(2, RoundingMode.HALF_UP));
	        stmt.setBigDecimal(8, booking.getTaxAmount().setScale(2, RoundingMode.HALF_UP));
	        stmt.setBigDecimal(9, booking.getFinalPrice().setScale(2, RoundingMode.HALF_UP));
	        stmt.setString(10, booking.getPaymentStatus());
	        stmt.setInt(11, booking.getDriverId());
	        stmt.setString(12, booking.getPaymentMethod());
	        stmt.setString(13, booking.getCarType());
	        stmt.setInt(14, booking.getDistance());

	        int rowsAffected = stmt.executeUpdate();
	        System.out.println("Rows affected: " + rowsAffected);
	        return rowsAffected > 0;
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    }
	}




    // Get all bookings for a user
    public static List<Booking> getBookingsByUser(String username) {
        String query = "SELECT * FROM bookings WHERE username = ?";
        List<Booking> bookings = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    bookings.add(mapResultSetToBooking(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    // Get all bookings
    public static List<Booking> getAllBookings() {
        String query = "SELECT * FROM bookings";
        List<Booking> bookings = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                bookings.add(mapResultSetToBooking(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    // Get booking by ID
    public static Booking getBookingById(int bookingId) {
        String query = "SELECT * FROM bookings WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, bookingId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToBooking(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get last booking ID for a user
    public static int getLastBookingId(String username) {
        String query = "SELECT id FROM bookings WHERE username = ? ORDER BY id DESC LIMIT 1";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("id");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    // Update payment status of a booking
    public static boolean updatePaymentStatus(int bookingId, String paymentStatus) {
        String query = "UPDATE bookings SET payment_status = ? WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, paymentStatus);
            ps.setInt(2, bookingId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static boolean updateTransactionId(int bookingId, String transactionId) {
        String query = "UPDATE bookings SET transaction_id = ? WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, transactionId);
            ps.setInt(2, bookingId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static boolean deleteBooking(int bookingId) {
        boolean deleted = false;
        String sql = "DELETE FROM bookings WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, bookingId);
            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                deleted = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return deleted;
    }

    // Get bookings by username
    public static List<Booking> getBookingsByUsername(String username) {
        return getBookingsByUser(username); // Avoid duplicate method logic
    }
    
 

 // Map ResultSet to Booking object
    private static Booking mapResultSetToBooking(ResultSet rs) throws SQLException {
        return new Booking(
            rs.getInt("id"),
            rs.getString("username"),
            rs.getInt("car_id"),
            rs.getString("car_name"),
            rs.getString("start_location"),
            rs.getString("destination"),
            rs.getBigDecimal("price"),
            rs.getBigDecimal("discounted_price"),  // Added this line
            rs.getBigDecimal("tax_amount"),        // Added this line
            rs.getBigDecimal("final_price"),       // Added this line
            rs.getString("payment_status"),
            rs.getTimestamp("created_at"),
            rs.getInt("driver_id"),
            rs.getString("payment_method"),
            rs.getString("car_type"),
            rs.getInt("distance"),  // Added this line
            rs.getString("transaction_id") // Added this line
        );
    }

}
