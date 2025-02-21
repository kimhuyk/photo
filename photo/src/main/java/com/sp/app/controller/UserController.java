package com.sp.app.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sp.app.domain.SessionInfo;
import com.sp.app.domain.User;
import com.sp.app.service.UserService;

@Controller
@RequestMapping(value = "user")
public class UserController {
	@Autowired
	private UserService service;
	
	@RequestMapping("")
	public String userForm(Model model) {
		model.addAttribute("user", "user");
		return "user/user";
	}
	
	// 회원 가입 완료 
		@PostMapping("user")
		public String userSubmit(User dto,
				final RedirectAttributes rAttr,
				Model model) {
			try {
				service.insertUser(dto);
			} catch (DuplicateKeyException e) {
				model.addAttribute("mode", "user");
				model.addAttribute("message", "등록된 아이디 입니다.");
				return "/user/user";
			} catch (DataIntegrityViolationException e) {
				model.addAttribute("mode", "member");
				model.addAttribute("message", "제약조건 위반 입니다.");
				return "/user/user";
			} catch (Exception e) {
				model.addAttribute("mode", "member");
				model.addAttribute("message", "회원 가입이 실패 했습다.");
				return "/user/user";
			}
			
			StringBuilder sb = new StringBuilder();
			sb.append("<strong>" + dto.getUserName() + "</strong>님의 회원가입이 정상적으로 처리 되었습니다.<br>");
			sb.append("메인화면으로 이동하여 로그인하시기 바랍니다.<br>");
			
			rAttr.addFlashAttribute("message", sb.toString());
			rAttr.addFlashAttribute("title", "회원 가입");
			
			//return "redirect:/user/complete";
			return "redirect:/user/complete";
		}
			
		
		// 회원 가입 완료후 메시지 출력
		@GetMapping("complete")
	    public String complete(@ModelAttribute("message") String message) throws Exception {

	        // 컴플릿 페이지(complete.jsp)의 출력되는 message와 title는 RedirectAttributes 값이다.
	        // F5를 눌러 새로 고침을 하면 null이 된다.

	        if (message == null || message.length() == 0) // F5를 누른 경우
	            return "redirect:/";

	        return "/user/complete";
	    }
	
	
		// ID 중복 검사
		@PostMapping("user_idCheck")
		@ResponseBody
		public Map<String, Object> idCheck(@RequestParam String userId) {
		
			String p = "true";
			User dto = service.findById(userId);
		
			if (dto != null) {
				p = "false";
			}
			Map<String, Object> model = new HashMap<>();
			model.put("passed", p);
			
			return model;
		}
		// 비밀번호 확인 후 정보수정하러 넘어가기
		@PostMapping("pwd")
		public String pwdSubmit(@RequestParam String userPwd,
				@RequestParam String mode,
				final RedirectAttributes rAttr,
				HttpSession session,
				Model model) {
			
			SessionInfo info = (SessionInfo)session.getAttribute("loginUser");
			User dto = service.findById(info.getUserId());
			
			if(dto == null) {
				session.invalidate();
				return "redirect:/";
			} 

			if(! dto.getUserPwd().equals(userPwd)) {
				model.addAttribute("mode", mode);
				model.addAttribute("message", "패스워드가 일치하지 않습니다.");
				
				return "/user/pwd";
			}
			model.addAttribute("dto", dto);
			model.addAttribute("mode", "update");
			
			return "/user/user";
			
		}
		
		
}
