package com.carrental.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("home".equals(action)) {
            // If action is 'home', redirect to the home page without logging out
            response.sendRedirect("index.jsp");
        } else {
            // Normal logout logic
            HttpSession session = request.getSession(false);
            if (session != null && !session.isNew()) { // Ensure session is valid before invalidating
                session.invalidate(); // Invalidate the session on logout
            }
            response.sendRedirect("userLogin.jsp?message=logout"); // Redirect to login page after logout
        }
    }
}
