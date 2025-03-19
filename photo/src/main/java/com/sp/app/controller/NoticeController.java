package com.sp.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("notice")
public class NoticeController {
	
	@RequestMapping("")
	public String list() {
		
		return "notice/notice";
	}
}
