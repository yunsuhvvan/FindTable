<%@ page isELIgnored="false" language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer"/>
<link href="<c:url value="/resources/css/notice.css"/>" rel="stylesheet">
<script src="<c:url value="/resources/js/notice.js"/>"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>

 
<script type="text/javascript">
	$(document).ready(function() {
		fnFindCommentList();
		
	});
	
	
	function fnFindCommentList() {
		$.ajax({
			url : '/restaurant/user/FindCommentList',
			type: 'get',
			data : 'reviewNo='+$('#reviewNo').val(),
			dataType: 'json',
			success: function(map){
				fnPrintCommentList(map);
			}
		});
	}
	

	   function fnPrintCommentList(map){
		      // 목록 초기화
		      $('.commentList').empty();
		      // 목록 만들기
		      if (map.list == null) {
		         $('<div>').text('등록된 댓글 없습니다.')
		         .appendTo( '.commentList' );
		      } else {
		    	  var a = '';
		         $.each(map.list, function(i, comment){
	        	 	a += '<div class="commentBorder">';
					a += '<div class="updateDeleteLink"><input class="commentNo" type="hidden" value="' + comment.commentNo + '">'+' 사장님 : '+ comment.writer
	                a += '</div></div>';
	                a += '<div class="commentContent" id="commentContent'+comment.commentNo+'"> <p style="margin-left:10px;"> 작성 내용 : ' + comment.content + '</p>';
	                a += '</div></div>';
		         });
		         $(".commentList").html(a);
		      }
		   }  
	 
</script>

<style>
	a{
	text-decoration: none;
	color: black;
}

h3{
	margin-left: 100px;
}
body{
  font-family: nanumsquare;
}



.card{
	width: 800px;
	margin: 0 auto;
	border: 1px solid silver;
	 box-shadow: 3px 3px 3px 3px gray;
}

.title{
	margin-left: 260px;
	font-weight: bold;
	font-size: 38px;

}

#contentBtn, .contentBtn{
			width: 70px;
		    background-color: rgb(230, 225, 225);
		    border: none;
		    color: gray;
		    padding: 5px;
		    margin: 5px;
		    border-radius: 10px;
		}
		#list_btn:hover{
			background-color:  rgba(160, 57, 38, 0.795);
		}
		.bottombtn{
			   justify-content: center;
		}
		.qnatable td:first-child{
			text-align:center;
		}
		.reviewimg{
			width:200px;
			height:200px;
		}
		.commentTitle{
			line-height:70px;
		}
		.containerForm{
			margin:30px 0;
		}
		.commentBorder{
			border-bottom: 1px solid rgb(230, 225, 225);
			border-top: 1px solid  rgb(230, 225, 225);
			margin:10px 0;
			padding: 10px;
		}
		.updateDeleteLink, .updateDeleteLink2{
			display:flex;
		}
		.updatelink, .deletelink{
			color:gray;
			margin:0 10px;
		}
		.commentContent{
			padding: 5px 0 ;
			border-top: none;
		}
		.updateDeleteLink2{
			margin-left: 100px;
		}
		.commentTextarea{
			padding: 5px;
			width: 700px;
			border: 1px solid  rgb(230, 225, 225);
		}
</style>

</head>
<body>
	
	  <header>
        <div class="wrap">
            <h1>
                <a href="/restaurant/">
                    <img src="/restaurant/resources/image/index/projectlogo.png">
                </a>
                
            </h1>
            <ul id="gnb">
            
            	<li><a href="/restaurant/admin/searchPage"><i class="fas fa-search fa-lg"></i></a></li> 
            
            	<c:if test="${loginUser == null}">
	                <li><a href="/restaurant/user/loginPage">LOGIN&nbsp;&nbsp;&nbsp;/</a></li>
	                <li><a href="/restaurant/user/join">JOIN&nbsp;&nbsp;&nbsp;</a></li>
            	</c:if>
            	
            	<!-- 사용자 state =1 -->
            	<c:if test="${loginUser.state == 1}">
            			<li>${loginUser.name} 님 환영합니다</li>
            		  <li><a href="/restaurant/user/logout">LOGOUT&nbsp;&nbsp;&nbsp;/</a></li>
            		  <li><a href="/restaurant/user/myPage">MYPAGE&nbsp;&nbsp;&nbsp;</a></li>
            	</c:if>
            	
            	<!-- 관리자 state 2 -->
            	<c:if test="${loginUser.state == 2}">
            		  <li>${loginUser.name} 님 환영합니다&nbsp;&nbsp;&nbsp;/</li>
            		  <li><a href="/restaurant/admin/adminPage">ADMIN PAGE</a></li>
            	</c:if>
            	
            	<!-- 사업자는 어떻게? -->
              <c:if test="${loginUser.state == 3}">
            		  <li>${loginUser.name} 님 환영합니다&nbsp;&nbsp;&nbsp;/</li>
            		  <li><a href="/restaurant/owner/logout">LOGOUT&nbsp;&nbsp;&nbsp;/</a></li>
            		  <li><a href="/restaurant/owner/managePage">OWNER PAGE</a></li>
            	</c:if>
                
                
            </ul>
        </div>
    </header>

    <div class="accordion">
        <div class="cate quickmenu">
            <span class="menu">
                <a href="#" class="menulink">Reservation</a>
                <a href="javascript:void(0);" class="subopen"></a>
            </span>
            <ul>
                 <li><a href="/restaurant/admin/searchPage"> 식당검색  </a></li>
                <li><a href="/restaurant/admin/newOpen"> 신규오픈 </a></li>
                <li><a href="/restaurant/admin/reviewRate"> 평점좋은식당 </a></li>
            </ul>
        </div>
        
        <div class="cate quickmenu">
            <span class="menu"> 
                <a href="#" class="menulink">Board</a>
                <a href="javascript:void(0);" class="subopen"></a>
            </span>
            <ul>
               <li><a href="/restaurant/notice/selectNoticeList"> 공지사항 </a></li>
                <li><a href="/restaurant/user/indexReviewPage"> 리뷰 </a></li>
                <li><a href="/restaurant/qnaboard/qnaList"> Q&A </a></li>
            </ul>
        </div>
        
        <div class="cate quickmenu">
            <span class="menu">
                <a href="#" class="menulink">Magazines</a>
                <a href="javascript:void(0);" class="subopen"></a>
            </span>
            <ul>
                <li><a href="/restaurant/user/magazine">다이닝 매거진</a></li>
            </ul>
        </div>
    </div>
	

	
	<div class="container">
		 <div style="width: 600px;">
             <div class="title" style="">&nbsp;&nbsp;자세히보기&nbsp;&nbsp;</div>        
         </div><br><br><br>
       
       <div class="card" style="">
		  <img style="width: 800px; height: 500px;" src="/restaurant/${review.reviewPath}/${review.reviewSaved}" class="card-img-top">
		  <div class="card-body">
		    <h5 class="card-title">${review.reviewWriter}<span style="margin-left: 500px; font-size: 15px;"> 작성일 : ${review.reviewDate}</span></h5><hr>
		    <p class="card-text">${review.reviewContent}</p>
		    <hr>
		    <p></p>
		    <div class="commentList">
		    
		    </div>
		    <a href="/restaurant/user/indexReviewPage" class="btn btn-danger">돌아가기</a>
		  </div>
		</div>
	</div>
	<input type="hidden" id="reviewNo" value="${review.reviewNo}">
	

    <section id="bottom">
        <div class="wrap">
            <div class="footer">
                <div class="footer_inner">
                    <ul class="footer_link">
                        <li><a href="#" target="_blank" class="footer_item">이용약관&nbsp;|</a></li>
                        <li><a href="#" target="_blank" class="footer_item">개인정보처리방침&nbsp;|</a></li>
                        <li><a href="#" target="_blank" class="footer_item">책임의 한계와 법적고지&nbsp;|</a></li>
                        <li><a href="#" target="_blank" class="footer_item">회원정보 고객센터</a></li>
                    </ul>
                    <div class="footer_copy">
                        <a href="#" target="_blank">
                            <img src="/restaurant/resources/image/index/projectlogo.png" alt="logo">
                        </a>
                        <span class="text">Copyright</span>
                        <span class="corp" style="font-weight: 800;">&copy; FindTable Corp.</span>
                        <span class="text">All Rights Reserved.</span>
                    </div>
                </div>
            </div>
        </div>
    </section>
</body>
</html>





			