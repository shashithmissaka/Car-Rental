package com.carrental.controller;

import com.carrental.dao.PaymentDAO;
import com.carrental.dao.BookingDAO;
import com.carrental.dao.DriverDAO;
import com.carrental.model.Booking;
import com.carrental.model.Payment;
import com.carrental.util.StripePayment;
import com.carrental.util.PayPalPayment;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(PaymentServlet.class.getName());

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Get request parameters
            String bookingIdParam = request.getParameter("bookingId");
            String amountParam = request.getParameter("amount");
            String paymentMethod = request.getParameter("paymentMethod");

            // Validate input parameters
            if (bookingIdParam == null || amountParam == null || paymentMethod == null) {
                response.sendRedirect("checkBooking.jsp?error=missingParams");
                return;
            }

            int bookingId = Integer.parseInt(bookingIdParam);
            BigDecimal amount = new BigDecimal(amountParam);
            String transactionId = null;
            boolean paymentSuccess = false;

            // Process payment based on selected method
            if ("Stripe".equals(paymentMethod)) {
                transactionId = StripePayment.processPayment(amount);
            } else if ("PayPal".equals(paymentMethod)) {
                transactionId = PayPalPayment.processPayment(amount);
            } else {
                response.sendRedirect("payment.jsp?error=invalidPaymentMethod");
                return;
            }

            paymentSuccess = (transactionId != null);

            if (paymentSuccess) {
                // Fetch booking details to get the driver_id
                Booking booking = BookingDAO.getBookingById(bookingId);
                int driverId = (booking != null) ? booking.getDriverId() : 0;

                // Fetch driver name only if driverId is valid
                String driverName = (driverId > 0) ? DriverDAO.getDriverNameById(driverId) : "Not Assigned";

                // Create a Payment object with all necessary fields
                Payment payment = new Payment(
                    0,
                    bookingId,
                    amount,
                    "Completed",
                    paymentMethod,
                    transactionId,
                    new Timestamp(System.currentTimeMillis()),
                    driverId,
                    driverName
                );

                // Store payment details
                boolean paymentStored = PaymentDAO.addPayment(payment);

                if (paymentStored) {
                    boolean bookingUpdated = BookingDAO.updatePaymentStatus(bookingId, "Completed");
                    boolean transactionUpdated = BookingDAO.updateTransactionId(bookingId, transactionId);
                    if (bookingUpdated && transactionUpdated) {
                        response.sendRedirect("checkBooking.jsp?success=paymentComplete");
                    } else {
                        LOGGER.log(Level.WARNING, "Failed to update booking status or transaction ID.");
                        response.sendRedirect("payment.jsp?error=bookingUpdateFailed");
                    }
                } else {
                    LOGGER.log(Level.WARNING, "Failed to store payment details.");
                    response.sendRedirect("payment.jsp?error=paymentFailed");
                }
            } else {
                LOGGER.log(Level.WARNING, "Payment processing failed.");
                response.sendRedirect("payment.jsp?error=paymentFailed");
            }
        } catch (NumberFormatException e) {
            LOGGER.log(Level.SEVERE, "Invalid input format: ", e);
            response.sendRedirect("payment.jsp?error=invalidInput");
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error: ", e);
            response.sendRedirect("payment.jsp?error=unexpectedError");
        }
    }
}
