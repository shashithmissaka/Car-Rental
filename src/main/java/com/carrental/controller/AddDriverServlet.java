package com.carrental.controller;

import com.carrental.dao.DriverDAO;
import com.carrental.model.Driver;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

@WebServlet("/AddDriverServlet")
public class AddDriverServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String driverName = request.getParameter("driverName");
        String phone = request.getParameter("phone");

        Driver driver = new Driver();
        driver.setDriverName(driverName);
        driver.setPhone(phone);

        boolean success = DriverDAO.addDriver(driver);

        if (success) {
            response.sendRedirect("adminDrivers.jsp?success=true");
        } else {
            response.sendRedirect("adminDrivers.jsp?error=true");
        }
    }
}
