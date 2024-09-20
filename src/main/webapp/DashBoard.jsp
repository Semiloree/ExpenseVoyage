<%-- Created by IntelliJ IDEA. User: Jesusemilore Date: 9/19/2024 Time: 2:58 PM To change this template use File | Settings | File Templates. --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.techwizexpensevoyageproject.model.User" %>
<%@ page import="com.example.techwizexpensevoyageproject.model.Trip" %>
<%@ page import="java.util.List" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        user = new User(); // Create a new guest user if null (for example purposes)
        user.setFirstName("Guest");
        user.setLastName("");
    }
%>

<html>
<head>
    <title>ExpenseVoyage</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet"> <!-- FontAwesome for icons -->

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const notificationIcon = document.querySelector('.notifications');
            notificationIcon.addEventListener('click', () => {
                alert('You have new notifications!');
            });
        });
    </script>

    <style>
        /* Custom styles for a vibrant UI */
        body {
            background-color: #f0f8ff; /* Soft background color */
            font-family: 'Roboto', sans-serif; /* Modern font */
        }

        .navbar {
            background: linear-gradient(45deg, #007bff, #00d4ff);
        }

        .navbar-brand {
            font-size: 1.75rem;
            font-weight: bold;
            color: #fff;
        }

        .navbar-nav .nav-link {
            color: #fff;
        }

        .navbar-nav .nav-link:hover {
            color: #ffce00;
        }

        .container {
            margin-top: 50px;
        }

        h2 {
            color: #007bff;
        }

        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s;
        }

        .card:hover {
            transform: scale(1.05);
        }

        .card-header, .card-body {
            background-color: #fff;
            color: #333;
        }

        /* Vibrant colors for trip overview */
        .trip-card {
            background: linear-gradient(45deg, #ff7f50, #ff6347);
            color: white;
            padding: 1rem;
            border-radius: 10px;
            margin-bottom: 20px;
        }

        .trip-card h5, .trip-card p {
            margin: 0;
            padding: 0.5rem 0;
        }

        .recent-activities .list-group-item {
            transition: background-color 0.3s, color 0.3s;
        }

        .recent-activities .list-group-item:hover {
            background-color: #007bff;
            color: white;
        }

        .welcome-message {
            text-align: center;
            padding: 30px;
            background: linear-gradient(135deg, #6dd5ed, #2193b0);
            color: white;
            border-radius: 15px;
            margin-bottom: 30px;
            animation: fadeIn 1s ease-in-out;
        }

        .welcome-message h2 {
            font-size: 2.5rem;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">ExpenseVoyage</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="#">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Trips</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Expenses</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <%= user.getFirstName() %> <%= user.getLastName() %>
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="#">Profile</a></li>
                        <li><a class="dropdown-item" href="#">Settings</a></li>
                        <li><a class="dropdown-item" href="logout.jsp">Logout</a></li>
                    </ul>
                </li>
                <li class="nav-item">
                    <a class="nav-link notifications" href="#"><i class="fas fa-bell"></i></a> <!-- Notification Icon -->
                </li>
            </ul>
        </div>
    </div>
</nav>

<%-- Welcome message depending on the user --%>
<div class="welcome-message">
    <h2>Welcome, <%= user.getFirstName() %>!</h2>
</div>

<%-- Display upcoming trips if available --%>
<div class="container">
    <h3>Your Upcoming Trips:</h3>
    <ul>
        <%
            List<Trip> upcomingTrips = (List<Trip>) request.getAttribute("upcomingTrips");
            if (upcomingTrips != null && !upcomingTrips.isEmpty()) {
                for (Trip trip : upcomingTrips) {
        %>
        <li class="trip-card">
            <h5>Destination: <%= trip.getDestination() %></h5>
            <p>Start Date: <%= trip.getStartDate() %></p>
            <p>End Date: <%= trip.getEndDate() %></p>
            <p>Budget: $<%= trip.getBudget() %></p>
        </li>
        <%
            }
        } else {
        %>
        <p>No upcoming trips.</p>
        <% } %>
    </ul>
</div>

<!-- Bootstrap and JS CDN -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
