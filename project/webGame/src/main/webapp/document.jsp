<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="User.UserVO" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<%
    HttpSession currentSession = request.getSession(false);
    UserVO user = null;
    if (currentSession != null) {
        user = (UserVO) currentSession.getAttribute("user");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Game Warrior Template</title>
    <meta charset="UTF-8">
    <meta name="description" content="Game Warrior Template">
    <meta name="keywords" content="warrior, game, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 파비콘 -->
    <link href="img/favicon.ico" rel="shortcut icon"/>

    <!-- 구글 폰트 -->
    <link href="https://fonts.googleapis.com/css?family=Roboto:400,400i,500,500i,700,700i" rel="stylesheet">

    <!-- 스타일시트 -->
    <link rel="stylesheet" href="css/bootstrap.min.css"/>
    <link rel="stylesheet" href="css/font-awesome.min.css"/>
    <link rel="stylesheet" href="css/owl.carousel.css"/>
    <link rel="stylesheet" href="css/style.css"/>
    <link rel="stylesheet" href="css/animate.css"/>

    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

    <!-- 인라인 스타일로 배경 이미지 추가 -->
    <style>
        body {
            background-image: url('img/community-bg.jpg');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            background-repeat: no-repeat;
            color: white; /* 텍스트 색상을 흰색으로 설정 */
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .content-wrapper {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding-top: 60px; /* 상단 메뉴와 겹치지 않도록 패딩 추가 */
        }
        .black-tab {
            background-color: rgba(0, 0, 0, 0.8); /* 검정색 배경과 약간의 투명도 */
            width: 75%; /* 가로 3/4 */
            height: 80vh; /* 세로 길이 (적절히 조절 가능) */
            padding: 20px;
            box-sizing: border-box; /* 패딩을 포함한 박스 크기 */
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            color: white; /* 텍스트 색상 */
        }
        .tab-content {
            width: 100%; /* 콘텐츠 가로 크기 */
            text-align: center; /* 텍스트 중앙 정렬 */
        }
    </style>
</head>
<body>
    <!-- 페이지 프리로더 -->
    <div id="preloder">
        <div class="loader"></div>
    </div>

    <!-- 헤더 섹션 -->
    <header class="header-section">
        <div class="container">
            <!-- 로고 -->
            <a class="site-logo" href="index.jsp">
                <img src="img/logo.png" alt="">
            </a>
            <div class="user-panel">
                <% if (user != null) { %>
                    <a href="UserServlet?action=logout">logout</a>
                <% } else { %>
                    <a href="login.jsp">login</a> / <a href="register.jsp">register</a>
                <% } %>
            </div>
            <!-- 반응형 메뉴 -->
            <div class="nav-switch">
                <i class="fa fa-bars"></i>
            </div>
            <!-- 사이트 메뉴 -->
            <nav class="main-menu">
                <ul>
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="document.jsp">Document</a></li>
                    <li><a href="pageinfo.html">PageInfo</a></li>
                    <li><a href="contact.html">Contact</a></li>
                    <% if (user != null) { %>
                        <li><a href="UserServlet?action=mypage">mypage</a></li>
                        <li><a href="UploadServlet?pagecode=contactMove">addgame</a></li>
                    <% } %>
                </ul>
            </nav>
        </div>
    </header>
    <!-- 헤더 섹션 끝 -->

    <!-- 검정색 탭을 포함하는 컨텐츠 래퍼 -->
    <div class="content-wrapper">
        <div class="black-tab">
            <div class="tab-content">
                <h2 style = "color : white">How to add games</h2>
                <p style = "color : white">1: Log in and click the addgame button at the top</p>
                <p style = "color : white">2: Register the webgl version build files of the game to be registered as compressed files.</p>
                <p style = "color : white">3: Enter the name and description of the game you want to register and attach an image to be registered as a thumbnail. However, the name of the attached image file must be the same as the game's build file name.</p>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <!--====== 자바스크립트 및 제이쿼리 ======-->
    <script src="js/jquery-3.2.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/owl.carousel.min.js"></script>
    <script src="js/jquery.marquee.min.js"></script>
    <script src="js/main.js"></script>
</body>
</html>