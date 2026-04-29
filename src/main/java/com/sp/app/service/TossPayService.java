package com.sp.app.service;

public interface TossPayService {
    // 토스 결제 승인 API 호출
    boolean confirmPayment(String paymentKey, String orderId, long amount) throws Exception;
}
