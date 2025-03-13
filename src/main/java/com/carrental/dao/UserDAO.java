package com.carrental.dao;

import com.carrental.model.User;
import com.carrental.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
	 public static List<User> getAllUsers() {
	        List<User> userList = new ArrayList<>();
	        try (Connection conn = DBConnection.getConnection()) {
	            // SQL query to fetch all users
	            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM users");
	            ResultSet rs = stmt.executeQuery();

	            // Iterate through the result set and create User objects
	            while (rs.next()) {
	                User user = new User();
	                user.setId(rs.getInt("id"));
	                user.setUsername(rs.getString("username"));
	                user.setPassword(rs.getString("password"));
	                user.setPhone(rs.getString("phone"));
	                user.setNic(rs.getString("nic"));
	                user.setEmail(rs.getString("email"));  // Fetch email

	                // Add the user to the list
	                userList.add(user);
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return userList;
	    }

    // Method to register a user
	public static boolean registerUser(User user) {
	    boolean isRegistered = false;
	    try (Connection conn = DBConnection.getConnection()) {
	        // Check if username already exists
	        PreparedStatement checkUsernameStmt = conn.prepareStatement("SELECT * FROM users WHERE username = ?");
	        checkUsernameStmt.setString(1, user.getUsername());
	        ResultSet rsUsername = checkUsernameStmt.executeQuery();

	        if (rsUsername.next()) {
	            return false; // Username already exists
	        }

	        // Check if email already exists
	        PreparedStatement checkEmailStmt = conn.prepareStatement("SELECT * FROM users WHERE email = ?");
	        checkEmailStmt.setString(1, user.getEmail());  // Assuming 'User' model has an 'email' property
	        ResultSet rsEmail = checkEmailStmt.executeQuery();

	        if (rsEmail.next()) {
	            return false; // Email already exists
	        }

	        // Insert new user if both username and email are unique
	        PreparedStatement stmt = conn.prepareStatement("INSERT INTO users(username, password, phone, nic, email) VALUES (?, ?, ?, ?, ?)");
	        stmt.setString(1, user.getUsername());
	        stmt.setString(2, user.getPassword());
	        stmt.setString(3, user.getPhone());
	        stmt.setString(4, user.getNic());
	        stmt.setString(5, user.getEmail());  // Add the email field in the insert query

	        isRegistered = stmt.executeUpdate() > 0;
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return isRegistered;
	}

    // Method to authenticate user login
    public static boolean validateUser(String username, String password) {
        boolean isValid = false;
        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM users WHERE username = ? AND password = ?");
            stmt.setString(1, username);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            isValid = rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isValid;
    }

    public static String getUsernameBySession(String sessionUsername) {
        String fullName = null;
        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement stmt = conn.prepareStatement("SELECT username FROM users WHERE username = ?");
            stmt.setString(1, sessionUsername);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                fullName = rs.getString("username");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return fullName;
    }
    

    // Method to get user by email (for password reset)
    public static User getUserByEmail(String email) {
        User user = null;
        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM users WHERE email = ?");
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setPhone(rs.getString("phone"));
                user.setNic(rs.getString("nic"));
                user.setEmail(rs.getString("email"));  // Set email
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }
 // Method to check if email already exists
    public static boolean isEmailExists(String email) {
        boolean emailExists = false;
        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM users WHERE email = ?");
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            emailExists = rs.next();  // If result exists, the email is already taken
        } catch (Exception e) {
            e.printStackTrace();
        }
        return emailExists;
    }
    // Update User in the database
    public static boolean updateUser(User user) {
        boolean isUpdated = false;
        Connection connection = DBConnection.getConnection();
        String query = "UPDATE users SET phone = ?, nic = ?, email = ? WHERE username = ?";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, user.getPhone());
            stmt.setString(2, user.getNic());
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getUsername());

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                isUpdated = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return isUpdated;
    }
    public static int getTotalUsers() {
        int totalUsers = 0;
        String sql = "SELECT COUNT(*) FROM users"; // Query to count total users

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                totalUsers = rs.getInt(1); // Get the user count
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return totalUsers;
    }


    // Delete User from the database
    public static boolean deleteUser(String username) {
        boolean isDeleted = false;
        Connection connection = DBConnection.getConnection();
        String query = "DELETE FROM users WHERE username = ?";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, username);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                isDeleted = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return isDeleted;
    }
}


