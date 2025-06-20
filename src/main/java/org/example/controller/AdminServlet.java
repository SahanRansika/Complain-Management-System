package org.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import org.example.dao.ComplaintDAO;
import org.example.dto.ComplaintDTO;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<ComplaintDTO> complaints = ComplaintDAO.getAllComplaints();
            request.setAttribute("complaints", complaints);
            request.getRequestDispatcher("adminComplaints.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("update".equals(action)) {
            int complaintId = Integer.parseInt(req.getParameter("complaintId"));
            String status = req.getParameter("status");
            String remarks = req.getParameter("remarks");

            try {
                boolean updated = ComplaintDAO.updateComplaint(complaintId, status, remarks);

                if (updated) {
                    resp.sendRedirect("admin");
                } else {
                    req.setAttribute("error", "Update failed.");
                    req.getRequestDispatcher("adminComplaints.jsp").forward(req, resp);
                }
            } catch (Exception e) {
                e.printStackTrace();
                resp.sendError(500, "Internal Server Error");
            }

        } else if ("delete".equals(action)) {
            int complaintId = Integer.parseInt(req.getParameter("complaintId"));
            try {
                boolean deleted = ComplaintDAO.deleteComplaint(complaintId);
                resp.sendRedirect("admin");
            } catch (Exception e) {
                e.printStackTrace();
                resp.sendError(500);
            }
        }
    }

}
