package com.sp.app.mapper;

import com.sp.app.domain.Item;
import com.sp.app.domain.Photo;
import org.apache.ibatis.annotations.Mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@Mapper
public interface ItemMapper {
	public void insertShop(Item dto) throws SQLException;
  List<Item> shopList(Map<String,Object> map);

}
