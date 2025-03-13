package com.carrental.controller;

import java.io.IOException;
import java.math.BigDecimal;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.carrental.dao.CarDAO;
import com.carrental.model.Car;

@WebServlet("/AddCarServlet")
public class AddCarServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String carName = request.getParameter("carName");
            String carType = request.getParameter("carType");
            String startLocation = request.getParameter("startLocation");
            String destination = request.getParameter("destination");
            boolean availability = "1".equals(request.getParameter("availability"));
            BigDecimal price = new BigDecimal(request.getParameter("price")); // Fixed price parsing
            int driverId = Integer.parseInt(request.getParameter("driverId"));
            int distance = Integer.parseInt(request.getParameter("distance")); // Added distance parameter

            // Creating a car object without an ID (ID is auto-increment in DB)
            Car newCar = new Car(0, carName, carType, startLocation, destination, price, availability, driverId, distance);

            boolean isAdded = CarDAO.addCar(newCar);

            if (isAdded) {
                response.sendRedirect("adminCars.jsp?success=Car Added Successfully");
            } else {
                response.sendRedirect("adminCars.jsp?error=Failed to Add Car");
            }
        } catch (Exception e) {
            response.sendRedirect("adminCars.jsp?error=Invalid Input Data");
        }
    }
}
