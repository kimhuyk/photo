package com.sp.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("mypage")
public class MypageController {

    @RequestMapping("")
    public String list(Model model) throws Exception {
        model.addAttribute("activeMenu", "mypage");
        return "/mypage/mypage";
    }

    @RequestMapping("privacy")
    public String privacy(Model model) throws Exception {
        model.addAttribute("activeMenu", "privacy");
        return "/mypage/privacy/privacy";
    }

    @RequestMapping("security")
    public String security(Model model) throws Exception {
        model.addAttribute("activeMenu", "security");
        return "/mypage/security/security";
    }

    @RequestMapping("buyPhoto")
    public String buyPhoto(Model model) throws Exception {
        model.addAttribute("activeMenu", "buyPhoto");
        return "/mypage/buyPhoto";
    }

    @RequestMapping("userTalk")
    public String userTalk(Model model) throws Exception {
        model.addAttribute("activeMenu", "userTalk");
        return "/mypage/userTalk";
    }
}