package com.sp.app.service;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.domain.Photo;
import com.sp.app.mapper.PhotoMapper;

@Service
public class PhotoServiceImpl implements PhotoService{
	@Autowired
	private PhotoMapper mapper;

	
	@Override
	public Photo findById(long userSeq) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Photo findByPhoto(long fileNum) {
		Photo dto = null;
		
		try {
			dto = mapper.findByPhoto(fileNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public Photo findByPrev(Map<String, Object> map) {
		Photo dto = null;
			try {
				dto = mapper.findByPrev(map);
			} catch (Exception e) {
				e.printStackTrace();
			}
		return dto;
	}

	@Override
	public Photo findByNext(Map<String, Object> map) {
		Photo dto = null;
		
		try {
			dto = mapper.findByNext(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	@Override
	public List<Photo> listPhoto(Map<String, Object> map) {
		List<Photo> list = null;
		try {
			list = mapper.listPhoto(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

//	@Override
//	public List<Photo> listPhoto(long fileNum) {
//		try {
//			return mapper.listPhoto(fileNum);
//		} catch (Exception e) {
//			e.printStackTrace();
//			return Collections.emptyList(); 
//		}
//	}

	@Override
	public List<Photo> loadPhoto(long fileNum) {
		try {
			return mapper.loadPhoto(fileNum);
		} catch (Exception e) {
			e.printStackTrace();
			return Collections.emptyList();
		}

	}

	@Override
	public void deletePhoto(long fileNum, String pathname, String userSeq) throws Exception {
		try {
			mapper.deletePhoto(fileNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}


	
}
