package org.example.dao;

import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import org.example.dto.ComplaintDTO;

public class ComplaintDAO {

    private static DataSource dataSource;

    public static void setDataSource(DataSource ds) {
        dataSource = ds;
    }

    public static List<ComplaintDTO> getAllComplaints() throws Exception {
        List<ComplaintDTO> complaintList = new ArrayList<>();

        String sql = "SELECT * FROM complaints";

        System.out.println("[GET ALL] SQL: " + sql);

        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ComplaintDTO complaint = new ComplaintDTO();
                complaint.setId(rs.getInt("id"));
                complaint.setUserId(rs.getInt("user_id"));
                complaint.setTitle(rs.getString("title"));
                complaint.setDescription(rs.getString("description"));
                complaint.setStatus(rs.getString("status"));
                complaint.setRemarks(rs.getString("remarks"));

                // Optional: Handle created_at if you want to display or store it
                Timestamp createdAt = rs.getTimestamp("created_at");
                if (createdAt != null) {
                    complaint.setCreatedAt(createdAt.toLocalDateTime()); // requires `createdAt` field in DTO
                }

                complaintList.add(complaint);
            }
        }

        return complaintList;
    }

    public static boolean insertComplaint(ComplaintDTO complaint) throws Exception {
        String sql = "INSERT INTO complaints (user_id, title, description, status, remarks, created_at) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, complaint.getUserId());
            ps.setString(2, complaint.getTitle());
            ps.setString(3, complaint.getDescription());
            ps.setString(4, complaint.getStatus());
            ps.setString(5, complaint.getRemarks());
            ps.setTimestamp(6, Timestamp.valueOf(complaint.getCreatedAt()));

            return ps.executeUpdate() > 0;
        }
    }


    // Add more methods like update, delete as needed
    public static boolean updateComplaint(int complaintId, String status, String remarks) throws Exception {
        String sql = "UPDATE complaints SET status = ?, remarks = ? WHERE id = ?";

        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setString(2, remarks);
            ps.setInt(3, complaintId);

            return ps.executeUpdate() > 0;
        }
    }

    public static boolean deleteComplaint(int complaintId) throws Exception {
        String sql = "DELETE FROM complaints WHERE id = ?";

        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, complaintId);

            return ps.executeUpdate() > 0;
        }
    }
    public static ComplaintDTO getComplaintById(int id) throws Exception {
        String sql = "SELECT * FROM complaints WHERE id = ?";

        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    ComplaintDTO c = new ComplaintDTO();
                    c.setId(rs.getInt("id"));
                    c.setUserId(rs.getInt("userId"));
                    c.setTitle(rs.getString("title"));
                    c.setDescription(rs.getString("description"));
                    c.setStatus(rs.getString("status"));
                    c.setRemarks(rs.getString("remarks"));
                    c.setCreatedAt(rs.getTimestamp("createdAt").toLocalDateTime());
                    return c;
                }
            }
        }
        return null;
    }
    public static boolean updateComplaintFull(ComplaintDTO c) throws Exception {
        String sql = "UPDATE complaints SET title=?, description=?, status=?, remarks=? WHERE id=?";

        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, c.getTitle());
            ps.setString(2, c.getDescription());
            ps.setString(3, c.getStatus());
            ps.setString(4, c.getRemarks());
            ps.setInt(5, c.getId());

            return ps.executeUpdate() > 0;
        }
    }


}
