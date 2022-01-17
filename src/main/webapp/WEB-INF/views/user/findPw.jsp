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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>
<link href="<c:url value="/resources/css/userCSS/login.css"/>" rel="stylesheet">

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
</style>
<script type="text/javascript">
$(document).ready(function(){
	fnSendAuthCode();
	fnFindPw();
	fnIdCheck();
	fnEmailCheck()
	
});
// 이메일 인증코드 전송함수
function fnSendAuthCode(){
	$('#authCode_btn').click(function(){
		let regEmail = /^[a-zA-Z0-9-_]+@[a-zA-Z0-9]+([.][a-zA-Z]{2,}){1,2}$/;
		if ( regEmail.test($('#email').val()) == false ) {
			alert('이메일 형식을 확인하세요.');
			return;
		}
		$.ajax({
			url: '/restaurant/user/tempPassword',
			type: 'post',
			data: $('#f').serialize(),
			dataType: 'json',
			success: function(map) {
				alert('임시 비밀번호가 발송되었습니다. 발송된 비밀번호로 로그인하여 새로운 비밀번호로 변경해주세요.');
				fnVerifyAuthCode(map.authCode);
			},
			error: function() {
				alert('비밀번호 전송 실패');
			}
		});
	});
}  // end fnSendAuthCode

// 인증코드 검증 함수
function fnVerifyAuthCode(authCode) {
	$('#verify_btn').click(function(){
		if ( $('#authCode').val() == authCode ) {
			alert('인증되었습니다.');
			$('#pass_btn').removeClass('.bad').addClass('.good');
		} else {
			alert('인증에 실패했습니다.');
			$('#pass_btn').addClass('.good').removeClass('.bad');
		}
	});
}  // end fnVerifyAuthCode


function fnFindPw(){
	$('#verify_btn').click(function(){
		let regEmail = /^[a-zA-Z0-9-_]+@[a-zA-Z0-9]+([.][a-zA-Z]{2,}){1,2}$/;
		if ( regEmail.test($('#email').val()) == false ) {
			alert('이메일 형식을 확인하세요.');
			$('#search_result').text('');
			return;
		}
		$.ajax({
			url: '/restaurant/user/findId',
			type: 'post',
			data: 'email=' + $('#email').val(),
			dataType: 'json',
			success: function(map) {
				$('#search_result').text("회원님의 비밀번호는 " + map.result.pw + "입니다!");
			},
			error: function(xhr) {
				$('#search_result').text(xhr.responseText);
			}
		});
	});
}


let idPass = false;
function fnIdCheck() {
	$('#id').keyup(function(){
		
        let regId = /^[a-zA-Z0-9-_]{4,}$/;
		if ( regId.test($(this).val()) == false ) {
			$('#id_result').text('아이디는 대문자,숫자,특수문자 -,_ 사용해서 4자 이상 입력해주세요.').addClass('no').removeClass('ok');
			idPass = false;
			return;
		}
		
		$.ajax({
			url: '/restaurant/user/idCheck',
			type: 'post',
			data: 'id=' + $(this).val(),
			dataType: 'json',
			success: function(map){
				if (map.result == null) {
					$('#id_result').text('일치하지 않는 아이디입니다').addClass('no').removeClass('ok');
					idPass = false;
				} else {
					$('#id_result').text('일치하는 아이디입니다').addClass('ok').removeClass('no');
					idPass = true;
				}
			},
			error: function(xhr){
				$('#id_result').text(xhr.responseText).addClass('no').removeClass('no');
				idPass = false;
			}
		});
	});
}  // end fnIdCheck

//이메일 중복체크 변수와 함수
let emailPass = false;
function fnEmailCheck() {
	$('#email').blur(function(){
		let regEmail = /^[a-zA-Z0-9-_]+@[a-zA-Z0-9]+([.][a-zA-Z]{2,}){1,2}$/;
		if ( regEmail.test($(this).val()) == false ) {
			alert('이메일 형식을 확인하세요.');
			emailPass = false;
			return;
		}
		$.ajax({
			url: '/restaurant/user/emailCheck',
			type: 'post',
			data: 'email=' + $(this).val(),
			dataType: 'json',
			success: function(map){
				if (map.result == null) {
					alert('일치하는 이메일이 없습니다. 다시 한번 확인해주세요.');
					fnInit();
					emailPass = false;
				} else {
					alert('동일한 이메일 입니다. 버튼을 눌러 임시비밀번호를 발급 받으세요.');
					emailPass = true;
				}
			},
			error: function(){
				alert('일치하는 이메일이 없습니다. 다시 한번 확인해주세요.');
				emailPass = false;
			}
		})
	});
}  // end fnEmailCheck
function fnInit() {
		$('#email').val('');
	
}

 </script>
<style>
	.tbtns {
   display: inline-block;
   font-size: 14px;
   text-align: center;
   padding: 0 8px;
   height: 32px;
   line-height: 29px;
   color: #515e71;
   background: #e3e7ed;
   border: 1px solid #bcc1ca;
   box-sizing: border-box;
   font-family: 'NotoKrM';
}

#id_result{
 	font-size: 12px;
}

#pass_btn{

}


 
  .bad{
  	display: none;
  }
  .good{
  display: inline;
  }
	.no{
		color:red;
	}
	.ok{
		color:green;
	}
</style>

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
      
     
    
         <main class="mainlogin"> 
            <div class="sc-kmisXD blbgsK">
               <img src="/restaurant/resources/image/join/FindTableLogo.png" alt="findtablelogo">
            </div>
      
            <div class="welcomelogin"> 
                  <div class="title">비밀번호 찾기</div>
                  <p>☺️&nbsp;&nbsp;환영합니다.&nbsp;무엇을 도와드릴까요?&nbsp;&nbsp;☺️</p> 
            </div>
            
         	<form id="f" method="post">
			 	<label for="id" class="loginMiddle">
             	<span>아이디</span>
             	<input type="text" name="id" id="id" placeholder="가입 당시 아이디를 입력해주세요."></label>
             	<p id="id_result"></p>
             
             <label for="email" class="loginMiddle">
             <span>이메일</span>
             <input type="text" name="email" id="email" placeholder="가입 당시 이메일을 입력해주세요."></label>
					<input type="button" value="이메일로 임시 비밀번호 받기" id="authCode_btn" class="tbtns rs-mt5">
			</form>
			</div>
				<p class="loginBottom">더 많은 서비스를 누려보세요!&nbsp;&nbsp;&nbsp;<a href="/restaurant/user/loginPage">로그인하러가기</a></p> 
				
	      	</main>	
    </div>
    
               
		
</body>
</html>