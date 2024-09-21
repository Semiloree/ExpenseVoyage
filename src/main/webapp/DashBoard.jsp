<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.techwizexpensevoyageproject.model.User" %>
<%@ page import="com.example.techwizexpensevoyageproject.model.Trip" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        user = new User(); // Create a new guest user if null
        user.setFirstName("Guest");
        user.setLastName("");
    }

    List<String> notes = (List<String>) session.getAttribute("notes");
    if (notes == null) {
        notes = new ArrayList<>();
    }

    String submittedNote = request.getParameter("note");
    if (submittedNote != null && !submittedNote.trim().isEmpty()) {
        notes.add(submittedNote);
        session.setAttribute("notes", notes);
    }

    String noteIndexStr = request.getParameter("noteIndex");
    if (noteIndexStr != null) {
        try {
            int noteIndex = Integer.parseInt(noteIndexStr);
            if (noteIndex >= 0 && noteIndex < notes.size()) {
                notes.remove(noteIndex);
                session.setAttribute("notes", notes);
            }
        } catch (NumberFormatException e) {
        }
    }
%>

<html>
<head>
    <title>ExpenseVoyage</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Sofadi+One&display=swap" rel="stylesheet">
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
            color: black;
        }

        .container {
            margin-top: 50px;
        }

        .welcome-message {
            text-align: center;
            padding: 30px;
            color: black;
            border-radius: 15px;
            margin-bottom: 30px;
        }

        .welcome-message h2 {
            font-size: 3.5rem;
        }

        .note {
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 4px;
            padding: 10px;
            margin: 10px 0;
            font-size: 0.9rem;
            max-width: 200px;
            text-align: left;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transform: rotate(0.5deg);
            position: relative;
            float: right;
            height: 5vh;
            font-family: 'Roboto', sans-serif;
        }

        .note-textarea {
            max-width: 300px;
            width: 100%;
            font-family: 'Roboto', sans-serif;
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
                <li class="nav-item"><a class="nav-link" href="DashBoard.jsp">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="#">Trips</a></li>
                <li class="nav-item"><a class="nav-link" href="#">Expenses</a></li>
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
                <li class="nav-item"><a class="nav-link notifications" href="#"><i class="fas fa-bell"></i></a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- Welcome message -->
<div class="welcome-message">
    <h1>Welcome, <%= user.getFirstName() %>!</h1>
</div>

<!-- Display upcoming trips -->
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

<div class="container mt-4">
    <h3>Add a Note:</h3>
    <form action="" method="post">
        <div class="mb-3">
            <textarea class="form-control note-textarea" name="note" rows="3" placeholder="Write your note here..." required></textarea>
        </div>
        <button type="submit" class="btn btn-primary">Add Note</button>
    </form>
</div>

<div class="container mt-4">
    <h3>Your Notes:</h3>
    <ul class="list-group">
        <%
            if (!notes.isEmpty()) {
                for (int i = 0; i < notes.size(); i++) {
                    String userNote = notes.get(i);
        %>
        <li class="list-group-item note position-relative">
            <%= userNote %>
            <form action="" method="post" style="display:inline;">
                <input type="hidden" name="noteIndex" value="<%= i %>">
                <button type="submit" class="btn btn-link text-danger position-absolute" style="bottom: 5px; right: 10px; padding: 0;">
                    <i class="fas fa-trash-alt"></i>
                </button>
            </form>
        </li>
        <%
            }
        } else {
        %>
        <p>No notes available.</p>
        <% } %>
    </ul>
</div>

<!-- Bootstrap and JS CDN -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
