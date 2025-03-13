package com.carrental.dao;

import com.carrental.model.Payment;
import com.carrental.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PaymentDAO {
	public static void deletePaymentsByUsername(String username) {
	    String query = "DELETE FROM payments WHERE username = ?";
	    try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(query)) {
	        ps.setString(1, username);
	        ps.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}

    // Add a new payment to the database, including driver_id
    public static boolean addPayment(Payment payment) {
        String query = "INSERT INTO payments (booking_id, amount, payment_status, payment_method, transaction_id, created_at, driver_id) " +
                       "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, payment.getBookingId());
            ps.setBigDecimal(2, payment.getAmount());
            ps.setString(3, payment.getPaymentStatus());
            ps.setString(4, payment.getPaymentMethod());
            ps.setString(5, payment.getTransactionId());
            ps.setTimestamp(6, payment.getCreatedAt());

            // Handle NULL driverId
            if (payment.getDriverId() != null && payment.getDriverId() > 0) {
                ps.setInt(7, payment.getDriverId());
            } else {
                ps.setNull(7, Types.INTEGER);
            }

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get payment details by booking ID
    public static Payment getPaymentByBookingId(int bookingId) {
        String query = "SELECT p.id, p.booking_id, p.amount, p.payment_status, p.payment_method, p.transaction_id, p.created_at, " +
                       "d.driver_id, d.driver_name FROM payments p " +
                       "LEFT JOIN drivers d ON p.driver_id = d.driver_id " +
                       "WHERE p.booking_id = ?";
        Payment payment = null;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, bookingId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    payment = new Payment(
                        rs.getInt("id"),
                        rs.getInt("booking_id"),
                        rs.getBigDecimal("amount"),
                        rs.getString("payment_status"),
                        rs.getString("payment_method"),
                        rs.getString("transaction_id"),
                        rs.getTimestamp("created_at"),
                        rs.getInt("driver_id") == 0 ? null : rs.getInt("driver_id"),
                        rs.getString("driver_name")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return payment;
    }

    // Retrieve all payments from the database
    public static List<Payment> getAllPayments() {
        List<Payment> payments = new ArrayList<>();
        String query = "SELECT p.id, p.booking_id, p.amount, p.payment_status, p.payment_method, p.transaction_id, p.created_at, " +
                       "d.driver_id, d.driver_name FROM payments p " +
                       "LEFT JOIN drivers d ON p.driver_id = d.driver_id";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Payment payment = new Payment(
                    rs.getInt("id"),
                    rs.getInt("booking_id"),
                    rs.getBigDecimal("amount"),
                    rs.getString("payment_status"),
                    rs.getString("payment_method"),
                    rs.getString("transaction_id"),
                    rs.getTimestamp("created_at"),
                    rs.getInt("driver_id") == 0 ? null : rs.getInt("driver_id"),
                    rs.getString("driver_name")
                );
                payments.add(payment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return payments;
    }
}
