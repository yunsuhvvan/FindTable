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
<style>
	
	.wrap{
		display: flex;
	}
	.mainImg{
		width: 100%;
		height: 100%;
	}
	.maintitle{
		padding: 10px;
		font-size: 30px;
		margin-top: 50px;
		margin-left: 800px;
    	font-weight: 700;
    	width: 300px;
    	color: green;
    	
	}
	.maindoc{
		font-size: 50px;
		line-height: 1.3;
	}
	.maindocWrap{
		padding:30px;
	}
	.mainImgArea{
		width: 700px;
		height: 500px;
	}
 	h2{
 		width: 100%;
 		padding: 10px;
 		margin: 20px 0 0 0;
 		border-bottom: 0.5px solid silver;
 	/* 	background-color: #e0e0e0; */
 	}
 	.recommand{
 		display: flex;
 		width: 100%;
 		margin: 30px 0;
 		padding: 30px 0;
 		border-bottom: 0.5px solid silver;
 	}
 	.recommandImg{
 		width: 100%;
 		margin: 10px;
 	}
 	.recommandDoc{
 		padding: 10px;
 		margin-left: 20px;
 	}
 	h3{
 	    color: rgb(160, 57, 38); 
 	    padding: 10px;   
 	    font-size: 20px;                                                                                                                                                       
 	}
 	p{
 		line-height: 1.3;
 	}
 	.fas {
 		color: green;
 	}
</style>
</head>
<body>
	
	  <header>
        <div class="wrap">
            <h1><a href="/restaurant/">  <img src="/restaurant/resources/image/index/projectlogo.png"> </a></h1>
            <div class="maintitle">DINING MAGAZINE</div>
        </div>
    </header>
    <section class="main">
   		<div class="wrap">
          <div class="mainImgArea">
            	<img class=" mainImg" src="/restaurant/resources/image/index/platter-g8605cb638_1920.jpg" alt="이미지">
            </div> 
            <div class="maindocWrap" >
            	<h1 class="maindoc">미식가들의 오감을 <br>즐겁게 해줄,<br>2022년 주목할 만한<br>Find Table이<br>추천하는 레스토랑을<br>만나보세요</h1>
            </div>
      </div>
    </section>
    	 <div class="wrap">
	    	<h2><i class="fas fa-store"></i>추천 식당</h2><br>
	    </div>
    <section id="location">
    	<div class="wrap">
	        <div class="wrap1">
			       <div class="recommand">
			       		<div class="recommandImg"><img src="/restaurant/resources/image/index/61d397ce135ed2738250.jpeg" alt="이미지"></div>
			       		<div class="recommandDoc">
			       			<h3>스시 마츠모토</h3>
			       			<p >
				       			 이곳의 수장인 마츠모토 미즈호 셰프는 조선호텔의 일식당 ‘스시조’를 오랫동안 이끌었던 인물로,
				       			 한국과 일본, 양국에서 스시계의 거물로 손꼽힌다. 트렌디함을 추구하기보다 일본 본토에서 
				       			 익힌 스시 요리를 그대로 재현하는 데 많은 노력을 기울이는데, 그래서인지 이곳은 서울에서 
				       			 가장 클래식한 일본 정통의 스시 요리를 맛볼 수 있는 음식점으로 통한다. 생선의 특징에 따라 
				       			 숙성 방법을 다르게 하는 것이 맛의 비결이다.
			       			 </p>
			       			 <br><br>
			       			 <p><strong>ADD</strong> 서울시 강남구 도산대로75길 5 </p>
							 <p><strong>OPEN</strong> 낮 12시~오후 10시(브레이크 타임 오후 2~6시) </p>
							 <p><strong>MENU</strong> 런치 코스 13만원, 디너 코스 25만원</p>
			       			 
			       </div>
			  </div>
			    	 <div class="recommand">
				       	<div class="recommandImg"><img src="/restaurant/resources/image/index/61d39849152ed2738250.jpeg" alt="이미지"></div>
				       	<div class="recommandDoc">
			       			<h3>코자차</h3>
			       			<p>
				       			한국인 셰프(KO)가 만드는 일식(JA)과 중식(CHA)의 만남이라는 뜻을
				       			 품은 레스토랑 코자차. 신라호텔 중식 레스토랑 ‘팔선’ 출신의 최유강 
				       			 셰프, 일식 레스토랑 ‘아리아께’ 출신의 조영두 셰프, 신라호텔 출신 
				       			 육가공 전문 송정식 셰프까지. 이름만 들어도 화려한 셰프 구성이 먼저 
				       			 눈길을 끈다. 이곳은 테이블마다 셰프가 등장해 당일 쓰이는 식재료와 
				       			 조리 과정을 설명하고 직접 시연하는데, 그걸 보고 듣는 재미가 쏠쏠하다
				       			 고. 오리엔탈풍의 골동품 등으로 채워진 내부와 유니크하고 아름다운 프린트의
				       			 플레이트가 해외에서 식사를 즐기는 것과 같은 착각을 불러일으킨다.
			       			  </p>
			       			  <br><br>
			       			 <p><strong>ADD</strong> ADD 서울시 강남구 학동로97길 17 </p>
							 <p><strong>OPEN</strong> 낮 12시~오후 11시(브레이크 타임 오후 3~6시, 일요일 휴무) </p>
							 <p><strong>MENU</strong>런치 코스 10만원, 디너 코스 25만원</p>
			       			  
			       			  
			       		</div>
			       </div>
			       <div class="recommand">
				       	<div class="recommandImg"><img src="/restaurant/resources/image/index/hane.jpeg" alt="이미지"></div>
				       	<div class="recommandDoc">
			       			<h3>하네</h3>
			       			<p>
				       			 스스로를 “자연산수집가”라 소개하는 최주용 셰프의 일식 레스토랑으로,
				       			 이곳을 다녀간 고객들이 자발적으로 ‘맛있게 잘 하네’라는 별칭을 지어줬
				       			 을 만큼 요즘 가장 핫한 플레이스 중 하나다. 런치와 디너 모두 오마카세로 준비되며
				       			 셰프의 소개 멘트에서도 알 수 있듯 이곳의 모든 메뉴는 우수한 자연산 식재료만으로 만든다.
				       			 무엇보다 재료의 선택에 공을 들이는 만큼 양념 맛이 아닌, 재료 본연의 향과 맛을 그대로
				       			 느낄 수 있는 것은 물론 재료 특유의 담백한 맛까지 즐길 수 있어 만족스럽다고. 전통적인
				       			 요소들을 모던하게 표현한 정갈하고 세련된 다이닝 공간도 만족스럽다.
			       			</p>
			       			<br><br>
			       			 <p><strong>ADD</strong> ADD 서울시 강남구 언주로172길 14 </p>
							 <p><strong>OPEN</strong> 낮 12시~오후 10시(브레이크 타임 오후 2~6시 30분, 일요일 & 둘째 넷째 월요일 휴무) </p>
							 <p><strong>MENU</strong>  런치 코스 15만원, 디너 코스 30만원</p>
			       			
			       			
			       		</div>
			       </div>
		       </div>
        </div>
    </section>
 
    

	<a style="color: #fff;" href="/restaurant/admin/userAdminPage">관리자페이지 이동</a>
    <section id="bottom">
        <div class="wrap1">
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
