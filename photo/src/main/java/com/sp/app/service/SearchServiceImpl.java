package com.sp.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.domain.User;
import com.sp.app.mapper.SearchMapper;
@Service
public class SearchServiceImpl implements SearchService{
	@Autowired
	private SearchMapper mapper;
	
	@Override
	public List<User> searchList(Map<String, Object> map) {
		List<User> list = null;
		try {
			list = mapper.searchList(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

}
