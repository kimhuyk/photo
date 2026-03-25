package com.sp.app.mapper;

import com.sp.app.domain.Item;
import com.sp.app.domain.Photo;
import org.apache.ibatis.annotations.Mapper;

import java.sql.SQLException;

@Mapper
public interface ItemMapper {
	public void insertShop(Item dto) throws SQLException;
	public long itemFileSeq();
}
