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
            	<img class=" mainImg" src="/restaurant/resources/image/index/platter-g8605cb638_1920.jpg" alt="?????????">
            </div> 
            <div class="maindocWrap" >
            	<h1 class="maindoc">??????????????? ????????? <br>????????? ??????,<br>2022??? ????????? ??????<br>Find Table???<br>???????????? ???????????????<br>???????????????</h1>
            </div>
      </div>
    </section>
    	 <div class="wrap">
	    	<h2><i class="fas fa-store"></i>?????? ??????</h2><br>
	    </div>
    <section id="location">
    	<div class="wrap">
	        <div class="wrap1">
			       <div class="recommand">
			       		<div class="recommandImg"><img src="/restaurant/resources/image/index/61d397ce135ed2738250.jpeg" alt="?????????"></div>
			       		<div class="recommandDoc">
			       			<h3>?????? ????????????</h3>
			       			<p >
				       			 ????????? ????????? ???????????? ????????? ????????? ??????????????? ????????? ?????????????????? ???????????? ???????????? ?????????,
				       			 ????????? ??????, ???????????? ???????????? ????????? ????????????. ??????????????? ?????????????????? ?????? ???????????? 
				       			 ?????? ?????? ????????? ????????? ???????????? ??? ?????? ????????? ???????????????, ??????????????? ????????? ???????????? 
				       			 ?????? ???????????? ?????? ????????? ?????? ????????? ?????? ??? ?????? ??????????????? ?????????. ????????? ????????? ?????? 
				       			 ?????? ????????? ????????? ?????? ?????? ?????? ????????????.
			       			 </p>
			       			 <br><br>
			       			 <p><strong>ADD</strong> ????????? ????????? ????????????75??? 5 </p>
							 <p><strong>OPEN</strong> ??? 12???~?????? 10???(???????????? ?????? ?????? 2~6???) </p>
							 <p><strong>MENU</strong> ?????? ?????? 13??????, ?????? ?????? 25??????</p>
			       			 
			       </div>
			  </div>
			    	 <div class="recommand">
				       	<div class="recommandImg"><img src="/restaurant/resources/image/index/61d39849152ed2738250.jpeg" alt="?????????"></div>
				       	<div class="recommandDoc">
			       			<h3>?????????</h3>
			       			<p>
				       			????????? ??????(KO)??? ????????? ??????(JA)??? ??????(CHA)??? ??????????????? ??????
				       			 ?????? ???????????? ?????????. ???????????? ?????? ???????????? ???????????? ????????? ????????? 
				       			 ??????, ?????? ???????????? ?????????????????? ????????? ????????? ??????, ???????????? ?????? 
				       			 ????????? ?????? ????????? ????????????. ????????? ????????? ????????? ?????? ????????? ?????? 
				       			 ????????? ??????. ????????? ??????????????? ????????? ????????? ?????? ????????? ???????????? 
				       			 ?????? ????????? ???????????? ?????? ???????????????, ?????? ?????? ?????? ????????? ????????????
				       			 ???. ?????????????????? ????????? ????????? ????????? ????????? ??????????????? ???????????? ????????????
				       			 ??????????????? ???????????? ????????? ????????? ?????? ?????? ????????? ??????????????????.
			       			  </p>
			       			  <br><br>
			       			 <p><strong>ADD</strong> ADD ????????? ????????? ?????????97??? 17 </p>
							 <p><strong>OPEN</strong> ??? 12???~?????? 11???(???????????? ?????? ?????? 3~6???, ????????? ??????) </p>
							 <p><strong>MENU</strong>?????? ?????? 10??????, ?????? ?????? 25??????</p>
			       			  
			       			  
			       		</div>
			       </div>
			       <div class="recommand">
				       	<div class="recommandImg"><img src="/restaurant/resources/image/index/hane.jpeg" alt="?????????"></div>
				       	<div class="recommandDoc">
			       			<h3>??????</h3>
			       			<p>
				       			 ???????????? ??????????????????????????? ???????????? ????????? ????????? ?????? ??????????????????,
				       			 ????????? ????????? ???????????? ??????????????? ???????????? ??? ??????????????? ????????? ?????????
				       			 ??? ?????? ?????? ?????? ?????? ???????????? ??? ?????????. ????????? ?????? ?????? ??????????????? ????????????
				       			 ????????? ?????? ??????????????? ??? ??? ?????? ????????? ?????? ????????? ????????? ????????? ?????????????????? ?????????.
				       			 ???????????? ????????? ????????? ?????? ????????? ?????? ?????? ?????? ??????, ?????? ????????? ?????? ?????? ?????????
				       			 ?????? ??? ?????? ?????? ?????? ?????? ????????? ????????? ????????? ?????? ??? ?????? ??????????????????. ????????????
				       			 ???????????? ???????????? ????????? ???????????? ????????? ????????? ????????? ???????????????.
			       			</p>
			       			<br><br>
			       			 <p><strong>ADD</strong> ADD ????????? ????????? ?????????172??? 14 </p>
							 <p><strong>OPEN</strong> ??? 12???~?????? 10???(???????????? ?????? ?????? 2~6??? 30???, ????????? & ?????? ?????? ????????? ??????) </p>
							 <p><strong>MENU</strong>  ?????? ?????? 15??????, ?????? ?????? 30??????</p>
			       			
			       			
			       		</div>
			       </div>
		       </div>
        </div>
    </section>
 
    

	<a style="color: #fff;" href="/restaurant/admin/userAdminPage">?????????????????? ??????</a>
    <section id="bottom">
        <div class="wrap1">
            <div class="footer">
                <div class="footer_inner">
                    <ul class="footer_link">
                        <li><a href="#" target="_blank" class="footer_item">????????????&nbsp;|</a></li>
                        <li><a href="#" target="_blank" class="footer_item">????????????????????????&nbsp;|</a></li>
                        <li><a href="#" target="_blank" class="footer_item">????????? ????????? ????????????&nbsp;|</a></li>
                        <li><a href="#" target="_blank" class="footer_item">???????????? ????????????</a></li>
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
