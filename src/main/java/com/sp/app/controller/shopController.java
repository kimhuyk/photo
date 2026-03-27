package com.sp.app.controller;

import com.sp.app.domain.Item;
import com.sp.app.service.ItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value="shop")
public class shopController {

    @Autowired
    private ItemService service;

    //마이페이지 연동 메소드
    @GetMapping("shoplist")
    public String shopList(Model model) {
        try {
            Map<String, Object> map = new HashMap<>();
            model.addAttribute("itemList", service.shopList(map));
            System.out.println("user.dir: " + System.getProperty("user.dir"));
            System.out.println("upload exists: " + new java.io.File(System.getProperty("user.dir") + "/uploads/shop").exists());
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("message", "목록 조회 중 오류 발생");
        }
        return "shop/shop";
    }

    @GetMapping("shopListJson")
    @ResponseBody
    public List<Item> shopListJson() {
        try {
            Map<String, Object> map = new HashMap<>();
            return service.shopList(map);
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    @GetMapping("image")
    public void shopImage(@RequestParam String saveFileName,
                          HttpServletResponse resp) {
        try {
            // DB filePath 없이 itemSeq로 조회해서 filePath 가져오기
            Map<String, Object> map = new HashMap<>();
            List<Item> list = service.shopList(map);
            String filePath = null;
            for (Item item : list) {
                if (saveFileName.equals(item.getSaveFileName())) {
                    filePath = item.getFilePath();
                    break;
                }
            }
            if (filePath == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }
            File file = new File(filePath + File.separator + saveFileName);
            if (!file.exists()) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }
            String ext = saveFileName.substring(saveFileName.lastIndexOf(".") + 1).toLowerCase();
            String contentType = ext.equals("png") ? "image/png" : ext.equals("gif") ? "image/gif" : "image/jpeg";
            resp.setContentType(contentType);
            try (FileInputStream fis = new FileInputStream(file);
                 OutputStream os = resp.getOutputStream()) {
                byte[] buf = new byte[8192];
                int len;
                while ((len = fis.read(buf)) != -1) os.write(buf, 0, len);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

/*    백단 (Java)
    ItemMapper.java      <- 쿼리 인터페이스 통합
    itemMapper.xml       <- 쿼리 통합
    ItemService.java     <- 서비스 인터페이스 통합
    itemServiceImpl.java <- 서비스 구현 통합
    ItemInsertController <- 등록 컨트롤러
    ShopController       <- 목록/상세/다운로드 컨트롤러 (읽기 전용)

    프론트 (JSP)
    item/iteminsert.jsp  <- 등록 페이지
    shop/shoplist.jsp    <- 목록 페이지
    shop/shopdetail.jsp  <- 상세 페이지 (나중에)
*/
}
