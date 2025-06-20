package org.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.dao.UserDAO;
import org.example.dto.UserDTO;

import java.io.IOException;
import java.util.List;

@WebServlet("/adminUser")
public class AdminUserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        try {
            List<UserDTO> users = UserDAO.getAllUsers();
            req.setAttribute("users", users);
            req.getRequestDispatcher("userList.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String action = req.getParameter("action");

        if ("delete".equals(action)) {
            int userId = Integer.parseInt(req.getParameter("userId"));
            try {
                UserDAO.deleteUser(userId);
                resp.sendRedirect("adminUser"); // reload list
            } catch (Exception e) {
                e.printStackTrace();
                resp.sendError(500);
            }
        }
    }
}
