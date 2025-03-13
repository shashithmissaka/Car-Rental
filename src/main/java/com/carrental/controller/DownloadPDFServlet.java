package com.carrental.controller;

import com.carrental.dao.BookingDAO;
import com.carrental.model.Booking;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;

@WebServlet("/DownloadPDFServlet")
public class DownloadPDFServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=bookings.pdf");

        try (OutputStream out = response.getOutputStream()) {
            Document document = new Document();
            PdfWriter.getInstance(document, out);
            document.open();

            // Add title
            Font titleFont = new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD);
            Paragraph title = new Paragraph("Booking Details", titleFont);
            title.setAlignment(Element.ALIGN_CENTER);
            document.add(title);
            document.add(new Paragraph("\n"));

            // Fetch username from session
            String username = (String) request.getSession().getAttribute("user");

            if (username == null) {
                document.add(new Paragraph("No user logged in."));
            } else {
                List<Booking> bookings = BookingDAO.getBookingsByUsername(username);

                if (bookings.isEmpty()) {
                    document.add(new Paragraph("No bookings found."));
                } else {
                    // Create table
                    PdfPTable table = new PdfPTable(7);
                    table.addCell("Car Name");
                    table.addCell("Car Type");
                    table.addCell("Start Location");
                    table.addCell("Destination");
                    table.addCell("Distance (km)");
                    table.addCell("Price");
                    table.addCell("Payment Status");

                    for (Booking booking : bookings) {
                        table.addCell(booking.getCarName());
                        table.addCell(booking.getCarType());
                        table.addCell(booking.getStartLocation());
                        table.addCell(booking.getDestination());
                        table.addCell(String.valueOf(booking.getDistance())); // Add distance field
                        table.addCell(String.valueOf(booking.getPrice()));
                        table.addCell(booking.getPaymentStatus());
                    }
                    document.add(table);
                }
            }
            document.close();
        } catch (DocumentException e) {
            throw new IOException(e);
        }
    }
}
