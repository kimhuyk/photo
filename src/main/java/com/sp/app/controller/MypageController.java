package com.sp.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("mypage")
public class MypageController {

	//마이페이지 연동 메소드
	@RequestMapping("")
	public String list() throws Exception {
		
		return "/mypage/mypage";
	}
	
	
	///////////////////////////////////////////////////////////////
	//  개인 이용내역 메소드
	@RequestMapping("privacy")
	public String privacy() throws Exception {
		
		return "/mypage/privacy";
	}
	
}
