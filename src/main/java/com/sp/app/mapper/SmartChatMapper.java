package com.sp.app.mapper;

import com.sp.app.domain.SmartChat;
import org.apache.ibatis.annotations.Mapper;

import java.sql.SQLException;
import java.util.List;

@Mapper
public interface SmartChatMapper {
    // 대화 저장
    void insertChat(SmartChat dto) throws SQLException;

    // 대화 내역 조회 (userSeq 기준, 최신 50건)
    List<SmartChat> chatHistory(long userSeq) throws SQLException;

    // 대화 내역 전체 삭제 (userSeq 기준)
    void deleteChatHistory(long userSeq) throws SQLException;
}
