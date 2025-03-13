package com.carrental.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.carrental.util.DBConnection;

@WebServlet("/DeleteBooking")
public class DeleteBooking extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookingId = request.getParameter("bookingId");

        if (bookingId != null && !bookingId.isEmpty()) {
            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement ps = conn.prepareStatement("DELETE FROM bookings WHERE id = ?")) {

                ps.setInt(1, Integer.parseInt(bookingId));
                int rowsAffected = ps.executeUpdate();

                if (rowsAffected > 0) {
                    // Set success message
                    request.setAttribute("success", "Booking deleted successfully!");
                } else {
                    // Set error message if booking not found
                    request.setAttribute("error", "Booking not found.");
                }
            } catch (Exception e) {
                e.printStackTrace();
                // Set error message for exception
                request.setAttribute("error", "Error deleting booking.");
            }
        } else {
            // Set error message for invalid booking ID
            request.setAttribute("error", "Invalid booking ID.");
        }

        // Forward to the adminBookings.jsp page with the message
        request.getRequestDispatcher("adminBookings.jsp").forward(request, response);
    }
}
