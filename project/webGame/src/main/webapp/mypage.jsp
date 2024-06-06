<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

    String userEmail = user.getUseremail();
    String emailUsername = "";
    String emailDomain = "";
    if (userEmail != null && !userEmail.isEmpty()) {
        String[] emailParts = userEmail.split("@");
        if (emailParts.length == 2) {
            emailUsername = emailParts[0];
            emailDomain = emailParts[1];
        }
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
        
        // ID 중복 검사
        $('#checkId').click(function() {
            var id = $('#id').val();
            if (id.trim() === "") {
                alert("ID를 입력하세요.");
                return;
            }
            checkDuplicate('id', id);
        });

        // 닉네임 중복 검사
        $('#checkNickname').click(function() {
            var nickname = $('#nickname').val();
            if (nickname.trim() === "") {
                alert("닉네임을 입력하세요.");
                return;
            }
            checkDuplicate('nickname', nickname);
        });

        // 이메일 중복 검사
        $('#checkEmail').click(function() {
            var email = $('#userid').val() + "@" + $('#emailDomain').val();
            if ($('#emailDomain').val() === "other") {
                email = $('#userid').val() + "@" + $('#otherDomain').val();
            }
            if (email.trim() === "") {
                alert("이메일을 입력하세요.");
                return;
            }
            checkDuplicate('email', email);
        });

        // 중복 검사를 위한 AJAX 호출
        function checkDuplicate(field, value) {
            $.post('CheckDuplicateFieldServlet', { field: field, value: value }, function(response) {
                if (response === "DUPLICATE") {
                    alert(field + "가 중복됩니다.");
                } else {
                    alert(field + "를 사용할 수 있습니다.");
                }
            });
        }

        // 이메일 도메인 변경 시 처리
        $('#emailDomain').change(function() {
            if ($(this).val() === "other") {
                $('#otherDomain').show().attr('required', true);
            } else {
                $('#otherDomain').hide().attr('required', false);
            }
        });
    });

    // 회원정보 수정 활성화
    function enableEdit() {
        document.querySelectorAll('.info input').forEach(input => input.disabled = false);
        document.querySelectorAll('.info select').forEach(select => select.disabled = false);
        document.querySelectorAll('.info .check-duplicate').forEach(button => button.style.display = 'inline-block');
        document.getElementById('save-btn').style.display = 'inline-block';
        document.getElementById('cancel-btn').style.display = 'inline-block';
        document.getElementById('edit-btn').style.display = 'none';
    }

    // 회원정보 수정 취소
    function cancelEdit() {
        document.querySelectorAll('.info input').forEach(input => input.disabled = true);
        document.querySelectorAll('.info select').forEach(select => select.disabled = true);
        document.querySelectorAll('.info .check-duplicate').forEach(button => button.style.display = 'none');
        document.getElementById('save-btn').style.display = 'none';
        document.getElementById('cancel-btn').style.display = 'none';
        document.getElementById('edit-btn').style.display = 'inline-block';
        alert("수정을 취소합니다.");
    }

    // 회원정보 수정 저장
    function saveEdit() {
        const updateForm = document.getElementById('updateForm');
        document.getElementById('usernameHidden').value = document.getElementById('nickname').value;
        document.getElementById('emailHidden').value = document.getElementById('userid').value + '@' + document.getElementById('emailDomain').value;
        if (document.getElementById('emailDomain').value === "other") {
            document.getElementById('emailHidden').value = document.getElementById('userid').value + '@' + document.getElementById('otherDomain').value;
        }
        document.getElementById('passwordHidden').value = document.getElementById('password').value;
        document.getElementById('useridHidden').value = document.getElementById('id').value;
        updateForm.submit();
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
	<section class="page-section community-page set-bg" data-setbg="img/community-bg.jpg">
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
				<h2 style="color: white;">게임관리</h2>
			</div>
			<div id="comment-management" class="tabcontent">
				<h2 style="color: white;">댓글관리</h2>
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
				<h2 style="color: white;">회원정보</h2>
				<div class="info">
                    <label for="nickname">Nickname:</label>
                    <input type="text" id="nickname" name="nickname" value="<%= user.getUsername() %>" disabled>
                    <button type="button" id="checkNickname" class="check-duplicate" style="display: none; font-size: 0.8em; padding: 5px 10px;">중복 검사</button>
                    <label for="id">ID:</label>
                    <input type="text" id="id" name="id" value="<%= user.getUserid() %>" disabled>
                    <button type="button" id="checkId" class="check-duplicate" style="display: none; font-size: 0.8em; padding: 5px 10px;">중복 검사</button>
                    <label for="email">Email:</label>
                    <div class="email-input">
                        <input type="text" id="userid" name="userid" placeholder="Username" value="<%= emailUsername %>" disabled> 
                        <span>@</span> 
                        <select id="emailDomain" name="emailDomain" disabled>
                            <option value="gmail.com" <%= "gmail.com".equals(emailDomain) ? "selected" : "" %>>gmail.com</option>
                            <option value="naver.com" <%= "naver.com".equals(emailDomain) ? "selected" : "" %>>naver.com</option>
                            <option value="hanmail.net" <%= "hanmail.net".equals(emailDomain) ? "selected" : "" %>>hanmail.net</option>
                            <option value="other">Other</option>
                        </select>
                        <input type="text" id="otherDomain" name="otherDomain" placeholder="Other Domain" style="display: none;" disabled>
                    </div>
                    <button type="button" id="checkEmail" class="check-duplicate" style="display: none; font-size: 0.8em; padding: 5px 10px;">중복 검사</button>
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" value="<%= user.getPassword() %>" disabled>
                    <label for="signup-date">Signup Date:</label>
                    <input type="text" id="signup-date" name="signup-date" value="<%= user.getCreated_date() %>" disabled readonly>
                    <label for="last-update">Last Update:</label>
                    <input type="text" id="last-update" name="last-update" value="<%= user.getUpdated_date() %>" disabled readonly>
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
                    <input type="hidden" id="usernameHidden" name="username" value="<%= user.getUsername() %>">
                    <input type="hidden" id="emailHidden" name="email" value="<%= user.getUseremail() %>">
                    <input type="hidden" id="passwordHidden" name="password" value="<%= user.getPassword() %>">
                    <input type="hidden" id="useridHidden" name="userid" value="<%= user.getUserid() %>">
                </form>
			</div>
		</div>
	</section>
</body>
</html>
