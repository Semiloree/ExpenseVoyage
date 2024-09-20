<%--
  Created by IntelliJ IDEA.
  User: Jesusemilore
  Date: 9/19/2024
  Time: 2:58 PM
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
        function validateLoginForm() {
            let valid = true;
            let email = document.getElementById("email");
            let password = document.getElementById("password");

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

            // Password validation
            if (!password.value) {
                document.getElementById("password-error").style.display = 'block';
                valid = false;
            }

            return valid;
        }
    </script>

    <style>
        /* Center the form in the middle of the screen */
        .login-container {
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

        /* Error message styling */
        .error-message {
            color: red;
            font-size: 12px;
            margin-top: 5px;
        }

        /* Button styling */
        .login-btn {
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

        .login-btn:hover {
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
            .login-container {
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

<div class="login-container">
    <div class="form-container">
    <form action="login" method="post" onsubmit="return validateLoginForm()">
        <h2>Login</h2>

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

        <!-- Forgot Password Link -->
        <div class="forgot-password">
            <a href="forgotPassword.jsp">Forgot password?</a>
        </div>

        <div class="form-footer">
            Dont have an account? <a href="Register.jsp">Register here</a>
        </div>

        <!-- Display error message from server-side validation if any -->
        <div class="error-message">
            <c:if test="${not empty error}">
                <p style="color: red;">${error}</p>
            </c:if>
        </div>

        <!-- Login Button -->
        <button type="submit" class="login-btn">LOGIN</button>
    </form>
    </div>
    <div class="image-container">
        <img src="images/RegisterImage.png" alt="Sign up illustration">
    </div>
</div>

</body>
</html>
