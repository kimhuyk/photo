package com.sp.app.service;

import com.sp.app.domain.SmartChat;

import java.util.List;

public interface SmartChatService {
    // 사용자 메시지 저장 + 봇 응답 생성 후 저장 → 봇 응답 반환
    String chat(long userSeq, String userMessage) throws Exception;

    // 대화 내역 조회
    List<SmartChat> chatHistory(long userSeq) throws Exception;

    // 대화 내역 삭제
    void deleteChatHistory(long userSeq) throws Exception;
}
