package com.example.techwizexpensevoyageproject.controllerServlet;

import com.example.techwizexpensevoyageproject.connections.DBConnection;
import com.example.techwizexpensevoyageproject.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Authenticate user
        User authenticatedUser = authenticateUser(email, password);

        if (authenticatedUser != null) {
            // Password is correct, proceed with login
            HttpSession session = request.getSession();
            session.setAttribute("user", authenticatedUser); // Store the User object in session

            request.setAttribute("message", "Login successful!");
            response.sendRedirect("DashBoard.jsp"); // Redirect to the dashboard
        } else {
            // Invalid email or password
            request.setAttribute("error", "Invalid email or password.");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        }
    }

    // Method to authenticate the user by email and password
    private User authenticateUser(String email, String password) {
        User user = null;

        try (Connection connection = DBConnection.getConnection()) {
            String sql = "SELECT * FROM Users WHERE email = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, email);

            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                String storedHashedPassword = resultSet.getString("passwordHash"); // Get the hashed password from DB

                // Compare the stored hashed password with the entered password using BCrypt
                if (BCrypt.checkpw(password, storedHashedPassword)) {
                    // If password is correct, create a new User object with details from the DB
                    user = new User();
                    user.setFirstName(resultSet.getString("firstName"));
                    user.setLastName(resultSet.getString("lastName"));
                    user.setEmail(resultSet.getString("email"));
                    // Add other necessary fields from the result set
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        return user; // Return the authenticated user object or null if authentication fails
    }
}