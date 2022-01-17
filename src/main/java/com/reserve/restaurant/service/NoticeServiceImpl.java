package com.reserve.restaurant.service;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.reserve.restaurant.domain.Notice;
import com.reserve.restaurant.repository.NoticeRepository;
@Service
public class NoticeServiceImpl implements NoticeService {
	

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	@Override
	public List<Notice> selectNoticeList( HttpServletRequest request) {
		  NoticeRepository noticeRepository = sqlSession.getMapper(NoticeRepository.class);  
		  List<Notice> list = noticeRepository.selectNoticeList();
			// 상세 보기할 때 session에 올려 둔 notice를 제거
			HttpSession session = request.getSession();
			Notice notice = (Notice) session.getAttribute("notice");
			if (notice != null) {
				session.removeAttribute("notice");
			}
			
			// 상세 보기할 때 session에 올려 둔 open을 제거
			if (session.getAttribute("open") != null) {
				session.removeAttribute("open");
			}
		  
		  return noticeRepository.selectNoticeList();
	}
	
	@Override
	public void addNotice(Notice notice,  HttpServletResponse response) {
		NoticeRepository noticeRepository = sqlSession.getMapper(NoticeRepository.class);      
		int result = noticeRepository.insertNotice(notice);
		message(result, response, "등록되었습니다", "등록 되지 않았습니다", "/restaurant/notice/selectNoticeList");
	
	}
	
	@Override
	public Notice findNoticeByNo(Long noticeNo ,HttpServletRequest request, HttpServletResponse response) {
		 NoticeRepository noticeRepository = sqlSession.getMapper(NoticeRepository.class);
			// session 꺼내기
			HttpSession session = request.getSession();
			
			// 게시글을 열면 session에 "open"값 저장하기로 함.
			// 조회수 증가.
			if (session.getAttribute("open") == null) {
				session.setAttribute("open", true);
				noticeRepository.updateNoticeHit(noticeNo);
			}		
			Notice notice =  noticeRepository.selectNoticeView(noticeNo);
			if (notice != null) {
				// session에 저장해 둠. (수정, 삭제 작업으로 이동할 때 파라미터를 넘길 필요가 없음.)
				session.setAttribute("notice", notice);
				
				// 댓글 리스트 가져옴.
//				List<Reply> replyList = ReplyDao.getInstance().selectReplyList(nNo);
				// noticeDetail.jsp에서 보여줄 수 있도록 request에 저장해 둠.
//				request.setAttribute("replyList", replyList);
				// noticeDetail.jsp에서 보여줄 수 있도록 request에 저장해 둠.
				request.setAttribute("notice", notice);
				// noticeDetail.jsp로 
				return notice;
			}
			else {
			try {
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('일치하는 공지사항이 없습니다. 다시 시도하세요.')");
				out.println("history.back()");
				out.println("</script>");
				out.close();
				return null;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
			return notice;
	}
	
	@Override
	public void updateNotice(Notice notice, HttpServletResponse response, HttpServletRequest request) {
		NoticeRepository noticeRepository = sqlSession.getMapper(NoticeRepository.class);
		int result = noticeRepository.updateNotice(notice);
		
		HttpSession session = request.getSession();
		
		// 게시글을 열면 session에 "open"값 저장하기로 함.
		// 조회수 증가.
		if (session.getAttribute("open") == null) {
			session.setAttribute("open", true);
			noticeRepository.updateNoticeHit(notice.getNoticeNo());
		}		
		message(result, response, "수정되었습니다", "수정 실패하였습니다", "/restaurant/notice/findNoticeByNo?noticeNo="+notice.getNoticeNo());
	}
	
	@Override
	public void deleteNotice(Long noticeNo, HttpServletResponse response) {
		NoticeRepository noticeRepository = sqlSession.getMapper(NoticeRepository.class);
		int result =  noticeRepository.deleteNotice(noticeNo);
		
		message(result, response, "삭제 되었습니다", "삭제되지 않았습니다", "/restaurant/notice/selectNoticeList");
	}
	
	
	
	
}
