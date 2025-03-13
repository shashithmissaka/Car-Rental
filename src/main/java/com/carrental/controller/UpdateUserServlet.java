package com.carrental.controller;

import com.carrental.dao.UserDAO;
import com.carrental.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/UpdateUserServlet")
public class UpdateUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        String username = request.getParameter("username");
        String phone = request.getParameter("phone");
        String nic = request.getParameter("nic");
        String email = request.getParameter("email");

        // Create a User object with updated information
        User updatedUser = new User();
        updatedUser.setUsername(username);
        updatedUser.setPhone(phone);
        updatedUser.setNic(nic);
        updatedUser.setEmail(email);

        // Call UserDAO to update user details in the database
        boolean isUpdated = UserDAO.updateUser(updatedUser);

        // Redirect with a success flag for SweetAlert
        if (isUpdated) {
            response.sendRedirect("adminUsers.jsp?updateSuccess=true");
        } else {
            response.sendRedirect("adminUsers.jsp?updateError=true");
        }
    }
}
