<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="User.UserVO"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="java.io.File"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>

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
<link href="img/favicon.ico" rel="shortcut icon" />

<!-- 구글 폰트 -->
<link
	href="https://fonts.googleapis.com/css?family=Roboto:400,400i,500,500i,700,700i"
	rel="stylesheet">

<!-- 스타일시트 -->
<link rel="stylesheet" href="css/bootstrap.min.css" />
<link rel="stylesheet" href="css/font-awesome.min.css" />
<link rel="stylesheet" href="css/owl.carousel.css" />
<link rel="stylesheet" href="css/style.css" />
<link rel="stylesheet" href="css/animate.css" />

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

.header-section {
	padding: 20px 0; /* 헤더 섹션에 패딩 추가 */
	background: rgba(0, 0, 0, 0.8); /* 헤더 섹션 배경 색상 */
	width: 100%;
	position: fixed;
	top: 0;
	left: 0;
	z-index: 1000;
}

.content-wrapper {
	flex: 1;
	display: flex;
	justify-content: center;
	align-items: center;
	padding-top: 120px; /* 상단 메뉴와 겹치지 않도록 패딩 추가 */
}

.black-tab {
	background-color: rgba(0, 0, 0, 0.8); /* 검정색 배경과 약간의 투명도 */
	width: 75%; /* 가로 3/4 */
	padding: 20px;
	box-sizing: border-box; /* 패딩을 포함한 박스 크기 */
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	color: white; /* 텍스트 색상 */
	overflow: hidden; /* 내부 요소가 벗어나지 않도록 설정 */
}

.tab-content {
	width: 100%; /* 콘텐츠 가로 크기 */
	text-align: center; /* 텍스트 중앙 정렬 */
	display: none; /* 초기에는 보이지 않도록 설정 */
}

.tab-content img {
	max-width: 100%; /* 이미지가 컨테이너의 크기를 넘지 않도록 설정 */
	height: auto; /* 이미지 비율을 유지 */
}

.tab-content p {
	font-size: 30px; /* 글자 크기 설정 */
	font-weight: bold; /* 글자 굵게 설정 */
}

.tab-content.active {
	display: block; /* active 클래스가 추가되면 보이도록 설정 */
}

.buttons {
	display: flex;
	justify-content: center;
	margin-bottom: 20px;
}

.buttons button {
	background-color: white;
	color: black;
	border: none;
	padding: 10px 20px;
	margin: 0 10px;
	cursor: pointer;
}

.buttons button.active {
	background-color: #555;
	color: white;
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
			<a class="site-logo" href="index.jsp"> <img src="img/logo.png"
				alt="">
			</a>
			<div class="user-panel">
				<%
				if (user != null) {
				%>
				<a href="UserServlet?action=logout">logout</a>
				<%
				} else {
				%>
				<a href="login.jsp">login</a> / <a href="register.jsp">register</a>
				<%
				}
				%>
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
					<li><a href="pageinfo.jsp">PageInfo</a></li>
					<li><a href="contact.html">Contact</a></li>
					<%
					if (user != null) {
					%>
					<li><a href="UserServlet?action=mypage">mypage</a></li>
					<li><a href="UploadServlet?pagecode=contactMove">addgame</a></li>
					<%
					}
					%>
				</ul>
			</nav>
		</div>
	</header>
	<!-- 헤더 섹션 끝 -->

	<!-- 검정색 탭을 포함하는 컨텐츠 래퍼 -->
	<div class="content-wrapper">
		<div class="black-tab">
			<div class="buttons">
				<button id="userBtn" onclick="showContent('userContent')">User</button>
				<button id="developerBtn" onclick="showContent('developerContent')">Developer</button>
			</div>
			<div id="userContent" class="tab-content active">
				<p style="color: white">1: register and Log in</p>
				<img src="img/1.JPG" alt="Step 1 Image">
				<p style="color: white">2: You can play games or edit your personal information.</p>
				<img src="img/6.JPG" alt="Step 6 Image">
				<p style="color: white">3: Enjoy the game!</p>
				<img src="img/7.JPG" alt="Step 7 Image">
				<p style="color: white">3: Please leave a rating and review for the game.</p>
				<img src="img/8.JPG" alt="Step 8 Image">
				
			</div>
			<div id="developerContent" class="tab-content">
				<p style="color: white">1: You must log in to use our site.</p>
				<img src="img/1.JPG" alt="Step 1 Image">
				<p style="color: white">2: Register the webgl version build
					files of the game to be registered as compressed files.</p>
				<img src="img/2.JPG" alt="Step 2 Image">
				<p style="color: white">3: Enter the name and description of the
					game you want to register and attach an image to be registered as a
					thumbnail. However, the name of the attached image file must be the
					same as the game's build file name.</p>
				<img src="img/3.JPG" alt="Step 3 Image">
				<p style="color: white">4: How to use our DB</p><br>
				<p style="color: white">4-1 form data : You can create a script to send the form and send it in form data format when the game ends or when you want to save it.</p>
				<img src="img/4-1.JPG" alt="Step 4-1 Image">
				<p style="color: white">4: How to use our DB</p><br>
				<p style="color: white">4-2 json data : You can write a script and transmit data in json format.</p>
				<img src="img/4-2.JPG" alt="Step 4-2 Image">
				<p style="color: white">5: How to use our DB</p><br>
				<p style="color: white">5 get json data : You can write a script and receive data in json format from the server.</p>
				<img src="img/5.JPG" alt="Step 5 Image">
			</div>
		</div>
	</div>

	<script>
		window.addEventListener('load', function() {
			document.getElementById('preloder').style.display = 'none';
		});

		function showContent(contentId) {
			var contents = document.querySelectorAll('.tab-content');
			var buttons = document.querySelectorAll('.buttons button');
			contents.forEach(function(content) {
				content.classList.remove('active');
			});
			buttons.forEach(function(button) {
				button.classList.remove('active');
			});
			document.getElementById(contentId).classList.add('active');
			var btn = document.querySelector(`#${contentId}Btn`);
			if (btn) {
				btn.classList.add('active');
			}
		}

		// 기본적으로 User 버튼을 활성화
		document.getElementById('userBtn').classList.add('active');
	</script>
</body>
</html>
