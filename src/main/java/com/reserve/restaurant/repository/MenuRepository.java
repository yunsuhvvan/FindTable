
package com.reserve.restaurant.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.reserve.restaurant.domain.Menu;

@Mapper
public interface MenuRepository {

	public void addMenu(Menu menu);
	public List<Menu> selectMenu(Long resNo);
	public int menuDelete(Long menuNo);
	public int modifyMenu(Menu menu);
}