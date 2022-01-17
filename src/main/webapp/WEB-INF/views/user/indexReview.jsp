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
		fnFindAllReview();
    	fnChangePage();
    	

	});
	
	var page =1;
	function fnFindAllReview() {
		$.ajax({
			url: '/restaurant/user/findCardReviewList/page/'+page,
			type : 'get',
			dataTye: 'json',
			success : function (map) {
				console.log(map.list);
				fnPrintReviewList(map);
			},
			error : function () {
				alert('에러 발생');
			}
		});
	}// end of fnFindAllReview

	function fnPrintReviewList(map){
		// 목록 초기화
		$('#cardReview_list').empty();
		var p = map.pageUtils;
		// 목록 만들기
		if (p.totalRecord == 0) {
			$('<div class="card" style="width: 18rem; margin: 10px;">')
			.append( $('<p>').text('등록된 리뷰가 없습니다.') )
			.appendTo( '#cardReview_list' );
		} else {
			$.each(map.list, function(i, review){
				if(review.reviewPath == null){
					$('<div class="card" style="width: 18rem; margin: 10px;"><p>등록된 이미지가 없는 리뷰입니다.</p><div class="card-body"><h5 class="card-title">'+review.reviewWriter+'</h5><p>'+review.reviewContent+'</p><a href="상세보기" class="btn btn-danger">상세보기</a>')
					.appendTo('#cardReview_list');
				} else {
					$('<div class="card" style="width: 237px; margin: 10px;"><img src="/restaurant/'+review.reviewPath+'/'+review.reviewSaved+'" class="card-img-top" style="width:237px; height:200px;" alt=""><div class="card-body"><h5 class="card-title">'+review.reviewWriter+'<span style="margin-left:40px; font-size: 14px; color:silver;">'+'평점 :'+review.reviewRate+'점'+'</span></h5><p>'+review.reviewContent+'</p><a href="/restaurant/user/indexReviewdetail?reviewNo='+review.reviewNo+'" class="btn btn-danger">상세보기</a>')
					.appendTo('#cardReview_list');
				}
			});
			fnPrintPaging(map.pageUtils);
		}
	}  // end fnPrintReviewList
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
			fnFindAllReview();
			fnPrintPaging(map.pageUtils);

		});
	}  // end fnChangePage
	
	
	 
</script>

<style>
	a{
	text-decoration: none;
	color: black;
}

h3{
	margin-left: 100px;
}
table tr td{
  white-space: nowrap; 
  width: 100px; 
  overflow: hidden;
  text-overflow: clip; 
}
input.btn.btn-danger {
    width: 20%;
    float: right;
}	
div.title {
    font-size: 30px;
}

	#paging > div {
		width: 20px;
		height: 20px;
		text-align: center;
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
	.card{
		box-shadow: 2px 2px 2px 2px gray;
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
		 <div style="width: 600px; margin-left: 100px;">
             <div class="title" style="">&nbsp;&nbsp;FindTable의 모든 리뷰를 확인해보세요 !&nbsp;&nbsp;</div>        
         </div><br><br><br>
        <div id="cardReview_list" style="display:flex">
        </div>
        <div id="paging" style="display: flex; justify-content: center;"></div>
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
