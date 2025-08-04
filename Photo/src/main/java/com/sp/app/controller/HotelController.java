package com.sp.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("hotel")
public class HotelController {
	
	
	
	@RequestMapping("hotel")
	public String hotel() {
		return "hotel/hotel";
	}
	
	
}
