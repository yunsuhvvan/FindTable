package com.reserve.restaurant.service;


import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.reserve.restaurant.domain.Owner;
import com.reserve.restaurant.repository.OwnerRepository;
import com.reserve.restaurant.util.SecurityUtils;
@Service
public class OwnerServiceImpl implements OwnerService {

	private SqlSessionTemplate sqlSession;
	private JavaMailSender javaMailSender;

	@Autowired
	public void setBean(SqlSessionTemplate sqlSession, JavaMailSender javaMailSender) {
		this.sqlSession = sqlSession;
		this.javaMailSender = javaMailSender;
	}
//회원가입
	@Override
	public void join(Owner owner,  HttpServletResponse response) {
		
		owner.setId(owner.getId());
		owner.setPw(SecurityUtils.sha256(owner.getPw()));
		owner.setName(SecurityUtils.xxs(owner.getName()));
		owner.setEmail(owner.getEmail());
		owner.setTel(owner.getTel());
		
		
		OwnerRepository ownerRepository = sqlSession.getMapper(OwnerRepository.class);
		ownerRepository.joinOwner(owner);
		
		
		int result = ownerRepository.joinOwner(owner);
		
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
//로그인
	@Override
	public void loginOwner(HttpServletRequest request) {
		
		Owner owner = new Owner();
		owner.setId(request.getParameter("id"));
		String pw = request.getParameter("pw");
		String security_pw = SecurityUtils.sha256(pw);
		owner.setPw(security_pw);
		OwnerRepository ownerRepository = sqlSession.getMapper(OwnerRepository.class);
		Owner loginOwner = ownerRepository.loginOwner(owner);
		
		if(loginOwner != null) {
			request.getSession().setAttribute("loginUser", loginOwner);
		}
	}

	@Override
	public Owner selectOwnerByNo(Long ownerNo) {
		OwnerRepository ownerRepository = sqlSession.getMapper(OwnerRepository.class);
		return ownerRepository.selectOwnerByNo(ownerNo);
	}
	
	//현재 비밀번호 체크
	@Override
	public Map<String, Object> presentPwCheck(HttpServletRequest request) {
		OwnerRepository ownerRepository = sqlSession.getMapper(OwnerRepository.class);
		Owner owner = ownerRepository.selectOwnerById(request.getParameter("id"));
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", SecurityUtils.sha256(request.getParameter("pw0")).equals(owner.getPw()));
		return map;
	}
	
	//비밀번호 변경
	@Override
	public void updatePw(Owner owner) {
		OwnerRepository ownerRepository = sqlSession.getMapper(OwnerRepository.class);
		owner.setPw(SecurityUtils.sha256(owner.getPw()));
		ownerRepository.updatePw(owner);
	}
	//탈퇴 하기
	@Override
	public void deleteOwner(Long ownerNo, HttpSession session) {
		OwnerRepository ownerRepository = sqlSession.getMapper(OwnerRepository.class);
		int result = ownerRepository.deleteOwner(ownerNo);
		if(result > 0) session.invalidate();
		
	}
	@Override
	public void updateOwner(Owner owner, HttpSession session,  HttpServletResponse response) {
		OwnerRepository ownerRepository = sqlSession.getMapper(OwnerRepository.class);
		owner.setEmail(owner.getEmail());
		owner.setTel(owner.getTel());
		
		int result = ownerRepository.updateOwner(owner);
		message(result, response, "회원정보가 수정되었습니다", "회원정보 수정 실패", "/restaurant/owner/updateOwner");
		Owner loginUser = (Owner)session.getAttribute("loginUser");
		loginUser.setName(owner.getName());
		loginUser.setEmail(owner.getEmail());
		
		
	
	}
	
}

