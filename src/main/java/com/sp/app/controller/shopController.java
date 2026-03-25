package com.sp.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value="shop")
public class shopController {




    //마이페이지 연동 메소드
    @RequestMapping("shoplist")
    public String shop() throws Exception {

        return "/shop/shop";
    }


}
