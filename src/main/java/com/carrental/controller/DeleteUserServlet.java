package com.carrental.controller;

import com.carrental.dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/deleteUserServlet")
public class DeleteUserServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve the username parameter from the request
        String username = request.getParameter("username");

        // Call UserDAO to delete the user from the database
        boolean isDeleted = UserDAO.deleteUser(username);

        // Redirect with a success flag for SweetAlert
        if (isDeleted) {
            response.sendRedirect("adminUsers.jsp?deleteSuccess=true");
        } else {
            response.sendRedirect("adminUsers.jsp?deleteError=true");
        }
    }
}
