package com.reserve.restaurant.service;


import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.Message;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.reserve.restaurant.domain.Comment;
import com.reserve.restaurant.domain.Menu;
import com.reserve.restaurant.domain.Pay;
import com.reserve.restaurant.domain.Qna;
import com.reserve.restaurant.domain.Restaurant;
import com.reserve.restaurant.domain.Review;
import com.reserve.restaurant.domain.User;
import com.reserve.restaurant.repository.UserRepository;
import com.reserve.restaurant.util.PageUtils;
import com.reserve.restaurant.util.SecurityUtils;
@Service
public class UserServiceImpl implements UserService {
		
	private SqlSessionTemplate sqlSession;
	private JavaMailSender javaMailSender;

	
	@Autowired
	public void setBean(SqlSessionTemplate sqlSession, JavaMailSender javaMailSender) {
		this.sqlSession = sqlSession;
		this.javaMailSender = javaMailSender;
	}
	
	@Override
	public User selectUserByNo(Long userNo) {
		UserRepository userRepository = sqlSession.getMapper(UserRepository.class);
		return userRepository.selectUserByNo(userNo);
	}
	
	@Override
	public void login(HttpServletRequest request , HttpServletResponse response) {
		UserRepository userRepository = sqlSession.getMapper(UserRepository.class);
		User user = new User();
		user.setId(request.getParameter("id"));
		user.setPw(SecurityUtils.sha256(request.getParameter("pw")));
		User loginUser = userRepository.login(user);
		
		if (loginUser != null) {
			request.getSession().setAttribute("loginUser", loginUser);
		
			// 로그인로그에 기록
			Long userNo = loginUser.getUserNo();
			userRepository.insertLoginLog(userNo);
		
			// 포인트 적립
			int result = userRepository.updateUserPoint(userNo);
			if (result == 1) {
				try {
					response.setContentType("text/html; charset=utf-8");
					PrintWriter out = response.getWriter();
					out.println("<script>");
					out.println("alert('로그인 성공! 포인트가 10점 적립됩니다.')");
					out.println("location.href='/restaurant/main/mainPage'");
					out.println("</script>");
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
			
		} 
		
		if(loginUser == null) {
			try {
				response.setContentType("text/html; charset=utf-8");
				PrintWriter out = response.getWriter();
					out.println("<script>");
					out.println("alert('아이디와 비밀번호를 다시 확인해주세요.')");
					out.println("location.href='/restaurant/user/loginPage'");
					out.println("</script>");
					out.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
	}
	
	
	@Override
	public Map<String, Object> findUserByEmail(String email) {
		UserRepository userRepository = sqlSession.getMapper(UserRepository.class);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", userRepository.selectUserByEmail(email));
		return map;
	}
	
	@Override
	public Map<String, Object> idCheck(String id) {
		UserRepository userRepository = sqlSession.getMapper(UserRepository.class);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", userRepository.selectUserById(id));
		return map;
		
	}
	
	@Override
	public Map<String, Object> emailCheck(String email) {
		UserRepository userRepository = sqlSession.getMapper(UserRepository.class);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", userRepository.selectUserByEmail(email));
		return map;
	}
	
	@Override
	public void insertUser(User user, HttpServletResponse response) {
		UserRepository userRepository = sqlSession.getMapper(UserRepository.class);
		user.setId(user.getId());
		user.setPw(SecurityUtils.sha256(user.getPw()));
		user.setName(SecurityUtils.xxs(user.getName()));
		user.setTel(user.getTel());
		user.setHbd(user.getHbd());
		user.setEmail(user.getEmail());
		
	
		int result = userRepository.insertUser(user);
		
		try {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			if(result > 0) {
				out.println("<script>");
				out.println("alert('회원가입 되었습니다.')");
				out.println("location.href='/restaurant'");
				out.println("</script>");
				out.close();
			} else {
				out.println("<script>");
				out.println("alert('회원 등록 실패하였습니다.')");
				out.println("history.back()");
				out.println("</script>");
				out.close(); 
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
		
	
	
	@Override
	public Map<String, Object> sendAuthCode(String email) {
			String authCode = SecurityUtils.authCode(6); 
			try {
				MimeMessage message = javaMailSender.createMimeMessage();
				message.setHeader("Content-Type", "text/plain; charset=UTF-8");
				message.setFrom(new InternetAddress("gogospringtest@gmail.com", "인증코드관리자"));
				message.setRecipient(Message.RecipientType.TO, new InternetAddress(email));
				message.setSubject("인증 요청 메일입니다.");
				message.setText("인증번호는 " + authCode + " 입니다.");
				javaMailSender.send(message);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("authCode", authCode);
			return map;
	}
	
	@Override
	public Map<String, Object> tempPassword(User user, HttpServletResponse response) {
		UserRepository userRepository = sqlSession.getMapper(UserRepository.class);

		String str = getTemPassword();
		try {
			MimeMessage message = javaMailSender.createMimeMessage();
			message.setHeader("Content-Type", "text/plain; charset=UTF-8");
			message.setFrom(new InternetAddress("gogospringtest@gmail.com", "임시비밀번호관리자"));
			message.setRecipient(Message.RecipientType.TO, new InternetAddress(user.getEmail()));
			message.setSubject("임시 비밀번호 입니다.");
			message.setText("임시 비밀번호는 " + str + " 입니다.");
			javaMailSender.send(message);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		user.setPw(SecurityUtils.sha256(str));
		int result = userRepository.updatePw(user);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("str", str);
		return map;
	}
	
	public String getTemPassword() {
		String str ="@$!";
		for(int i =0; i <= 7; i++) {
			str += (char)((Math.random()*26)+97);
		}
		return str;
	}
	
	
	
	
	@Override
	public Map<String, Object> presentPwCheck(HttpServletRequest request) {
		UserRepository userRepository = sqlSession.getMapper(UserRepository.class);
		User user = userRepository.selectUserById(request.getParameter("id"));
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", SecurityUtils.sha256(request.getParameter("pw0")).equals(user.getPw()));
		return map;
	}
	
	@Override
	public void updatePw(User user, HttpServletResponse response) {
		UserRepository userRepository = sqlSession.getMapper(UserRepository.class);
		user.setPw(SecurityUtils.sha256(user.getPw()));
		int result = userRepository.updatePw(user);
		message(result, response, "비밀번호가 수정되었습니다", "비밀번호 수정 실패", "/restaurant/user/updateUser");
	}	
	
	
	@Override
	public void deleteUser(Long userNo,HttpServletResponse response , HttpSession session) {
		UserRepository userRepository = sqlSession.getMapper(UserRepository.class);
		int result = userRepository.deleteUser(userNo);
		
		message(result, response, "사용자가 삭제 되었습니다.", " 사용자가 삭제되지 않았습니다.", "/restaurant");
		if(result > 0 ) session.invalidate();
	}
	
	@Override
	public void updateUser(User user, HttpSession session, HttpServletResponse response) {
		UserRepository userRepository = sqlSession.getMapper(UserRepository.class);
		user.setEmail(user.getEmail());
		user.setTel(user.getTel());
		
		
		int result = userRepository.updateUser(user);
		message(result, response, "회원정보가 수정되었습니다", "회원정보 수정 실패", "/restaurant/user/updateUser");
		User loginUser = (User)session.getAttribute("loginUser");
		loginUser.setEmail(user.getEmail());
		loginUser.setTel(user.getTel());
	}
	
	@Override
	public Map<String, Object> hourCheck(String bookHours) {
		UserRepository userRepository = sqlSession.getMapper(UserRepository.class);
		List<User> list = userRepository.hourCheck(bookHours);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", list);
		return map;
	}
	
	@Override
	public Map<String, Object> findMenuList(Long resNo) {
		
		UserRepository userRepository = sqlSession.getMapper(UserRepository.class);
		List<Menu> list = userRepository.selectMenuList(resNo);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		return map;
	}
	@Override
	public Map<String, Object> FindCommentList(Long reviewNo) {
		UserRepository userRepository = sqlSession.getMapper(UserRepository.class);
		List<Comment> list = userRepository.selectComment(reviewNo);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		
		return map;
	}
	
	@Override
	public List<Comment> ReviewCommentList(Long resNo) {
		UserRepository userRepository = sqlSession.getMapper(UserRepository.class);
		List<Comment> list = userRepository.commentList1(resNo);
		System.out.println("list"+list.toString());
		return list;
	}
	
	@Override
	public Map<String, Object> findReviewList() {
		
		UserRepository userRepository = sqlSession.getMapper(UserRepository.class);
		List<Menu> list = userRepository.selectReviewList();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		return map;
	}
	@Override
	public Map<String, Object> findCartList(Integer page) {
		
		UserRepository userRepository = sqlSession.getMapper(UserRepository.class);
		
		int totalRecord = userRepository.selectTotalResCount();
		PageUtils pageUtils = new PageUtils();
		pageUtils.setPageEntity(totalRecord, page);
		
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("beginRecord", pageUtils.getBeginRecord());
		m.put("endRecord", pageUtils.getEndRecord());
		
		List<Restaurant> list = userRepository.selectCartList(m);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pageUtils", pageUtils);
		map.put("totalRecord", totalRecord);
		map.put("list", list);
		return map;
	}
	@Override
	public Map<String, Object> findCardReviewList(Integer page) {
		
		UserRepository userRepository = sqlSession.getMapper(UserRepository.class);
		
		int totalRecord = userRepository.selectTotalReviewCount();
		PageUtils pageUtils = new PageUtils();
		pageUtils.setPageEntity(totalRecord, page);
		
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("beginRecord", pageUtils.getBeginRecord());
		m.put("endRecord", pageUtils.getEndRecord());
		
		List<Review> list = userRepository.selectCardReviewList(m);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pageUtils", pageUtils);
		map.put("totalRecord", totalRecord);
		map.put("list", list);
		return map;
	}
	@Override
	public Map<String, Object> findPayList(Integer page, Long userNo) {
		
		UserRepository userRepository = sqlSession.getMapper(UserRepository.class);
		
		int totalRecord = userRepository.selectTotalpayCount();
		PageUtils pageUtils = new PageUtils();
		pageUtils.setPageEntity(totalRecord, page);
		
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("beginRecord", pageUtils.getBeginRecord());
		m.put("endRecord", pageUtils.getEndRecord());
		m.put("userNo", userNo);
		List<Pay> list = userRepository.selectPayListByuserNo(m);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pageUtils", pageUtils);
		map.put("totalRecord", totalRecord);
		map.put("list", list);
		return map;
	}
	
	@Override
	public Map<String, Object> goCartRes(Long resNo) {
		UserRepository userRepository = sqlSession.getMapper(UserRepository.class);
		int result = userRepository.UpdateRestState(resNo);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", result);
		return map;
	}
	@Override
	public Map<String, Object> removeCart(Long resNo) {
		UserRepository userRepository = sqlSession.getMapper(UserRepository.class);
		int result = userRepository.DeleteRestState(resNo);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", result);
		return map;
	}
		
	@Override
	public Map<String, Object> qnaAsk(Qna qna , HttpServletRequest request) {
		UserRepository userRepository = sqlSession.getMapper(UserRepository.class);
		int result = userRepository.insertQna(qna);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", result);
		return map;
	}
	
	@Override
	public List<Qna> findQnaList(String qnaWriter, Model model) {
		UserRepository userRepository = sqlSession.getMapper(UserRepository.class);
		List<Qna> list = userRepository.selectQnaList(qnaWriter);
		model.addAttribute("list", list);
		return list;
	}
	
	
	@Override
	public void findQnaByNo(Long qnaNo, Model model, HttpServletRequest request) {
		UserRepository userRepository =  sqlSession.getMapper(UserRepository.class);
		Qna list2= userRepository.selectQna2(qnaNo);
		Qna list3= userRepository.selectQna3(qnaNo);
		Qna list1= userRepository.selectQna1(qnaNo);
		
		model.addAttribute("reply", userRepository.qnaReplyByUser(qnaNo));
		model.addAttribute("list2", list2);
		model.addAttribute("list3", list3);
		model.addAttribute("list1", list1);
		model.addAttribute("adminReply", userRepository.selectReplyQna(qnaNo));
		System.out.println(userRepository.selectReplyQna(qnaNo) + " 임플");
	}
	
	@Override
	public void removeQna(Long qnaNo, HttpServletResponse response) {
		UserRepository userRepository =  sqlSession.getMapper(UserRepository.class);
		int result = userRepository.deleteQna(qnaNo);
		message(result, response, "삭제되었습니다", "삭제 실패", "/restaurant/user/myPage");
	}
	@Override
	public void qnaUpdate(Qna qna, HttpServletResponse response) {
		UserRepository userRepository =  sqlSession.getMapper(UserRepository.class);
		int result = userRepository.updateQna(qna);
		message(result, response, "수정 되었습니다", "수정 실패", "/restaurant/user/findQnaList?qnaWriter="+qna.getQnaWriter());
		
	}
	
	@Override
	public Map<String, Object> gogopay(Pay pay, HttpServletRequest request) {
		UserRepository userRepository =  sqlSession.getMapper(UserRepository.class);
		int result = userRepository.insertPay(pay);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", result);
		return map;
	}
	
	
	@Override
	public Review indexReviewdetail(Long reviewNo, Model model) {
		UserRepository userRepository =  sqlSession.getMapper(UserRepository.class);
		Review review = userRepository.selectCardReview(reviewNo);
		model.addAttribute("review", review);
		return review;
	}
	
	@Override
	public Map<String, Object> snsJoin(User user , HttpServletRequest request) {
		UserRepository userRepository =  sqlSession.getMapper(UserRepository.class);
		int result = userRepository.insertUser(user);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", result);
		return map;
	}
	@Override
	public Map<String, Object> snslogin(User user , HttpServletRequest request) {
		UserRepository userRepository =  sqlSession.getMapper(UserRepository.class);
		User loginUser = userRepository.login(user);
		if (loginUser != null) {
			request.getSession().setAttribute("loginUser", loginUser);
			}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", userRepository.login(user));
		return map;
	}
}