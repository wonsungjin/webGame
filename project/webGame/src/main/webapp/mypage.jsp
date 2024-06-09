<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="User.UserVO"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="Reply.ReplyVO"%>

<%
    HttpSession currentSession = request.getSession(false);
    UserVO user = null;
    ArrayList<ReplyVO> userReplies = null;
    if (currentSession != null) {
        user = (UserVO) currentSession.getAttribute("user");
        userReplies = (ArrayList<ReplyVO>) currentSession.getAttribute("userReplies");
    }
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
    <title>My Page</title>
    <meta charset="UTF-8">
    <meta name="description" content="My Personal Page">
    <meta name="keywords" content="personal, mypage, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Favicon -->   
    <link href="img/favicon.ico" rel="shortcut icon"/>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Roboto:400,400i,500,500i,700,700i" rel="stylesheet">

    <!-- Stylesheets -->
    <link rel="stylesheet" href="css/bootstrap.min.css"/>
    <link rel="stylesheet" href="css/font-awesome.min.css"/>
    <link rel="stylesheet" href="css/owl.carousel.css"/>
    <link rel="stylesheet" href="css/style.css"/>
    <link rel="stylesheet" href="css/animate.css"/>

    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    
    <style>
        body {
            background-image: url('img/community-bg.jpg');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            background-repeat: no-repeat;
            color: white;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .info label, .info input, .info select, .info span {
            color: white;
        }
        .info input:disabled, .info select:disabled {
            color: white;
        }
        .info input:enabled, .info select:enabled {
            color: black;
        }
        .page-section {
            flex: 1;
        }
        .mypage-body {
            width: 50%;
            height: calc(100vh - 100px); /* Adjust the header height if necessary */
            margin: 0 auto;
            background-color: rgba(0, 0, 0, 0.7); /* Optional: Add background color with transparency */
            padding: 20px;
            overflow-y: auto;
        }
        .tabs {
            display: flex;
            flex-direction: row;
            justify-content: space-between;
        }
        .tablinks {
            flex: 1;
            padding: 10px;
            margin: 5px;
            background-color: #333;
            color: white;
            border: none;
            text-align: center;
            cursor: pointer;
        }
        .tablinks.active {
            background-color: #555;
        }
        .tabcontent {
            display: none;
            padding: 20px;
        }
        .tabcontent h2 {
            color: white;
        }
        .info {
            display: grid;
            grid-template-columns: 1fr 2fr 1fr;
            gap: 10px;
            align-items: center;
        }
        .info label {
            grid-column: 1 / 2;
        }
        .info input, .info select {
            grid-column: 2 / 3;
        }
        .info .check-duplicate {
            grid-column: 3 / 4;
            display: none;
            font-size: 0.8em;
            padding: 5px 10px;
        }
        .buttons {
            display: flex;
            justify-content: flex-end;
            margin-top: 20px;
        }
        .btn {
            color: white;
            background-color: blue;
            margin-left: 10px;
        }
        .btn.btn-danger {
            background-color: red;
        }
        .profile-image {
            display: flex;
            align-items: center;
        }
        .profile-image img {
            width: 63px;
            height: 63px;
            border-radius: 50%;
        }
        .file-upload-wrapper {
            position: relative;
            display: inline-block;
        }
        .file-upload-wrapper input[type="file"] {
            position: absolute;
            top: 0;
            left: 0;
            opacity: 0;
            height: 100%;
            width: 100%;
            cursor: pointer;
        }
        .file-upload-label {
            color: white;
            display: inline-block;
            padding: 5px 10px;
            border: 1px solid white;
            cursor: pointer;
        }
        .file-upload-filename {
            color: white;
            margin-left: 10px;
        }
        .file-upload-filename {
            color: white;
            margin-left: 10px;
        }
        .comments p {
            color: white;
        }
        .comment-buttons {
            margin-left: 10px;
        }
    </style>

    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script>
        $(document).ready(function(){
            const urlParams = new URLSearchParams(window.location.search);
            if (urlParams.get('update') === 'success') {
                alert('회원정보가 수정되었습니다.');
            }
            
            $('#checkId').click(function() {
                var id = $('#id').val();
                if (id.trim() === "") {
                    alert("ID를 입력하세요.");
                    return;
                }
                checkDuplicate('id', id);
            });

            $('#checkNickname').click(function() {
                var nickname = $('#nickname').val();
                if (nickname.trim() === "") {
                    alert("닉네임을 입력하세요.");
                    return;
                }
                checkDuplicate('nickname', nickname);
            });

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

            function checkDuplicate(field, value) {
                $.post('CheckDuplicateFieldServlet', { field: field, value: value }, function(response) {
                    if (response === "DUPLICATE") {
                        alert(field + "가 중복됩니다.");
                    } else {
                        alert(field + "를 사용할 수 있습니다.");
                    }
                });
            }

            $('#emailDomain').change(function() {
                if ($(this).val() === "other") {
                    $('#otherDomain').show().attr('required', true);
                } else {
                    $('#otherDomain').hide().attr('required', false);
                }
            });

            $('#file-upload').change(function() {
                var fileName = $(this).val().split('\\').pop();
                $('.file-upload-filename').text(fileName).css('color', 'white');
            });
        });

        function enableEdit() {
        document.querySelectorAll('.info input').forEach(input => input.disabled = false);
        document.querySelectorAll('.info select').forEach(select => select.disabled = false);
        document.querySelectorAll('.info .check-duplicate').forEach(button => button.style.display = 'inline-block');
        document.getElementById('save-btn').style.display = 'inline-block';
        document.getElementById('cancel-btn').style.display = 'inline-block';
        document.getElementById('edit-btn').style.display = 'none';
        document.getElementById('delete-btn').style.display = 'none';
        document.getElementById('file-upload-wrapper').style.display = 'block'; // 파일 업로드 버튼 표시
        document.querySelectorAll('.info input, .info select').forEach(input => input.style.color = 'black');
    }

        function cancelEdit() {
        document.querySelectorAll('.info input').forEach(input => input.disabled = true);
        document.querySelectorAll('.info select').forEach(select => select.disabled = true);
        document.querySelectorAll('.info .check-duplicate').forEach(button => button.style.display = 'none');
        document.getElementById('save-btn').style.display = 'none';
        document.getElementById('cancel-btn').style.display = 'none';
        document.getElementById('edit-btn').style.display = 'inline-block';
        document.getElementById('delete-btn').style.display = 'inline-block';
        document.getElementById('file-upload-wrapper').style.display = 'none'; // 파일 업로드 버튼 숨기기
        document.querySelectorAll('.info input:disabled, .info select:disabled').forEach(input => input.style.color = 'white');
    }

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

        function confirmDeletion() {
            if (confirm("정말 회원 탈퇴를 하시겠습니까?")) {
                window.location.href = 'UserServlet?action=delete&seq=<%= user.getUser_seq() %>';
            }
        }

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

    function deleteComment(replySeq) {
        if (confirm("정말 이 댓글을 삭제하시겠습니까?")) {
            $.ajax({
                url: '<%= request.getContextPath() %>/ReplyServlet', // ReplyServlet의 deleteComment 액션
                type: 'POST',
                data: { action: 'deleteComment', replySeq: replySeq },
                success: function(response) {
                    console.log('댓글이 삭제되었습니다.');
                    $('#reply-' + replySeq).remove();
                },
                error: function(error) {
                    console.error('댓글 삭제에 실패했습니다:', error);
                }
            });
        }
    }

        window.onload = function() {
            document.getElementById("defaultOpen").click();
        };
    </script>
</head>
<body>
    <!-- 페이지 전처리기 -->
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
                <c:if test="${user != null}">
                    <a href="UserServlet?action=logout">Logout</a>
                </c:if>
                <c:if test="${user == null}">
                    <a href="login.jsp">Login</a> / <a href="register.jsp">Register</a>
                </c:if>
            </div>
            <!-- 반응형 메뉴 버튼 -->
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
                    <c:if test="${user != null}">
                        <li><a href="UserServlet?action=mypage">MyPage</a></li>
                    </c:if>
                </ul>
            </nav>
        </div>
    </header>

    <!-- 페이지 섹션 -->
    <div class="page-section community-page set-bg" data-setbg="img/community-bg.jpg">
        <div class="mypage-body">
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
                    <c:if test="${not empty userReplies}">
                        <c:forEach var="reply" items="${userReplies}">
                            <div id="reply-${reply.reply_seq}">
                                <p>댓글 <c:out value="${reply.reply_seq}" />: <c:out value="${reply.reply}" />
                                    <span class="comment-buttons">
                                         <button class="btn" onclick="window.location.href='GameServlet?webGLName=<c:out value="${reply.webGL}" />'">이동</button>
                                        <button class="btn btn-danger" onclick="deleteComment(${reply.reply_seq})">삭제</button>
                                    </span>
                                </p>
                            </div>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty userReplies}">
                        <p>댓글이 없습니다.</p>
                    </c:if>
                </div>
            </div>
            <div id="user-info" class="tabcontent">
                <h2>회원정보</h2>
                <div class="info">
                    <label for="nickname">Nickname:</label>
                    <input type="text" id="nickname" name="nickname" value="<%= user.getUsername() %>" disabled>
                    <button type="button" id="checkNickname" class="check-duplicate">중복 검사</button>
                    <label for="id">ID:</label>
                    <input type="text" id="id" name="id" value="<%= user.getUserid() %>" disabled>
                    <button type="button" id="checkId" class="check-duplicate">중복 검사</button>
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
                    <button type="button" id="checkEmail" class="check-duplicate">중복 검사</button>
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" value="<%= user.getPassword() %>" disabled>
                    <br>
                    <label for="signup-date">Signup Date:</label>
                    <input type="text" id="signup-date" name="signup-date" value="<%= user.getCreated_date() %>" disabled readonly>
                    <br>
                    <label for="last-update">Last Update:</label>
                    <input type="text" id="last-update" name="last-update" value="<%= user.getUpdated_date() %>" disabled readonly>
                    <br>
                    <label for="profile-image">Profile Image:</label>
                    <div class="profile-image">
                        <img src="img/authors/1.jpg" alt="Profile Image">
                        <div class="file-upload-wrapper" id="file-upload-wrapper" style="display: none;">
                            <label for="file-upload" class="file-upload-label">Choose File</label>
                            <input type="file" id="file-upload" name="profileImage">
                            <span class="file-upload-filename"></span>
                        </div>
                    </div>
                </div>
                <div class="buttons">
                    <button id="edit-btn" class="btn" onclick="enableEdit()">수정</button>
                    <button id="save-btn" class="btn" style="display: none" onclick="saveEdit()">확인</button>
                    <button id="cancel-btn" class="btn btn-danger" style="display: none" onclick="cancelEdit()">취소</button>
                    <button id="delete-btn" class="btn btn-danger" onclick="confirmDeletion()">회원탈퇴</button>
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
    </div>
    <!-- 페이지 섹션 끝 -->

    <!--====== Javascripts & Jquery ======-->
    <script src="js/jquery-3.2.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/owl.carousel.min.js"></script>
    <script src="js/jquery.marquee.min.js"></script>
    <script src="js/main.js"></script>
</body>
</html>
