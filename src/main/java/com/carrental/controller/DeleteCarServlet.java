package com.carrental.controller;

import com.carrental.dao.CarDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DeleteCarServlet")
public class DeleteCarServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String carIdParam = request.getParameter("carId");
            if (carIdParam == null || carIdParam.trim().isEmpty()) {
                response.sendRedirect("adminCars.jsp?error=Invalid Car ID");
                return;
            }

            int carId = Integer.parseInt(carIdParam);

            if (CarDAO.hasActiveBookings(carId)) {
                response.getWriter().write("has_bookings");
            } else {
                boolean success = CarDAO.deleteCar(carId);
                if (success) {
                    response.getWriter().write("success");
                } else {
                    response.getWriter().write("error");
                }
            }
        } catch (NumberFormatException e) {
            response.getWriter().write("error");
        }
    }
}