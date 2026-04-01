package com.sp.app.controller;

import com.sp.app.domain.Cart;
import com.sp.app.domain.SessionInfo;
import com.sp.app.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("cart")
public class CartController {

    @Autowired
    private CartService cartService;

    // 카트 담기 (Ajax POST)
    @PostMapping("addCart")
    @ResponseBody
    public Map<String, Object> addCart(@RequestBody Cart dto, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
            SessionInfo info = (SessionInfo) session.getAttribute("loginUser");
            if (info == null) {
                result.put("status", "login");
                return result;
            }
            dto.setUserSeq(info.getUserSeq());
            boolean ok = cartService.insertCart(dto);
            result.put("status", ok ? "ok" : "exists");
        } catch (Exception e) {
            e.printStackTrace();
            result.put("status", "error");
        }
        return result;
    }

    // 카트 목록
    @GetMapping("cartListJson")
    @ResponseBody
    public List<Cart> cartListJson(HttpSession session) {
        List<Cart> list = new java.util.ArrayList<>();
        try {
            SessionInfo info = (SessionInfo) session.getAttribute("loginUser");
            if (info == null) return list;
            Map<String, Object> map = new HashMap<>();
            map.put("userSeq", info.getUserSeq());
            list = cartService.cartList(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 카트 삭제 Ajax
    @PostMapping("deleteCart")
    @ResponseBody
    public Map<String, Object> deleteCart(@RequestParam long cartSeq, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
            SessionInfo info = (SessionInfo) session.getAttribute("loginUser");
            if (info == null) {
                result.put("status", "login"); return result;
            }
            cartService.deleteCart(cartSeq);
            result.put("status", "ok");
        } catch (Exception e) {
            e.printStackTrace();
            result.put("status", "error");
        }
        return result;
    }

    // 카트 페이지
    @GetMapping("cartList")
    public String cartList(HttpSession session, Model model) {
        SessionInfo info = (SessionInfo) session.getAttribute("loginUser");
        if (info == null) return "redirect:/home";
        return "cart/cart";
    }
}
