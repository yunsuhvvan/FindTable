<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer"/>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link href="<c:url value="/resources/css/userCSS/myPage.css"/>" rel="stylesheet">
<link href="<c:url value="/resources/css/userCSS/myqnadetail.css"/>" rel="stylesheet">

<style>

	body{
		font-family: nanumsquare;
	}
	 a {
	    text-decoration: none;
	    color: black;
	}
	
	a:hover {
	    cursor: pointer;
	    color:black;
	}
	table{
		font-size: 16px;
		margin-bottom: 30px;
	}
	.question_btn{
	    display: flex;
	}
	
	.listimg{
		width:300px;
		height: 250px;
		border-radius: 10px;
	}
	.listtitle{
		text-align:center;
		padding-top: 15px;
	}
	.qnatable{
		width:100%;
		font-size: 16px;
	}

	.qnatable input, .qnatable textarea{
		border: none;
		outline: none;
	}
	.qnatable td{
		border-bottom:0.5px solid silver;
		padding: 10px;
	}
	
	.comment{
		display: flex;
		margin: 10px;
		flex-flow:row nowrap;
		justify-content:space-between;
		text-align:center;
	}
	.commenttitle{
		font-size:14px;
		width:100px;
		height:30px;
		margin: 20px 0 0 0;
		padding:10px;
	}
	.content_btn{
		width:30px;
		background-color: silver;
		padding:10px
	}
	.bottombtn{
		display:flex;
		text-align:center;
	}
	.commentList{
		padding: 10px;
		border-top: 1px solid silver;
		border-bottom: 1px solid silver;
		margin-bottom: 30px;
	}
	
	.commentList input{
		margin: 5px;
	 	border : none;
	 	outline: none;
	}
	.col-sm-9 {
    flex: 0 0 auto;
    width: 100%;
	}
	table td:first-child{
		width: 150px;
		text-align: center;
		
	}
	.formatDate{
		width: 88px;
	}
	.footerInput{
		text-align: center;
	}
</style>

<script>
	$(document).ready(function () {
		fnremoveQna();
		
		$('#update_btn1').click(function () {
			  if($('.qnaState2').val() == 2){
				location.href='/restaurant/user/qnaUpdatePage?qnaNo='+$('.qnaNo2').val();
			} else if ($('.qnaState3').val() == 3){
				location.href='/restaurant/user/qnaUpdatePage?qnaNo='+$('.qnaNo3').val();
			} else {
				location.href='/restaurant/user/qnaUpdatePage?qnaNo='+$('.qnaNo1').val();
			}
		});
	});


	function fnremoveQna() {
		$('#delete_btn').click(function () {
			if(confirm('정말로 삭제하시겠습니까?')){
				if($('.qnaState2').val() == 2){
					$('#qnaform1').attr('action', '/restaurant/user/removeQna?qnaNo='+$('.qnaNo2').val());
					$('#qnaform1').submit();
				} else if($('.qnaState3').val() == 3){
					$('#qnaform1').attr('action', '/restaurant/user/removeQna?qnaNo='+$('.qnaNo3').val());
					$('#qnaform1').submit();
				} else{
					$('#qnaform1').attr('action', '/restaurant/user/removeQna?qnaNo='+$('.qnaNo1').val());
					$('#qnaform1').submit();
				}
			}
		});
	}	
	
</script>
</head>
<body>
  
      <header>
        <div class="wrap">
            <h1 id="header_h1">
                <a href="/restaurant">
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
            		  <li>${loginUser.name} 님 환영합니다</li>
            		  <li><a href="/restaurant/admin/myPage">ADMIN PAGE</a></li>
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
       
   
    <div class="container">
        <div class="row">
            <div class="col-4">
                <div class="menu_nav">
                    <h2 class="menu_title">예약 내역</h2>
                    <ul>
                        <li><a href="/restaurant/book/selectBookingList?userNo=${loginUser.userNo}" class="menu_sub_title">예약완료</a></li>
                        <li><a href="/restaurant/book/findCancelList" class="menu_sub_title">예약취소내역 / 환불</a></li>
                        <li><a href="/restaurant/user/PayListPage" class="menu_sub_title">결제내역</a></li>
                    </ul>
                </div>
                <div class="menu_nav"> 
                    <h2 class="menu_title">My 활동</h2>
                    <ul>
                        <li><a href="/restaurant/user/findQnaList?qnaWriter=${loginUser.id}">문의 내역</a></li>
                        <li><a href="/restaurant/user/goCartPage">찜 목록</a></li>
                    </ul>
                </div>
                <div class="menu_nav">
                    <h2 class="menu_title">내 정보</h2>
                    <ul>
                        <li><a href="/restaurant/user/updateUser">내 정보 수정</a></li>
                    </ul>
                </div>
            </div>
            
            <div class="col-6">
                <div>
                    <h3 class="ing_title" style="font-size: 30px" >세부 문의 사항</h3>
                </div>
                <hr>
                <div class="containers">
                     <div class="col-sm-9">
                    <form id="qnaform1" method="post"> 
                         <input type="hidden" value="${list2.qnaNo}" name="qnaNo" class="qnaNo2">
                         <input type="hidden" value="${list3.qnaNo}" name="qnaNo" class="qnaNo3">
                         <input type="hidden" value="${list2.qnaState}" name=qnaState class="qnaState2">
                         <input type="hidden" value="${list3.qnaState}" name="qnaState" class="qnaState3">
                         <input type="hidden" value="${list1.qnaNo}" name="qnaNo" class="qnaNo1">
                         <input type="hidden" value="${list1.qnaState}" name="qnaState" class="qnaState1">
                         <table class="qnatable">
                              <tbody>
                              	<c:if test="${list2.qnaState ==2 }">
                                  <tr >
                                     <td>작성자</td>
                                     <td><input type="text" value="${list2.qnaWriter}" id="qnaWriter" readonly></td>
                                  </tr>
                                  <tr >
                                     <td>제목</td>
                                     <td><input type="text" value="${list2.qnaTitle}" id="qnaTitle" readonly></td>
                                  </tr>
                                  <tr>
                                      <td>작성일</td>
                                      <td><input type="text" value="${list2.qnaDate}" id="qnaDate" readonly></td>
                                  </tr>
                                  <tr>
                                     <td>내용</td>
                                     <td><textarea rows="20" cols="70" name="qnaContent" readonly>${list2.qnaContent}</textarea></td>
                                  </tr>
                              	</c:if>
                              	<c:if test="${list3.qnaState ==3 }">
                                  <tr>
                                     <td>작성자</td>
                                     <td><input type="text" value="${list3.qnaWriter}" id="qnaWriter" readonly></td>
                                  </tr>
                                  <tr>
                                     <td>제목</td>
                                     <td><input type="text" value="${list3.qnaTitle}" id="qnaTitle" readonly></td>
                                  </tr>
                                  <tr>
                                      <td>작성일</td>
                                      <td><input type="text" value="${list3.qnaDate}" id="qnaDate" readonly></td>
                                  </tr>
                                  <tr>
                                     <td>내용</td>
                                     <td><textarea rows="20" cols="70" name="qnaContent" readonly>${list3.qnaContent}</textarea></td>
                                  </tr>
                              	</c:if>
                              	<c:if test="${list1.qnaState ==1 }">
                                  <tr>
                                     <td>작성자</td>
                                     <td><input type="text" value="${list1.qnaWriter}" id="qnaWriter" readonly></td>
                                  </tr>
                                  <tr>
                                     <td>제목</td>
                                     <td><input type="text" value="${list1.qnaTitle}" id="qnaTitle" readonly></td>
                                  </tr>
                                  <tr>
                                      <td>작성일</td>
                                      <td><input type="text" value="${list1.qnaDate}" id="qnaDate" readonly></td>
                                  </tr>
                                  <tr>
                                     <td>내용</td>
                                     <td><textarea rows="20" cols="70" name="qnaContent" readonly>${list1.qnaContent}</textarea></td>
                                  </tr>
                              	</c:if>
                              </tbody>
                            </table>
                            <c:if test="${list1.qnaState != 1}">
	                           <div class ="commentList">
	                                <label>가게 : </label>
							       <input type="text" value="${reply.get('RES_NAME')}" readonly>
							       <label> 등록 날짜 : </label>
							       <input type="text" class="formatDate" value="${reply.get('REPLY_DATE')}" readonly >
							      
							       <div>
							       <label>댓글 : </label>
								       <input type="text" value="${reply.get('REPLY_CONTENT')}" readonly>
							       </div>
							    </div>
                            </c:if>
                             <c:if test="${list1.qnaState == 1}">
                             	<c:if test="${not empty adminReply}">
                             	  <c:forEach var="reply" items="${adminReply}">
			                           <div class ="commentList">
			                                <label>관리자 : </label>
									       <input type="text" value="${reply.replyWriter}" readonly>
									       <label> 등록 날짜 : </label>
									       <input  type="text" class="formatDate" value="${reply.replyDate}" readonly >
									       <div>
									       <label>댓글 : </label>
									       <input style="width: 550px;" type="text" value="${reply.replyContent}" readonly>
									       </div>
		                            	</div>
                             	  </c:forEach>
                             	</c:if>
                             </c:if>
						    <script>
						    	
						    </script>
							
                           <div class="footerInput">
	                           <input type="button" value="목록보기"  class="btn btn-danger" id="list_btn" onclick="location.href='/restaurant/user/findQnaList?qnaWriter=${loginUser.id}'">
	                           <input type="button" value="수정하기" class="btn btn-danger" id="update_btn1">
	                           <input type="reset" value="삭제하기" class="btn btn-danger" id="delete_btn">
	                       </div>
                         </form>
                        </div>
                    </div>
                  </div> 
           </div>
        
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