package com.sp.app.service.serviceImpl;

import com.sp.app.domain.Cart;
import com.sp.app.domain.OrderDetail;
import com.sp.app.domain.OrderMaster;
import com.sp.app.mapper.CartMapper;
import com.sp.app.mapper.OrderMapper;
import com.sp.app.service.CartService;
import com.sp.app.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderMapper orderMapper;

    @Autowired
    private CartMapper cartMapper;

    @Autowired
    private CartService cartService;

    /**
     * 주문 확정
     * 1. 카트 목록 조회
     * 2. 총 금액 계산
     * 3. ORDER_MASTER INSERT
     * 4. ORDER_DETAIL INSERT (카트 아이템 수만큼 반복)
     * 5. CART 전체 삭제
     */
    @Override
    @Transactional
    public long placeOrder(long userSeq, long deNum) throws Exception {
        // 1. 카트 목록 조회
        Map<String, Object> cartMap = new HashMap<>();
        cartMap.put("userSeq", userSeq);
        List<Cart> cartItems = cartService.cartList(cartMap);

        if (cartItems == null || cartItems.isEmpty()) {
            throw new Exception("장바구니가 비어있습니다.");
        }

        // 2. 총 금액 계산
        int totalPrice = 0;
        for (Cart item : cartItems) {
            totalPrice += item.getItemPrice() * item.getQuantity();
        }

        // 3. ORDER_MASTER INSERT
        long orderSeq = orderMapper.orderSeq();
        OrderMaster master = new OrderMaster();
        master.setOrderSeq(orderSeq);
        master.setUserSeq(userSeq);
        master.setDeNum(deNum);
        master.setTotalPrice(totalPrice);
        master.setOrderStatus("결제완료");
        orderMapper.insertOrderMaster(master);

        // 4. ORDER_DETAIL INSERT (카트 아이템 수만큼)
        for (Cart item : cartItems) {
            OrderDetail detail = new OrderDetail();
            detail.setOrderSeq(orderSeq);
            detail.setItemSeq(item.getItemSeq());
            detail.setQuantity(item.getQuantity());
            detail.setUnitPrice(item.getItemPrice());
            orderMapper.insertOrderDetail(detail);
        }

        // 5. CART 전체 삭제
        orderMapper.deleteCartByUser(userSeq);

        return orderSeq;
    }

    @Override
    public List<OrderMaster> orderList(Map<String, Object> map) throws Exception {
        return orderMapper.orderList(map);
    }

    @Override
    public List<OrderDetail> orderDetailList(long orderSeq) throws Exception {
        return orderMapper.orderDetailList(orderSeq);
    }
}
