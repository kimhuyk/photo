package com.sp.app.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sp.app.common.BCryptUtil;
import com.sp.app.domain.SessionInfo;
import com.sp.app.domain.User;
import com.sp.app.service.LoginService;

@Controller
@RequestMapping(value = "login")
public class LoginController {
	@Autowired
	private LoginService service;
	
	@RequestMapping("login")
	public String loginForm() {
		return "home";
	}
	
	@PostMapping("login")
    @ResponseBody
    public String loginSubmit(
            @RequestParam String userId,
            @RequestParam String userPwd,
            HttpSession session,
            Model model) {

        User dto = service.loginUser(userId);
        System.out.println("DB 조회 결과: " + dto);
        if (dto == null || !BCryptUtil.matches(userPwd, dto.getUserPwd())) {
        	model.addAttribute("message", "아이디 또는 패스워드가 일치하지 않습니다.");
        	System.out.println("로그인실패: " + userId);
        	System.out.println("로그인실패: " + userPwd);

            return "fail"; // 로그인 실패
        }

        // 세션에 로그인 정보 저장
        SessionInfo info = new SessionInfo();
        info.setUserSeq(dto.getUserSeq());
        info.setUserId(dto.getUserId());
        info.setUserName(dto.getUserName());
        info.setEmail(dto.getEmail());
        info.setTel(dto.getTel());

        session.setMaxInactiveInterval(30 * 60); // 세션 유지 시간 30분
        session.setAttribute("loginUser", info);
        System.out.println("세션 저장 완료: " + info.getUserId()); // 로그 출력
        return "success"; // 로그인 성공
    }


	@GetMapping(value = "logout")
	public String logout(HttpSession session, RedirectAttributes redirectAttributes) {
		// 세션에 저장된 정보 지우기
		session.removeAttribute("loginUser"); 

		// 세션에 저장된 모든 정보 지우고, 세션초기화
		session.invalidate();
	    redirectAttributes.addFlashAttribute("logoutMessage", "로그아웃 되었습니다.");
		return "redirect:/home";
	}
	
	
	
	
}
