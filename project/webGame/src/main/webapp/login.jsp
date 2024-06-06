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
        <!--
            <img src="logo.png" alt="Game Warrior Logo" class="logo"> 일단 로고 에러나서 주석처리
            -->
            <h1 class="title">Game Warrior</h1>
        </div>
        <div class="login-form">
            <h2>Login</h2>
            <form id="loginForm" method="post" action="UserServlet">
                <!-- 사용자 아이디 입력 필드 -->
                <div class="input-group">
                    <label for="userid">아이디</label>
                    <input type="text" id="userid" name="userid" required>
                </div>
                <!-- 사용자 비밀번호 입력 필드 -->
                <div class="input-group">
                    <label for="password">비밀번호</label>
                    <input type="password" id="password" name="password" required>
                </div>
                <!-- 페이지 코드 숨김 입력 필드 -->
                <input type="hidden" name="pagecode" value="login">
                <!-- 로그인 버튼 -->
                <button type="submit" class="btn">로그인</button>
                <p>
                    <a href="forgot-password.jsp">비밀번호찾기</a>
                </p>
                <p>
                    계정이 없으신가요? <a href="register.jsp">회원가입</a>
                </p>
                <!-- 로그인 실패 시 에러 메시지 표시 -->
                <c:if test="${param.error == '1'}">
                    <p style="color: red;">아이디나 패스워드가 잘못되었습니다.</p>
                </c:if>
            </form>
        </div>
    </div>
</body>
</html>
