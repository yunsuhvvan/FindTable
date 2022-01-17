package com.reserve.restaurant.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.reserve.restaurant.domain.Book;
import com.reserve.restaurant.domain.Owner;
import com.reserve.restaurant.domain.Restaurant;
import com.reserve.restaurant.domain.Review;
import com.reserve.restaurant.domain.UploadFile;
import com.reserve.restaurant.domain.User;
import com.reserve.restaurant.repository.AdminRepository;
import com.reserve.restaurant.repository.ReviewRepository;
import com.reserve.restaurant.util.PageUtils;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public void findAllUser(Model model) {
		
		AdminRepository adminRepository = sqlSession.getMapper(AdminRepository.class);
		
		Map<String, Object> m = model.asMap();
		HttpServletRequest request = (HttpServletRequest)m.get("request");
		
		int totalRecord = adminRepository.countUser();
		
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		
		PageUtils pageUtils = new PageUtils();
		pageUtils.setPageEntity(totalRecord, page);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("beginRecord", pageUtils.getBeginRecord());
		map.put("endRecord", pageUtils.getEndRecord());
		
		List<User> list = adminRepository.selectUserList(map);
		System.out.println(list.toString());
		
		model.addAttribute("totalRecord", totalRecord);
		model.addAttribute("list", list);
		model.addAttribute("startNum", totalRecord - (page - 1) * pageUtils.getRecordPerPage());
		if (totalRecord == 0) {
			model.addAttribute("paging", null);
		} else {
			model.addAttribute("paging", pageUtils.getPageEntity("findAllUser"));			
		}
	}
	
	@Override
	public void findAllOwner(Model model) {
		AdminRepository adminRepository = sqlSession.getMapper(AdminRepository.class);
		
		Map<String, Object> m = model.asMap();
		HttpServletRequest request = (HttpServletRequest)m.get("request");
		
		int totalRecord = adminRepository.countOwner();
		
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		
		PageUtils pageUtils = new PageUtils();
		pageUtils.setPageEntity(totalRecord, page);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("beginRecord", pageUtils.getBeginRecord());
		map.put("endRecord", pageUtils.getEndRecord());
		
		List<Owner> list = adminRepository.selectOwnerList(map);
		
		
		model.addAttribute("totalRecord", totalRecord);
		model.addAttribute("ownerList", list);
		model.addAttribute("startNum", totalRecord - (page - 1) * pageUtils.getRecordPerPage());
		if (totalRecord == 0) {
			model.addAttribute("paging", 0);
		} else {
			model.addAttribute("paging", pageUtils.getPageEntity("findAllOwner"));			
		}
	}
	
	@Override
	public void findUser(Model model) {
		AdminRepository adminRepository = sqlSession.getMapper(AdminRepository.class);
		
		Map<String, Object> m = model.asMap();
		HttpServletRequest request = (HttpServletRequest)m.get("request");
		
		String column = request.getParameter("column");
		String query = request.getParameter("query");
		String begin = request.getParameter("begin");
		String end = request.getParameter("end");
		String type = request.getParameter("radio");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("column", column);
		map.put("query", query);
		map.put("begin", begin);
		map.put("end", end);
		
		int totalRecord = adminRepository.selectFindRecordCount(map);
		
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		
		PageUtils pageUtils = new PageUtils();
		pageUtils.setPageEntity(totalRecord, page);
		
		map.put("beginRecord", pageUtils.getBeginRecord());
		map.put("endRecord", pageUtils.getEndRecord());
		
		List<String> list = adminRepository.selectFindList(map);
		model.addAttribute("list", list);
		model.addAttribute("totalRecord", totalRecord);
		
		switch (column) {
		case "ID":
			model.addAttribute("paging", pageUtils.getPageEntity("findUser?column=" + column + "&query=" + query + "&radio=" + type));
			break;
		case "NAME":
			model.addAttribute("paging", pageUtils.getPageEntity("findUser?column=" + column + "&query=" + query + "&radio=" + type));  
			break;
		case "TEL":
			model.addAttribute("paging", pageUtils.getPageEntity("findUser?column=" + column + "&query=" + query + "&radio=" + type));  
			break;
		}
		
	}
	
	@Override
	public void findOwner(Model model) {
		
		AdminRepository adminRepository = sqlSession.getMapper(AdminRepository.class);
		
		Map<String, Object> m = model.asMap();
		HttpServletRequest request = (HttpServletRequest)m.get("request");
		
		String column = request.getParameter("column");
		String query = request.getParameter("query");
		String begin = request.getParameter("begin");
		String end = request.getParameter("end");
		String type = request.getParameter("radio");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("column", column);
		map.put("query", query);
		map.put("begin", begin);
		map.put("end", end);
		
		int totalRecord = adminRepository.selectFindRecordCountOwner(map);
		
		// 전달된 페이지 번호 (전달 안 되면 page = 1 사용)
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		
		// 페이징 처리 PageUtils 객체 생성 및 계산
		PageUtils pageUtils = new PageUtils();
		pageUtils.setPageEntity(totalRecord, page);
		
		// map + beginRecord + endRecord
		map.put("beginRecord", pageUtils.getBeginRecord());
		map.put("endRecord", pageUtils.getEndRecord());
		
		// 검색된 목록 중 beginRecord ~ endRecord 사이 목록 가져오기
		List<String> list = adminRepository.selectFindListOwner(map);
		
		// View(employee/list.jsp)로 보낼 데이터
		model.addAttribute("ownerList", list);
		model.addAttribute("totalRecord", totalRecord);
		
		// 검색 조건에 따라서 파라미터가 달라짐
		switch (column) {
		case "ID":
			model.addAttribute("paging", pageUtils.getPageEntity("findUser?column=" + column + "&query=" + query + "&radio=" + type));  // 목록을 출력하는 매핑값 전달
			break;
		case "NAME":
			model.addAttribute("paging", pageUtils.getPageEntity("findUser?column=" + column + "&query=" + query + "&radio=" + type));  // 목록을 출력하는 매핑값 전달
			break;
		case "TEL":
			model.addAttribute("paging", pageUtils.getPageEntity("findUser?column=" + column + "&query=" + query + "&radio=" + type));  // 목록을 출력하는 매핑값 전달
			break;
		}
		
	}

		
	// 일반회원상세 정보
	@Override
	public void selectUserInfo(Model model) {
		AdminRepository adminRepository = sqlSession.getMapper(AdminRepository.class);
		Map<String, Object> m = model.asMap();
		HttpServletRequest request = (HttpServletRequest)m.get("request");
		String userNo = request.getParameter("userNo");
		User user = adminRepository.selectUserInfo(userNo);
		int countLog = adminRepository.countUserLog(userNo);
		// model.addAttribute("bookList", bookList);
		model.addAttribute("countLog", countLog);
		model.addAttribute("user", user);
	}
	
	// userDetail에서 BookList ajax처리
	@Override
	public Map<String, Object> userBookList(Long userNo, Integer page) {
		AdminRepository adminRepository = sqlSession.getMapper(AdminRepository.class);
		
		int totalRecord = adminRepository.countBookList(userNo);
		
		PageUtils pageUtils = new PageUtils();
		pageUtils.setPageEntity(totalRecord, page);	// 페이징 요소들은 전체 목록 갯수 + 페이지 번호 필요
		
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("beginRecord", pageUtils.getBeginRecord());
		m.put("endRecord", pageUtils.getEndRecord());
		m.put("userNo", userNo);
		
		System.out.println("beginRecord:" + pageUtils.getBeginRecord());
		System.out.println("endRecord:" + pageUtils.getEndRecord());
		
		List<Book> bookList = adminRepository.selectBookList(m);	// 목록
		
		System.out.println(bookList.toString());
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("bookList", bookList);				// 목록
		map.put("pageUtils", pageUtils);	// 페이징 처리를 위해서
		
		return map;
	}
	
	
	// 사업자회원 상세정보
	@Override
	public void selectOwnerInfo(Model model) {
		AdminRepository adminRepository = sqlSession.getMapper(AdminRepository.class);
		Map<String, Object> map = model.asMap();
		Long ownerNo = (Long) map.get("ownerNo");
		Owner owner = adminRepository.selectOwnerInfo(ownerNo);
		int count = adminRepository.countOwnerRes(ownerNo);
		model.addAttribute("count", count);
		model.addAttribute("owner", owner);
		List<Restaurant> restList = adminRepository.selectOwnerInfoRes(ownerNo);
		model.addAttribute("restList", restList);
		
	}

	// ownerDetail에서 resList ajax처리
	@Override
	public Map<String, Object> ownerResList(Long ownerNo, Integer page) {
		AdminRepository adminRepository = sqlSession.getMapper(AdminRepository.class);
		int totalRecord = adminRepository.countOwnerRes(ownerNo);
		
		PageUtils pageUtils = new PageUtils();
		pageUtils.setPageEntity(totalRecord, page);	// 페이징 요소들은 전체 목록 갯수 + 페이지 번호 필요
		
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("beginRecord", pageUtils.getBeginRecord());
		m.put("endRecord", pageUtils.getEndRecord());
		m.put("ownerNo", ownerNo);
		
		List<Restaurant> resList = adminRepository.selectResList(m);	// 목록
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("resList", resList);				// 목록
		map.put("pageUtils", pageUtils);	// 페이징 처리를 위해서
		
		return map;
	}
	
	
	
	
	
	// 검색페이지(페이징)
	@Override
	public void selectResList(HttpServletRequest request, Model model) {
		AdminRepository adminRepository = sqlSession.getMapper(AdminRepository.class);
		String query = request.getParameter("query");
		int totalRecord = adminRepository.searchCountRes(query);	
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		PageUtils pageUtils = new PageUtils();
		pageUtils.setPageEntity(totalRecord, page);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("query", query);
		map.put("beginRecord", pageUtils.getBeginRecord());
		map.put("endRecord", pageUtils.getEndRecord());
		List<Restaurant> resList = adminRepository.resListByAddress(map);
		model.addAttribute("resList", resList);
		model.addAttribute("totalRecord", totalRecord);
		model.addAttribute("paging", pageUtils.getPageEntity("searchRestaurant?query=" + query));			
	}


	@Override

	public void selectResDetail(Model model, Restaurant restaurant, HttpServletRequest request) {
	      AdminRepository adminRepository = sqlSession.getMapper(AdminRepository.class);
	      ReviewRepository reviewRepository = sqlSession.getMapper(ReviewRepository.class);
	      
	      Long resNo = restaurant.getResNo();
	      Restaurant rest = adminRepository.selectResDetail(resNo);
	      Integer totalReviewCount  = reviewRepository.totalReview(resNo);
	      Integer avgReview = reviewRepository.avgReviewRate(resNo);
	      
	      List<Review> reviewList = adminRepository.selectReviewList(resNo);
	      List<UploadFile> picList = adminRepository.selectFile(resNo);
	      if (rest != null) {
	         request.getSession().setAttribute("rest", rest);
	      }
	      
	      model.addAttribute("reviewList",reviewList);
	      if(reviewList != null) {
	    	  request.getSession().setAttribute("review", reviewList);
	      }
	      
	      model.addAttribute("pic" ,  picList);
	      if (picList != null) {
	    	  request.getSession().setAttribute("pic", picList);
	      }
	     model.addAttribute("reviewCount", totalReviewCount);
	     model.addAttribute("avgReview", avgReview);
	      
	      
	   }
	
	

	// 전체 사업장 리스트 출력
	@Override
	public Map<String, Object> resList(Integer page, Model model) {
		AdminRepository adminRepository = sqlSession.getMapper(AdminRepository.class);
		
		int totalRecord = adminRepository.countRes();
		
		model.addAttribute("totalReocrd", totalRecord);
		
		PageUtils pageUtils = new PageUtils();
		pageUtils.setPageEntity(totalRecord, page);	// 페이징 요소들은 전체 목록 갯수 + 페이지 번호 필요
		
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("beginRecord", pageUtils.getBeginRecord());
		m.put("endRecord", pageUtils.getEndRecord());

		List<Restaurant> list = adminRepository.selectRes(m);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("resList", list);
		map.put("pageUtils", pageUtils);
		
		return map;
	}
	
	// 사업장 검색
	@Override
	public Map<String, Object> findRes(Integer page, HttpServletRequest request) {
		AdminRepository adminRepository = sqlSession.getMapper(AdminRepository.class);
		Map<String, Object> m1 = new HashMap<String, Object>();
		m1.put("column", request.getParameter("column"));
		m1.put("query", request.getParameter("query"));
		int totalRecord = adminRepository.countFindRes(m1);
		PageUtils pageUtils = new PageUtils();
		pageUtils.setPageEntity(totalRecord, page);	// 페이징 요소들은 전체 목록 갯수 + 페이지 번호 필요
		Map<String, Object> m2 = new HashMap<String, Object>();
		m2.put("beginRecord", pageUtils.getBeginRecord());
		m2.put("endRecord", pageUtils.getEndRecord());
		m2.put("column", request.getParameter("column"));
		m2.put("query", request.getParameter("query"));
		List<Restaurant> list = adminRepository.findRes(m2);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("pageUtils", pageUtils);
		return map;
	}

	
	// 새로 등록된 식당
	@Override
	public void newOpen(Model model) {
		AdminRepository adminRepository = sqlSession.getMapper(AdminRepository.class);
		List<Restaurant> list = adminRepository.newOpen();
		model.addAttribute("list", list);
		
		
	}
	
	@Override
	public Map<String, Object> indexNewOpen(int resState) {
		AdminRepository adminRepository = sqlSession.getMapper(AdminRepository.class);
		List<Restaurant> list = adminRepository.indexnewOpen(resState);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		return map;
	}
	
	@Override
	public void reviewRate(Model model) {
		AdminRepository adminRepository = sqlSession.getMapper(AdminRepository.class);
		List<Restaurant> list = adminRepository.ReviewRate();
		model.addAttribute("list", list);
	}
	
	
	
	
	
}
