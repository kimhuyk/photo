package com.sp.app.mapper;

import com.sp.app.domain.OrderDetail;
import com.sp.app.domain.OrderMaster;
import org.apache.ibatis.annotations.Mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@Mapper
public interface OrderMapper {

    // ORDER_MASTER 시퀀스 채번
    public long orderSeq() throws SQLException;

    // 주문 마스터 INSERT
    public void insertOrderMaster(OrderMaster dto) throws SQLException;

    // 주문 상세 INSERT (카트 아이템 1건씩)
    public void insertOrderDetail(OrderDetail dto) throws SQLException;

    // 주문 목록 조회 (userSeq 기준, 마이페이지용)
    List<OrderMaster> orderList(Map<String, Object> map) throws SQLException;

    // 주문 상세 조회 (orderSeq 기준)
    List<OrderDetail> orderDetailList(long orderSeq) throws SQLException;

    // 카트 전체 삭제 (주문 완료 후)
    public void deleteCartByUser(long userSeq) throws SQLException;
}
