package com.carrental.controller;

import com.carrental.dao.DriverDAO;
import java.io.IOException;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DeleteDriverServlet")
public class DeleteDriverServlet extends HttpServlet {
    
    private static final Logger logger = Logger.getLogger(DeleteDriverServlet.class.getName());
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        logger.info("DeleteDriverServlet doGet triggered.");
        
        String driverId = request.getParameter("driverId");
        
        try {
            int id = Integer.parseInt(driverId);
            boolean deleteStatus = DriverDAO.deleteDriver(id);
            logger.info("Driver deletion status: " + deleteStatus);
            
            if (deleteStatus) {
                response.sendRedirect("adminDrivers.jsp?message=Driver deleted successfully");
            } else {
                response.sendRedirect("adminDrivers.jsp?error=Failed to delete driver.");
            }
        } catch (NumberFormatException e) {
            logger.warning("Invalid driver ID format.");
            response.sendRedirect("adminDrivers.jsp?error=Invalid driver ID.");
        }
    }
}