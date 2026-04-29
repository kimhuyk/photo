package com.sp.app.controller;

import com.sp.app.domain.OrderDetail;
import com.sp.app.domain.OrderMaster;
import com.sp.app.domain.SessionInfo;
import com.sp.app.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("order")
public class OrderController {

    @Autowired
    private OrderService orderService;

    // 토스 클라이언트 키
    private static final String TOSS_CLIENT_KEY = "클라이언트 키";

    // Checkout 페이지
    @GetMapping("checkout")
    public String checkout(HttpSession session, Model model) {
        SessionInfo info = (SessionInfo) session.getAttribute("loginUser");
        if (info == null) return "redirect:/home";
        model.addAttribute("tossClientKey", TOSS_CLIENT_KEY);
        return "order/checkout";
    }

    // 주문 확정 (order/placeOrder)
    @PostMapping("placeOrder")
    @ResponseBody
    public Map<String, Object> placeOrder(@RequestBody Map<String, Object> body,
                                          HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
            SessionInfo info = (SessionInfo) session.getAttribute("loginUser");
            if (info == null) {
                result.put("status", "login");
                return result;
            }

            long deNum = Long.parseLong(body.get("deNum").toString());
            long orderSeq = orderService.placeOrder(info.getUserSeq(), deNum);

            result.put("status", "ok");
            result.put("orderSeq", orderSeq);

        } catch (Exception e) {
            e.printStackTrace();
            result.put("status", "error");
            result.put("message", e.getMessage());
        }
        return result;
    }

    // 주문 완료 페이지
    @GetMapping("complete")
    public String complete(@RequestParam(required = false) Long orderSeq,
                           HttpSession session, Model model) {
        SessionInfo info = (SessionInfo) session.getAttribute("loginUser");
        if (info == null) return "redirect:/home";
        model.addAttribute("orderSeq", orderSeq);
        return "order/complete";
    }

    // 주문 목록 (마이페이지용)
    @GetMapping("orderListJson")
    @ResponseBody
    public List<OrderMaster> orderListJson(HttpSession session) {
        try {
            SessionInfo info = (SessionInfo) session.getAttribute("loginUser");
            if (info == null) return new java.util.ArrayList<>();
            Map<String, Object> map = new HashMap<>();
            map.put("userSeq", info.getUserSeq());
            return orderService.orderList(map);
        } catch (Exception e) {
            e.printStackTrace();
            return new java.util.ArrayList<>();
        }
    }

    // 주문 상세 (마이페이지용)
    @GetMapping("orderDetailJson")
    @ResponseBody
    public List<OrderDetail> orderDetailJson(@RequestParam long orderSeq,
                                             HttpSession session) {
        try {
            SessionInfo info = (SessionInfo) session.getAttribute("loginUser");
            if (info == null) return new java.util.ArrayList<>();
            return orderService.orderDetailList(orderSeq);
        } catch (Exception e) {
            e.printStackTrace();
            return new java.util.ArrayList<>();
        }
    }
}
