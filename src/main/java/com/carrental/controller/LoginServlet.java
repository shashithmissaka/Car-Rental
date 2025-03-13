package com.carrental.controller;

import com.carrental.dao.UserDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        HttpSession session = request.getSession();

        // Check if the user is an admin
        if ("admin".equals(username) && "admin".equals(password)) {
            session.setAttribute("user", "admin");
            response.sendRedirect("admin.jsp");
            return;
        }

        // Validate regular users
        if (UserDAO.validateUser(username, password)) {
            session.setAttribute("user", username);
            response.sendRedirect("dashboard.jsp");
        } else {
            // Redirect with an error message if credentials are invalid
            response.sendRedirect("userLogin.jsp?error=Invalid username or password!");
        }
    }
}

