package com.sp.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("mypage")
public class MypageController {

	@RequestMapping("")
	public String list() throws Exception {
		
		return "user/mypage";
	}


}
