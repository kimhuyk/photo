package com.sp.app.service.serviceImpl;

import com.sp.app.service.TossPayService;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.springframework.stereotype.Service;

import java.nio.charset.StandardCharsets;
import java.util.Base64;

@Service
public class TossPayServiceImpl implements TossPayService {

    // ⚠️ 여기에 발급받은 테스트 시크릿 키 입력
    private static final String SECRET_KEY = "시크릿 키";

    private static final String CONFIRM_URL = "https://api.tosspayments.com/v1/payments/confirm";

    @Override
    public boolean confirmPayment(String paymentKey, String orderId, long amount) throws Exception {

        // 시크릿 키 Base64 인코딩 (토스 인증 방식)
        String encoded = Base64.getEncoder()
                .encodeToString((SECRET_KEY + ":").getBytes(StandardCharsets.UTF_8));

        // HTTP 요청 구성
        try (CloseableHttpClient client = HttpClients.createDefault()) {
            HttpPost post = new HttpPost(CONFIRM_URL);
            post.setHeader("Authorization", "Basic " + encoded);
            post.setHeader("Content-Type", "application/json");

            String body = "{\"paymentKey\":\"" + paymentKey + "\"," +
                          "\"orderId\":\"" + orderId + "\"," +
                          "\"amount\":" + amount + "}";
            post.setEntity(new StringEntity(body, StandardCharsets.UTF_8));

            try (CloseableHttpResponse response = client.execute(post)) {
                int statusCode = response.getStatusLine().getStatusCode();
                String responseBody = EntityUtils.toString(response.getEntity(), StandardCharsets.UTF_8);
                System.out.println("토스 결제 승인 응답 [" + statusCode + "]: " + responseBody);
                return statusCode == 200;
            }
        }
    }
}
