package com.sp.app.controller;

import com.sp.app.domain.SessionInfo;
import com.sp.app.service.OrderService;
import com.sp.app.service.TossPayService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("toss")
public class TossPayController {

    @Autowired
    private TossPayService tossPayService;

    @Autowired
    private OrderService orderService;

    // 결제 성공 콜백
    @GetMapping("success")
    public String success(@RequestParam String paymentKey,
                          @RequestParam String orderId,
                          @RequestParam long amount,
                          HttpSession session, Model model) {
        try {
            SessionInfo info = (SessionInfo) session.getAttribute("loginUser");
            if (info == null) return "redirect:/home";

            // 토스 결제 승인 API 호출
            boolean approved = tossPayService.confirmPayment(paymentKey, orderId, amount);
            if (!approved) {
                model.addAttribute("errorMsg", "결제 승인에 실패했습니다.");
                return "order/fail";
            }

            String[] parts = orderId.split("_");
            long deNum = Long.parseLong(parts[1]);
            long orderSeq = orderService.placeOrder(info.getUserSeq(), deNum);

            return "redirect:/order/complete?orderSeq=" + orderSeq;

        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("errorMsg", e.getMessage());
            return "order/fail";
        }
    }

    // 결제 실패 콜백
    @GetMapping("fail")
    public String fail(@RequestParam(required = false) String message,
                       @RequestParam(required = false) String code,
                       Model model) {
        model.addAttribute("errorMsg", message);
        model.addAttribute("errorCode", code);
        return "order/fail";
    }

    // 결제 취소 콜백
    @GetMapping("cancel")
    public String cancel() {
        return "redirect:/order/checkout";
    }
}
