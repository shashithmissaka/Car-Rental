package com.carrental.controller;

import com.carrental.dao.BookingDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/DeleteOneBooking")
public class DeleteOneBooking extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookingIdStr = request.getParameter("bookingId");
        
        if (bookingIdStr != null && !bookingIdStr.isEmpty()) {
            try {
                int bookingId = Integer.parseInt(bookingIdStr);
                
                // Debugging: Log the bookingId received
                System.out.println("Received bookingId: " + bookingId);
                
                // Call DAO method to delete the booking
                boolean isDeleted = BookingDAO.deleteBookingUser(bookingId);
                
                if (isDeleted) {
                    response.sendRedirect("checkBooking.jsp");  // Redirect to the bookings page after deletion
                } else {
                    response.getWriter().write("Error deleting booking.");
                }
            } catch (NumberFormatException e) {
                response.getWriter().write("Invalid booking ID.");
            }
        } else {
            response.getWriter().write("No booking ID provided.");
        }
    }
}
