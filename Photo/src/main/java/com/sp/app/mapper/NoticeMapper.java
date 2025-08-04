package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.domain.Notice;

@Mapper
public interface NoticeMapper {
	public void insertNotice(Notice dto) throws SQLException;
	public long noticeSeq();
	
	public void updateNotice(Notice dto) throws SQLException;
	public void deleteNotice(long noticeSeq) throws SQLException;
	// 리스트
	public List<Notice> listNotice(Map<String, Object> map);
	// 페이징
	public int dataCount(Map<String, Object> map);
	// 등록된값 불러오는 메소드
	public Notice findbyNotice(long noticeSeq);
	// 검색 이전글 다음글
	public Notice find(long noticeSeq);
	public Notice findByPrev(Map<String, Object> map);
	public Notice findByNext(Map<String, Object> map);

}
