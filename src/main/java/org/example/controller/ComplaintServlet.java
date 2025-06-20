package org.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.dao.ComplaintDAO;
import org.example.dto.ComplaintDTO;
import org.example.dto.UserDTO;

import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet("/complaint")
public class ComplaintServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String title = req.getParameter("title");
            String description = req.getParameter("description");

            HttpSession session = req.getSession(false);
            if (session == null || session.getAttribute("userId") == null) {
                resp.sendRedirect("signIn.jsp");
                return;
            }

            int userId = (int) session.getAttribute("userId");

            ComplaintDTO complaint = new ComplaintDTO();
            complaint.setUserId(userId);
            complaint.setTitle(title);
            complaint.setDescription(description);
            complaint.setStatus("Pending");
            complaint.setRemarks("");
            complaint.setCreatedAt(LocalDateTime.now());

            boolean inserted = ComplaintDAO.insertComplaint(complaint);

            if (inserted) {
                // Optional: redirect anuwa user role eka balanna
                UserDTO user = (UserDTO) session.getAttribute("user");
                if (user != null && "employee".equalsIgnoreCase(user.getRole())) {
                    resp.sendRedirect("");
                } else {
                    resp.sendRedirect("employee");
                }
            } else {
                req.setAttribute("error", "Failed to submit complaint. Try again.");
                req.getRequestDispatcher("create.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(500, "Internal Server Error");
        }
    }
}
