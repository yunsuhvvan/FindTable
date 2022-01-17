package com.reserve.restaurant.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.reserve.restaurant.domain.Book;
import com.reserve.restaurant.domain.Restaurant;
import com.reserve.restaurant.repository.BookRepository;
import com.reserve.restaurant.util.PageUtils;
import com.reserve.restaurant.util.PageUtilsOnlyforSuhwan;

@Service
public class BookServiceImpl implements BookService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public Map<String, Object> booking(Book book , HttpServletRequest request) {
		BookRepository bookRepository = sqlSession.getMapper(BookRepository.class);
		int result = bookRepository.insertBook(book);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", result);
		map.put("bookNo", book.getBookNo());
		return map;
	}
	
	@Override
	public void selectBookingList(Long userNo, Model model) {
		BookRepository bookRepository = sqlSession.getMapper(BookRepository.class);
		Map<String, Object> m = model.asMap();
		HttpServletRequest request = (HttpServletRequest)m.get("request");
		
		int totalRecord = bookRepository.selectTotalBookingCount();
		
		//전달된 페이지 번호
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		
		
		PageUtils pageUtils = new PageUtils();
		pageUtils.setPageEntity(totalRecord, page);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("beginRecord", pageUtils.getBeginRecord());
		map.put("endRecord", pageUtils.getEndRecord());
		map.put("userNo", userNo);
		
		List<Book> list = bookRepository.selectBookingListByuserNo(map);
		
		
		model.addAttribute("list", list);
		model.addAttribute("startNum", totalRecord - (page -1) * pageUtils.getRecordPerPage());
		model.addAttribute("paging" , pageUtils.getPageEntity("selectBookingList?userNo="+userNo));
		
		
		if(list != null) {
			request.getSession().setAttribute("bookingInfo", list);
		}
	}
	
	@Override
	public void selectBookingDetail(Long resNo, Model model) {
		BookRepository bookRepository = sqlSession.getMapper(BookRepository.class);
		
		Map<String, Object> m = model.asMap();
		HttpServletRequest request = (HttpServletRequest)m.get("request");
		
		int totalRecord = bookRepository.selectTotalResCount();
		
		//전달된 페이지 번호
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		
		
		PageUtilsOnlyforSuhwan pageUtils = new PageUtilsOnlyforSuhwan();
		pageUtils.setPageEntity(totalRecord, page);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("beginRecord", pageUtils.getBeginRecord());
		map.put("endRecord", pageUtils.getEndRecord());
		map.put("resNo", resNo);
		
		
		List<Book> list = bookRepository.selectBookingByresNo(map);
		model.addAttribute("detail", list);
		model.addAttribute("startNum", totalRecord - (page -1) * pageUtils.getRecordPerPage());
		model.addAttribute("paging" , pageUtils.getPageEntity("selectBookingDetail?resNo="+resNo)); 
		
		
	}
	
	@Override
	public void bookingCancel(Long bookNo, HttpServletResponse response) {
		BookRepository bookRepository = sqlSession.getMapper(BookRepository.class);
		int result = bookRepository.updatebookingState(bookNo);
		message(result, response, "예약이 취소 되었습니다", "예약이 취소되지 않았습니다.", "/restaurant/book/findCancelList");
	}
	
	@Override
	public void FindCancelList(Model model) {
		BookRepository bookRepository = sqlSession.getMapper(BookRepository.class);
		Map<String, Object> m = model.asMap();
		HttpServletRequest request = (HttpServletRequest)m.get("request");
		int totalRecord = bookRepository.selectCancelCount();

		//전달된 페이지 번호
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		
		
		PageUtils pageUtils = new PageUtils();
		pageUtils.setPageEntity(totalRecord, page);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("beginRecord", pageUtils.getBeginRecord());
		map.put("endRecord", pageUtils.getEndRecord());

		
		List<Book> list = bookRepository.selectCancelList(map);
		
		model.addAttribute("cancelList", list);
		model.addAttribute("startNum", totalRecord - (page -1) * pageUtils.getRecordPerPage());
		model.addAttribute("paging" , pageUtils.getPageEntity("findCancelList")); 
		
		
	}

	@Override
	public void bookList(Model model) {	
		
		BookRepository bookRepository = sqlSession.getMapper(BookRepository.class);
		
		Map<String, Object> m = model.asMap();
		HttpServletRequest request = (HttpServletRequest)m.get("request");
		
		Long ownerNo = (Long) m.get("ownerNo");
		
		Map<String, Object>map = new HashMap<String, Object>();
		map.put("ownerNo", ownerNo);
		
		
		List<Map<String, String>> list = bookRepository.bookList(map);
		
		JSONArray json_array = new JSONArray();
		for(Map<String, String> result : list) {
			JSONObject object = new JSONObject();
			object.put("title", result.get("NAME") + " " + result.get("BOOK_HOURS"));
			String start = (String) result.get("BOOK_DATE");
			object.put("start", start);
			json_array.put(object);
		}
		
		model.addAttribute("list", list);
		model.addAttribute("list_json", json_array);

	}
//
	@Override
	public void selectBookBybookNo(HttpServletRequest request, Model model) {
		Long bookNo = Long.parseLong(request.getParameter("bookNo"));
		BookRepository bookRepository = sqlSession.getMapper(BookRepository.class);
		Restaurant restaurant = bookRepository.selectBookBybookNo(bookNo);
		model.addAttribute("restaurant", restaurant);
		
	}
	
	
	@Override
	public Map<String, Object> hourCheck(Book book , HttpServletRequest request) {
		BookRepository bookRepository = sqlSession.getMapper(BookRepository.class);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", bookRepository.hourCheck(book));
		return map;
	}


	
	
}