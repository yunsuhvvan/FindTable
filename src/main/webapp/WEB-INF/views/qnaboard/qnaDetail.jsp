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
<link href="<c:url value="/resources/css/qnaBoardCSS/qnaDetail.css"/>" rel="stylesheet">
<script src="<c:url value="/resources/js/index.js"/>"></script>
 <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
	    fnhover();
	    fnQuickMenu();
		fnListBtn();
		fnUpdateBtn();
		fnDeleteBtn();
		fnInsertReply();
		fnDeleteReply();
	});
	
	function fnQuickMenu() {
	    var currentPosition = parseInt($(".quickmenu").css("top"));
	    $(window).scroll(function() {
	        var position = $(window).scrollTop();
	        $(".quickmenu").stop().animate({
	            "top": position + currentPosition + "px"
	        }, 1000);
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
	
	
	function fnListBtn() {
		$('#list_btn').click(function() {
			location.href="/restaurant/qnaboard/qnaList";
		})
	}
	
	function fnUpdateBtn() {
		$('#update_btn').click(function() {
			$('#info_form').attr('action', '/restaurant/qnaboard/goUpdatePage');
			$('#info_form').submit();
		})
	}
	
	
	function fnDeleteBtn() {
		$('#delete_btn').click(function() {
			if ( confirm('???????????? ?????????????????????????')  ) {
				$('#info_form').attr('action', '/restaurant/qnaboard/qnaDelete');
				$('#info_form').submit();
			}
		})
	}
	
	function fnInsertReply() {
		$('#reply_btn').click(function() {
			if ( confirm('????????? ?????????????????????????') ) {
				if ($('#replyContent').val() == '') {
					alert('????????? ??????????????????')
					return;
				} else {
					$('#reply_form').attr('action', '/restaurant/qnaboard/insertReply');
					$('#reply_form').submit();
				}
			}
		})
	}
	
	function fnDeleteReply() {
		$('#delete_reply_btn').click(function(event) {
			if( confirm('????????? ?????????????????????????') ) {
				if ( $('#reply_content').val() == "" ) {
					alert('????????? ????????? ????????????.');
					event.preventDefault();
					return false;
				}
				$('#reply_form').attr('action', '/restaurant/qnaboard/deleteReply');
				$('#reply_form').submit();
				return true;
			}
		})
	}
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

                <c:if test="${loginUser == null}">
                    <li><a href="/restaurant/user/loginPage">LOGIN&nbsp;&nbsp;&nbsp;/</a></li>
                    <li><a href="/restaurant/user/join">JOIN&nbsp;&nbsp;&nbsp;</a></li>
                </c:if>

                <!-- ????????? state =1 -->
                <c:if test="${loginUser != null}">
                    <c:if test="${loginUser.name != '?????????'}">
                        <li>${loginUser.name} ??? ???????????????</li>
                        <li><a href="/restaurant/user/logout">LOGOUT&nbsp;&nbsp;&nbsp;/</a></li>
                        <li><a href="/restaurant/user/myPage">MYPAGE&nbsp;&nbsp;&nbsp;</a></li>
                    </c:if>
                </c:if>



                <c:if test="${loginUser.name == '?????????'}">
                    <li>${loginUser.name} ??? ???????????????</li>
                    <li><a href="/restaurant/user/logout">LOGOUT&nbsp;&nbsp;&nbsp;/</a></li>
                    <li><a href="/restaurant/admin/adminPage">ADMIN&nbsp;PAGE&nbsp;&nbsp;&nbsp;</a></li>
                </c:if>


                <!-- ???????????? ?????????? -->
                <c:if test="${loginUser.state == 3}">
                    <li>${loginUser.name} ??? ???????????????&nbsp;&nbsp;&nbsp;/</li>
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
                <li><a href="/restaurant/admin/searchPage"> ?????? ??????  </a></li>
                <li><a href="/restaurant/admin/newOpen"> ?????? ?????? </a></li>
                <li><a href="/restaurant/admin/reviewRate"> ?????????????????? </a></li>
                
            </ul>
        </div>
        
        <div class="cate quickmenu">
            <span class="menu"> 
                <a href="#" class="menulink">Board</a>
                <a href="javascript:void(0);" class="subopen"></a>
            </span>
            <ul>
                <li><a href="/restaurant/notice/selectNoticeList"> ???????????? </a></li>
                <li><a href="/restaurant/user/indexReviewPage"> ?????? </a></li>
                <li><a href="/restaurant/qnaboard/qnaList"> Q&A </a></li>
            </ul>
        </div>
        
        <div class="cate quickmenu">
            <span class="menu">
                <a href="#" class="menulink">Magazines</a>
                <a href="javascript:void(0);" class="subopen"></a>
            </span>
            <ul>
                <li><a href="/restaurant/user/magazine">????????? ?????????</a></li>
            </ul>
        </div>
    </div>

<div class="qna_title">
        <span>Q&A</span>
    </div>
    <section class="insert_section">
        <table border="1px" class="qna_info">
            <tbody>
                <tr>
                    <td>??????</td>
                    <td>${qna.qnaNo}</td>
                    <td>?????????</td>
                    <td>${qna.qnaHit}</td>
                </tr>
                <tr>
                    <td>?????????</td>
                    <td>${qna.qnaDate}</td>
                    <td>???????????????</td>
                    <td>${qna.qnaLastModified}</td>
                </tr>
                <tr>
                    <td>?????????</td>
                    <td colspan="3">${qna.qnaWriter}</td>
                </tr>
            </tbody>
        </table>
        <form method="post" id="info_form">
	        <div>
	            <p class="title">??????</p>
	            <input type="hidden" name="qnaNo" value="${qna.qnaNo}">
	            <input type="text" class="title_text" id="qnaTitle" name="qnaTitle" value="${qna.qnaTitle}" readonly>
	        </div>
	        <div>
	            <p class="content">??????</p>
	            <textarea class="content_text" id="qnaContent" name="qnaContent" readonly>${qna.qnaContent}</textarea>
	        </div>
	        <div class="reply_show">
	            <p class="reply_writer">??????????????? ??????</p>
	            <c:if test="${loginUser.state == 2 }">
		            <input type="button" id="delete_reply_btn" class="delete_reply_btn" value="?????? ????????????">
	            </c:if>
	            <textarea class="reply_text" id="reply_content" readonly>${reply.replyContent}</textarea>
        	</div>
	        <div class="update_btn_box">
		        <c:if test="${loginUser.id == qna.qnaWriter}">
		            <input type="button" value="??????" class="update_btn" id="update_btn">
		            <input type="button" value="??????" class="delete_btn" id="delete_btn">
		        </c:if>
	            <input type="button" value="??????" class="list_btn" id="list_btn">
	        </div>
        </form>
        <c:if test="${loginUser.state == 2}">
	        <div>
	            <p class="reply_writer">Q&A ?????? ?????????</p>
	        </div>
	        <form method="post" id="reply_form">
	        	<input type="hidden" value="${qna.qnaNo}" name="qnaNo">
	        	<input type="hidden" value="${loginUser.id}" name="replyWriter">
	            <textarea placeholder="????????? ??????????????????" class="reply_text" id="replyContent" name="replyContent"></textarea>
	            <div class="reply_btn_box">
	            	<input type="button" class="reply_btn" id="reply_btn" value="??????">
	            </div>
	        </form>
        </c:if>
    </section>
    <section id="bottom">
        <div class="wrap">
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
                  			<img src="/restaurant/resources/image/index/projectlogo.png" class="logo_box">
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