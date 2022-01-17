package com.reserve.restaurant.service;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.regex.Matcher;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.reserve.restaurant.domain.Comment;
import com.reserve.restaurant.domain.Owner;
import com.reserve.restaurant.domain.Restaurant;
import com.reserve.restaurant.domain.Review;
import com.reserve.restaurant.repository.RestaurantRepository;
import com.reserve.restaurant.repository.ReviewRepository;
import com.reserve.restaurant.repository.UserRepository;

import net.coobird.thumbnailator.Thumbnails;
@Service
public class ReviewServiceImpl implements ReviewService {

   @Autowired
   private SqlSessionTemplate sqlSession;

   @Override
   public void insertReview(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) {
      Review review = new Review();
      review.setReviewWriter(multipartRequest.getParameter("reviewWriter"));
      review.setReviewContent(multipartRequest.getParameter("reviewContent"));
      review.setReviewRate(Integer.parseInt(multipartRequest.getParameter("rating")));
      review.setUserNo(Long.parseLong(multipartRequest.getParameter("userNo")));
      review.setResNo(Long.parseLong(multipartRequest.getParameter("resNo")));
      
      
      try {
         
         MultipartFile file = multipartRequest.getFile("r_file");
         
         if (file != null && !file.isEmpty()) {  
            String origin = file.getOriginalFilename();
            String extName = origin.substring(origin.lastIndexOf("."));
      
            String uuid = UUID.randomUUID().toString().replaceAll("-", "");
            String saved = uuid + extName;
            String sep = Matcher.quoteReplacement(File.separator);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String path = "resources" + sep + "upload"  + sep + sdf.format(new Date()).replaceAll("-", sep);
            String realPath = multipartRequest.getServletContext().getRealPath(path);
         
            File dir = new File(realPath);
            if (dir.exists() == false) {
               dir.mkdirs();
            }
            
            File uploadFile = new File(realPath, saved);  
            file.transferTo(uploadFile);  
            
            Thumbnails.of(uploadFile)
            .size(150, 150)
            .toFile(new File(realPath, "s_" + saved));
            
            review.setReviewPath(path);
            review.setReviewOrigin(origin);
            review.setReviewSaved(saved);
            
         } 
         else {
            review.setReviewPath("");
            review.setReviewOrigin("");
            review.setReviewSaved("");
         }
      } catch (Exception e) {
         e.printStackTrace();
      }
      ReviewRepository reviewRepository = sqlSession.getMapper(ReviewRepository.class);
      int result = reviewRepository.insertReview(review);
      
      String opt = multipartRequest.getParameter("resNo");
      Long resNo =  Long.parseLong(opt);
      
      
      message(result, response, "리뷰가 등록되었습니다.", "리뷰등록이 싫패했습니다.", "/restaurant/admin/goResDetail?resNo="+resNo);
      
   }
   
   @Override
   public void reviewList(Model model) {
      
      ReviewRepository reviewRepository = sqlSession.getMapper(ReviewRepository.class);
      RestaurantRepository resRepository = sqlSession.getMapper(RestaurantRepository.class);
      
      Map<String, Object> m = model.asMap();
      HttpServletRequest request = (HttpServletRequest)m.get("request");
      
      Long userNo = (Long) m.get("userNo");
      Long resNo = (Long)m.get("resNo");

      Map<String, Object>map = new HashMap<String, Object>();
      map.put("resNo", resNo);
      
      
      int totalCount = reviewRepository.totalReview(resNo);
//      
      List<Review> list = reviewRepository.reviewList(map);
      
      Restaurant restaurant = resRepository.selectList(resNo);

      model.addAttribute("resNo", resNo);
      model.addAttribute("reviewlist", list);
      model.addAttribute("restaurant", restaurant);
      model.addAttribute("totalCount", totalCount);
      
   }
   
   //리뷰 더보기
   
   @Override
   public void moreReview(Model model) {
      
      ReviewRepository reviewRepository = sqlSession.getMapper(ReviewRepository.class);
      UserRepository userRepository = sqlSession.getMapper(UserRepository.class);
      
    		  
      Map<String, Object> m = model.asMap();
      HttpServletRequest request = (HttpServletRequest)m.get("request");
      
      Long userNo = (Long) m.get("userNo");
      Long resNo = (Long)m.get("resNo");
      
      Map<String, Object>map = new HashMap<String, Object>();
      map.put("resNo", resNo);
      
      Integer avgReview = reviewRepository.avgReviewRate(resNo);
      Integer totalReviewCount = reviewRepository.totalReview(resNo);
      
      List<Integer> reviewCountList = reviewRepository.selectReviewCount(resNo);
      List<Review> list = reviewRepository.reviewList(map);

      model.addAttribute("resNo", resNo);
      model.addAttribute("reviewlist", list);
      model.addAttribute("avgReview", avgReview);
      model.addAttribute("totalReviewCount", totalReviewCount);
      model.addAttribute("reviewCountList", reviewCountList);
      model.addAttribute("moreReply" , userRepository.commentList1(resNo) );
      
   }

   //사업자한테 보여주는 리스트
   @Override
   public void ownerReviewList(Model model) {
      ReviewRepository reviewRepository = sqlSession.getMapper(ReviewRepository.class);
      
      Map<String, Object> m = model.asMap();
      HttpServletRequest request = (HttpServletRequest)m.get("request");
      Long userNo = (Long)m.get("userNo");
      Long ownerNo = (Long)m.get("ownerNo");
      
      Map<String, Object>map = new HashMap<String, Object>();
      map.put("ownerNo", ownerNo);
      
      List<Review> reviewlist = reviewRepository.ownerReviewList(map);
      
      model.addAttribute("reviewlist", reviewlist);
   }

   //하나의 리뷰 조회
   @Override
   public Review selectReviewList(Long reviewNo) {
      ReviewRepository reviewRepository = sqlSession.getMapper(ReviewRepository.class);
      return reviewRepository.selectReviewList(reviewNo);
   }
   //댓글 리스트
   @Override
   public List<Comment> commentList(Long reviewNo, Model model) {
      ReviewRepository reviewRepository = sqlSession.getMapper(ReviewRepository.class);
      return reviewRepository.commentList(reviewNo);
   }

   //댓글추가
   @Override
   public int addComment(HttpServletRequest request) {
      HttpSession session = request.getSession();
      Owner loginUser = (Owner)session.getAttribute("loginUser");
      
       Comment comment = new Comment();
       Long reviewNo  = Long.parseLong(request.getParameter("reviewNo"));
       String content = request.getParameter("content");
       
       comment.setReviewNo(reviewNo);
       comment.setContent(content);
       comment.setWriter(loginUser.getName());
       
      ReviewRepository reviewRepository = sqlSession.getMapper(ReviewRepository.class);
      return reviewRepository.addComment(comment);
   }
   //댓글 삭제
   @Override
   public int removeComment(Long commentNo) {
      ReviewRepository reviewRepository = sqlSession.getMapper(ReviewRepository.class);;
      return reviewRepository.removeComment(commentNo);
   }

   //댓글 수정
   @Override
   public int updateComment(Comment comment) {
      ReviewRepository reviewRepository = sqlSession.getMapper(ReviewRepository.class);
      return reviewRepository.updateComment(comment);
   }



   
}