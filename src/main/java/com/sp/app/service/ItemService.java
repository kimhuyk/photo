package com.sp.app.service;

import com.sp.app.domain.Item;
import com.sp.app.domain.Photo;

import java.util.List;
import java.util.Map;

public interface ItemService {
    // Shop insert
    public void insertShop(Item dto, String pathname) throws Exception;

    // Shop 리스트
    public List<Item> shopList(Map<String, Object> map);

}
