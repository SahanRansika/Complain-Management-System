package org.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import org.example.dao.UserDAO;
import org.example.dto.UserDTO;

import java.io.IOException;

@WebServlet("/signin")
public class SignInServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            System.out.println("[LOGIN] Values: " + username + ", " + password);

            // DAO through credentials validate karanawa
            UserDTO user = UserDAO.getUserByCredentials(username, password);

            if (user != null) {
                // Session ekak hadala user data daanna
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setAttribute("userId", user.getId()); // 👈️ IMPORTANT

                HttpSession session1 = request.getSession();
                session.setAttribute("username", username);

                // Role anuwa redirect
                if ("admin".equalsIgnoreCase(user.getRole())) {
                    response.sendRedirect(request.getContextPath() + "/admin");
                } else {
                    response.sendRedirect(request.getContextPath() + "/employee");
                }
            } else {
                request.setAttribute("errorMessage", "Invalid username or password");
                request.getRequestDispatcher("signIn.jsp").forward(request, response);
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
