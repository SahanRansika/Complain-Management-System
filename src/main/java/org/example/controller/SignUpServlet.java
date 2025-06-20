package org.example.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;

import org.example.dao.UserDAO;
import org.example.db.DataSource;

import java.io.IOException;

@WebServlet("/signup")
public class SignUpServlet extends HttpServlet {

    @Override
    public void init() throws ServletException {
        UserDAO.setDataSource(DataSource.getDataSource());
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String role = req.getParameter("role");

        try {
            boolean success = UserDAO.insertUser(username, password, role);
            if (success) {
                resp.sendRedirect("signIn.jsp");
            } else {
                req.setAttribute("error", "Sign-up failed.");
                req.getRequestDispatcher("signup.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(500);
        }
    }
}
