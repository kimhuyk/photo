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
import org.springframework.web.bind.annotation.RequestParam;
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
	@GetMapping(value = "list")
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
	
	// 등록 페이지 가져오는 메소드, 명칭은 insert지만 update랑 같은 메소드
	@RequestMapping(value = "insert")
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
	        	return "redirect:/home";
	        	
	        }
			service.insertDelivery(dto);
			model.addAttribute("message", "배송지가 등록되었습니다");
			// redirect를 사용안하고 return을 사용할시 post 요청 후 브라우저가 이전요청을 그대로
			// 다시 보내서 연속 insert 발생 그래서 redirect로 수정
			return "redirect:/delivery/list";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "배송지 등록중 오류가 발생했습니다" + e.getMessage());
			return "redirect:/delivery/list";
		}		
	}
	// insert 된 배송지 정보 들고오는 form
	@PostMapping("updateForm")					// long으로 바꿔도 상관x
	public String updateDeliveryForm(@RequestParam int deNum, Model model) {
		try {
			Delivery dto = service.findByAddress(deNum);
			
			model.addAttribute("dto", dto);
			model.addAttribute("mode", "update");
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "배송지 정보 조회 중 오류가 발생했습니다.");
		}
		
		return "/delivery/insert"; 
	}
	
	@PostMapping(value = "update")
	public String updateDelivery(RedirectAttributes rAttr
			 , Model model
			 , HttpSession session
			 , Delivery dto) {
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("loginUser");
			if (info != null) {
	            dto.setUserSeq(info.getUserSeq());
	        } else {
	        	rAttr.addFlashAttribute("message", "로그인이 필요합니다.");
	        	return "/home";
	        }
			service.updateDelivery(dto);
			rAttr.addFlashAttribute("message", "배송지 정보가 정상적으로 수정되었습니다.");
			return "/delivery/list";
		} catch (Exception e) {
			e.printStackTrace();
			rAttr.addFlashAttribute("message", "배송지 수정 중 오류가 발생했습니다.");
		}
		return "/delivery/list";
	}
	
	@PostMapping(value = "delete")
	@ResponseBody 
	public Map<String, Object> deleteDelivery(@RequestParam("deNum") long deNum,
	                                          HttpSession session) {
	    Map<String, Object> result = new HashMap<>();
	    
	    try {
	        // 로그인 체크
	        SessionInfo info = (SessionInfo) session.getAttribute("loginUser");
	        if (info == null) {
	            result.put("success", false);
	            result.put("message", "로그인이 필요합니다.");
	            return result;
	        }

	        // 유저 검증 (선택 사항)
	        // 서비스에서 해당 유저의 배송지인지 체크 가능
	        // dto.setUserSeq(info.getUserSeq());

	        service.deleteDelivery(deNum);

	        result.put("success", true);
	        result.put("message", "주소가 삭제되었습니다.");

	    } catch (Exception e) {
	        e.printStackTrace();
	        result.put("success", false);
	        result.put("message", "주소 삭제 중 오류가 발생했습니다.");
	    }

	    return result;
	}

}
