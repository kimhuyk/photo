package com.sp.app.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sp.app.domain.Delivery;
import com.sp.app.domain.SessionInfo;
import com.sp.app.service.DeliveryService;

@Controller
@RequestMapping(value = "delivery")
public class DeliveryController {
	
	@Autowired
	private DeliveryService service;
	
	// list.jsp 페이지 보여주는 역할
	@RequestMapping(value = "list")
	public String delivery(HttpServletRequest req, Model model) throws Exception {
		// Map<String, Object> map = new HashMap<String, Object>();
		
		// List<Delivery> list = service.listDelivery(map);
		// phone이 list<delivery>로 갖고와서 NumberFormatException 오류가 나옴 
		// listDelivery(map) 등록된 값 1개만 보낼려면 밑에방식, 등록된 전체값을 넘길려면 List자체를 넘겨야함 
		// Delivery dto = service.listDelivery(map).get(0); // < 이건 아마도 기본배송지에 쓰면될듯
		// 배송지 리스트
		// model.addAttribute("dto" , list);
		
		return "/delivery/list";
	}
	// datatable json으로 받기
	@PostMapping(value = "listData") 
	@ResponseBody
	public Map<String, Object> listData(HttpSession session) throws Exception {
	    Map<String, Object> result = new HashMap<>();
	    Map<String, Object> params = new HashMap<>();
	    
	    SessionInfo info = (SessionInfo) session.getAttribute("loginUser");
	    if (info == null) {
	    	result.put("data", new ArrayList<>());
	        return result;
	    }
	    params.put("userSeq", info.getUserSeq());
	    
	    List<Delivery> list = service.listDelivery(params);
	    
	    result.put("data", list);
	    
	    return result;
	}
	
	// insert페이지 가져오는 메소드
	@GetMapping(value = "insert")
    public String insertDeliveryForm() {
		return "/delivery/insert"; // JSP 파일 경로
	}
	
	@PostMapping(value = "insert")
	public String insertDelivery(RedirectAttributes rAttr
								 , Model model
								 , HttpSession session
								 , Delivery dto) {
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("loginUser");
			if (info != null) {
	            dto.setUserSeq(info.getUserSeq());
	        } else {
	        	model.addAttribute("message", "로그인이 필요합니다");
	        	return "/home";
	        	
	        }
			service.insertDelivery(dto);
			model.addAttribute("message", "배송지가 등록되었습니다");
			return "/delivery/list";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "배송지 등록중 오류가 발생했습니다" + e.getMessage());
			return "/delivery/list";
		}		
	}
	
	@PostMapping(value = "update")
	public String updateDelivery() {
		
		return "";
	}
	
	@PostMapping(value = "delete")
	public String deleteDelivery() {
		
		return "";
	}

}
