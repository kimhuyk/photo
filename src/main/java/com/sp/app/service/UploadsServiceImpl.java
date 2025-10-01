package com.sp.app.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.common.FileManager;
import com.sp.app.domain.Photo;
import com.sp.app.mapper.UploadsMapper;
@Service
public class UploadsServiceImpl implements UploadsService{
	@Autowired
	private UploadsMapper mapper;	
	
	@Autowired
	private FileManager fileManager;

	@Override
	public void insertPhoto(Photo dto, String pathname) throws Exception {
		try {
			System.out.println("서비스 진입 시 userSeq: " + dto.getUserSeq());
			long fileNum = mapper.photofileSeq();
			
			dto.setFileNum(fileNum);
			
			String saveFilename = fileManager.doFileUpload(dto.getSelectFile(), pathname);
			if (saveFilename != null) {
				dto.setSavefileName(saveFilename);
				dto.setOriginalfileName(dto.getSelectFile().getOriginalFilename());
				dto.setFilePath(pathname);
				
				mapper.insertPhoto(dto);
			} else {
	            throw new Exception("파일 업로드 실패. 파일 이름이 null입니다.");
	        }
	    } catch (Exception e) {
	        // 예외 발생 시 로그를 더 상세히 남겨서 디버깅
	        System.out.println("파일 업로드 및 DB 삽입 중 오류 발생: " + e.getMessage());
	        e.printStackTrace();
	        throw new Exception("파일 처리 또는 데이터베이스 삽입 중 오류가 발생했습니다.", e); // 원인 추적을 위한 예외 전달
	    }
	}
}
