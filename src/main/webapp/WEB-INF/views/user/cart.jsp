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
<link href="<c:url value="/resources/css/userCSS/myPage.css"/>" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<style>
 
	a {
	    text-decoration: none;
	    color: inherit;
	}
	.col-4{
		width: 20%;
	}
	.col-6{
		width: 70%;
		
	}
	th, td{
		font-size: 15px;
	}

    .table{
    	width: 900px;
    	text-align: center;
    	
    }
    td {
    	line-height: 50px;
    
   }
	#paging > div {
		width: 20px;
		height: 20px;
		justify-content: center;
	}
	.disable_link {
		color: lightgray;
	}
	.enable_link {
		cursor: pointer;
	}
	.now_page {
		color: red;
	}
}
    </style>
    
    <script>
    $(document).ready(function () {
    	fnFindCartList();
    	fnChangePage();
    	
    
    	
    	$('body').on('click' , '#cancel_btn' ,function () {
			if(confirm('찜 목록에서 삭제하시겠습니까?')){
				$.ajax({
					url:'/restaurant/user/removeCart',
					type : 'post',
					data : 'resNo='+$('#resNo').val(),
					dataType : 'json',
					success : function (map) {
						if(map.result > 0){
							alert('찜 목록에서 삭제 되었습니다.');
							fnFindCartList();
					    	fnChangePage();
						}
					},
					error : function (xhr) {
						
					}
				});
			}
		});// end of deletecart
	});// end of pageload event
    
	var page = 1;
    function fnFindCartList() {
		$.ajax({
			url :'/restaurant/user/findCartList/page/'+page,
			type : 'get',
			dataType : 'json',
			success : function (map) {
				$('#cart_list').empty();
				var p = map.pageUtils;
				if(p.totalRecord == 0){
				$('<tr>')
				.append( $('<th scope="row" colspan="5">').text('찜 된 식당이 없습니다.') )
				.appendTo('#cart_list');
				}
				$.each(map.list, function (i , like) {
					console.log(like.resState);
					if(like.resState ==2 ){
						$('<tr>')
						.append($('<th scope="row"><a href="/restaurant/admin/goResDetail?resNo='+like.resNo+'"><img src="/restaurant/'+like.resPath+'/'+like.resSaved+'" style="width: 70px; height:70px;"></a>'))
						.append($('<td>').text(like.resNo))
						.append($('<td>').text(like.resName))
						.append($('<td>').text(like.resTel))
						.append($('<td>').text(like.resOption))
						.append($('<td>').html('<input type="hidden" name="resNo" id="resNo" class="btn btn-danger" value="'+like.resNo+'"><input type="button" id="cancel_btn" class="btn btn-danger" value="찜 취소">'))
						.appendTo('#cart_list');
						}
					});
					fnPrintPaging(map.pageUtils);
			},
			error : function (xhr) {
				alert('실패');
			}
		});
	}// end of fnCartList
  
	// 페이징 출력 함수
	function fnPrintPaging(p) {
		$('#paging').empty();
		
		if (page == 1) {
			//$('<div class="disable_link">&lt;&lt;</div>').appendTo('#paging');
			$('<div>').addClass('disable_link').html('&lt;&lt;').appendTo('#paging');
		} else {
			//$('<div class="enable_link" data-page="1">&lt;&lt;</div>').appendTo('#paging');
			$('<div>').addClass('enable_link').html('&lt;&lt;').attr('data-page', 1).appendTo('#paging');
		}
		// 이전 블록으로 이동
		if (page <= p.pagePerBlock) {
			$('<div class="disable_link">&lt;</div>').appendTo('#paging');
		} else {
			$('<div class="enable_link" data-page="'+(p.beginPage-1)+'">&lt;</div>').appendTo('#paging');
		}
		// 페이지 번호
		for (let i = p.beginPage; i <= p.endPage; i++) {
			if (i == page) {
				$('<div class="disable_link now_page">'+i+'</div>').appendTo('#paging');
			} else {
				$('<div class="enable_link" data-page="'+i+'">'+i+'</div>').appendTo('#paging');
			}
		}
		// 다음 블록으로 이동
		if (p.endPage == p.totalPage) {
			$('<div class="disable_link">&gt;</div>').appendTo('#paging');
		} else {
			$('<div class="enable_link" data-page="'+(p.endPage+1)+'">&gt;</div>').appendTo('#paging');
		}
		// 마지막 페이지로 이동
		if (page == p.totalPage) {
			$('<div class="disable_link">&gt;&gt;</div>').appendTo('#paging');
		} else {
			$('<div class="enable_link" data-page="'+p.totalPage+'">&gt;&gt;</div>').appendTo('#paging');
		}
	}  // end fnPrintPaging
	
	// 페이징 링크 처리 함수(전역변수 page값을 바꾸고)
	function fnChangePage(){
		$('body').on('click', '.enable_link', function(){
			page = $(this).data('page');
			fnFindCartList();
			fnPrintPaging(map.pageUtils);

		});
	}  // end fnChangePage
	
	
	
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
                        <li><a href="/restaurant/user/findQnaList?qnaWriter=${loginUser.name}">문의 내역</a></li>
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
                    <h2 class="ing_title" >찜 목록</h2>
                </div>
                <hr style="width: 900px;">
                <div class="ing_menu">
                
                </div> 
					<form id="f" method="post">
             <table class="table table-hover" >
					 <thead>
						<tr>
							 <th scope="col">#</th>
							 <th scope="col">번호</th>
							 <th scope="col">식당명</th>
							 <th scope="col">연락처</th>
							 <th scope="col">식당옵션</th>
						</tr>
					</thead>
						<tbody id="cart_list">
							
						</tbody>
					<tfoot>
						<tr>
							<td style="border: none;" colspan="5"><div id="paging" style="display: flex; justify-content: center;"></div></td>
						</tr>
					</tfoot>
					</table>
					</form>
			
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
	    <input type="hidden" name="userNo" id="userNo" value="${loginUser.userNo}">
</body>
</html>