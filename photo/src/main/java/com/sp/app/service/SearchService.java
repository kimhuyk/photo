package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.domain.User;

public interface SearchService {
	
	// 오직 검색만을 위한
	List<User> searchList(Map<String, Object> map);
}
