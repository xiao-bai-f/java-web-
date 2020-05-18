//package Gttss.Interceptor;

//import org.springframework.stereotype.Component;
//import org.springframework.web.servlet.HandlerInterceptor;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;

//@Component
//public class TeacherInerceptor implements HandlerInterceptor {
//	@Override
//	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
//			throws Exception {
//
//		/*
//		 * 拦击未登录不准进入后台界面
//		 */
//		if(request.getSession().getAttribute("Teacher") != null) { System.out.println("已经登陆");return true; }//登陆
//		else {return false;}
//
//
//	}
//}
