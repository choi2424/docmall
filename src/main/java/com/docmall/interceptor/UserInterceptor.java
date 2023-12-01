package com.docmall.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.docmall.domain.MemberVO;

public class UserInterceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
				throws Exception {
		
		boolean result = false;
		
		// 현재 클라이언트의 세션을 통한 인증상태 확인작업을 할수가 있다.
		HttpSession session = request.getSession();
		
		MemberVO user = (MemberVO) session.getAttribute("loginStatus");
		
		if(user == null) { // 인증정보가 없는경우
			
			result = false; // 컨트롤러로 진행을 하지 못한다
			
			if(isAjaxRequest(request)) {
				
				response.sendError(400); // 클라이언트의 ajax구문에서 error : 동작됨.
			}else {
				
				getTargetUrl(request);
				
				response.sendRedirect("/member/login");
				
			}
			
			
		}else { // 인증정보가 있는 경우 . 즉 세션 loginStatus 정보가 존재(사용자는 로그인중)
			
			result = true; // 컨트롤러로 진행을 하게된다.
			
		}
		
		return result;
	}
	
	// 인증되지 않은 상태에서 사용자가 요청한 URL을 저장하고 로그인후 URL로 리다이렉트 작업
	private void getTargetUrl(HttpServletRequest request) {
		
		// 예 요청주소 . /member/modify?userid=user01
		
		String uri = request.getRequestURI(); // /user/order/order_info
		String query = request.getQueryString(); // userid=user01
		
		if(query == null || query.equals("null")) {
			query = "";
		}else {
			query = "?" + query;
		}
		
		String targetUrl = uri + query;
		
		if(request.getMethod().equals("GET")) {
			request.getSession().setAttribute("targetUrl", targetUrl);
		}
		
		
	}
	
	// 사용자 요청이 ajax요청인지 체크
	private boolean isAjaxRequest(HttpServletRequest request) {
		
		boolean isAjax = false;
		
		String header = request.getHeader("AJAX");
		if(header != null && header.equals("true")) {
			isAjax = true;
		}
		
		return isAjax;
	}
}
