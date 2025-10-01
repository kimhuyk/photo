package com.sp.app.service;

import com.sp.app.domain.Photo;

public interface UploadsService {
	// 싹다 uploads로 옮겨야댐
		public void insertPhoto(Photo dto, String pathname) throws Exception;
}
