
package com.reserve.restaurant.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.reserve.restaurant.domain.UploadFile;

@Mapper
public interface UploadFileRepository {

	public int fileInsert(UploadFile uploadFile);
	public int deleteFile(Long fileNo);
	public List<UploadFile> selectFile(Long resNo);
	
}