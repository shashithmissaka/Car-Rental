package com.carrental.controller;

import com.carrental.dao.BookingDAO;
import com.carrental.dao.PaymentDAO;
import com.carrental.dao.DriverDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/DeleteAllBookingsServlet")
public class DeleteAllBookingsServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the current session and username
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("userLogin.jsp");
            return;
        }

        String sessionUsername = (String) session.getAttribute("user");

        // Delete all bookings for the logged-in user
        boolean success = BookingDAO.deleteAllBookingsByUsername(sessionUsername);

        if (success) {
            // Optionally, delete associated payment and driver info if needed
            PaymentDAO.deletePaymentsByUsername(sessionUsername);
            DriverDAO.deleteDriverAssignmentsByUsername(sessionUsername);

            // Redirect back to the "My Bookings" page with a success message
            request.setAttribute("message", "All bookings have been successfully deleted.");
        } else {
            // If deletion failed, set an error message
            request.setAttribute("errorMessage", "Failed to delete all bookings. Please try again.");
        }

        // Forward to the "My Bookings" page to display the result
        request.getRequestDispatcher("checkBooking.jsp").forward(request, response);
    }
}
