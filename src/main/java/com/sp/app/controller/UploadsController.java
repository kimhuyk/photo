package com.sp.app.controller;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sp.app.domain.Photo;
import com.sp.app.domain.SessionInfo;
import com.sp.app.service.UploadsService;

@Controller
@RequestMapping(value = "photouploads")
public class UploadsController {
	@Autowired
	private UploadsService service;
	
//	@Autowired
//	private FileManager fileManager;
	
	@RequestMapping("")
	public String list(HttpServletRequest req,
			HttpSession session, Model model) {
	    

		return "uploads/uploads";
	}
	
	@PostMapping("insertPhoto")
	public String insertPhoto(@ModelAttribute Photo dto, HttpServletRequest req, HttpSession session, Model model) {
	    // 세션에서 로그인 정보 가져오기 
	    SessionInfo info = (SessionInfo) session.getAttribute("loginUser");
	    
	    // 로그인 정보가 없거나 세션이 만료된 경우 로그인 페이지로 리다이렉트
	    if (info == null) {
	    	model.addAttribute("message", "로그인이 필요합니다.");
	        return "redirect:/home";
	    }
	    // 로그인 회원 값 넘기기
	    dto.setUserSeq(info.getUserSeq());
	    dto.setUserName(info.getUserName());
	    
	    String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "photo";
		
		System.out.println("파일 저장 경로: " + pathname);
		
		File dir = new File(pathname);
	    if (!dir.exists()) {
	        dir.mkdirs(); // 디렉토리가 없으면 생성
	    }
		
		try {
			service.insertPhoto(dto, pathname);
			model.addAttribute("message", "성공적으로 등록되었습니다.");
			String fileUrl = "/uploads/photo/" + dto.getSavefileName(); //클라이언트에서 접근할 수 있는 URL
			model.addAttribute("fileUrl", fileUrl); // 이 URL을 클라이언트로 전달	//굳이 있어야되나 싶음
			
			return "redirect:/photo";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "등록에 실패했다 이놈아" + e.getMessage());
		}
		return "uploads/uploads";
	}
	
}
