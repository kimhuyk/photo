package com.sp.app.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("story")
public class StoryController {
	
	//@Autowired
	//private NoticeService service;
	
	@Autowired
    private ServletContext servletContext; // Webapp 경로 가져오기
	
	// 공지사항 리스트
	@RequestMapping("story.do")
	public String listNotice(
			HttpServletRequest req,
			Model model) throws Exception {
		
		// 동적으로 Webapp 경로 가져오기
        String folderPath = servletContext.getRealPath("/resources/images/story"); 
        File folder = new File(folderPath);

        List<String> imageList = new ArrayList<>();
        if (folder.exists() && folder.isDirectory()) {
            for (File file : folder.listFiles()) {
                if (file.isFile() && file.getName().matches(".*\\.(jpg|png|gif|jpeg)$")) {
                    imageList.add(file.getName()); // 파일 이름만 저장
                }
            }
        }
        
        model.addAttribute("imageList", imageList);
        
		return "story/list";
	}
	
}
