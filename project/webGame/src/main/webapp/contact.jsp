<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="User.UserVO"%>
<%@ page import="java.io.*, java.util.*, org.apache.commons.fileupload.*, org.apache.commons.fileupload.disk.*, org.apache.commons.fileupload.servlet.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>Game Warrior Template</title>
	<meta charset="UTF-8">
	<meta name="description" content="Game Warrior Template">
	<meta name="keywords" content="warrior, game, creative, html">
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

</head>

<%
    HttpSession currentSession = request.getSession(false);
    UserVO user = null;
    if (currentSession != null) {
        user = (UserVO) currentSession.getAttribute("user");
    }
%>
<body>
	<!-- Page Preloder -->
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
                    <li><a href="pageinfo.jsp">PageInfo</a></li>
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


	<!-- Page info section -->
	<section class="page-info-section set-bg" data-setbg="img/page-top-bg/5.jpg">
		<div class="pi-content">
			<div class="container">
				<div class="row">
					<div class="col-xl-5 col-lg-6 text-white">
						<h2>게임 등록</h2>
						<p>게임 등록을 위한 webGL파일을 업로드 해주세요.</p>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Page info section -->
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Footer Example</title>
    <style>
        .comment-title {
            color: #FFA500; 
            font-size: 24px; 
            font-weight: bold;
        }
        
        .col-lg-4 {
            display: flex;
            align-items: center; 
            justify-content: center; 
            width: 450px;
            height: 200px;
            object-fit: cover;
        }

        .comment-form input, .comment-form textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
        }

        .site-btn {
            display: inline-block;
            background-color: #FFD700; 
            color: #fff; 
            padding: 10px 20px;
            text-decoration: none;
            border: none;
            cursor: pointer;
        }
    </style>
</head>
<body>
<section class="footer-top-section">
    <div class="container">
        <div class="row">
            <div class="col-lg-4 mb-5 mb-lg-0" style="text-align: center; position: relative; margin-top: 90px">
                <img id="image-preview" src="img/gameLogo/10.jpg">
                <input type="file" id="image-upload" accept="image/*" style="display: none;">
                <button id="upload-button" class="site-btn btn-sm" style="position: absolute; top: 100%; left: 50%; transform: translateX(-50%); margin-top: 175px;">Upload Image</button>
                <div id="file-name" style="margin-top: 10px; color: white; text-align: center; position: absolute; bottom: -60px; left: 50%; transform: translateX(-50%);"></div> <!-- 파일 이름을 표시할 요소 수정 -->
            </div>
            <div class="col-lg-8">
                <div class="contact-form-warp">
                    <h4 class="comment-title">Leave a Reply</h4>
                    <div class="comment-form">
                        <div class="row">
                            <div class="col-md-6">
                                <input type="text" placeholder="Name" value="<%= user.getUsername() %>" readonly>
                            </div>
                            <div class="col-md-6">
                                <input type="email" placeholder="Email" value="<%= user.getUseremail() %>" readonly>
                            </div>
                            <div class="col-lg-12" style="position: relative;">
                                <input id="game-name" type="text" placeholder="게임 이름 입력...">
                                <textarea id="game-description" class="form-control no-resize" placeholder="게임 설명 입력..."></textarea>
                                <input type="file" id="file-upload" accept=".zip" style="display: none;">
                                <label for="file-upload" class="site-btn btn-sm" style=" right: 0;">Upload File</label>
                                <button id="save-button" class="site-btn btn-sm" style="position: absolute; bottom: 0; right: 0;">저장</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        var imageData = null; // 이미지 데이터를 저장할 변수
        var fileData = null; // 파일 데이터를 저장할 변수
        var imageFileName = null;
        var fileFileName = null;

        $("#upload-button").click(function() {
            $("#image-upload").trigger("click"); // 이미지 업로드 input 클릭 이벤트 트리거
        });

        $("#file-upload-button").click(function() {
            $("#file-upload").trigger("click"); // 파일 업로드 input 클릭 이벤트 트리거
        });
        
        $("#image-upload").change(function(event) {
            var input = event.target;
            var reader = new FileReader();
            reader.onload = function() {
                var dataURL = reader.result;
                $("#image-preview").attr("src", dataURL); // 미리보기 이미지 업데이트
                imageData = input.files[0]; // 이미지 데이터 저장
                imageFileName = imageData.name.split('.').slice(0, -1).join('.');
            };
            reader.readAsDataURL(input.files[0]);
        });

        $("#file-upload").change(function(event) {
            fileData = event.target.files[0]; // 파일 데이터 저장
            if (fileData) {
                $("#file-name").text("선택한 파일: " + fileData.name); // 선택한 파일 이름을 업데이트
                fileFileName = fileData.name.split('.').slice(0, -1).join('.');
            } else {
                $("#file-name").text(""); // 파일이 선택되지 않은 경우
            }
        });

        $("#save-button").click(function() {
            if (imageData && fileData) { // 이미지와 파일 데이터가 모두 존재할 경우에만 실행
                if (imageFileName === fileFileName) {
                	var formData = new FormData();
                	let postContent = $(event.target).closest('.comment-form');
                	let gameName = $('#game-name').val();
                	let gameContent = $('#game-description').val();
                	let user_seq = <%=user.getUser_seq()%>;
                	let webGL = imageData.name;
                	if (webGL.lastIndexOf(".") !== -1) {
                	    webGL = webGL.substring(0, webGL.lastIndexOf("."));
                	}
                	formData.append('image', imageData);
                	formData.append('file', fileData);

                	formData.append('gameName', gameName);
                	formData.append('gameContent', gameContent);
                	formData.append('user_seq', user_seq);
                	formData.append('webGL', webGL);

                	$.ajax({
                	    url: '<%= request.getContextPath() %>/UploadServlet?pagecode=file', // 파일 업로드를 처리하는 서버 측 스크립트의 URL
                	    type: 'POST',
                	    data: formData,
                	    processData: false,
                	    contentType: false,
                	    success: function(response) {
                	        console.log(response); // 성공 시 응답 출력
                	       	
                	    },
                	    error: function(xhr, status, error) {
                	        console.error(xhr.responseText); // 에러 메시지 출력
                	    }
                	});
                }else {
                    alert("이미지와 파일의 이름을 같게 해주세요.");
                }
            } else {
                alert("이미지와 파일을 선택하세요.");
            }
        });
    });
</script>


	<!-- Footer section -->
	<footer class="footer-section">
		<div class="container">
			<ul class="footer-menu">
	
			</ul>
		</div>
	</footer>
	<!-- Footer section end -->


	<!--====== Javascripts & Jquery ======-->
	<script src="js/jquery-3.2.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/owl.carousel.min.js"></script>
	<script src="js/jquery.marquee.min.js"></script>
	<script src="js/main.js"></script>

    </body>
</html>