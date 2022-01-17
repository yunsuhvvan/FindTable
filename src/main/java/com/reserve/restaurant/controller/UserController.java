package com.reserve.restaurant.controller;


import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.reserve.restaurant.domain.Comment;
import com.reserve.restaurant.domain.Owner;
import com.reserve.restaurant.domain.Pay;
import com.reserve.restaurant.domain.Qna;
import com.reserve.restaurant.domain.Restaurant;
import com.reserve.restaurant.domain.User;
import com.reserve.restaurant.service.BookService;
import com.reserve.restaurant.service.RestaurantService;
import com.reserve.restaurant.service.ReviewService;
import com.reserve.restaurant.service.UserService;

@Controller
@RequestMapping("user/*")
public class UserController {
	

	@Autowired
	private UserService userService;
	@Autowired
	private ReviewService reviewService;
	@Autowired
	private BookService bookService;
	
	@Autowired
	private RestaurantService restaurantService;
	
	//검색페이지
	@GetMapping(value = "search")
	public String search() {
		return"/user/search";
	}
	
	// 마이페이지
	@GetMapping(value="myPage")
	public String myPage() {
		return "/user/myPage";
	}
	
	@GetMapping(value="selectUserByNo")
	public String selectUserByNo(@RequestParam("userNo") Long userNo , Model model ) {
		model.addAttribute("userInfo", userService.selectUserByNo(userNo));
		return "/user/updateUser";
	}
	
	// 예약페이지
	@GetMapping(value="reserve")
	public String reserve() {
		return "/user/reserve";
	}

	// 회원가입페이지
	@GetMapping(value="join")
	public String join() {
		return "/user/join";
	}
	// 로그인페이지
	@GetMapping(value="loginPage")
	public String loginPage() {
		return "user/login";
	}
	
	//리뷰작성 페이지
	@GetMapping(value="reviewPage")
	public String reviewPage(HttpServletRequest request,Model model) {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("loginUser");	
		bookService.selectBookBybookNo(request, model);
		return "user/reviewPage";
	}
	
	//리뷰 더보기
	@GetMapping(value="moreReview")
	public String moreReview(HttpServletRequest request,Model model) {
		HttpSession session  = request.getSession();
		Object object = session.getAttribute("loginUser");
		
		if(object.getClass() == Owner.class) {
			Owner owner = (Owner) object;
			model.addAttribute("userNo", owner.getOwnerNo());
		} else {
			User user = (User) object;
			model.addAttribute("userNo", user.getUserNo());
		}
		
		Restaurant restaurant = (Restaurant)session.getAttribute("rest");
		model.addAttribute("resNo", restaurant.getResNo());
		model.addAttribute("request", request);
		
		reviewService.moreReview(model);
			return "user/moreReview";
		}
		
	
	
	//아이디 중복체크
	@PostMapping(value="idCheck", produces="application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> idCheck(@RequestParam("id") String id) {
			return userService.idCheck(id);
	}
	
	//이메일 중복체크
	@PostMapping(value= {"emailCheck", "findId"} , produces="application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> findUserByEmail(@RequestParam("email") String email) {
		return userService.findUserByEmail(email);
	
	}
	//인증번호전송
	@PostMapping(value = "sendAuthCode" , produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> sendAuthCode(@RequestParam("email") String email) {
		return userService.sendAuthCode(email);
	}
	
	@PostMapping(value = "tempPassword" , produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> tempPassword(User user, HttpServletResponse response) {
		return userService.tempPassword(user, response);
	}
	
	
	// 회원등록
	@PostMapping(value = "insertUser")
	public void insertUser(User user , HttpServletResponse response) {
		userService.insertUser(user, response);
	}
//
	@PostMapping(value="login")
	public void login(HttpServletRequest request, HttpServletResponse response) {
		userService.login(request,response);
		// return "redirect:/";
	}
	// 로그아웃
	@GetMapping(value="logout")
	public String logout(HttpSession session) {
		if (session.getAttribute("loginUser") != null) {
			session.invalidate();
		}
		return "redirect:/";
	}
	// 업데이트페이지 이동
	@GetMapping(value="updateUser")
	public String updateUser() {
		return "/user/updateUser";
	}
	
	//현재 비밀번호 체크
	@PostMapping(value="presentPwCheck", produces="application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> presentPwCheck(HttpServletRequest request) {
		return userService.presentPwCheck(request);
	}
	
	//사용자 비밀번호 변경하기
	@PostMapping(value="updatePw")
	public void updatePw(User user, HttpServletResponse response) {
		userService.updatePw(user,response);
		
	}
	
	//사용자 탈퇴하기
	@PostMapping(value="leave")
	public void leave(@RequestParam("userNo") Long userNo , HttpServletResponse response ,HttpSession session) {
		userService.deleteUser(userNo, response, session);
	}
	
	//사용자 정보 수정
	@PostMapping(value="updateUser")
	public void updateUser(User user, HttpSession session, HttpServletResponse response) {
		userService.updateUser(user, session,response);
	}
	
	//아이디 찾기 페이지
	@GetMapping(value = "findIdPage")
	public String findIdPage() {
		return"/user/findId";
	}
	//비밀번호 찾기 페이지
	@GetMapping(value = "findPwPage")
	public String findPwPage() {
		return"/user/findPw";
	}
	
	//사업장 디테일 보여주는 페이지
	   @GetMapping(value = "detail")
	   public String detail(Long resNo, HttpSession session, Model model, HttpServletResponse response) {
	      User user = (User)session.getAttribute("loginUser");
	      model.addAttribute("userNo", user.getUserNo());
	      model.addAttribute("resNo", resNo);
	      
	      reviewService.reviewList(model);
	      return "user/detail";   
	   }
		
	   //리뷰작성
		@PostMapping(value="insertReview")
		public void insertReview(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) {
			reviewService.insertReview(multipartRequest, response);
		}	
	
	
		
		// 메뉴 목록 ajax
		@GetMapping(value="FindMenuList", produces="application/json; charset=UTF-8")
		@ResponseBody
		public Map<String, Object> findAllMember(@RequestBody @RequestParam(value = "resNo") Long resNo) {
			return userService.findMenuList(resNo);
		}
		// 리뷰 목록 ajax
			@GetMapping(value="FindReviewList", produces="application/json; charset=UTF-8")
			@ResponseBody
			public Map<String, Object> fnFindAllReview() {
				return userService.findReviewList();
			}
		// 카트 목록 ajax
		@GetMapping(value="findCartList/page/{page}", produces="application/json; charset=UTF-8")
		@ResponseBody
		public Map<String, Object> findCartList(@PathVariable(value = "page", required = false) Optional<Integer> opt ) {
			Integer page = opt.orElse(1);
			return userService.findCartList(page);
		}
		// 리뷰  ajax
		@GetMapping(value="findCardReviewList/page/{page}", produces="application/json; charset=UTF-8")
		@ResponseBody
		public Map<String, Object> findCardReviewList(@PathVariable(value = "page", required = false) Optional<Integer> opt ) {
			Integer page = opt.orElse(1);
			return userService.findCardReviewList(page);
		}
		// 결제 목록 ajax
		@GetMapping(value="findPayList/page/{page}", produces="application/json; charset=UTF-8")
		@ResponseBody
		public Map<String, Object> findPayList(@PathVariable(value = "page", required = false)@RequestParam(value = "userNo") Long userNo,Optional<Integer> opt ) {
			Integer page = opt.orElse(1);
			return userService.findPayList(page, userNo);
		}

		// 리뷰 댓글 목록 ajax
		@GetMapping(value="FindCommentList", produces="application/json; charset=UTF-8")
		@ResponseBody
		public Map<String, Object> FindCommentList(@RequestBody @RequestParam(value = "reviewNo") Long reviewNo) {
			return userService.FindCommentList(reviewNo);
		}
		
		// 리뷰 댓글 목록 ajax
		@GetMapping(value="ReviewCommentList", produces="application/json; charset=UTF-8")
		@ResponseBody
		public List<Comment> ReviewCommentList(@RequestBody @RequestParam(value = "resNo") Long resNo) {
			return userService.ReviewCommentList(resNo);
		}
		
		// 찜하기 
		@PostMapping(value="goCartRes", produces="application/json; charset=UTF-8")
		@ResponseBody
		public Map<String, Object> goCartRes(@RequestParam(value = "resNo") Long resNo) {
			return userService.goCartRes(resNo);
		}
		//카트페이지이동
		@GetMapping(value = "goCartPage")
		public String goCartPage() {
			return "user/cart";
		}
		
		@PostMapping(value = "qnaAsk" , produces ="application/json; charset=utf-8")
		@ResponseBody
		public Map<String, Object> qnaAsk (@RequestBody Qna qna, HttpServletRequest request){
		  return userService.qnaAsk(qna, request);
		}
		
		
		
		@GetMapping(value = "findQnaList")
		public String qnalist(@RequestParam(value = "qnaWriter") String qnaWriter, Model model) {
			userService.findQnaList(qnaWriter, model);
			return "user/qnaList";
		}
		
		
		
		@GetMapping(value = "findQnaList1")
		public String findQnaList1(@RequestParam(value = "qnaWriter") String qnaWriter, Model model) {
			userService.findQnaList(qnaWriter, model);
			return "user/qnaList1";
		}
		@GetMapping(value = "findQnaList2")
		public String findQnaList2(@RequestParam(value = "qnaWriter") String qnaWriter, Model model) {
			userService.findQnaList(qnaWriter, model);
			return "user/qnaList2";
		}
		@GetMapping(value = "findQnaByNo")
		public String findQnaByNo(@RequestParam(value = "qnaNo") Long qnaNo, Model model, HttpServletRequest request) {
			userService.findQnaByNo(qnaNo, model, request);
			return "user/qnadetail";
		}
		
		@PostMapping(value = "removeQna")
		public void  removeQna(@RequestParam(value = "qnaNo") Long qnaNo, HttpServletResponse response) {
			userService.removeQna(qnaNo, response);
		}
		
		@GetMapping(value = "qnaUpdatePage")
		public String qnaUpdatePage(@RequestParam(value = "qnaNo") Long qnaNo, Model model, HttpServletRequest request) {
			userService.findQnaByNo(qnaNo, model, request);
			return "user/qnaUpdate";
		}
		@PostMapping(value = "qnaUpdate")
		public void qnaUpdate(Qna qna , HttpServletResponse response) {
			userService.qnaUpdate(qna, response);
		}
		
		@PostMapping(value="removeCart", produces="application/json; charset=UTF-8")
		@ResponseBody
		public Map<String, Object> removeCart(@RequestParam(value = "resNo") Long resNo) {
			return userService.removeCart(resNo);
		}
		
		 
		@PostMapping(value = "gogopay" , produces ="application/json; charset=utf-8")
		@ResponseBody
		public Map<String, Object> booking (@RequestBody Pay pay, HttpServletRequest request){
		  return  userService.gogopay(pay, request);
		}
		
		@GetMapping(value = "PayListPage")
		public String PayListPage() {
			return "user/payList";
		}
		
		@GetMapping(value = "indexReviewPage")
		public String indexReviewPage() {
			return "user/indexReview";
		}
		
		@GetMapping(value = "indexReviewdetail")
		public String indexReviewdetail(@RequestParam("reviewNo") Long reviewNo, Model model, HttpServletRequest request) {
			userService.indexReviewdetail(reviewNo, model);
			return "user/indexReviewdetail";
		}
		@PostMapping(value = "snsJoin" , produces ="application/json; charset=utf-8")
		@ResponseBody
		public Map<String, Object> snsJoin (@RequestBody User user, HttpServletRequest request){
		  return userService.snsJoin(user, request);
		}
		
		@PostMapping(value = "snslogin" , produces ="application/json; charset=utf-8")
		@ResponseBody
		public Map<String, Object> snslogin (@RequestBody User user, HttpServletRequest request){
			return userService.snslogin(user, request);
		}
		
		@GetMapping(value="magazine")
		public String magazine() {
			return "magazine";
		}
}