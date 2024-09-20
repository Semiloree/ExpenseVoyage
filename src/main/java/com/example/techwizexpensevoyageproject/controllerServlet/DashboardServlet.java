package com.example.techwizexpensevoyageproject.controllerServlet;

import com.example.techwizexpensevoyageproject.connections.DBConnection;
import com.example.techwizexpensevoyageproject.model.Trip;
import com.example.techwizexpensevoyageproject.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user != null) {
            List<Trip> upcomingTrips = getUpcomingTrips(user.getUserId());
            request.setAttribute("upcomingTrips", upcomingTrips);
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
        } else {
            response.sendRedirect("login.jsp");
        }
    }

    private List<Trip> getUpcomingTrips(Long userId) {
        List<Trip> trips = new ArrayList<>();
        try (Connection connection = DBConnection.getConnection()) {
            String sql = "SELECT * FROM Trips WHERE userId = ? AND startDate >= CURDATE() ORDER BY startDate ASC";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setLong(1, userId);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                Trip trip = new Trip();
                trip.setDestination(resultSet.getString("destination"));
                trip.setStartDate(resultSet.getDate("startDate"));
                trip.setEndDate(resultSet.getDate("endDate"));
                trip.setBudget(resultSet.getDouble("budget"));
                trips.add(trip);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return trips;
    }
}