<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer"/>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<link href="<c:url value="/resources/css/index.css"/>" rel="stylesheet">
<script src="<c:url value="/resources/js/index.js"/>"></script>
 <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		fnindexNewOpen();
		fnAdminPage();
		fnFindAllReview();
		 
		
	});
	
	
	function fnAdminPage() {
		$('#go_adminPage').click(function() {
			location.href="/restaurant/admin/adminPage";
		})
	}
	
	function fnindexNewOpen() {
		$.ajax({
			url : '/restaurant/admin/indexNewOpen',
			type :'get',
			data : 'resState=0',
			dataType : 'json',
			success : function (map) {
				$('#new_list').empty();
				$.each(map.list , function (i, lately) {
					$('<li style="border: 1px solid rgb(243, 239, 239); width: 200px; box-shadow: 2px 2px 2px 2px gray; border-radius: 3px 3px 3px 3px;"><a href="/restaurant/admin/goResDetail?resNo='+lately.resNo+'"><img style="width: 200px; height: 200px;" src="/restaurant/'+lately.resPath+'/'+lately.resSaved+'"></a><h3 style="text-align:center; font-weight:bold;">'+lately.resName+'</h3><p style="font-weight:bold;">'+lately.resContent+'</p><p style="font-weight:bold;">'+'Contact :'+lately.resTel+'</p><p style="font-weight:bold;">'+'Running :'+lately.resOpenTime+'~'+lately.resCloseTime+'</p>')
					.appendTo('#new_list');
				});
			},
			error : function (xhr) {
				alert('실패');
			}
		});
	} // end of indexNewOpen
	
	
	function fnFindAllReview() {
		$.ajax({
			url: '/restaurant/user/FindReviewList',
			type : 'get',
			dataTye: 'json',
			success : function (map) {
				fnPrintReviewList(map);
			}
		});
	}// end of fnFindAllReview

	function fnPrintReviewList(map){
		// 목록 초기화
		$('#review_list').empty();
		// 목록 만들기
		if (map.list == null) {
			$('<div class="swiper-slide" role="group" aria-label="1 / 9" style="width: 150px; margin-right: 30px;">')
			.append( $('<p>').text('등록된 리뷰가 없습니다.') )
			.appendTo( '#review_list' );
		} else {
			$.each(map.list, function(i, review){
				if(review.reviewPath == null){
					$('<div class="box"><div style="text-align:center; margin-top: 70px;"  class="img"><a href="/restaurant/admin/goResDetail?resNo='+review.resNo+'">등록된 이미지가 없는 리뷰입니다.</a><div class="info"><h3>'+review.reviewWriter+'</h3><p>'+review.reviewContent+'</p>')
					.appendTo('#review_list');
				} else {
					$('<div class="box"><div class="img"><a href="/restaurant/admin/goResDetail?resNo='+review.resNo+'"><img  alt="Hover Effect" src="/restaurant/'+review.reviewPath+'/'+review.reviewSaved+'" style="width: 100%; height:250px;"></a><div class="info"><h3>'+review.reviewWriter+'</h3><p>'+review.reviewContent+'</p>')
					.appendTo('#review_list');
				}
			});
		}
	}  // end fnPrintReviewList
	 
 	
     
</script>
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
            
            	
            	<!-- 사용자 state =1 -->
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
                <li><a href="/restaurant/admin/searchPage"> 식당 검색  </a></li>
                <li><a href="/restaurant/admin/newOpen"> 신규 오픈 </a></li>
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




    <section class="main">
        <div class="wrap">
            <div id="frame">
                <ul class="slide">
                    <li>
                        <div class="text">
                            <h3>Welcome FindTable</h3>
                            <p><strong>🍖Bon Appetit🍖</strong></p>
                        </div>
                    </li>
                    <li>
                        <div class="text">
                            <h3>2022년 식당 예약은</h3>
                            <p><strong>FindTable에서..</strong></p>
                        </div>
                    </li>
                    <li>
                        <div class="text">
                            <h3>원하시는 식당을 FindTable에서 찾아보세요</h3>
                            <p><strong>Enjoy your meal !</strong></p>
                        </div>
                    </li>
                </ul>
            </div>
            <a href="#none" class="prev">
                <img src="/restaurant/resources/image/index/prev.png" alt="이전">
            </a>
            <a href="#none" class="next">
                <img src="/restaurant/resources/image/index/next.png" alt="다음">
            </a>
            <ul class="page">
                <li class="num">3</li>
                <li>/ 3</li>
            </ul>
        </div>
    </section>

    <section id="location">
        <div class="wrap">
            <h3 class="h3_text">어디로 갈까요?</h3>
            <div class="location_wrap" data-aos="fade-up">
                <ul class="location_ul">
                    <li class="location_img">
                        <a href="/restaurant/admin/searchPage"><img src="/restaurant/resources/image/index/location.jpeg"></a>
                    </li>
                    <h3>위치검색</h3>
                    <p></p>
                </ul>
                <ul class="location_ul">
                    <li class="location_img">
                        <a href="/restaurant/admin/searchRestaurant?query=송파구"><img src="/restaurant/resources/image/index/jamsil.jpg"></a>
                    </li>
                    <h3>잠실</h3>
                    <p></p>
                </ul>
                <ul class="location_ul">
                    <li class="location_img">
                        <a href="/restaurant/admin/searchRestaurant?query=영등포구"><img src="/restaurant/resources/image/index/yeouido.jpeg"></a>
                    </li>
                    <h3>여의도</h3>
                    <p></p>
                </ul>
                <ul class="location_ul">
                    <li class="location_img">
                        <a href="/restaurant/admin/searchRestaurant?query=부산"><img src="/restaurant/resources/image/index/busan.jpeg"></a>
                    </li>
                    <h3>부산</h3>
                    <p></p>
                </ul>
                <ul class="location_ul">
                    <li class="location_img">
                        <a href="/restaurant/admin/searchRestaurant?query=속초"><img src="/restaurant/resources/image/index/sokcho.jpeg"></a>
                    </li>
                    <h3>속초</h3>
                    <p></p>
                </ul>
                <ul class="location_ul">
                    <li class="location_img">
                        <a href="/restaurant/admin/searchRestaurant?query=제주"><img src="/restaurant/resources/image/index/jejudo.jpeg"></a>
                    </li>
                    <h3>제주도</h3>
                    <p></p>
                </ul>

            </div>
        </div>
    </section>
            	
            	

    <section id="new">
        <div class="wrap">
            <h3 class="h3_text"> <span style="color: crimson;">New </span><a href="/restaurant/admin/newOpen">신규 오픈 식당!</a></h3>
            <ul data-aos="fade-up" id="new_list">
            	
            </ul>
        </div>
    </section>

    <section id="review" style="width: 1200px; margin: 0 auto;">
        <div class="wrap">
            <h3 class="h3_text"> <span style="color: crimson;">New </span>리얼 리뷰 Pick!</h3>
            <div class="box-wrap" data-aos="fade-down" id="review_list">
            
            </div>
        </div>
    </section>

    <section id="video_section">
        <div class="wrap">
            <div>
                <iframe width="560" height="315" src="https://www.youtube.com/embed/Af25fONww4I" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
            </div>
            <div class="video_text">
                "예약도 약속입니다" <br><br> "Reservation, It's a Promise" 안녕하세요 즐거운 미식생활의 시작 파인드테이블입니다. 즐거운 미식 생활만큼이나 중요한 매너있는 미식생활! 파인드테이블에서 푸드컨텐츠 기업 '마푸테'와 노쇼캠페인을 진행합니다. 😊<br><br> 레스토랑 예약 후 업장에 나타나지 않는 "노쇼"를 근절하고 올바른 식문화를 정착시키 위한 캠페인을 제작 하였습니다. 예약도 중요한 레스토랑과의
                약속이라는 사실! 이번기회에 다시 되새겨보면 어떨까요!?
            </div>
        </div>
    </section>

	<a style="color: #fff;" href="/restaurant/admin/userAdminPage">관리자페이지 이동</a>
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
 	<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js" charset="utf-8"></script>
    
    
</body>
</html>