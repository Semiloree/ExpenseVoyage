<%--
  Created by IntelliJ IDEA.
  User: Jesusemilore
  Date: 9/19/2024
  Time: 2:56 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script>
        function validateForm() {
            let valid = true;
            let email = document.getElementById("email");
            let firstName = document.getElementById("firstName");
            let lastName = document.getElementById("lastName");
            let password = document.getElementById("password");
            let repeatPassword = document.getElementById("repeatPassword");
            let termsCheckbox = document.getElementById('terms');

            // Clear previous error messages
            document.querySelectorAll(".error-message").forEach(function (el) {
                el.style.display = 'none';
            });

            // Email validation
            const emailPattern = /^[^@\s]+@[^@\s]+\.[^@\s]+$/;
            if (!email.value || !emailPattern.test(email.value)) {
                document.getElementById("email-error").style.display = 'block';
                valid = false;
            }

            // First Name validation
            if (!firstName.value) {
                document.getElementById("firstName-error").style.display = 'block';
                valid = false;
            }

            // Last Name validation
            if (!lastName.value) {
                document.getElementById("lastName-error").style.display = 'block';
                valid = false;
            }

            // Password validation
            if (!password.value) {
                document.getElementById("password-error").style.display = 'block';
                valid = false;
            } else if (password.value.length < 6) {
                document.getElementById("password-length-error").style.display = 'block';
                valid = false;
            }

            // Password match validation
            if (password.value !== repeatPassword.value) {
                document.getElementById("password-match-error").style.display = 'block';
                valid = false;
            }

            // Terms checkbox validation
            if (!termsCheckbox.checked) {
                document.getElementById("terms-error").style.display = 'block';
                valid = false;
            }

            return valid;
        }
    </script>
    <style>
        /* Center the form in the middle of the screen */

        .navbar {
            color: black;
            background: linear-gradient(45deg, #007bff, #00d4ff); /* Gradient background */
        }

        .container-fluid{
            display: flex;
            justify-content: space-between;
            align-items: center;
            text-align: center;
        }

        .navbar-brand {
            font-size: 1.75rem;
            font-weight: bold;
            color: black;
        }

        .navbar-nav{
            position: relative;
            left: 800px;
            color: black;
        }

        .navbar-nav .nav-link {
            color: black;
            margin-left: 20px; /* Adds space between the links */
        }

        .navbar-nav .nav-link:hover {
            color: white;
        }

        .navbar-toggler {
            border: none;
            background: transparent;
        }

        /* Adjusting notification icon size */
        .nav-link.notifications i {
            font-size: 1.2rem;
        }

        /* Optional: To center the nav vertically */
        .navbar {
            padding: 0.8rem 2rem; /* Adjust padding for better vertical centering */
        }
        .register-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #fff;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0px 10px 20px rgba(0, 0, 0, 0.1);
            max-width: 1000px;
            margin: 50px auto;
        }

        /* Form and image container */
        .form-container, .image-container {
            width: 48%;
        }

        /* Form fields styling */
        .input-group {
            position: relative;
            margin-bottom: 15px;
        }

        .input-group input {
            width: 100%;
            padding: 10px 40px; /* Extra padding for icons */
            font-size: 14px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        .input-group i {
            position: absolute;
            top: 50%;
            left: 10px;
            transform: translateY(-50%);
            font-size: 18px;
            color: #666;
        }

        /* Terms of service styling */
        /*#terms {*/
        /*    margin-right: 10px;*/
        /*}*/

        .terms {
            margin: 15px 0;
            color: #666; /* Medium grey for the terms text */
        }

        #terms-error {
            margin-left: 25px;
        }

        /* Error message styling */
        .error-message {
            color: red;
            font-size: 12px;
            margin-top: 5px;
        }

        /* Button styling */
        .register-btn {
            width: 100%;
            padding: 12px;
            background-color: #0073e6;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            margin-top: 20px;
        }

        .register-btn:hover {
            background-color: #005bb5;
        }

        /* Image styling */
        .image-container img {
            width: 100%;
            height: auto;
            display: block;
        }

        .form-footer {
            margin-top: 15px;
        }

        /* Responsive for mobile */
        @media (max-width: 768px) {
            .register-container {
                flex-direction: column;
                align-items: flex-start;
            }

            .form-container, .image-container {
                width: 100%;
            }

            .image-container {
                margin-top: 20px;
            }
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light">
    <div class="container-fluid">
        <!-- Brand/Logo on the left -->
        <a class="navbar-brand" href="#">ExpenseVoyage</a>

        <!-- Toggle button for mobile view -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Navbar links aligned to the right -->
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto"> <!-- 'ms-auto' pushes items to the right -->
                <li class="nav-item">
                    <a class="nav-link" href="#">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Trips</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Expenses</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link notifications" href="#"><i class="fas fa-bell"></i></a> <!-- Notification icon -->
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="register-container">
    <!-- Form Container -->
    <div class="form-container">
        <form action="register" method="post" onsubmit="return validateForm()">
            <h2 style="color: darkblue">Sign up</h2>

            <!-- Name Field -->
            <div class="input-group">
                <i class="fas fa-user"></i>
                <input type="text" id="firstName" name="firstName" placeholder="Your First Name" required>
                <p class="error-message" id="firstName-error" style="display: none; color: red">Name is required.</p>
            </div>

            <div class="input-group">
                <i class="fas fa-user"></i>
                <input type="text" id="lastName" name="lastName" placeholder="Your Last Name" required>
                <p class="error-message" id="lastName-error" style="display: none; color: red">Name is required.</p>
            </div>

            <!-- Email Field -->
            <div class="input-group">
                <i class="fas fa-envelope"></i>
                <input type="email" id="email" name="email" placeholder="Your Email" required>
                <p class="error-message" id="email-error" style="display: none; color: red">Valid email is required.</p>
            </div>

            <!-- Password Field -->
            <div class="input-group">
                <i class="fas fa-lock"></i>
                <input type="password" id="password" name="password" placeholder="Password" required>
                <p class="error-message" id="password-error" style="display: none; color: red">Password is required.</p>
            </div>

            <!-- Repeat Password Field -->
            <div class="input-group">
                <i class="fas fa-key"></i>
                <input type="password" id="repeatPassword" name="repeatPassword" placeholder="Repeat your password" required>
                <p class="error-message" id="repeatPassword-error" style="display: none; color: red">Please confirm your password.</p>
            </div>

            <!-- Terms and Conditions -->
            <div class="terms">
                <input type="checkbox" id="terms" name="terms" required>
                <label for="terms">I agree to all statements in <a href="#">Terms of service</a></label>
                <p class="error-message" id="terms-error" style="display: none; color: red">You must accept the terms and conditions.</p>
            </div>
            <div class="form-footer">
                Already registered? <a href="Login.jsp">Login here</a>
            </div>

            <!-- Register Button -->
            <button type="submit" class="register-btn">REGISTER</button>
        </form>
    </div>

    <!-- Image Container -->
    <div class="image-container">
        <img src="images/RegisterImage.png" alt="Sign up illustration">
    </div>
</div>

</body>
</html>
