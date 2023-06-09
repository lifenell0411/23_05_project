package com.KoreaIT.bjw._05_project.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.KoreaIT.bjw._05_project.vo.Rq;


// 관리자페이지 인터셉터
@Component
public class NeedAdminInterceptor implements HandlerInterceptor {
	@Autowired
	private Rq rq;

	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp, Object handler) throws Exception {

		if (!rq.isAdmin()) {
			if (rq.isAjax()) {
				resp.setContentType("application/json; charset=UTF-8");
				resp.getWriter().append("{\"resultCode\":\"F-A\",\"msg\":\"관리자로 로그인 후 이용해주세요\"}");
			} else {
				String afterLoginUri = rq.getAfterLoginUri();
				rq.jsReplace("관리자로 로그인 후 이용해주세요", "/adm/member/login?afterLoginUri=" + afterLoginUri);
			}
			return false;
		}

		return HandlerInterceptor.super.preHandle(req, resp, handler);
	}

}