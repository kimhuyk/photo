package com.sp.app.controller;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.common.MyUtil;
import com.sp.app.domain.Notice;
import com.sp.app.service.NoticeService;

@Controller
@RequestMapping("notice")
public class NoticeController {
	@Autowired
	private MyUtil myUtil;
	
	@Autowired
	private NoticeService service;
	
	@RequestMapping("list")
	public String listNotice(@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String schType,
			@RequestParam(defaultValue = "") String kwd,
			HttpServletRequest req,
			Model model) throws Exception {
		
		String cp = req.getContextPath();
		// 페이지당 몇개 표출할지
		int size = 5;
		int total_page;
		int dataCount;
		
		if (req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
			kwd = URLDecoder.decode(kwd, "utf-8");
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("schType", schType);
		map.put("kwd", kwd);
		
		dataCount = service.dataCount(map);
		total_page = myUtil.pageCount(dataCount, size);
		
		// total_page가 0인 경우에는 1로 설정
	    if (total_page == 0) {
	        total_page = 1;
	    }
		
		// 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
		if (total_page < current_page) {
			current_page = total_page;
		}	
		
		// 리스트에 출력할 데이터를 가져오기
		int offset = (current_page - 1) * size;
		if (offset < 0) offset = 0;
		map.put("offset", offset);
		map.put("size", size);
				
		// 글 리스트
		List<Notice> list = service.listNotice(map);
		
		 // 📌 디버깅 코드 추가 (리스트 데이터 확인)
//	    System.out.println("===== 공지사항 리스트 확인 =====");
//	    if (list == null || list.isEmpty()) {
//	        System.out.println("공지사항 데이터가 없습니다.");
//	    } else {
//	        for (Notice notice : list) {
//	            System.out.println("공지사항 제목: " + notice.getNoticeTitle());
//	            System.out.println("작성자: " + notice.getUserName());
//	            System.out.println("등록일: " + notice.getNoticeRegdate());
//	        }
//	    }
//	    System.out.println("================================");
//	    
//	    System.out.println("======= map 값 확인 =======");
//	    System.out.println("offset: " + map.get("offset"));
//	    System.out.println("size: " + map.get("size"));
//	    System.out.println("===========================");
	    
	    
		String query = "";
		String listUrl = cp + "/notice/list";
		String articleUrl = cp + "/notice/article?page=" + current_page;
		if (kwd.length() != 0) {
			query = "schType=" + schType + "&kwd=" + URLEncoder.encode(kwd, "utf-8");
		}
		
		if (query.length() != 0) {
			listUrl += "?" + query;
			articleUrl = cp + "/notice/article?page=" + current_page + "&" + query;
		}
		
		String paging = myUtil.paging(current_page, total_page, listUrl);
		
		model.addAttribute("list", list);
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("size", size);
		model.addAttribute("total_page", total_page);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("paging", paging);

		model.addAttribute("schType", schType);
		model.addAttribute("kwd", kwd);

		return "notice/list";
	}
	
	@GetMapping("article")
	public String article(@RequestParam long noticeSeq,
			@RequestParam String page,
			@RequestParam(defaultValue = "all") String schType,
			@RequestParam(defaultValue = "") String kwd,
			Model model) throws Exception {
		
		kwd = URLDecoder.decode(kwd, "utf-8");
		
		String query = "page=" + page;
		if (kwd.length() != 0) {
			query += "&schType=" + schType + "&kwd=" + URLEncoder.encode(kwd, "UTF-8");
		}
		
		Notice dto = service.find(noticeSeq);
		if (dto == null) {
			return "redirect:/notice/list?" + query;
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("schType", schType);
		map.put("kwd", kwd);
		map.put("noticeSeq", noticeSeq);
		
		Notice prevDto = service.findByPrev(map);
		Notice nextDto = service.findByNext(map);
		
		// 파일 리스트 넣을거면 여기
		
		model.addAttribute("dto", dto);
		model.addAttribute("prevDto", prevDto);
		model.addAttribute("nextDto", nextDto);
		model.addAttribute("page", page);
		model.addAttribute("query", query);

		return "notice/article";
	}
	
	
	
	
	
	
}
