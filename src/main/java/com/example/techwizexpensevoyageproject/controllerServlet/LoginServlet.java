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

        try (Connection connection = DBConnection.getConnection()) {
            String sql = "SELECT firstName, lastName, passwordHash FROM Users WHERE email = ?";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, email);
                ResultSet rs = statement.executeQuery();

                if (rs.next()) {
                    String hashedPassword = rs.getString("passwordHash");
                    // Verify the password
                    if (BCrypt.checkpw(password, hashedPassword)) {
                        // Password matches, retrieve user details
                        String firstName = rs.getString("firstName");
                        String lastName = rs.getString("lastName");

                        // Store user details in session
                        HttpSession session = request.getSession();
                        session.setAttribute("firstName", firstName);
                        session.setAttribute("lastName", lastName);

                        // Redirect to the dashboard
                        response.sendRedirect("DashBoard.jsp");
                    } else {
                        request.setAttribute("error", "Invalid password.");
                        request.getRequestDispatcher("Login.jsp").forward(request, response);
                    }
                } else {
                    request.setAttribute("error", "No user found with this email.");
                    request.getRequestDispatcher("Login.jsp").forward(request, response);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error occurred. Please try again later.");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        }
    }
}
