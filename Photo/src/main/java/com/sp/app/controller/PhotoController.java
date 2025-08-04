package com.sp.app.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.common.FileManager;
import com.sp.app.domain.Photo;
import com.sp.app.domain.SessionInfo;
import com.sp.app.service.PhotoService;

@Controller
@RequestMapping(value = "photo")
public class PhotoController {
	@Autowired
	private PhotoService service;
	
	@Autowired
	private FileManager fileManager;
	
	@Autowired
    private ServletContext servletContext;
	
	@RequestMapping("")
	public String list(HttpServletRequest req, Model model) throws Exception {
		
		String folderPath = servletContext.getRealPath("/resources/images/uploads"); 
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
		
		return "photo/photo";
	}
	
	@GetMapping("download")
	public String download(@RequestParam long fileNum,
	        HttpServletRequest req, HttpServletResponse resp,
	        HttpSession session) throws Exception {

	    String root = session.getServletContext().getRealPath("/");
	    String pathname = root + "uploads" + File.separator + "photo";

	    System.out.println("fileNum: " + fileNum);  // 디버깅
	    Photo dto = service.findByPhoto(fileNum);
	    System.out.println("dto: " + dto); // DTO가 제대로 조회되는지 확인

	    if (dto != null) {
	        File file = new File(pathname, dto.getSavefileName());
	        System.out.println("파일 존재 여부: " + file.exists()); // 파일이 존재하는지 확인

	        boolean b = fileManager.doFileDownload(dto.getSavefileName(),
	                dto.getOriginalfileName(), pathname, resp);
	        if (b) {
	            return null;
	        } else {
	            System.err.println("파일 다운로드 실패: " + dto.getSavefileName());
	        }
	    } else {
	        System.err.println("해당 fileNum(" + fileNum + ")에 대한 파일 정보 없음");
	    }

	    return "error/filedownloadFailure";
	}
	
	// 사진 상세정보 들고오기, 이전사진 다음사진
	@RequestMapping(value = "/loadPhoto.do", 
            method = RequestMethod.GET, 
            produces = "application/json; charset=UTF-8")
	@ResponseBody
	public List<Photo> loadPhoto(@RequestParam(value = "fileNum", required = false) Long fileNum) {
	    List<Photo> results = null;
	    try {
	        if (fileNum == null) {
	            // fileNum이 null인 경우 기본 처리
	            System.out.println("fileNum 널이에용,,,,");
	            fileNum = 1L;  // 기본값으로 처리 (예: 1L)
	        }
	        
	        results = service.loadPhoto(fileNum);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return results;
	}
		
	@PostMapping("deletePhoto")
	public String deletePhoto(@RequestParam long fileNum,
			HttpSession session, Model model) throws Exception {
	
		SessionInfo info = (SessionInfo) session.getAttribute("loginUser");
		
		if (info.getUserSeq() != 1) {
	        return "redirect:/home"; 
	    }
	
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "photo";
		
		try {
			service.deletePhoto(fileNum, pathname, info.getUserId());	// session info에서 userid사용해서 id로
			model.addAttribute("message", "사진이 삭제되었습니다.");       
	        return "redirect:/photo";
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/photo";
	}
	
	
}
