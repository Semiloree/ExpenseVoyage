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
            // Load MySQL Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Updated connection URL with 'allowPublicKeyRetrieval=true' to fix public key retrieval error
            String url = "jdbc:mysql://localhost:3306/ExpenseVoyageDB?autoReconnect=true&useSSL=false&allowPublicKeyRetrieval=true";
            String username = "root";
            String password = "Uche2006";

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
