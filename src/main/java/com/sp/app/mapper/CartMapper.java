package com.sp.app.mapper;

import com.sp.app.domain.Cart;
import org.apache.ibatis.annotations.Mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@Mapper
public interface CartMapper {
    // 카트 담기
    public void insertCart(Cart dto) throws SQLException;

    // 카트 목록 조회 (userSeq 기준)
    public List<Cart> cartList(Map<String, Object> map) throws SQLException;

    // 이미 담긴 상품 체크
    public int countCartItem(Map<String, Object> map) throws SQLException;

    // 카트 삭제
    public void deleteCart(long cartSeq) throws SQLException;
}
