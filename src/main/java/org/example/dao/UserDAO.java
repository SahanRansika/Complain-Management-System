package org.example.dao;

import org.example.dto.UserDTO;

import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    private static DataSource dataSource;

    public static void setDataSource(DataSource ds) {
        dataSource = ds;
    }

    // 1. Insert user
    public static boolean insertUser(String username, String password, String role) throws Exception {
        String sql = "INSERT INTO users (username, password, role) VALUES (?, ?, ?)";

        System.out.println("[INSERT USER] SQL: " + sql);
        System.out.println("[INSERT USER] Values: " + username + ", " + password + ", " + role);

        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password); // Note: hash password if needed
            ps.setString(3, role);

            return ps.executeUpdate() > 0;
        }
    }

    // 2. Get user by username + password (login)
    public static UserDTO getUserByCredentials(String username, String password) throws Exception {
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";

        System.out.println("[LOGIN] SQL: " + sql);
        System.out.println("[LOGIN] Values: " + username + ", " + password);

        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    UserDTO user = new UserDTO();
                    user.setId(rs.getInt("id"));
                    user.setUsername(rs.getString("username"));
                    user.setPassword(rs.getString("password"));
                    user.setRole(rs.getString("role"));
                    return user;
                }
            }
        }
        return null;
    }

    // 3. Check if username already exists
    public static boolean isUsernameExists(String username) throws Exception {
        String sql = "SELECT id FROM users WHERE username = ?";

        System.out.println("[CHECK USERNAME] SQL: " + sql);
        System.out.println("[CHECK USERNAME] Username: " + username);

        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next(); // if found, username exists
            }
        }
    }

    public static List<UserDTO> getAllUsers() throws Exception {
        List<UserDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM users";

        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                UserDTO user = new UserDTO();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setRole(rs.getString("role"));
                list.add(user);
            }
        }
        return list;
    }

    public static boolean deleteUser(int id) throws Exception {
        String sql = "DELETE FROM users WHERE id = ?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

}
