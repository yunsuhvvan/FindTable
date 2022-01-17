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
   <!-- 썸머노트 한글 반영하기(꼭) -->  
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/lang/summernote-ko-KR.js"></script>
   
 
<script type="text/javascript">
   $(document).ready(function() {
      
      $('#update_btn').on('click',function () {
         if('${notice.noticeTitle}' == $('#noticeTitle').val() &&
            '${notice.noticeContent}' == $('#noticeContent').val() ){
            alert('변경할 내용이 없습니다.');
            return;
         }
         $('#f').attr('action', '/restaurant/notice/updateNotice');
         $('#f').submit();
      });
   });

   $(document).ready(function() {
      //여기 아래 부분
      $('.summernote').summernote({
           height: 300,                       // 에디터 높이
           minHeight: null,                   // 최소 높이
           maxHeight: null,                   // 최대 높이
           focus: true,                       // 에디터 로딩후 포커스를 맞출지 여부
           lang: "ko-KR",               // 한글 설정
           placeholder: '내용을 작성해주세요.'   //placeholder 설정
             
      });
   });     

   $('.summernote').summernote({
           toolbar: [
                // [groupName, [list of button]]
                ['fontname', ['fontname']],
                ['fontsize', ['fontsize']],
                ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
                ['color', ['forecolor','color']],
                ['table', ['table']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['height', ['height']],
                ['insert',['picture','link','video']],
                ['view', ['fullscreen', 'help']]
              ],
            fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋움체','바탕체'],
            fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72']
        });
   
</script>

<style>
   a{
   text-decoration: none;
   color: black;
}
h3{margin-left: 100px;}
.container{width: 1000px;}
#title_box{
   font-size: 22px;
   font-weight: bold;
}
.card{
   margin-top: 50px;
   margin-left: 100px;
}
.top_btn{
   float: right;
}

.board_view {
   width:100%;
   border-top:2px solid #252525;
   border-bottom:1px solid #ccc
} 
.board_view tbody th {
   text-align:left;
   background:#f7f7f7;
   color:#3b3a3a
} 
.board_view tbody th.list_tit {
   font-size:13px;
   color:#000;
   letter-spacing:0.1px
} 
.board_view tbody .no_line_b th, .board_view tbody .no_line_b td {
   border-bottom:none
} 
.board_view tbody th, .board_view tbody td {
   padding:15px 0 16px 16px;
   border-bottom:1px solid #ccc
} 
.board_view tbody td.view_text {
   border-top:1px solid #ccc; 
   border-bottom:1px solid #ccc;
   padding:45px 18px 45px 18px
} 
.board_view tbody th.th_file {
   padding:0 0 0 15px; 
   vertical-align:middle
}


.board_view {
   width: 100%;
    margin: inherit;
    text-align: center;
}

input#noticeTitle {
    height: 50px;
    padding: 5px;
    font-size: 16px;
    line-height: 1.5;
    border-radius: 3px; 
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
   
   <div class="container">
      <form id="f" method="post">
          
          <div >
                <h2 class="ing_title">❗공지사항 수정하기❗</h2>
            </div>
            
            <br>
           
<!-- 
            <div class="top_btn">
               <input type="button" class="btn btn-danger" id="update_btn" value="수정완료">
               <input type="button" class="btn btn-danger" id="list_btn" value="목록" onclick="location.href='/restaurant/notice/selectNoticeList'">
            </div>
 -->

            
                   <table class="board_view">
                <colgroup> 
                <col width="15%"/>
                <col width="35%"/> 
                <col width="15%"/>
         
                
                <tbody> 
                <tr> 
                <th scope="row">작성일</th>
                <td>${notice.noticeDate}</td> 
                
                 
                <th scope="row">최종수정일</th> 
                <td>${notice.noticeLastmodified}</td>
                </tr>
               
                <tr> 
                <th scope="row">작성자</th> 
                <td>${notice.noticeWriter}</td> 
                               
                <th scope="row">글 번호</th>
                <td>${notice.noticeNo}</td> 
                </tr>
                
                  </tbody>
                   </table>
            
           
            <!-- 
           <div class="row">
             <div class="col-sm-8">
              <input style="height: 50px; font-size:20px; width: 400px;"type="text" class="form-control" aria-label="First name"id="noticeTitle" name="noticeTitle" value="${notice.noticeTitle}"> 
             </div>
           </div>
             -->
<br>             
               <div class="input-group input-group-sm mb-3" style="width: 100%;">
              <span class="input-group-text" id="inputGroup-sizing-sm">제목</span><br>
              <input type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm" name="noticeTitle" id="noticeTitle" placeholder="제목을 입력하세요." value="${notice.noticeTitle}">
            </div>
<!-- 
             <div class="form-group">
             <textarea class="summernote" name="noticeContent" id="summernote" value="${qnaBoardDetail.qnaContent}">${notice.noticeContent}</textarea>
             </div>

 -->
             
             <br>
             

            
           
             <div class="form-floating">
              <textarea class="form-control" placeholder="Leave a comment here" id="noticeContent" style="height: 300px" name="noticeContent">${notice.noticeContent}</textarea>
              <label for="floatingTextarea2">내용</label>
            </div>             
             
          
           <!-- 
           <div class="row">
             <div class="col-sm">작성자 : ${notice.noticeWriter}</div>
             <div class="col-sm"></div>
             <div class="col-sm">첫 등록일  &nbsp;&nbsp;&nbsp;  ${notice.noticeDate}</div>
             <div class="col-sm">최초수정일&nbsp;&nbsp;&nbsp; ${notice.noticeLastmodified}</div>
          
          
           </div> 
            -->
           
             <div class="top_btn">
               <input type="button" class="btn btn-danger" id="update_btn" value="수정완료">
               <input type="button" class="btn btn-danger" id="list_btn" value="목록" onclick="location.href='/restaurant/notice/selectNoticeList'">
            </div>
         
           <input type="hidden" name="noticeNo" value="${notice.noticeNo}">
           
      </form>
       
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