<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
<body>
	<!-- Page Preloder -->
	<div id="preloder">
		<div class="loader"></div>
	</div>

	<!-- Header section -->
	<header class="header-section">
		<div class="container">
			<!-- logo -->
			<a class="site-logo" href="index.html">
				<img src="img/logo.png" alt="">
			</a>
			<div class="user-panel">
				<a href="#">Login</a>  /  <a href="#">Register</a>
			</div>
			<!-- responsive -->
			<div class="nav-switch">
				<i class="fa fa-bars"></i>
			</div>
			<!-- site menu -->
			<nav class="main-menu">
				<ul>
					<li><a href="index.html">Home</a></li>
					<li><a href="review.html">Games</a></li>
					<li><a href="categories.html">Blog</a></li>
					<li><a href="community.html">Forums</a></li>
					<li><a href="contact.html">Contact</a></li>
				</ul>
			</nav>
		</div>
	</header>
	<!-- Header section end -->


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
            </div>
            <div class="col-lg-8">
                <div class="contact-form-warp">
                    <h4 class="comment-title">Leave a Reply</h4>
                    <div class="comment-form">
                        <div class="row">
                            <div class="col-md-6">
                                <input type="text" placeholder="Name">
                            </div>
                            <div class="col-md-6">
                                <input type="email" placeholder="Email">
                            </div>
                            <div class="col-lg-12" style="position: relative;">
                                <input type="text" placeholder="Subject">
                                <textarea placeholder="Message"></textarea>
                                <input type="file" id="file-upload" accept=".zip" style="display: none;">
                                <label for="file-upload" class="site-btn btn-sm" style=" right: 0;">Upload File</label>
                                <button id="save-button" class="site-btn btn-sm" style="position: absolute;  right: 0;">저장</button>
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

        // 이미지 업로드 버튼 클릭 시
        $("#upload-button").click(function() {
            $("#image-upload").click(); // 이미지 업로드 input 클릭
        });

        // 파일 업로드 버튼 클릭 시
        $("#file-upload-button").click(function() {
            $("#file-upload").click(); // 파일 업로드 input 클릭
        });
        
        // 이미지 선택 시
        $("#image-upload").change(function(event) {
            var input = event.target;
            var reader = new FileReader();
            reader.onload = function() {
                var dataURL = reader.result;
                $("#image-preview").attr("src", dataURL); // 미리보기 이미지 업데이트
                imageData = input.files[0]; // 이미지 데이터 저장
            };
            reader.readAsDataURL(input.files[0]);
        });

        // 파일 선택 시
        $("#file-upload").change(function(event) {
            fileData = event.target.files[0]; // 파일 데이터 저장
        });

        // 저장 버튼 클릭 시
        $("#save-button").click(function() {
            if (imageData && fileData) { // 이미지와 파일 데이터가 모두 존재할 경우에만 실행
                var formData = new FormData();
                formData.append('image', imageData); // 이미지 데이터 추가
                formData.append('file', fileData); // 파일 데이터 추가

                // AJAX를 사용하여 이미지와 파일을 서버로 전송
                $.ajax({
                    url: '<%= request.getContextPath() %>/UploadServlet', // 파일 업로드를 처리하는 서버 측 스크립트의 URL
                    type: 'POST',
                    data: formData,
                    processData: false,
                    contentType: false,
                    success: function(response) {
                        console.log(response); // 성공 시 응답 출력
                        // 여기에 추가적인 작업을 수행할 수 있습니다.
                    },
                    error: function(xhr, status, error) {
                        console.error(xhr.responseText); // 에러 메시지 출력
                    }
                });
            } else {
                console.log("이미지와 파일을 선택하세요.");
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