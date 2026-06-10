package com.sp.app.controller;

import com.sp.app.domain.SessionInfo;
import com.sp.app.domain.SmartChat;
import com.sp.app.service.SmartChatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("smartchat")
public class SmartChatController {

    @Autowired
    private SmartChatService smartChatService;

    // 스마트봇 페이지
    @GetMapping("")
    public String smartChat(HttpSession session, Model model) {
        SessionInfo info = (SessionInfo) session.getAttribute("loginUser");
        if (info == null) return "redirect:/home";
        model.addAttribute("activeMenu", "smartChat");
        return "mypage/smartChat";
    }

    // 대화 내역 조회 Ajax
    @GetMapping("history")
    @ResponseBody
    public List<SmartChat> history(HttpSession session) {
        List<SmartChat> list = new java.util.ArrayList<>();
        try {
            SessionInfo info = (SessionInfo) session.getAttribute("loginUser");
            if (info == null) return list;
            list = smartChatService.chatHistory(info.getUserSeq());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 메시지 전송 Ajax
    @PostMapping("send")
    @ResponseBody
    public Map<String, Object> send(@RequestBody Map<String, String> body,
                                    HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
            SessionInfo info = (SessionInfo) session.getAttribute("loginUser");
            if (info == null) {
                result.put("status", "login");
                return result;
            }
            String userMessage = body.get("message");
            if (userMessage == null || userMessage.trim().isEmpty()) {
                result.put("status", "empty");
                return result;
            }
            String botResponse = smartChatService.chat(info.getUserSeq(), userMessage.trim());
            result.put("status", "ok");
            result.put("response", botResponse);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("status", "error");
        }
        return result;
    }

    // 대화 내역 삭제 Ajax
    @PostMapping("clear")
    @ResponseBody
    public Map<String, Object> clear(HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
            SessionInfo info = (SessionInfo) session.getAttribute("loginUser");
            if (info == null) { result.put("status", "login"); return result; }
            smartChatService.deleteChatHistory(info.getUserSeq());
            result.put("status", "ok");
        } catch (Exception e) {
            e.printStackTrace();
            result.put("status", "error");
        }
        return result;
    }
}
