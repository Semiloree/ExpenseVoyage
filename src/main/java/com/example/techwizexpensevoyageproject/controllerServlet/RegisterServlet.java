package com.example.techwizexpensevoyageproject.controllerServlet;

import com.example.techwizexpensevoyageproject.Dao.UserDao;
import com.example.techwizexpensevoyageproject.connections.DBConnection;
import com.example.techwizexpensevoyageproject.model.User;
import jakarta.ejb.EJB;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.PersistenceContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import org.mindrot.jbcrypt.BCrypt;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String password = request.getParameter("password");
        String repeatPassword = request.getParameter("repeatPassword");
        String termsAccepted = request.getParameter("terms");

        String errorMessage = null;
        boolean hasError = false;


        // Validate fields
        if (email == null || email.trim().isEmpty()) {
            errorMessage = "Email is required.";
            hasError = true;
        } else if (firstName == null || firstName.trim().isEmpty()) {
            errorMessage = "First name is required.";
            hasError = true;
        } else if (lastName == null || lastName.trim().isEmpty()) {
            errorMessage = "Last name is required.";
            hasError = true;
        } else if (password == null || password.trim().isEmpty()) {
            errorMessage = "Password is required.";
            hasError = true;
        } else if (password.length() < 6) {
            errorMessage = "Password must be at least 6 characters.";
            hasError = true;
        } else if (!password.equals(repeatPassword)) {
            errorMessage = "Passwords do not match.";
            hasError = true;
        } else if (termsAccepted == null) {
            errorMessage = "You must accept the terms and conditions.";
            hasError = true;
        }

        // Hash the password before saving
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

        if (hasError) {
            // Forward back to the registration page with error message
            request.setAttribute("error", errorMessage);
            request.getRequestDispatcher("Register.jsp").forward(request, response);
        } else {
            // Proceed with database insertion if no validation errors
            try (Connection connection = DBConnection.getConnection()) {
                String sql = "INSERT INTO Users (email, passwordHash, firstName, lastName) VALUES (?, ?, ?, ?)";
                PreparedStatement statement = connection.prepareStatement(sql);

                // TODO: Hash the password using BCrypt before storing it
                statement.setString(1, email);
                statement.setString(2, hashedPassword); // Consider using a hashed version
                statement.setString(3, firstName);
                statement.setString(4, lastName);

                int result = statement.executeUpdate();

                if (result > 0) {
                    // If registration is successful, redirect to a success page
                    request.setAttribute("message", "Registration successful!");
                    request.getRequestDispatcher("registerSuccess.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "An error occurred during registration. Please try again.");
                    request.getRequestDispatcher("Register.jsp").forward(request, response);
                }
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "Database error occurred. Please try again later.");
                request.getRequestDispatcher("Register.jsp").forward(request, response);
            } catch (ClassNotFoundException e) {
                throw new RuntimeException(e);
            }
        }
    }
}