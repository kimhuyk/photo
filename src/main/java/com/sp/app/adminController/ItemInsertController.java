package com.sp.app.adminController;

import java.io.File;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.sp.app.common.FileManager;
import com.sp.app.domain.Item;
import com.sp.app.domain.SessionInfo;
import com.sp.app.service.ItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("admin")
public class ItemInsertController {
	
	@Autowired
	private ItemService service;

  @Autowired
  private FileManager fileManager;


  @GetMapping("insertShop")
  public String insertShopForm() {
      return "item/iteminsert";
  }

	// 공지사항 리스트
	@PostMapping("insertShop")
	public String insertShop(@ModelAttribute Item dto,
	                         @RequestParam(value = "subImages", required = false) List<MultipartFile> subImages,
	                         HttpServletRequest req, HttpSession session, Model model, RedirectAttributes redirectAttributes) throws Exception {

      SessionInfo info = (SessionInfo) session.getAttribute("loginUser");
      if (info == null) {
          model.addAttribute("message", "로그인이 필요합니다.");
          return "redirect:/home";
      }
      dto.setUserSeq(info.getUserSeq());
      dto.setUserName(info.getUserName());

      // subImages는 @RequestParam으로 직접 받아서 service에 바로 전달

      // SHOP페이지
      String root = session.getServletContext().getRealPath("/");
      String pathname = root + "uploads" + File.separator + "shop";

      File dir = new File(pathname);
      if (!dir.exists()) {
          dir.mkdirs();
      }

      try {
          service.insertShop(dto, subImages, pathname);
          model.addAttribute("Message", "등록 되었습니다.");
          return "redirect:/shop/shoplist";

      } catch (Exception e) {
          e.printStackTrace();
          model.addAttribute("message", "등록실패" + e.getMessage());
      }
      return "item/iteminsert";

  }
	
}
