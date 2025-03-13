package com.carrental.controller;

import com.carrental.dao.CarDAO;
import com.carrental.model.Car;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/AvailableCarsServlet")
public class AvailableCarsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String startLocation = request.getParameter("startLocation");
        String destination = request.getParameter("destination");

        // Store startLocation and destination in cookies
        Cookie startLocationCookie = new Cookie("startLocation", startLocation);
        Cookie destinationCookie = new Cookie("destination", destination);

        // Set cookie expiration to 1 hour (3600 seconds)
        startLocationCookie.setMaxAge(60 * 60);
        destinationCookie.setMaxAge(60 * 60);

        // Add cookies to response
        response.addCookie(startLocationCookie);
        response.addCookie(destinationCookie);

        // Fetch available cars from the database
        List<Car> availableCars = CarDAO.getAvailableCars(startLocation, destination);

        // Set the available cars list in the request
        request.setAttribute("availableCars", availableCars);
        request.setAttribute("selectedStartLocation", startLocation);
        request.setAttribute("selectedDestination", destination);

        // Forward to availableCars.jsp for display
        request.getRequestDispatcher("availableCars.jsp").forward(request, response);
    }
}
