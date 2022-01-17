<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<c:url value="/resources/css/userCSS/detail.css"/>" rel="stylesheet">
<link href="c:<url value="/resources/js/userJS/detail.js"/>" rel="stylesheet">
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.css" integrity="sha512-4wfcoXlib1Aq0mUtsLLM74SZtmB73VHTafZAvxIp/Wk9u1PpIsrfmTvK0+yKetghCL8SHlZbMyEcV8Z21v42UQ==" crossorigin="anonymous" referrerpolicy="no-referrer"/>
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous"> 
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.css" integrity="sha512-4wfcoXlib1Aq0mUtsLLM74SZtmB73VHTafZAvxIp/Wk9u1PpIsrfmTvK0+yKetghCL8SHlZbMyEcV8Z21v42UQ==" crossorigin="anonymous" referrerpolicy="no-referrer"/>
	<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
	<link href="<c:url value="/resources/css/index.css"/>" rel="stylesheet">
	<link href="<c:url value="/resources/css/owner1.css"/>" rel="stylesheet">
	<link href="<c:url value="/resources/css/userCSS/detail.css"/>" rel="stylesheet">
	<script src="<c:url value="/resources/js/index.js"/>"></script>
	<script src="<c:url value="/resources/js/userJS/detail.js"/>"></script>
 <script>
 $(document).ready(function() {
	    fnhover();
	    fnQuickMenu();
	   // fnFindCommentList();
	    
	    //리뷰 개수 구하기
	   const arr = '${reviewCountList}';
	   
	   let count5 = 0;
	   let count4 = 0;
	   let count3 = 0;
	   let count2 = 0;
	   let count1 = 0;
	   
	   for (let i = 0; i < arr.length; i++) {
		   if (arr[i] == 5){count5 += 1;}
		   if (arr[i] == 4){count4 += 1;}
		   if (arr[i] == 3){count3 += 1;}
		   if (arr[i] == 2){count2 += 1;}
		   if (arr[i] == 1){count1 += 1;}
	   }
	   $('#5score').html(count5);
	   $('#5bar').attr('value', count5);
	   
	   $('#4score').html(count4);
	   $('#4bar').attr('value', count4);
	   
	   $('#3score').html(count3);
	   $('#3bar').attr('value', count3);
	   
	   $('#2score').html(count2);
	   $('#2bar').attr('value', count2);
	   
	   $('#1score').html(count1);
	   $('#1bar').attr('value', count1);
	   
	   
	});
	

	function fnQuickMenu() {
	    var currentPosition = parseInt($(".quickmenu").css("top"));
	    $(window).scroll(function() {
	        var position = $(window).scrollTop();
	        $(".quickmenu").stop().animate({ "top": position + currentPosition + "px" }, 1000);
	    });
	}

	function fnhover() {
	    (function($) {
	        $('.cate ul').hide();
	        $('.cate .menu .subopen').click(function() {
	            if ($(this).hasClass('active')) {
	                $(this).parent().next().slideUp('slow');
	                $(this).removeClass('active');
	            } else {
	                $('.accordion').find('.active').parent().next().slideUp('slow');
	                $('.accordion').find('.active').removeClass('active');
	                $(this).parent().next().slideDown('slow');
	                $(this).addClass('active');
	            }
	        });
	    })(jQuery);
	}
	
   function fnFindCommentList() {
	      $.ajax({
	         url : '/restaurant/user/ReviewCommentList?resNo='+${resNo},
	         type: 'get',
	         dataType: 'json',
	         success: function(list){
	            fnPrintCommentList(list);
	         }
	      });
	   }
		   

      function fnPrintCommentList(list){
            $('.commentList').empty();
            if (list == null) {
               $('<div>').text('등록된 댓글 없습니다.')
               .appendTo( '.commentList' );
            } else {
               var a = '';
               $.each(list, function(i, comment){
	                  a += '<div class="commentBorder">';
	                  a += '<div ><p><i class="far fa-calendar-alt"></i>&nbsp;작성 일자 : ' + comment.createDate + '</p>';
	                  a += '<div><p><i class="far fa-comment-dots"></i>&nbsp;사장님 댓글 : '+ comment.content+ comment.reviewNo+'</p>';
	                  a += '</div>';
	                  a += '</div></div>';
	               });
               $(".commentList").html(a);
            }
         }  
	
	
	
 </script>
 
 <style>
	 a{
	 	color: black;
	 	text-decoration:none;
	 	font-weight: normal;
	 }
	 
	 /* component */
	
	.star-rating {
	  display:flex;
	  flex-direction: row-reverse;
	  font-size:1.5em;
	  justify-content:space-around;
	  padding:0 .2em;
	  text-align:center;
	  width:5em;
	}
	.returnbtn{
		font-weight:800;
		font-size: 20px;
	}
	.average{
		font-size: 20px;
	}
	.scores{
		color:red;
		font-size: 20px;
	}
	.container{
		width:900px;
	}
	.col-9 {
	    display: flex;
	    flex: 0 0 auto;
	    width: 100%;
	   background-color: rgb(233 233 233);
	   padding: 20px;
	   border-radius: 20px;
	   margin: 10px;
	}
	.col-4{
		margin: 0;
		text-align: center;
		line-height: 3;
	}
	.col-6 {
	    flex: 0 0 auto;
	    width: 70%;
	}
	.reviewimg{
		width:150px;
		height:150px;
		padding-right: 20px;
	}
	.dateinput{
		width: 93px;
		border:none;
		outline:none;'
	}
	.reviewmultiple{
		border-bottom : 1px solid silver;
		padding: 10px;
	}
	.reviewmultiple h3{
		padding-left: 10px;
		
	}
	.review_content>p:nth-of-type(2){
		margin: 10px;
	}
	.reviewContent{
		margin-top: 10px;
	}
	.reviewStar{
		font-size: 30px;
	}
	.reviewCount{
		font-size: 20px;
	}
	.progress{
		background-color: #cfcfcf;
		margin: 3px;
	} 
	.emptyReview{
		font-size: 20px;
		padding: 10px;
		text-align: center;
        margin: 50px;
	}
	.progress{
		width: 500px;
	}
	progress {

 	 -webkit-appearance: none;
	}
	
	::-webkit-progress-bar {
	  background-color: grey;
	}
	
	::-webkit-progress-value {
	  background-color: orange;
	}
	.commentBorder{
		margin: 15px;
		padding: 5px;
		border-top: 1px solid silver;
		border-bottom: 1px solid silver;
	}
 </style>
</head>
<body>

	
	  <header>
        <div class="wrap">
            <h1 style="padding-top: 0">
                <a href="/restaurant/" >
                    <img  src="/restaurant/resources/image/index/projectlogo.png">
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
    
    <div class="accordion"  style="margin-top: 180px;">
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
		 <section>
	 	<div>
	 		<div style="display: inline-block;">
	 		<a href="/restaurant/admin/goResDetail?resNo=${resNo}" class="returnbtn"><i class="far fa-hand-point-left returnbtn"></i> 돌아가기</a>
	 		</div>
	 		<div class="reviewrating">
			  <div class="row">
			    <div class="col-9">
			    
				    <div class="col-4">
					    <div class="reviewStar"> ★${avgReview}</div>
					    <div class="reviewCount"><strong>${totalReviewCount}</strong>개의 리뷰</div>
					</div>
				    <div class="col-6 average">
					    <div>
				 			<ul>
				 				<li>
				 					<c:forEach var="review" items="${reviewlist}">
				 						<c:if test="${review.get('REVIEW_RATE')} == 5">
				 							
				 						</c:if>
				 					</c:forEach>
				 					<span class="score">5점</span>&nbsp;(<span id="5score"></span>)
				 					<progress class="progress" max="10" id="5bar"></progress>
				 					
				 				</li>
				 				
				 				<li>
				 					<span class="score">4점</span>&nbsp;(<span id="4score"></span>)
				 					<progress class="progress" max="10" id="4bar"></progress>
				 					
				 				</li>
				 				<li>
				 					<span class="score">3점</span>&nbsp;(<span id="3score"></span>)
				 					<progress class="progress" max="10" id="3bar"></progress>
				 					
				 				</li>
				 				<li>
				 					<span class="score">2점</span>&nbsp;	(<span id="2score"></span>)
				 					<progress class="progress" max="10" id="2bar"></progress>
				 				</li>
				 				<li>
				 					<span class="score">1점</span>&nbsp;	(<span id="1score"></span>)
				 					<progress class="progress" max="10" id="1bar"></progress>
				 				
				 				</li>
				 			</ul>
				 		</div>
				    </div>
				</div>
		 		<c:if  test="${empty reviewlist}">
		 			<div class="emptyReview">
		 				작성된 리뷰가 없습니다.
		 			</div>
		 		</c:if>
		 		<c:if test="${not empty reviewlist}">
			 		<c:forEach var="review" items="${reviewlist}">
		            	<div class="reviewmultiple">
							<c:set var="reviewNo" value="${review.get('REVIEW_NO')}"/>
		            		<input type="hidden" value="${review.get('REVIEW_NO')}" id="reviewNo">
		            		<h3>${review.get("RES_NAME")}</h3>
		            		<img alt="${review.get('REVIEW_ORIGIN')}" src="/restaurant/${review.get('REVIEW_PATH')}/${review.get('REVIEW_SAVED')}" class="reviewimg">
		                    <div class="review_content">
		                        <div>${review.get("REVIEW_WRITER")}</div>
		                        <div class="reviewdaterate">
			                        <span><input type="text" class="dateinput" value="${review.get('REVIEW_DATE')}"></span>
			                        <span style="color:darkorange;">★&nbsp;${review.get("REVIEW_RATE")}</span>
		                        </div>
		                        <div class="reviewContent">${review.get("REVIEW_CONTENT")}</div>
		                    </div>
		            	</div>
				    <c:if test="${not empty moreReply}">
				      <c:forEach var="comment" items="${moreReply}">
				      	<c:if test="${reviewNo == comment.reviewNo}">
						    <div class="commentList">
						        <div class="commentBorder">
						            <div>
					                    <p>
					                        <i class="far fa-calendar-alt"></i>&nbsp;작성 일자 : ${comment.createDate}
					                    </p>
					                <div>
						                <p>
						                    <i class="far fa-comment-dots"></i>&nbsp;사장님 댓글 : ${comment.content}
						                </p>
					                </div>
						            </div>
						        </div>
						    </div>
				      	</c:if>
				      </c:forEach>
				    </c:if>        	
		            </c:forEach>
		           </c:if>
			   </div>
			</div>
		</div>
	 </section>
       
		</div>
  
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