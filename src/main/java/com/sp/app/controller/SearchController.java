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

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sp.app.domain.Search;
import com.sp.app.service.SearchService;

@Controller
@RequestMapping("/search")
public class SearchController {

	@Autowired
	private SearchService service;
	
	@Autowired
	private ObjectMapper objectMapper;

	// 검색
	@GetMapping("list")
	public String searchList(@RequestParam(required = false) String keyword,
			Model model) throws Exception { 

		// keyword가 존재하면 초기 검색 결과를 가져와 모델에 추가
		if (keyword != null && !keyword.isEmpty()) {
			Map<String, Object> map = new HashMap<>();
			map.put("keyword", keyword);
			
			List<Search> searchMain = service.searchAll(map);
			
			// 결과를 JSON 문자열로 변환하여 모델에 추가
			model.addAttribute("searchMainJson", objectMapper.writeValueAsString(searchMain));
			model.addAttribute("keyword", keyword);
		} else {
            // 키워드가 없을 때 빈 JSON 배열을 전달
            model.addAttribute("searchMainJson", "[]");
        }

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
