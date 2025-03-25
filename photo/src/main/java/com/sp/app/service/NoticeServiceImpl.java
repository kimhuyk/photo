package com.sp.app.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.domain.Notice;
import com.sp.app.mapper.NoticeMapper;

@Service
public class NoticeServiceImpl implements NoticeService{
	@Autowired
	private NoticeMapper mapper;
	@Override
	public void insertNotice(Notice dto) throws SQLException {
		try {
			long boardSeq = mapper.noticeSeq();
			dto.setNoticeSeq(boardSeq);
			mapper.insertNotice(dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void updateNotice(Notice dto) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteNotice(long boardSeq) throws SQLException {
		try {
			mapper.deleteNotice(boardSeq);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Notice> listNotice(Map<String, Object> map) {
		List<Notice> list = null;
		try {
			list = mapper.listNotice(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = mapper.dataCount(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public Notice find(long boardSeq) {
		Notice dto = null;
		// 게시물 들고오기
		try {
			dto = mapper.find(boardSeq);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public Notice findByPrev(Map<String, Object> map) {
		Notice dto = null;
		try {
			dto = mapper.findByPrev(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public Notice findByNext(Map<String, Object> map) {
		Notice dto = null;
		try {
			dto = mapper.findByNext(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

}
