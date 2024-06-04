<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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

<section class="page-section community-page set-bg" data-setbg="img/community-bg.jpg">
    <!-- 유니티 WebGL 빌드를 추가하는 부분 -->
   <iframe src="timeChase/index.html" frameborder="0" width="100%" height="1000" style="overflow: hidden; border: none;"></iframe>
	<!-- Page info section -->

<style>
    .community-warp {
        width: 100%;
        background-color: rgba(0, 0, 0, 0.6); /* 검은색 투명도 60%로 설정 */
    }
</style>
<!-- Page section -->
<div class="community-warp spad diablo-style">
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <h3 class="community-top-title" style="color: #fff;">모든 멤버 (344)</h3>
            </div>
            
        </div>
        <ul class="community-post-list">
            <li>
                <div class="community-post" style="position: relative;">
                    <div class="author-avator set-bg" data-setbg="img/authors/1.jpg"></div>
                    <div class="post-content">
                        <h5>James Smith<span>님이 업데이트를 게시했습니다</span></h5>
                        <div class="post-date">2018년 6월 21일</div>
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed feugiat porttitor nunc, ac consequat lorem convallis nec. Mauris consectetur, leo vitae fermentum euismod, sem metus gravida turpis, id aliquam nulla orci nec enim. </p>
                        <!-- 수정 버튼 -->
                        <button class="btn btn-secondary btn-sm edit-comment" style="position: absolute; bottom: -50px; right: 5px;">수정</button>
                        <!-- 삭제 버튼 -->
                        <button class="btn btn-danger btn-sm delete-comment" style="position: absolute; bottom: -50px; right: -45px;">삭제</button>
                    </div>
                </div>
            </li>
        </ul>
        <div class="site-pagination sp-style-2">
            <span class="active">01.</span>
            <a href="#">02.</a>
            <a href="#">03.</a>
        </div>
    </div>
</div>
<!-- Page section end -->

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
    // 수정 버튼에 클릭 이벤트 리스너 추가
    $('.edit-comment').click(handleEdit);

    // 삭제 버튼에 클릭 이벤트 리스너 추가
    $('.delete-comment').click(handleDelete);
});

function handleEdit(event) {
    // 클릭된 요소의 부모 요소를 찾아 댓글 내용을 수정 가능한 입력란으로 바꿈
    const postContent = $(this).closest('.community-post').find('.post-content');
    const commentText = postContent.find('p').text();
    postContent.html(`
        <textarea class="form-control no-resize">${commentText}</textarea>
        <button class="btn btn-primary btn-sm update-comment">수정하기</button>
        <button class="btn btn-danger btn-sm cancel-update">취소</button>
    `);

    // 수정하기 버튼에 클릭 이벤트 리스너 추가
    postContent.find('.update-comment').click(handleUpdate);

    // 취소 버튼에 클릭 이벤트 리스너 추가
    postContent.find('.cancel-update').click(handleCancel);
}

function handleUpdate(event) {
    const updatedComment = $(this).siblings('textarea').val();
    const postContent = $(this).parent();
    const commentId = postContent.closest('.community-post').data('id');  // 댓글 ID 가져오기

    // 여기에 수정된 댓글 내용을 처리하는 코드를 추가하세요
    $.ajax({
        url: '/update-comment',  // 서버의 수정 API 엔드포인트
        type: 'POST',
        data: { 
            id: commentId,
            comment: updatedComment 
        },
        success: function(response) {
            console.log('수정된 댓글 내용:', updatedComment);
            restoreOriginalComment(postContent, updatedComment);
        },
        error: function(error) {
            console.error('댓글 수정에 실패했습니다:', error);
        }
    });
}

function handleCancel(event) {
    const originalComment = $(this).siblings('textarea').val();
    restoreOriginalComment($(this).parent(), originalComment);
}

function handleDelete(event) {
    if (confirm('진짜로 삭제하시겠습니까?')) {
        const postContent = $(this).closest('.community-post');
        const commentId = postContent.data('id');  // 댓글 ID 가져오기
        
        $.ajax({
            url: '/delete-comment',  // 서버의 삭제 API 엔드포인트
            type: 'POST',
            data: { id: commentId },  // 댓글 ID 또는 식별자를 전송
            success: function(response) {
                postContent.remove();
                console.log('댓글이 삭제되었습니다.');
            },
            error: function(error) {
                console.error('댓글 삭제에 실패했습니다:', error);
            }
        });
    }
}

function restoreOriginalComment(postContent, commentText) {
    postContent.html(`
        <h5>James Smith<span>님이 업데이트를 게시했습니다</span></h5>
        <div class="post-date">2018년 6월 21일</div>
        <p>${commentText}</p>
        <button class="btn btn-secondary btn-sm edit-comment" style="position: absolute; bottom: -50px; right: 5px;">수정</button>
        <button class="btn btn-danger btn-sm delete-comment" style="position: absolute; bottom: -50px; right: -45px;">삭제</button>
    `);

    // 수정 버튼에 클릭 이벤트 리스너 다시 추가
    postContent.find('.edit-comment').click(handleEdit);

    // 삭제 버튼에 클릭 이벤트 리스너 다시 추가
    postContent.find('.delete-comment').click(handleDelete);
}
</script>
	<!--====== Javascripts & Jquery ======-->
	<script src="js/jquery-3.2.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/owl.carousel.min.js"></script>
	<script src="js/jquery.marquee.min.js"></script>
	<script src="js/main.js"></script>
    </body>
</html>