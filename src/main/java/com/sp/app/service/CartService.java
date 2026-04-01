package com.sp.app.service;

import com.sp.app.domain.Cart;

import java.util.List;
import java.util.Map;

public interface CartService {
    // 카트 담기 (이미 있으면 false 반환)
    public boolean insertCart(Cart dto) throws Exception;

    // 카트 목록
    public List<Cart> cartList(Map<String, Object> map) throws Exception;

    // 카트 삭제
    public void deleteCart(long cartSeq) throws Exception;
}
