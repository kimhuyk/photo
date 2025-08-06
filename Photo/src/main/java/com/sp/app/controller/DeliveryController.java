package com.sp.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "delivery")
public class DeliveryController {
	
	
	@RequestMapping(value = "list")
	public String delivery() {
		
		return "/delivery/delivery";
	}
	
	@PostMapping(value = "insert")
	public String deliveryInsert() {
		
		return "/delivery/insert";
	}
	
	

}
