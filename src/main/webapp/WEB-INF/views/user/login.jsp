<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer"/>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
  
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<link href="<c:url value="/resources/css/userCSS/login.css"/>" rel="stylesheet">
<meta name ="google-signin-client_id" content="406920167318-vvq0vb00hf9r1874t1fquonanvj8p7f9.apps.googleusercontent.com">

<style type="text/css">
li{
	list-style: none;
	list-style-type: none;
}

  
  .icon_ul {
      display: flex;
      justify-content: center;
  }
  
  .icon_ul li{
  
  	margin:  0 40px;
  }

  .radio_box{
  	border: 1px solid crimson;
  	width: 150px;
  	margin: 0 auto;
  	padding: 10px;
  	border-radius: 7px;
  	
  }
  
  .radio_box > input{
  	margin-left: 10px;
  }
  
  .check_img1{
  	display: none;
  }
  .check_img2{
  	display: none;
  }
  
  .no{
  	display: none;
  }
  .ok{
  display: inline;
  }
</style>
<script type="text/javascript">
 	$(document).ready(function(){
 		fnLogin();
 		$("#user_radio, #owner_radio").click(function(event){
 			if(this.value == "user") {
				$("#loginForm").attr("action", "/restaurant/user/login");
				$('.check_img1').addClass('ok').removeClass('no');
				$('.check_img2').addClass('no').removeClass('ok');
			} else if (this.value == "owner") {
				$('.check_img2').addClass('ok').removeClass('no');
				$('.check_img1').addClass('no').removeClass('ok');
				
				$("#loginForm").attr("action", "/restaurant/owner/login");
			}
		});
 	});
 	
	function fnLogin(){
		$('#loginForm').submit(function(event){
			let regId = /^[a-zA-Z0-9-_]{4,}$/;  
			let regPw = /^[a-zA-Z0-9!@#$%^&*()]{8,20}$/;  
			if ( regId.test($('#id').val())  == false || regPw.test($('#pw').val())  == false ) {
				alert('아이디와 비밀번호를 형식을 확인하세요.');
				event.preventDefault();
				return false;
			} 
			
		});
	}
 </script>

</head>
<body>

   <div id="root" class="root">
      <!-- 맨윗부분 -->
      <header class="shareit_header"> 
         <div>
            <a class="header-logo" href="/restaurant"><img src="/restaurant/resources/image/join/FindTableLogo.png" alt="shareit-logo"></a> 
            <a class="header-logo1" href="/restaurant"><img src="/restaurant/resources/image/join/rightaway.svg" alt="파인드테이블">&nbsp;&nbsp;FindTable 사이트 가기</a> 
         </div>
      </header>
      <div style="
        background-image: url(/restaurant/resources/image/join/background.png) ;
        background-color: 색상이름 또는 코드;
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100vh;
        background-size: cover;
        z-index: -1;">
</div>
      
      <!-- 로그인 부분 -->
      <div>
         <main class="mainlogin"> 
            <div class="sc-kmisXD blbgsK">
               <img src="/restaurant/resources/image/join/FindTableLogo.png" alt="findtablelogo">
            </div>
      
            <div class="welcomelogin"> 
                  <div class="title">로그인</div>
                  <p>🍖&nbsp;&nbsp;환영합니다.&nbsp;기다리고 있었습니다.&nbsp;&nbsp;🥩</p> 
            </div>
      			<div class="radio_box">
		       		<label for="user_radio">회원</label><span class="check_img1">✔</span>
		       		<input style="display: none" type="radio" name="radio" id="user_radio" value="user" checked >&nbsp;
		       		<label for="owner_radio">사업자</label><span class="check_img2">✔</span>
		       		<input style="display: none" type="radio" name="radio" id="owner_radio" value="owner">
		       	</div>	
		       	<br>
               <form id="loginForm" method="post" action="/restaurant/user/login">
                     <label for="id" class="loginMiddle">
                     <span>아이디</span>
                     <input type="text" name="id" id="id" placeholder="아이디를 입력해주세요"></label>
      
                     <label for="pw" class="loginMiddle">
                     <span>비밀번호</span>
                     <input type="password" name="pw" id="pw" placeholder="비밀번호를 입력해주세요"></label>
      
                     <div class="FindIdPw">
                        <a href="/restaurant/user/findIdPage">아이디<a>/<a href="/restaurant/user/findPwPage">비밀번호 찾기</a>
                     </div>
                     <button type="submit" class="LoginEnter" id="LoginEn" >로그인</button>  
               </form>
	                 <div class="login_icon">
					      <ul class="icon_ul">
					          		 <li id="naver_id_login" style="margin-top: 10px " class="naver" name="naver">
					              <a href="${url}">
					                  <img style="width: 45px" src="https://developers.naver.com/inc/devcenter/dist/0739723a031b354f5311473e386d3eb1.png" />
					              </a>
					          </li>
					          <li onclick="kakaoLogin();">
					              <a href="javascript:void(0)" class="kakao" name="kakao">
					                  <img src="/restaurant/resources/image/join/kakao.svg" style="width: 50px">
					              </a>
					          </li>
					          <li id="GgCustomLogin">
					              <a href="javascript:void(0)" class="google" name="google">
					                  <span><img src="/restaurant/resources/image/join/google1.png" style="width: 45px"></span>
					              </a>
					          </li>
					      </ul>
					  </div>
                  <p class="loginBottom">더 많은 서비스를 누려보세요!&nbsp;&nbsp;&nbsp;<a href="/restaurant/user/join">회원가입</a></p> 
               </main> 
            </div>
         </div>

		<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js" charset="utf-8"></script>
         <script type="text/javascript">
		         var naver_id_login = new naver_id_login("3YBssR0gciXfYwTuych2", "http://localhost:9090/restaurant/");    // Client ID, CallBack URL 삽입
		                                            // 단 'localhost'가 포함된 CallBack URL
		         console.log(naver_id_login);
		         var state = naver_id_login.getUniqState();
		        
		         naver_id_login.setButton("green", BUTTON_TYPE =1 ,40);
		         naver_id_login.setDomain("http://localhost:9090/restaurant/loginPage");    //  URL
		         naver_id_login.setState(state);
		         naver_id_login.setPopup();
		         naver_id_login.init_naver_id_login();
         </script>
		<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
		<script>
		Kakao.init('add2b063191c7683544aaf2a7638f601'); //발급받은 키 중 javascript키를 사용해준다.
		console.log(Kakao.isInitialized()); // sdk초기화여부판단
		//카카오로그인
		function kakaoLogin() {
		    Kakao.Auth.login({
		      success: function (response) {
		        Kakao.API.request({
		          url: '/v2/user/me',
		          success: function (response) {
		        	  console.log(response);
		        	  var id = response.id;
		        	  var name =  response.properties.nickname;
		        	  var email = response.kakao_account.email;
					  scope : 'account_email';
		        	  //아이디 중복체크
		        	  $.ajax({
		  				url: '/restaurant/user/idCheck',
		  				type: 'post',
		  				data: {"id" : id},
		  				dataType: 'json',
		  				success: function(map){
		  					console.log(map.result);
		  					if (map.result == null) {
		  						let join = JSON.stringify({
		  							id : id,
		  						    pw : '@sns1234kkk',
		  							name : name,
		  							tel : '010-5681-7757',
		  							hbd : '1994-04-18',
		  							email : email,
		  						});
		  						$.ajax({
		  							url : '/restaurant/user/snsJoin',
		  							type : 'post',
		  							data : join,
		  							contentType : 'application/json',
		  							dataType : 'json',
		  							success : function (map) {
		  								if(map.result > 0 ){
		  									let login = JSON.stringify({
		  			  							id : id,
		  			  						    pw : '@sns1234kkk'
		  			  						});
		  			  						$.ajax({
		  			  							url : '/restaurant/user/snslogin',
		  			  							type : 'post',
		  			  							data : login,
		  			  							contentType : 'application/json',
		  			  							dataType : 'json',
		  			  							success : function (map) {
		  			  								if(map.result != null){
		  			  								  alert('카카오 로그인 성공');
		  			  						          location.href="http://localhost:9090/restaurant/";
		  			  								} else{
		  			  									alert('간편 로그인 실패');
		  			  								}
		  			  							}
		  			  						});
		  									
		  								} else{
		  									alert('간편 회원가입 실패');
		  								}
		  							},
		  							error : function (xhr) {
		  								
		  							}
		  						});
		  					} else{ // 아이디가 존재하면 로그인처리
		  						let login = JSON.stringify({
			  							id : id,
			  						    pw : '@sns1234kkk'
			  						});
			  						$.ajax({
			  							url : '/restaurant/user/snslogin',
			  							type : 'post',
			  							data : login,
			  							contentType : 'application/json',
			  							dataType : 'json',
			  							success : function (map) {
			  								if(map.result != null){
			  								  alert('카카오 로그인 성공');
			  						          location.href="/restaurant";
			  								} else{
			  									alert('카카오 로그인 실패');
			  								}
			  							}
			  						});
		  					}
		  				},
		  				error: function(xhr){
		  					alert('서버실패');
		  				}
		  			});// 아이디 중복체크 끝
		        	  
		           //   location.href="http://localhost:9090/restaurant/";
		          },
		          fail: function (error) {
		            console.log(error)
		          },
		        })
		      },
		      fail: function (error) {
		        console.log(error)
		      },
		    })
		  }
		//카카오로그아웃  
		function kakaoLogout() {
		    if (Kakao.Auth.getAccessToken()) {
		      Kakao.API.request({
		        url: '/v1/user/unlink',
		        success: function (response) {
		        	console.log(response)
		        },
		        fail: function (error) {
		          console.log(error)
		        },
		      })
		      Kakao.Auth.setAccessToken(undefined)
		    }
		  }  
		</script>
		
		<script>
		//구글 
		function init() {
			gapi.load('auth2', function() {
				gapi.auth2.init();
				options = new gapi.auth2.SigninOptionsBuilder();
				options.setPrompt('select_account');
		        // 추가는 Oauth 승인 권한 추가 후 띄어쓰기 기준으로 추가
				options.setScope('email profile openid https://www.googleapis.com/auth/user.birthday.read');
		        // 인스턴스의 함수 호출 - element에 로그인 기능 추가
		        // GgCustomLogin은 li태그안에 있는 ID, 위에 설정한 options와 아래 성공,실패시 실행하는 함수들
				gapi.auth2.getAuthInstance().attachClickHandler('GgCustomLogin', options, onSignIn, onSignInFailure);
			})
		}

		function onSignIn(googleUser) {
			var access_token = googleUser.getAuthResponse().access_token
			$.ajax({
		    	// people api를 이용하여 프로필 및 생년월일에 대한 선택동의후 가져온다.
				url: 'https://people.googleapis.com/v1/people/me'
		        // key에 자신의 API 키를 넣습니다.
				, data: {personFields:'birthdays', key:'AIzaSyBA-3bIPeWaxBLMoCnVQhsVCL9-nrIwg24', 'access_token': access_token}
				, method:'GET'
			})
			.done(function(e){
		        //프로필을 가져온다.
				var profile = googleUser.getBasicProfile();
				console.log(profile);
				var email = profile.getEmail();
				var name = profile.nf;
				var id = profile.getId();
				  //아이디 중복체크
	        	  $.ajax({
	  				url: '/restaurant/user/idCheck',
	  				type: 'post',
	  				data: {"id" : id},
	  				dataType: 'json',
	  				success: function(map){
	  					console.log(map.result);
	  					if (map.result == null) {   // 아이디가 없으면 회원가입 진행
	  						let join = JSON.stringify({
	  							id : id,
	  						    pw : '@sns1234kkk',
	  							name : name,
	  							tel : '010-5681-7757',
	  							hbd : '1994-04-18',
	  							email : email,
	  						});    
	  						$.ajax({     // 회원가입 중....
	  							url : '/restaurant/user/snsJoin',
	  							type : 'post',
	  							data : join,
	  							contentType : 'application/json',
	  							dataType : 'json',
	  							success : function (map) {  //회원가입이 성공하면 바로 login을 시킨다.
	  								if(map.result > 0 ){
	  									let login = JSON.stringify({
	  			  							id : id,
	  			  						    pw : '@sns1234kkk'   // password를 내가 알 수 없으니깐 소셜로그인은 비번을 이걸로 통합시켜서 db에 저장하겠다.
	  			  						});
	  			  						$.ajax({
	  			  							url : '/restaurant/user/snslogin',
	  			  							type : 'post',
	  			  							data : login,
	  			  							contentType : 'application/json',
	  			  							dataType : 'json',
	  			  							success : function (map) {
	  			  								if(map.result != null){
	  			  								  alert('구글 로그인 성공');
	  			  						          location.href="http://localhost:9090/restaurant/";
	  			  								} else{
	  			  									alert('구글 로그인 실패');
	  			  								}
	  			  							}
	  			  						});
	  									
	  								} else{
	  									alert('구글 회원가입 실패');
	  								}
	  							},
	  							error : function (xhr) {
	  								
	  							}
	  						});
	  					} else{ // 아이디가 존재하면(중복이 있으면) 로그인처리
	  						let login = JSON.stringify({
		  							id : id,
		  						    pw : '@sns1234kkk'
		  						});
		  						$.ajax({
		  							url : '/restaurant/user/snslogin',
		  							type : 'post',
		  							data : login,
		  							contentType : 'application/json',
		  							dataType : 'json',
		  							success : function (map) {
		  								if(map.result != null){
		  								  alert('구글 로그인 성공');
		  						          location.href="/restaurant";
		  								} else{
		  									alert('구글 로그인 실패');
		  								}
		  							}
		  						});
	  					}
	  				},
	  				error: function(xhr){
	  					alert('서버실패');
	  				}
	  			});// 아이디 중복체크 끝
				
	             // location.href="http://localhost:9090/restaurant/";
			})
			.fail(function(e){
				console.log(e);
			})
		}
		function onSignInFailure(t){		
			console.log(t);
		}
		</script>
		<script src="https://apis.google.com/js/platform.js?onload=init" async defer></script>
		
		
</body>
</html>