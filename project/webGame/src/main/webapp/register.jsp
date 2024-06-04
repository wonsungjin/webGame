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
<title>Register - Game Warrior</title>
<link rel="stylesheet" href="css/login.css">
</head>
<body>
	<div class="login-container">
		<div class="header">
			<img src="logo.png" alt="Game Warrior Logo" class="logo">
			<h1 class="title">Game Warrior</h1>
		</div>
		<div class="login-form">
			<h2>Register</h2>
			<form id="registerForm" method="post" action="UserServlet">
				<div class="input-group">
					<label for="nickname">Nickname</label> 
					<input type="text" id="nickname" name="nickname" required>
				</div>
				<div class="input-group">
					<label for="id">ID</label> 
					<input type="text" id="id" name="id" required>
				</div>
				<div class="input-group">
					<label for="email">Email</label>
					<div class="email-input">
						<input type="text" id="userid" name="userid" placeholder="Username" required> 
						<span>@</span> 
						<select id="emailDomain" name="emailDomain" onchange="checkOther()">
							<option value="gmail.com">gmail.com</option>
							<option value="naver.com">naver.com</option>
							<option value="hanmail.net">hanmail.net</option>
							<option value="other">Other</option>
						</select>
					</div>
					<input type="text" id="otherDomain" name="otherDomain" placeholder="Other Domain" style="display: none;">
				</div>
				<div class="input-group">
					<label for="password">Password</label> 
					<input type="password" id="password" name="password" required>
				</div>
				<!-- Hidden input으로 pagecode부분 -->
				<input type="hidden" name="pagecode" value="register">
				<button type="submit" class="btn">Register</button>
				<p>
					Already have an account? <a href="login.jsp">Login</a>
				</p>
			</form>
		</div>
	</div>

	<script>
		// 이메일주소에서 다른거 골랐을때 동작하는 함수
		function checkOther() {
			var select = document.getElementById("emailDomain");
			var otherDomainInput = document.getElementById("otherDomain");

			if (select.value === "other") {
				otherDomainInput.style.display = "inline-block";
				otherDomainInput.setAttribute("required", true);
			} else {
				otherDomainInput.style.display = "none";
				otherDomainInput.removeAttribute("required");
			}
		}
	</script>
</body>
</html>
