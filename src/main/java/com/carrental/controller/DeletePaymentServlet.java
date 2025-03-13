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

@WebServlet("/DeletePaymentServlet")
public class DeletePaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String paymentId = request.getParameter("paymentId");

        if (paymentId != null) {
            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement ps = conn.prepareStatement("DELETE FROM payments WHERE id = ?")) {
                ps.setInt(1, Integer.parseInt(paymentId));
                int rowsAffected = ps.executeUpdate();

                if (rowsAffected > 0) {
                    response.sendRedirect("adminPayments.jsp?success=Payment deleted successfully!");
                } else {
                    response.sendRedirect("adminPayments.jsp?error=Failed to delete payment.");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("adminPayments.jsp?error=Error deleting payment.");
            }
        } else {
            response.sendRedirect("adminPayments.jsp?error=Invalid payment ID.");
        }
    }
}
