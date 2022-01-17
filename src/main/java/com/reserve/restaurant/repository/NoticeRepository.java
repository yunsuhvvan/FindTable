package com.reserve.restaurant.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.reserve.restaurant.domain.Notice;

@Mapper
public interface NoticeRepository {

	
	public List<Notice> selectNoticeList();
	public int insertNotice(Notice notice);
	public Notice selectNoticeView(Long noticeNo);
	public int updateNotice(Notice notice);
	public int updateNoticeHit(Long noticeNo);
	public int deleteNotice(Long noticeNo);
	
}
