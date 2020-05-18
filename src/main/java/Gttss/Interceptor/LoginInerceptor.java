//package Gttss.Interceptor;

//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import org.springframework.context.annotation.ComponentScan;
//import org.springframework.stereotype.Component;
//import org.springframework.web.servlet.HandlerInterceptor;
//@Component
//public class LoginInerceptor implements HandlerInterceptor{
//
//    @Override
//    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
//            throws Exception {
//        System.out.println(request.getSession().getAttribute("Teacher"));
//        if(request.getSession().getAttribute("Teacher") == null) {return true;}//未登录
//        else {System.out.println("请先退出");return false;}
//    }
//}
