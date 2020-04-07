//package Gttss.MvcConfig;
//
//import org.springframework.context.annotation.Configuration;
//import org.springframework.web.servlet.config.annotation.InterceptorRegistration;
//import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
//import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
//
//import Gttss.Interceptor.LoginInerceptor;
//import Gttss.Interceptor.TeacherInerceptor;
///*
// * 配置拦截器
// */
//@Configuration
//public class InterceptorConfiug implements WebMvcConfigurer {
//	/*
//	 * 拦截器配置
//	 */
//	@Override
//	public  void addInterceptors(InterceptorRegistry registry) {
//		
//		//配置拦截路径
//		String [] addPathPatterns = {"/**.*","/**"};
//		//排除拦截路径
//		String [] excludePathPatterns = {"/TeacherLogin.jsp","/StudentLogin.jsp","/TeacherLogin","/StudentLogin"};
//		//注册未登录访问其他页面的拦截器
//		InterceptorRegistration addPathPatterns1 = 
//			registry.addInterceptor(new TeacherInerceptor())
//			.addPathPatterns(addPathPatterns)
//			.excludePathPatterns(excludePathPatterns);
//		//++++++++++++++++++++注册其他拦截器
//		//注册登陆拦截页面
//		String[] addLoginPatterns = {"/TeacherLogin.jsp","/StudentLogin.jsp"};
//		InterceptorRegistration addPathPatterns2 = 
//			registry.addInterceptor(new LoginInerceptor())
//			.addPathPatterns(addLoginPatterns);
//
//	}
//	
//}
