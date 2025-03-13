package com.carrental.controller;

import com.carrental.dao.UserDAO;
import com.carrental.model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String nic = request.getParameter("nic");
        String email = request.getParameter("email");  // Capture email input

        User user = new User(username, password, phone, nic, email);

        // Check if the user was successfully registered
        boolean isRegistered = UserDAO.registerUser(user);

        if (isRegistered) {
            response.sendRedirect("userLogin.jsp?message=registered");
        } else {
            // Redirect with an error message depending on which field caused the issue
            if (UserDAO.isEmailExists(email)) {
                response.sendRedirect("userRegister.jsp?error=email_taken");
            } else {
                response.sendRedirect("userRegister.jsp?error=username_taken");
            }
        }
    }
}
