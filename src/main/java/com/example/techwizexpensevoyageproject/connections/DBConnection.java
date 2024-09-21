package com.example.techwizexpensevoyageproject.connections;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    // Private constructor to prevent instantiation
    private DBConnection() { }

    // Static method to get a new database connection
    public static Connection getConnection() throws ClassNotFoundException, SQLException {
        Connection connection = null;
        try {
            // Load PostgreSQL Driver
            Class.forName("org.postgresql.Driver");

            // Updated connection URL for PostgreSQL
            String url = "jdbc:postgresql://localhost:5432/ExpenseVoyageDB";
            String username = "postgres"; // Replace with your PostgreSQL username
            String password = "anita";     // Replace with your PostgreSQL password

            // Establish connection
            connection = DriverManager.getConnection(url, username, password);
            System.out.println("Database connection established successfully.");
        } catch (ClassNotFoundException e) {
            System.err.println("JDBC Driver not found.");
            throw e; // Re-throwing for higher-level handling
        } catch (SQLException e) {
            System.err.println("Failed to establish database connection: " + e.getMessage());
            throw e; // Re-throwing for higher-level handling
        }
        return connection;
    }

    // Method to close the connection to prevent leaks
    public static void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
                System.out.println("Database connection closed successfully.");
            } catch (SQLException e) {
                System.err.println("Failed to close database connection: " + e.getMessage());
            }
        }
    }
}
