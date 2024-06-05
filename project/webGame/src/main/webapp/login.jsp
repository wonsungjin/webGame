<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login - Game Warrior</title>
<link rel="stylesheet" href="css/login.css">
</head>
<body>
	<div class="login-container">
		<div class="header">
			<img src="logo.png" alt="Game Warrior Logo" class="logo">
			<h1 class="title">Game Warrior</h1>
		</div>
		<div class="login-form">
			<h2>Login</h2>
			<form id="loginForm" method="post" action="UserServlet">
				<div class="input-group">
					<label for="username">Username</label> <input type="text"
						id="username" name="username" required>
				</div>
				<div class="input-group">
					<label for="password">Password</label> <input type="password"
						id="password" name="password" required>
				</div>
				
				<!-- Hidden input으로 pagecode -->
				<input type="hidden" name="pagecode" value="login">
				<button type="submit" class="btn">Login</button>
				<p>
					<a href="forgot-password.jsp">Forgot Password?</a>
				</p>
				<p>
					Don't have an account? <a href="register.jsp">Register</a>
				</p>
			</form>
		</div>
	</div>
</body>
</html>
