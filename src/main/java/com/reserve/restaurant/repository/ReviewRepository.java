package com.reserve.restaurant.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.reserve.restaurant.domain.Comment;
import com.reserve.restaurant.domain.Review;

@Mapper
public interface ReviewRepository {

	public List<Review> reviewList(Map<String, Object> map);
	public List<Review> reviewList1(Long resNo);
	public List<Review> ownerReviewList(Map<String, Object> map);
	
	public Review selectReviewList(Long reviewNo);
	public List<Review> moreReview(Map<String, Object> map);
	public int insertReview(Review review);
	public Integer avgReviewRate(Long resNo);
	public Integer totalReview(Long resNo);
	public List<Integer> selectReviewCount(Long resNo);
	
	//comment
	public int commentCount();
	public List<Comment> commentList(Long reviewNo);
	public int addComment(Comment comment);
	public int updateComment(Comment commment);
	public int removeComment(Long commentNo);
	
	
	

	
}
