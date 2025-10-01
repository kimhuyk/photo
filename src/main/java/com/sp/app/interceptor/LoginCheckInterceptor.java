package com.sp.app.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.sp.app.domain.SessionInfo;

/*
  - HandlerInterceptor 인터페이스
    : 컨트롤러가 요청 전과 후에 반복적으로 실행할 기능을 구현하기 위한 인터페이스
    : 다수의 인터셉터도 구현할 수 있다.
    : 로그인 검사, 응답시간 계산, 인벤트 기간 만료등에서 이용하면 편리
    : 인터셉터를 적용하기 위해서 HandlerInterceptor를 등록해야 한다.
      <mvc:interceptors/> 태그 이용
*/

public class LoginCheckInterceptor implements HandlerInterceptor {

	/*
	  - 클라이언트의 요청이 컨트롤러에 도착하기 전에 호출
	  - false를 리턴하면 HandlerInterceptor 또는 컨트롤러를 실행하지 않고 요청 종료
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		boolean result = true;
		
		try {
			HttpSession session = request.getSession();
			SessionInfo info = (SessionInfo)session.getAttribute("loginUser");
			String cp = request.getContextPath();
			String uri = request.getRequestURI();
			String qs = request.getQueryString();
			
			if(info == null) {
				result = false;
				
				if(isAjaxRequest(request)) {
					response.sendError(403);
				} else {
					if(uri.indexOf(cp) == 0) {
						// cp 가 존재하면 uri에서 cp를 제거 
						uri = uri.substring(request.getContextPath().length());
					}
					
					if(qs != null) {
						uri += "?" + qs;
					}
					
					session.setAttribute("preLoginURI", uri);
					response.sendRedirect(cp + "/user/login");
				}
			} else {
				// 로그인이 된 경우
				// 관리자 메뉴는 userSeq 가 51 이상만 가능
				if(uri.indexOf("admin") != -1 && info.getUserSeq() != 1) {
				    result = false;
				    response.sendRedirect(cp + "/user/noAuthorized");
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	/*
	 - 클라이언트의 요청을 처리 후 실행
	 - 컨트롤러 실행 중 예외가 발생하면 실행하지 않음
	 */
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
	}

	/*
	 - 뷰를 통해 클라이언트의 응답을 전송후에 실행
	 - 뷰를 생성하는 과정에서 예외가 발생해도 실행
	 */
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
	}
	
	// AJAX 요청인지를 확인 하기 위한 메소드 작성
	private boolean isAjaxRequest(HttpServletRequest req) {
		String header = req.getHeader("AJAX");
		return header != null && header.equals("true");
	}

}
