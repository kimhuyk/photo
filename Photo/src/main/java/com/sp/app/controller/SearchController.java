package com.sp.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.domain.Search;
import com.sp.app.domain.User;
import com.sp.app.service.SearchService;

@Controller
@RequestMapping("/search")
public class SearchController {

	@Autowired
	private SearchService service;

	// 검색
	@GetMapping("list")
	public String searchList(@RequestParam(required = false) String userId,
			@RequestParam(required = false) String userName,
			@RequestParam(required = false) String regDate,
			@RequestParam(required = false) String originalfileName,
			@RequestParam(required = false) String keyword,
			 Model model) {

		Map<String, Object> map = new HashMap<>();

		if (userId != null && !userId.isEmpty()) {
			map.put("userId", userId);
		}
		if (userName != null && !userName.isEmpty()) {
			map.put("userName", userName);
		}
		if (regDate != null && !regDate.isEmpty()) {
			map.put("regDate", regDate);
		}
		if (originalfileName != null && !originalfileName.isEmpty()) {
			map.put("originalfileName", originalfileName);
		}
		// keyword가 존재하면 모델에 추가하여 JSP로 전달
	    if (keyword != null && !keyword.isEmpty()) {
	        model.addAttribute("keyword", keyword);
	    }

		List<User> list = service.searchList(map);

		model.addAttribute("list", list);
		model.addAttribute("userId", userId);
		model.addAttribute("userName", userName);
		model.addAttribute("regDate", regDate);
		model.addAttribute("originalfileName", originalfileName);
		
		return "/search/search"; 
	}
	
	
	@RequestMapping (value = "/results")
	@ResponseBody
	public List<Search> searchAll(@RequestParam(name = "keyword", defaultValue = "") String keyword) {
		List<Search> results = null;
		try {
            Map<String, Object> map = new HashMap<>();
            
            map.put("keyword", keyword);
            
			results = service.searchAll(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return results;
	}
	
	
	

}
