<%--
  Created by IntelliJ IDEA.
  User: Jesusemilore
  Date: 9/19/2024
  Time: 2:57 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #e0f7ff; /* light blue background */
            font-family: Arial, sans-serif;
        }

        .success-card {
            background-color: #fff; /* white card background */
            width: 350px;
            padding: 40px 20px;
            border-radius: 20px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1); /* soft shadow */
            text-align: center;
            position: relative;
        }

        .success-card .checkmark {
            background-color: #1e90ff; /* blue background */
            border-radius: 50%;
            width: 80px;
            height: 80px;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: -60px auto 20px; /* positioned at the top */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .checkmark i {
            font-size: 2.5em;
            color: #fff; /* white checkmark */
        }

        h2 {
            color: #1e90ff; /* deep blue heading */
            margin: 0;
            font-size: 1.8em;
        }

        p {
            font-size: 1.2em;
            color: #666; /* muted gray for text */
            margin-top: 10px;
        }

        .back-to-login {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #1e90ff; /* blue background */
            color: white;
            border-radius: 5px;
            text-decoration: none;
            font-size: 1em;
            transition: background-color 0.3s ease;
        }

        .back-to-login:hover {
            background-color: #0052cc; /* deep blue on hover */
        }
    </style>
</head>
<body>

<div class="success-card">
    <div class="checkmark">
        <i>✔</i> <!-- This can be replaced with an actual image for the checkmark -->
    </div>
    <h2>Registration Successful</h2>
    <p>Your account has been created successfully!</p>
    <a href="Login.jsp" class="back-to-login">Back to Login</a>
</div>

</body>
</html>