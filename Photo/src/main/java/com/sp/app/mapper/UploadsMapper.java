package com.sp.app.mapper;

import java.sql.SQLException;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.domain.Photo;

@Mapper
public interface UploadsMapper {
	public void insertPhoto(Photo dto) throws SQLException;

	public long photofileSeq();
}
