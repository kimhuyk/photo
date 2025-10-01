package com.sp.app.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.sp.app.domain.Notice;

public interface NoticeService {
	public void insertNotice(Notice dto) throws SQLException;
	public void updateNotice(Notice dto) throws SQLException;
	public void deleteNotice(long noticeSeq) throws SQLException;
	// 리스트
	public List<Notice> listNotice(Map<String, Object> map);
	// 페이징
	public int dataCount(Map<String, Object> map);
	// 등록된 값 불러오기
	public Notice findbyNotice(long noticeSeq);
	// 글보기 불러오기 이전글 다음글
	public Notice find(long noticeSeq);
	public Notice findByPrev(Map<String, Object> map);
	public Notice findByNext(Map<String, Object> map);
}
