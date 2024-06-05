<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="User.UserVO"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="Reply.ReplyVO"%>

<%
    // 기존 세션이 없으면 null 반환
    HttpSession currentSession = request.getSession(false);
    UserVO user = null;
    ArrayList<ReplyVO> userReplies = null;
    if (currentSession != null) {
        user = (UserVO) currentSession.getAttribute("user");
        userReplies = (ArrayList<ReplyVO>) currentSession.getAttribute("userReplies");
    }
    // 사용자 정보가 없으면 로그인 페이지로 리다이렉트
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Page - Game Warrior</title>
<link rel="stylesheet" href="css/mypage.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script>
    $(document).ready(function(){
        // 배경 이미지 설정
        var bg = $(".set-bg").attr("data-setbg");
        $(".set-bg").css("background-image", "url(" + bg + ")");

        // 회원정보 수정 성공 시 알림
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get('update') === 'success') {
            alert('회원정보가 수정되었습니다.');
        }
    });

    // 회원정보 수정 활성화
    function enableEdit() {
        document.querySelectorAll('.info input').forEach(input => input.disabled = false);
        document.getElementById('save-btn').style.display = 'inline-block';
        document.getElementById('cancel-btn').style.display = 'inline-block';
        document.getElementById('edit-btn').style.display = 'none';
    }

    // 회원정보 수정 취소
    function cancelEdit() {
        document.querySelectorAll('.info input').forEach(input => input.disabled = true);
        document.getElementById('save-btn').style.display = 'none';
        document.getElementById('cancel-btn').style.display = 'none';
        document.getElementById('edit-btn').style.display = 'inline-block';
        alert("수정을 취소합니다.");
    }

    // 회원정보 수정 저장
    function saveEdit() {
        document.getElementById('updateForm').submit();
    }

    // 회원 탈퇴 확인
    function confirmDeletion() {
        if (confirm("정말 회원 탈퇴를 하시겠습니까?")) {
            window.location.href = 'UserServlet?action=delete&seq=<%= user.getUser_seq() %>';
        }
    }

    // 탭 열기
    function openTab(evt, tabName) {
        var i, tabcontent, tablinks;
        tabcontent = document.getElementsByClassName("tabcontent");
        for (i = 0; i < tabcontent.length; i++) {
            tabcontent[i].style.display = "none";
        }
        tablinks = document.getElementsByClassName("tablinks");
        for (i = 0; i < tablinks.length; i++) {
            tablinks[i].className = tablinks[i].className.replace(" active", "");
        }
        document.getElementById(tabName).style.display = "block";
        evt.currentTarget.className += " active";
    }

    window.onload = function() {
        document.getElementById("defaultOpen").click();
    };
</script>
</head>
<body>
	<!-- 스타일시트 -->
	<link rel="stylesheet" href="css/bootstrap.min.css" />
	<link rel="stylesheet" href="css/font-awesome.min.css" />
	<link rel="stylesheet" href="css/owl.carousel.css" />
	<link rel="stylesheet" href="css/style.css" />
	<link rel="stylesheet" href="css/animate.css" />

	<!-- 페이지 섹션 -->
	<section class="page-section community-page set-bg"
		data-setbg="img/community-bg.jpg">
		<!-- 헤더 섹션 -->
		<header class="header-section">
			<div class="container">
				<a class="site-logo" href="index.jsp">
					<img src="img/logo.png" alt="">
				</a>
				<div class="user-panel">
					<% if (user != null) { %>
					<a href="UserServlet?action=logout">로그아웃</a>
					<% } else { %>
					<a href="login.jsp">로그인</a> / <a href="register.jsp">회원가입</a>
					<% } %>
				</div>
				<!-- 네비게이션 스위치 -->
				<div class="nav-switch">
					<i class="fa fa-bars"></i>
				</div>
				<!-- 메인 메뉴 -->
				<nav class="main-menu">
					<ul>
						<li><a href="index.jsp">홈</a></li>
						<li><a href="document.html">문서</a></li>
						<% if (user != null) { %>
						<li><a href="UserServlet?action=mypage">마이페이지</a></li>
						<% } %>
					</ul>
				</nav>
			</div>
		</header>

		<div class="mypage-container">
			<!-- 탭 섹션 -->
			<div class="tabs">
				<button class="tablinks" onclick="openTab(event, 'game-management')">게임관리</button>
				<button class="tablinks" onclick="openTab(event, 'comment-management')">댓글관리</button>
				<button class="tablinks active" id="defaultOpen" onclick="openTab(event, 'user-info')">회원정보</button>
			</div>
			<div id="game-management" class="tabcontent">
				<h2>게임관리</h2>
			</div>
			<div id="comment-management" class="tabcontent">
				<h2>댓글관리</h2>
				<div class="comments">
					<% if (userReplies != null && !userReplies.isEmpty()) { %>
					<!-- 댓글이 있는 경우 -->
					<c:forEach var="reply" items="${userReplies}">
						<p>
							댓글 <c:out value="${reply.reply_seq}" />: <c:out value="${reply.reply}" />
						</p>
					</c:forEach>
					<% } else { %>
					<!-- 댓글이 없는 경우 -->
					<p>댓글이 없습니다.</p>
					<% } %>
				</div>
			</div>
			<div id="user-info" class="tabcontent">
				<h2>회원정보</h2>
				<div class="info">
					<label for="nickname">Nickname:</label>
					<input type="text" id="nickname" name="nickname" value="<%= user.getUsername() %>" disabled>
					<label for="id">ID:</label>
					<input type="text" id="id" name="id" value="<%= user.getUserid() %>" disabled>
					<label for="email">Email:</label>
					<input type="email" id="email" name="email" value="<%= user.getUseremail() %>" disabled>
					<label for="password">Password:</label>
					<input type="password" id="password" name="password" value="<%= user.getPassword() %>" disabled>
					<label for="signup-date">Signup Date:</label>
					<input type="text" id="signup-date" name="signup-date" value="<%= user.getCreated_date() %>" disabled>
					<label for="last-update">Last Update:</label>
					<input type="text" id="last-update" name="last-update" value="<%= user.getUpdated_date() %>" disabled>
				</div>
				<div class="buttons">
					<button id="edit-btn" class="btn" onclick="enableEdit()">수정</button>
					<button id="save-btn" class="btn" style="display: none" onclick="saveEdit()">확인</button>
					<button id="cancel-btn" class="btn" style="display: none" onclick="cancelEdit()">취소</button>
					<button class="btn btn-danger" onclick="confirmDeletion()">회원탈퇴</button>
				</div>
				<form id="updateForm" method="post" action="UserServlet">
					<input type="hidden" name="pagecode" value="update">
					<input type="hidden" name="seq" value="<%= user.getUser_seq() %>">
					<input type="hidden" name="username" value="<%= user.getUsername() %>">
					<input type="hidden" name="email" value="<%= user.getUseremail() %>">
					<input type="hidden" name="password" value="<%= user.getPassword() %>">
					<input type="hidden" name="userid" value="<%= user.getUserid() %>">
				</form>
			</div>
		</div>
	</section>
</body>
</html>
