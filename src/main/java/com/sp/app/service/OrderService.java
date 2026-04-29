package com.sp.app.service;

import com.sp.app.domain.OrderDetail;
import com.sp.app.domain.OrderMaster;

import java.util.List;
import java.util.Map;

public interface OrderService {

    // 주문 확정 (ORDER_MASTER + ORDER_DETAIL INSERT, CART DELETE)
    // 반환값: 생성된 orderSeq
    long placeOrder(long userSeq, long deNum) throws Exception;

    // 주문 목록 조회 (마이페이지용)
    List<OrderMaster> orderList(Map<String, Object> map) throws Exception;

    // 주문 상세 조회
    List<OrderDetail> orderDetailList(long orderSeq) throws Exception;
}
