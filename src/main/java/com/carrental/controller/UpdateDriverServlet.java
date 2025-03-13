package com.carrental.controller;

import com.carrental.dao.DriverDAO;
import com.carrental.model.Driver;
import java.util.logging.Logger;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/UpdateDriverServlet")
public class UpdateDriverServlet extends HttpServlet {
    
    private static final Logger logger = Logger.getLogger(UpdateDriverServlet.class.getName());
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        logger.info("UpdateDriverServlet doPost triggered.");
        
        // Retrieve form data
        String driverId = request.getParameter("driverId");
        String driverName = request.getParameter("driverName");
        String phone = request.getParameter("phone");

        logger.info("Received form data: Driver ID = " + driverId + ", Driver Name = " + driverName + ", Phone = " + phone);
        
        try {
            int id = Integer.parseInt(driverId);
            Driver driver = new Driver(id, driverName, phone);

            boolean updateStatus = DriverDAO.updateDriver(driver);
            logger.info("Driver update status: " + updateStatus);

            if (updateStatus) {
                response.sendRedirect("adminDrivers.jsp?success=Driver updated successfully");
            } else {
                response.sendRedirect("adminDrivers.jsp?error=Failed to update driver details.");
            }
        } catch (NumberFormatException e) {
            logger.warning("Invalid driver ID format.");
            response.sendRedirect("adminDrivers.jsp?error=Invalid driver ID.");
        }
    }
}
