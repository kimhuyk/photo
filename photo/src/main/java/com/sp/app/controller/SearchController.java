package com.sp.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.domain.User;
import com.sp.app.service.SearchService;

@Controller
@RequestMapping(value = "search")
public class SearchController {

	@Autowired
	private SearchService service;

	// 검색
	@PostMapping("")
	public String searchList(@RequestParam(required = false) String userId,
			@RequestParam(required = false) String userName,
			@RequestParam(required = false) String regDate,
			@RequestParam(required = false) String originalfileName, Model model) {

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

		List<User> list = service.searchList(map);

		model.addAttribute("list", list);
		model.addAttribute("userId", userId);
		model.addAttribute("userName", userName);
		model.addAttribute("regDate", regDate);
		model.addAttribute("originalfileName", originalfileName);

		return "home"; // 결과를 표시할 JSP 페이지
	}

}
