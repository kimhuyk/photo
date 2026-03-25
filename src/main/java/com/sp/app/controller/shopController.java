package com.sp.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value="shop")
public class shopController {
    //@Autowired
    //private shopService service

    //마이페이지 연동 메소드
    @RequestMapping("shopList")
    public String shopList() throws Exception {

        return "/shop/shop";
    }


}
