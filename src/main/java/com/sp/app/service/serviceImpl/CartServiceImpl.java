package com.sp.app.service.serviceImpl;

import com.sp.app.domain.Cart;
import com.sp.app.mapper.CartMapper;
import com.sp.app.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class CartServiceImpl implements CartService {

    @Autowired
    private CartMapper mapper;

    @Override
    public boolean insertCart(Cart dto) throws Exception {
        // 이미 담긴 상품 체크
        Map<String, Object> map = new HashMap<>();
        map.put("userSeq", dto.getUserSeq());
        map.put("itemSeq", dto.getItemSeq());
        int cnt = mapper.countCartItem(map);
        if (cnt > 0) return false;

        mapper.insertCart(dto);
        return true;
    }

    @Override
    public List<Cart> cartList(Map<String, Object> map) throws Exception {
        return mapper.cartList(map);
    }

    @Override
    public void deleteCart(long cartSeq) throws Exception {
        mapper.deleteCart(cartSeq);
    }
}
