package com.sp.app.service.serviceImpl;

import com.sp.app.domain.SmartChat;
import com.sp.app.mapper.SmartChatMapper;
import com.sp.app.service.SmartChatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SmartChatServiceImpl implements SmartChatService {

    @Autowired
    private SmartChatMapper mapper;

    @Override
    public String chat(long userSeq, String userMessage) throws Exception {
        try {
            // 1. 사용자 메시지 저장
            SmartChat userChat = new SmartChat();
            userChat.setUserSeq(userSeq);
            userChat.setSender("user");
            userChat.setMessage(userMessage);
            mapper.insertChat(userChat);

            // 2. 봇 응답 생성
            String botResponse = generateResponse(userMessage);

            // 3. 봇 응답 저장
            SmartChat botChat = new SmartChat();
            botChat.setUserSeq(userSeq);
            botChat.setSender("bot");
            botChat.setMessage(botResponse);
            mapper.insertChat(botChat);

            return botResponse;
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public List<SmartChat> chatHistory(long userSeq) throws Exception {
        List<SmartChat> list = null;
        try {
            list = mapper.chatHistory(userSeq);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
        return list;
    }

    @Override
    public void deleteChatHistory(long userSeq) throws Exception {
        try {
            mapper.deleteChatHistory(userSeq);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    /**
     * 키워드 기반 응답 생성
     * 나중에 AI API 교체할 메서드
     */
    private String generateResponse(String message) {
        String msg = message.toLowerCase().trim();

        // 인사
        if (contains(msg, "안녕", "hello", "hi", "반가워", "처음")) {
            return "안녕하세요! photoID 스마트봇입니다. 무엇을 도와드릴까요? 😊";
        }
        // 주문/결제
        if (contains(msg, "주문", "결제", "구매", "order", "pay")) {
            return "주문 관련 문의시 마이페이지 → 구매한 사진에서 주문 내역을 확인하실 수 있습니다. 결제 오류 발생 시 고객센터로 문의 부탁드립니다.";
        }
        // 다운로드
        if (contains(msg, "다운", "download", "저장")) {
            return "구매한 사진은 마이페이지 → 구매한 사진 보기에서 다운로드하실 수 있습니다. 다운로드 버튼을 클릭해 주세요!";
        }
        // 배송
        if (contains(msg, "배송", "delivery", "받아")) {
            return "photoID는 디지털 다운로드 상품으로 별도의 배송이 없습니다. 결제 완료 후 즉시 다운로드 가능합니다.";
        }
        // 환불
        if (contains(msg, "환불", "취소", "refund", "cancel")) {
            return "디지털 상품 특성상 다운로드 완료 후에는 환불이 어렵습니다. 미다운로드 상태에서의 환불은 고객센터로 문의 부탁드립니다.";
        }
        // 가격
        if (contains(msg, "가격", "가", "price", "얼마", "비용")) {
            return "상품별 가격은 Shop 페이지에서 확인하실 수 있습니다. 모든 가격은 VAT 별도입니다.";
        }
        // 회원가입/로그인
        if (contains(msg, "회원가입", "로그인", "가입", "계정", "비밀번호")) {
            return "회원가입은 상단 메뉴에서 진행하실 수 있습니다. 비밀번호 변경은 마이페이지 → 보안설정에서 가능합니다.";
        }
        // 사진/상품
        if (contains(msg, "사진", "상품", "photo", "image", "bundle")) {
            return "다양한 고화질 사진 번들을 Shop 페이지에서 만나보세요! 카테고리별로 필터링하여 원하는 상품을 찾을 수 있습니다.";
        }
        // 감사
        if (contains(msg, "감사", "고마워", "thanks", "thank")) {
            return "도움이 되었다니 기쁩니다! 추가로 궁금한 점이 있으시면 언제든지 질문해 주세요 😊";
        }
        // 도움말
        if (contains(msg, "도움", "help", "뭐", "어떻게", "알려줘")) {
            return "다음 내용에 대해 도움을 드릴 수 있어요!\n\n" +
                   "📦 주문/결제 문의\n" +
                   "⬇️ 다운로드 방법\n" +
                   "💰 환불/취소 정책\n" +
                   "🖼️ 상품 정보\n" +
                   "🔐 계정/보안 설정\n\n" +
                   "궁금한 점을 입력해 주세요!";
        }

        // 기본 응답
        return "죄송합니다, 해당 내용은 제가 답변드리기 어렵습니다. 더 자세한 문의는 고객센터를 이용해 주세요.";
    }

    private boolean contains(String message, String... keywords) {
        for (String kw : keywords) {
            if (message.contains(kw)) return true;
        }
        return false;
    }
}
