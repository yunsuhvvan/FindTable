
# FindTable

따로 호스팅 해서 다시 올릴 것 : http://3.35.11.168:8080/restaurant/

 ##### * 기획의도 : 식당 이름, 장소 등 키워드 만으로 레스토랑 검색이 가능하고 전화나 방문 없이 원하는 날짜, 시간 인원으로 예약 가능을 할 수 있게끔 구현
#####  * 개발환경 : <img src="https://img.shields.io/badge/JAVA-inactive?style=flat&logo=Java&logoColor=007396"/>  <img src="https://img.shields.io/badge/JavaScript-yellow?style=flat&logo=JavaScript&logoColor=F7DF1E"/>  <img src="https://img.shields.io/badge/Oracle-red?style=flat&logo=Oracle&logoColor=F80000"/>  <img src="https://img.shields.io/badge/HTML5-white?style=flat&logo=HTML5&logoColor=E34F26"/>  <img src="https://img.shields.io/badge/CSS-white?style=flat&logo=CSS3&logoColor=1572B6"/>  <img src="https://img.shields.io/badge/JQUERY-blue?style=flat&logo=jQuery&logoColor=0769AD"/>  <img src="https://img.shields.io/badge/SPRING-green?style=flat&logo=Spring&logoColor=6DB33F"/>  <img src="https://img.shields.io/badge/TomCat-yellow?style=flat&logo=ApacheTomcat&logoColor=F8DC75"/>
##### * 개발기간  : 2021/12/17 ~ 2022/1/13
##### * 개발인원 : 3명


***

### ✔️ FindTable DB 다이어그램
![db다이어그램](https://user-images.githubusercontent.com/87231093/149790214-687a3bad-c6f3-4179-92c8-82f1281046a3.png)


***

### ✔️ 담당 파트 플로우차트 
![사용자 플로우차트](https://user-images.githubusercontent.com/87231093/149789523-650683b9-b07b-4fb2-8c3e-401128bd5b52.png)


***


### ✔️ 구글로그인 DB 연결
<img src="https://user-images.githubusercontent.com/87231093/149790061-e089348f-fa7a-4785-ad7a-e143065a2816.png" width="300" height="300"/> <img src="https://user-images.githubusercontent.com/87231093/149790722-c3a23417-b550-4034-ac11-2ac9b4cb9aa1.png" width="300" height="300"/>

####  * 자바스크립트 key 사용 
####  * Ajax를 이용하여 아이디가 존재하면 로그인처리, 존재하지 않으면 회원가입(DB에 저장)처리  

***


### ✔️ 카카오로그인 DB 연결
<img src="https://user-images.githubusercontent.com/87231093/149791095-cbd7d4b2-0022-4537-8f21-246b727582a8.png" width="300" height="300"/> <img src="https://user-images.githubusercontent.com/87231093/149791363-769a0646-85e9-413f-afb3-fe574a465673.png" width="300" height="300"/>

####  * 자바스크립트 key 사용 
####  * Ajax를 이용하여 아이디가 존재하면 로그인처리, 존재하지 않으면 회원가입(DB에 저장)처리  

***

### ✔️ 카카오지도 API
 <img src="https://user-images.githubusercontent.com/87231093/149850770-cf1ef5e4-1c60-4746-bbc7-62e31647c46f.png" width="500" height="300"/>
 
#### * 식당정보를 Model에 담아 해당 jsp 페이지에 넘긴 뒤, 카카오지도 API에서 제공하는 소스안에 EL을 사용하였음
 
 ***
 

### ✔️ IamPORT 이용하여 카카오페이  구현
<img src="https://user-images.githubusercontent.com/87231093/149850906-1d1cd822-3401-448a-9f80-8efa1cee6587.png" width="500" height="300"/>

####  * IamPort에서 제공하는 카카오페이 오픈소스를 활용
####  * JSON.stringify 내부에 필요한 데이터를 담아 Ajax를 이용하여 DB에 결제정보를 저장하였음


***

### ✔️ 예약하기
<img src="https://user-images.githubusercontent.com/87231093/149851153-6efd0796-ecc5-4eaf-bf13-f1fa66e276f2.png" width="500" height="300"/>

#### 1. datepicker를 이용하여 날짜 선택
#### 2. Ajax(JSON.stringify)를 이용하여 Modal창에 있는 데이터를 보냄  ➡️  DB에 저장
#### 3. 같은 날짜 , 같은 시간을 선택하면 사용자에게 중복 경고창을 창 띄움
#### 4. 예약취소 가능 ➡️ 사업자에게 표시,  예약된 식당 이름을 누르면 예약세부내역 확인 가능

***

### ✔️ 문의하기
<img src="https://user-images.githubusercontent.com/87231093/151493421-212e083c-9412-47d3-bdc0-f131690cbf75.png" width="400" height="350"/><img src="https://user-images.githubusercontent.com/87231093/151493478-fa2c822c-1758-4f98-924d-48fc2c2fb653.png" width="400" height="350"/>

#### 1. Modal 창안에 문의 타입 선택 (state로 구별)
#### 2. Ajax(JSON.stringify)를 이용하여 Modal창에 있는 데이터를 보냄  ➡️  DB에 저장
#### 3. 사용자가 문의 한 내용을 사용자 마이페이지에서 확인,수정,삭제 가능



***


#### ✔️ 그 외 구현 한 것들

|구현|설명|  
|------|------|
|아이디찾기|중복되는 아이디가 있으면 Ajax를 통해 중복 유무를 검사|
|비밀번호찾기|JavaMailSender를 이용, 랜덤 문자열 메서드 생성 후 메일로 발송 후 임시비밀번호를 DB에 저장|
|공지사항CRUD|특이사항 없음|
|식당 찜하기|식당에 State 칼럼을 추가하여 찜 여부 확인|
|개인정보수정|특이사항 없음|
|리뷰페이지|사용자가 작성한 모든 리뷰를 Ajax를 이용하여 가져옴|




*** 

##### 배포 후 발생한 문제  (해결 할 것)
##### 1.SNS로그인,Email인증하기가 local에서는 실행이 되나 EC2 인스턴스에서는 실행이 되지 않는 문제 발견












