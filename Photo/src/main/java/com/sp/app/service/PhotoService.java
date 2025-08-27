package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.domain.Photo;

public interface PhotoService {
	// 메인 사진리스트 두개가 세트 
	List<Photo> listPhoto(Map<String, Object>map);
//	List<Photo> listPhoto(long fileNum);  사진,올린사람 디버깅용
	List<Photo> loadPhoto(long fileNum);	
	//찾기 
	public Photo findById(long userSeq);
	// 사진 다운로드
	public Photo findByPhoto(long fileNum);
	
	public Photo findByPrev(Map<String, Object> map);                                                     
	public Photo findByNext(Map<String, Object> map);
	
	public void deletePhoto(long fileNum, String pathname, String userSeq) throws Exception;
	
}
