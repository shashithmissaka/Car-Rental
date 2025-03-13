package com.carrental.controller;

import com.carrental.dao.CarDAO;
import com.carrental.model.Car;
import java.io.IOException;
import java.math.BigDecimal;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UpdateCarServlet")
public class UpdateCarServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Retrieve parameters from the request
            String carIdParam = request.getParameter("carId");
            String driverIdParam = request.getParameter("driverId");

            if (carIdParam == null || carIdParam.trim().isEmpty()) {
                throw new NumberFormatException("Car ID is missing");
            }

            int carId = Integer.parseInt(carIdParam); // Car ID from the form
            int driverId = (driverIdParam != null && !driverIdParam.trim().isEmpty()) ? Integer.parseInt(driverIdParam) : 0;

            // Retrieve other car details
            String carName = request.getParameter("carName");
            String carType = request.getParameter("carType");
            String startLocation = request.getParameter("startLocation");
            String destination = request.getParameter("destination");
            BigDecimal price = new BigDecimal(request.getParameter("price"));
            boolean availability = "1".equals(request.getParameter("availability"));
            int distance = Integer.parseInt(request.getParameter("distance")); // Distance from the form

            // Create a new Car object with the updated details
            Car car = new Car(carId, carName, carType, startLocation, destination, price, availability, driverId, distance);
            
            // Call the DAO to update the car in the database
            boolean success = CarDAO.updateCar(car);

            // Set response type and encoding
            response.setContentType("text/plain");
            response.setCharacterEncoding("UTF-8");

            if (success) {
                response.getWriter().write("success");  // Send success message if car update was successful
            } else {
                response.getWriter().write("error");  // Send error message if update failed
            }

        } catch (NumberFormatException e) {
            // Catch any number parsing exceptions and log them
            e.printStackTrace();
            response.getWriter().write("error");  // Send error message for number format issues
        }
    }
}
