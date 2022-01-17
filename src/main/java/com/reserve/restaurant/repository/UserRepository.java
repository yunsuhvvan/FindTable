package com.reserve.restaurant.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.reserve.restaurant.domain.Comment;
import com.reserve.restaurant.domain.Menu;
import com.reserve.restaurant.domain.Pay;
import com.reserve.restaurant.domain.Qna;
import com.reserve.restaurant.domain.Reply;
import com.reserve.restaurant.domain.Restaurant;
import com.reserve.restaurant.domain.Review;
import com.reserve.restaurant.domain.User;

@Mapper
public interface UserRepository {

	public User selectUserById(String id);
	public User selectUserByEmail(String email);
	public int insertUser(User user);
	public User login(User user);
	public User selectUserByNo(Long userNo);
	public int updatePw(User user);
	public int deleteUser(Long userNo);
	public int updateUser(User user);
	public List<User> hourCheck(String bookHours);
	public List<Restaurant> selectCartList(Map<String, Object> map);
	public List<Review> selectCardReviewList(Map<String, Object> map);
	public List<Pay> selectPayListByuserNo(Map<String, Object> map);
	public List<Menu> selectMenuList(Long resNo);
	public List<Menu> selectReviewList();
	public int UpdateRestState(Long resNo);
	public int DeleteRestState(Long resNo);
	public int selectTotalResCount();
	public int insertQna(Qna qna);
	public int insertPay(Pay pay);
	public List<Qna> selectQnaList(String qnaWriter);
	public Qna selectQna1(Long qnaNo);
	public Qna selectQna2(Long qnaNo);
	public Qna selectQna3(Long qnaNo);
	public int deleteQna(Long qnaNo);
	public int updateQna(Qna qna);
	public int selectTotalpayCount();
	public Map<String, Object> qnaReplyByUser(Long qnaNo);
	public int insertLoginLog(Long userNo);
	public int updateUserPoint(Long userNo);
	public int selectTotalReviewCount();
	public Review selectCardReview(Long reviewNo);
	public List<Comment> selectComment(Long reviewNo);
	public List<Reply> selectReplyQna(Long qnaNo);
	public List<Comment> commentList1(Long resNo);
	
}