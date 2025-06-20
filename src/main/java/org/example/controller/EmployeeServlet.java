package org.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.dao.ComplaintDAO;
import org.example.dto.ComplaintDTO;


import java.io.IOException;
import java.util.List;

@WebServlet("/employee")
public class EmployeeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {

            List<ComplaintDTO> complaints = ComplaintDAO.getAllComplaints();
            req.setAttribute("complaints", complaints);


            req.getRequestDispatcher("employeeDashboard.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(500, "Internal Server Error");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {

            int complaintId = Integer.parseInt(req.getParameter("complaintId"));
            String status = req.getParameter("status");
            String remarks = req.getParameter("remarks");

            boolean updated = ComplaintDAO.updateComplaint(complaintId, status, remarks);

            if (updated) {
                resp.sendRedirect("employee");
            } else {
                req.setAttribute("error", "Failed to update complaint");
                doGet(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(500, "Internal Server Error");
        }
    }
}
