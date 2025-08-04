package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.domain.Photo;

@Mapper
public interface PhotoMapper {
	// 사진리스트
	List<Photo> listPhoto(Map<String, Object>map);
	List<Photo> listPhoto(long fileNum);
	List<Photo> loadPhoto(long fileNum);
	List<Photo> selectAllPhotos();
	
	public void insertPhoto(Photo dto) throws SQLException;
	public long photofileSeq();
	
	public void deletePhoto(long fileNum) throws SQLException;

	public Photo findById(long userSeq);
	public Photo findByPhoto(long fileNum);

	public Photo findByPrev(Map<String, Object> map);                                                     
	public Photo findByNext(Map<String, Object> map);
}
