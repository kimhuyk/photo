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
	public void deleteNotice(long boardSeq) throws SQLException;
	// 리스트
	public List<Notice> listNotice(Map<String, Object> map);
	// 페이징
	public int dataCount(Map<String, Object> map);
	// 검색 이전글 다음글
	public Notice find(long boardSeq);
	public Notice findByPrev(Map<String, Object> map);
	public Notice findByNext(Map<String, Object> map);

}
