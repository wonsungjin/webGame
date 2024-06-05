<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="User.UserVO"%>
<%@ page import="Reply.ReplyVO"%>
<%@ page import="java.util.ArrayList"%>
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
<%
UserVO uvo = (UserVO) request.getAttribute("KEY_userVO");
String webGLName = (String) request.getAttribute("KEY_webGLName"); 
%>

<section class="page-section community-page set-bg" data-setbg="img/community-bg.jpg">
    <!-- 유니티 WebGL 빌드를 추가하는 부분 -->
    <iframe src="webGL/<%= webGLName %>/index.html" frameborder="0" width="100%" height="1000" style="overflow: hidden; border: none;"></iframe>
    <!-- Page info section -->
<style>
    .community-warp {
        width: 100%;
        background-color: rgba(0, 0, 0, 0.6); /* 검은색 투명도 60%로 설정 */
    }
</style>
<%
ArrayList<ReplyVO> rvoList = (ArrayList<ReplyVO>)request.getAttribute("KEY_replyVOList");
int reply_seq =0;
int user_seq =0;
String reply = "";
String created_date="";
String updated_date="";
String webGL="";
int grade=0;
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dynamic Number Counter</title>
    <style>
        .counter {
            font-size: 2em;
            font-weight: bold;
        }
    </style>
</head>
<!-- Page section -->
<div class="community-warp spad diablo-style">
    <div class="container">
        <div class="row">
            <div class="col-md-6">
            <!-- 동적 숫자 시작 -->
                <!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dynamic Number Counter</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body style="background-color: #000; color: #fff;">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h3 class="community-top-title" style="color: #fff; display: inline;">댓글 수 </h3>
                <div class="counter" data-target="<%=rvoList.size()%>" style="color: #fff; display: inline;">0</div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            $('.counter').each(function() {
                var $this = $(this),
                    target = parseInt($this.data('target'), 10),
                    count = 0,
                    increment = target / 100, // Adjust this to control the speed of the counter
                    interval = 20; // Adjust this to control the interval of the counter
                
                var counterInterval = setInterval(function() {
                    count += increment;
                    if (count >= target) {
                        count = target;
                        clearInterval(counterInterval);
                    }
                    $this.text(Math.floor(count));
                }, interval);
            });
        });
    </script>
</body>
</html>
<!-- 동적 숫자 끝 -->

<br>
            </div>
            
        </div><%
        for(ReplyVO rvo  : rvoList)
{
	reply_seq=rvo.getReply_seq();
	user_seq = rvo.getUser_seq();
	reply = rvo.getReply();
	created_date = rvo.getCreated_date();
	updated_date = rvo.getUpdated_date();
	webGL = rvo.getWebGL();
	grade =rvo.getGrade();
	UserVO replyUserVo = rvo.getUserVO();
%>
        <ul class="community-post-list">
            <li>
                <div class="community-post" style="position: relative;">
                    <div class="author-avator set-bg" data-setbg="img/authors/1.jpg"></div>
                    <div class="post-content">
                        <div class ="replydata">
                        <h5><%=replyUserVo.getUsername()%><span>님이 업데이트를 게시했습니다</span></h5>
                        <input type="hidden" name="updated_date" value=<%=updated_date%>>
                        <input type="hidden" name="user_seq" value=<%=user_seq%>>
                        <input type="hidden" name="reply_seq" value=<%=reply_seq%>>
                        <div class="post-date" name="created_date" value=<%=created_date%>><%=created_date%></div>
                        <div class="reply" name="reply"><p><%=reply%></p></div>
                   		 </div>   
                        <%if(uvo.getUser_seq()==user_seq) {%>
                        <!-- 수정 버튼 -->
                        <button class="btn btn-secondary btn-sm edit-comment" id = "modify" style="position: absolute; bottom: -50px; right: 5px;">수정</button>
                        <!-- 삭제 버튼 -->
                        <button class="btn btn-danger btn-sm delete-comment" id = "delete" style="position: absolute; bottom: -50px; right: -45px;">삭제</button>
                        <%}%>
                    </div>
                </div>
            </li>
        </ul>
        <%}%>
      <div class="comment-form diablo-style">
    <h4 style="color: #fff;">댓글 작성하기</h4>
    <div class="form-group">
        <textarea class="form-control no-resize" id="comment" placeholder="댓글을 입력하세요" rows="6" style="background-color: #333; color: #fff; font-size: 16px;"></textarea>
    </div>
    <button type="button" class="btn btn-primary" style="background-color: #555; border-color: #555; font-size: 16px;">작성하기</button>
</div>
    </div>
</div>
<!-- Page section end -->

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
function handleEdit(event) {
    // 기존 이벤트 핸들러 제거
    $('.cancel-update').off('click', handleCancel);
    $('.update-comment').off('click', handleUpdate);

    let postContent = $(event.target).closest('.community-post').find('.post-content').find('.reply');
    let commentText = postContent.find('p').text();
    let originalHtml = postContent.html();
    
    // 댓글 요소에 데이터를 저장
    postContent.data('original-html', originalHtml);
    postContent.data('original-comment-text', commentText);
    
    $(event.target).closest('.community-post').find('.edit-comment').hide();
    $(event.target).closest('.community-post').find('.delete-comment').hide();
    
    postContent.html(`
        <textarea class="form-control no-resize">${commentText}</textarea>
        <button class="btn btn-primary btn-sm update-comment" style="position: absolute; bottom: -50px; right: 5px;">완료</button>
        <button class="btn btn-danger btn-sm cancel-update" style="position: absolute; bottom: -50px; right: -45px;">취소</button>
    `);

    // 수정하기 버튼에 클릭 이벤트 리스너 추가
    $('.update-comment').on('click', handleUpdate);
    // 취소 버튼에 클릭 이벤트 리스너 추가
    $('.cancel-update').on('click', handleCancel);
}

function handleCancel(event) {
    let postContent = $(event.target).closest('.community-post').find('.post-content').find('.reply');
    restoreOriginalComment(postContent);
}

function restoreOriginalComment(postContent) {
    let originalHtml = postContent.data('original-html');
    let originalCommentText = postContent.data('original-comment-text');
    
    // 원래 상태 복원
    postContent.html(originalHtml);
    
    let communityPost = postContent.closest('.community-post');
    communityPost.find('.edit-comment').show();
    communityPost.find('.delete-comment').show();

    console.log("댓글이 원래대로 돌아갔습니다.");
}

function handleUpdate(event) {
    let replyData = $(event.target).closest('.community-post').find('.replydata');
    
    // 해당 div 내의 hidden input 요소들의 값을 가져옴
    let updatedDate = replyData.find('input[name="updated_date"]').val();
    let userSeq = replyData.find('input[name="user_seq"]').val();
    let replySeq = replyData.find('input[name="reply_seq"]').val();
    let createdDate = replyData.find('.post-date').text();
    let replyContent = $(event.target).closest('.community-post').find('textarea').val();
    if (!replyContent || replyContent.trim() === '') {
        console.error('댓글 내용이 비어 있습니다.');
        return; // 댓글 내용이 비어 있으면 더 이상 진행하지 않고 함수 종료
    }
    
    // 가져온 데이터 사용 예시
    console.log('Updated Date:', updatedDate);
    console.log('User Seq:', userSeq);
    console.log('Reply Seq:', replySeq);
    console.log('Created Date:', createdDate);
    console.log('Reply Content:', replyContent);
    
    // AJAX를 사용하여 서버에 댓글 업데이트 요청을 보냄
    $.ajax({
        url: '<%= request.getContextPath() %>/GameServlet?webGLName=<%=webGLName%>&pagecode=replyUpdate',
        type: 'POST',
        data: {
            updatedDate: updatedDate,
            userSeq: userSeq,
            replySeq: replySeq,
            createdDate: createdDate,
            replyContent: replyContent
        },
        success: function(response) {
            // 성공적으로 업데이트되었을 때의 처리
            console.log('댓글이 업데이트되었습니다.');
            
            let postContent = $(event.target).closest('.community-post').find('.post-content').find('.reply');
            restoreOriginalComment(postContent);

            // 댓글 내용을 업데이트된 내용으로 변경
            postContent.find('p').text(replyContent);

            let communityPost = postContent.closest('.community-post');
            communityPost.find('.edit-comment').show();
            communityPost.find('.delete-comment').show();
        },
        error: function(error) {
            // 업데이트에 실패했을 때의 처리
            console.error('댓글 업데이트에 실패했습니다:', error);
        }
    });
}

function handleDelete(event) {
    if (confirm('진짜로 삭제하시겠습니까?')) {
        let postContent = $(event.target).closest('.community-post-list');
        let replySeq = postContent.find('input[name="reply_seq"]').val();
        $.ajax({
            url: '<%= request.getContextPath() %>/GameServlet?webGLName=<%=webGLName%>&pagecode=replyDelete', // 서버의 삭제 API 엔드포인트
            type: 'POST',
            data: { replySeq: replySeq }, // 댓글 ID 또는 식별자를 전송
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

$(document).ready(function() {
    // 수정하기 버튼 클릭 시 호출되는 함수
    $('.edit-comment').click(handleEdit);
    
    // 삭제하기 버튼 클릭 시 호출되는 함수
    $('.delete-comment').click(handleDelete);
    
    // 작성하기 버튼 클릭 시 호출되는 함수
    $('.btn-primary').click(handleInsert);
    
    function handleInsert(event) {
        // 작성된 댓글 내용 가져오기
        let replyContent = $('#comment').val();
        if (!replyContent || replyContent.trim() === '') {
            console.error('댓글 내용이 비어 있습니다.');
            return; // 댓글 내용이 비어 있으면 더 이상 진행하지 않고 함수 종료
        }
        let userSeq = <%=uvo.getUser_seq()%>;
        // Ajax를 사용하여 서버로 댓글 전송
        $.ajax({
            url: '<%= request.getContextPath() %>/GameServlet?webGLName=<%=webGLName%>&pagecode=replyInsert', // 서버의 댓글 추가 API 엔드포인트
            type: 'POST',
            data: { userSeq: userSeq, replyContent: replyContent }, // 작성된 댓글 내용 전송
            success: function(response) {
                // 댓글 추가 성공 시 처리
                console.log('댓글이 성공적으로 추가되었습니다.');
                // 페이지 리로드 또는 새로운 댓글을 화면에 표시하는 등의 작업 수행
                location.reload(); // 페이지 리로드 예시
            },
            error: function(error) {
                // 댓글 추가 실패 시 처리
                console.error('댓글 추가에 실패했습니다:', error);
            }
        });
    }
});
</script>

</script>

	<!--====== Javascripts & Jquery ======-->
	<script src="js/jquery-3.2.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/owl.carousel.min.js"></script>
	<script src="js/jquery.marquee.min.js"></script>
	<script src="js/main.js"></script>
    </body>
</html>