package com.sp.app.service;

import com.sp.app.domain.Item;
import com.sp.app.domain.Photo;

public interface ItemService {
    public void insertShop(Item dto, String pathname) throws Exception;

}
