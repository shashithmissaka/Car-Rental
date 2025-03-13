package com.carrental.controller;

import com.carrental.dao.BookingDAO;
import com.carrental.dao.DriverDAO;
import com.carrental.dao.PaymentDAO;
import com.carrental.model.Booking;
import com.carrental.model.Driver;
import com.carrental.model.Payment;
import com.carrental.util.PDFGenerator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;

@WebServlet("/DownloadReceiptServlet")
public class DownloadReceiptServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String bookingIdParam = request.getParameter("bookingId");
        if (bookingIdParam == null) {
            response.sendRedirect("checkBookings.jsp?error=missingBookingId");
            return;
        }

        int bookingId = Integer.parseInt(bookingIdParam);

        // Fetch booking, driver, and payment details
        Booking booking = BookingDAO.getBookingById(bookingId);
        Driver driver = (booking != null && booking.getDriverId() != 0) ? DriverDAO.getDriverById(booking.getDriverId()) : null;
        Payment payment = PaymentDAO.getPaymentByBookingId(bookingId);

        if (booking == null || !"Completed".equals(booking.getPaymentStatus())) {
            response.sendRedirect("checkBookings.jsp?error=paymentNotCompleted");
            return;
        }

        // Get Transaction ID
        String transactionId = (payment != null) ? payment.getTransactionId() : "N/A";

        // Generate the PDF receipt with Transaction ID
        try {
            ByteArrayOutputStream pdfBytes = PDFGenerator.generateReceipt(booking, driver, transactionId);

            // Set response headers
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=receipt_" + bookingId + ".pdf");

            // Write the PDF to the response
            OutputStream out = response.getOutputStream();
            pdfBytes.writeTo(out);
            out.flush();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("checkBookings.jsp?error=pdfGenerationFailed");
        }
    }
}