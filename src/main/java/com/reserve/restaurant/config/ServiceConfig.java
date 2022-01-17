package com.reserve.restaurant.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.reserve.restaurant.service.AdminService;
import com.reserve.restaurant.service.AdminServiceImpl;
import com.reserve.restaurant.service.BookService;
import com.reserve.restaurant.service.BookServiceImpl;
import com.reserve.restaurant.service.NoticeService;
import com.reserve.restaurant.service.NoticeServiceImpl;
import com.reserve.restaurant.service.OwnerService;
import com.reserve.restaurant.service.OwnerServiceImpl;
import com.reserve.restaurant.service.QnaBoardService;
import com.reserve.restaurant.service.QnaBoardServiceImpl;
import com.reserve.restaurant.service.QnaService;
import com.reserve.restaurant.service.QnaServiceImpl;
import com.reserve.restaurant.service.RestaurantService;
import com.reserve.restaurant.service.RestaurantServiceImpl;
import com.reserve.restaurant.service.ReviewService;
import com.reserve.restaurant.service.ReviewServiceImpl;
import com.reserve.restaurant.service.UserService;
import com.reserve.restaurant.service.UserServiceImpl;

@Configuration
public class ServiceConfig {

	@Bean
	public UserService userService() {
		return new UserServiceImpl();
	}
	
	@Bean
	public NoticeService noticeService() {
		return new NoticeServiceImpl();
	}
	
	@Bean
	public RestaurantService restaurantService() {
		return new RestaurantServiceImpl();
	}
	
	@Bean
	public OwnerService ownerService() {
		return new OwnerServiceImpl();
	}
	
	@Bean
	public QnaService qnaService() {
		return new QnaServiceImpl();
	}
	@Bean
	public BookService bookService() {
		return new BookServiceImpl();
	}
	
	@Bean
	public AdminService adminService() {
		return new AdminServiceImpl(); 
	}
	
	@Bean
	public ReviewService reviewService() {
		return new ReviewServiceImpl();
	}
	
    @Bean
    public QnaBoardService qnaBoardService() {
    	return new QnaBoardServiceImpl();
    }

	
}
