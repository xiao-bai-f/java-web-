package Gttss;

import Gttss.Mapper.StudentMapper;
import Gttss.SendMessage.StudentMessage;
import org.directwebremoting.servlet.DwrServlet;
import org.directwebremoting.spring.DwrSpringServlet;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.server.ConfigurableWebServerFactory;
import org.springframework.boot.web.server.ErrorPage;
import org.springframework.boot.web.server.WebServerFactoryCustomizer;
import org.springframework.boot.web.servlet.ServletListenerRegistrationBean;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpStatus;
import org.springframework.web.socket.server.standard.ServerEndpointExporter;

import java.util.HashMap;
import java.util.Map;

@Configuration
@SpringBootApplication
public class AppTest implements ApplicationRunner{
	@Autowired(required = false)
	StudentMapper studentMapper;
	//启动程序
	public static void main(String[] args) {
		SpringApplication.run(AppTest.class, args);
	}
	
//	//注册dwr的拦截器
	@Bean
	public ServletRegistrationBean servletRegistrationBean() {
		DwrSpringServlet servlet = new DwrSpringServlet();
		ServletRegistrationBean registrationBean = new ServletRegistrationBean(new DwrServlet(), "/dwr/*");
		Map<String, String> initParam = new HashMap<>();
		initParam.put("crossDomainSessionSecurity", "false");
		initParam.put("allowScriptTagRemoting", "true");
		initParam.put("classes", "java.lang.Object");
		initParam.put("activeReverseAjaxEnabled", "true");
		initParam.put("initApplicationScopeCreatorsAtStartup", "true");
		initParam.put("maxWaitAfterWrite", "60000");
		initParam.put("debug", "true");
		initParam.put("logLevel", "WARN");
		initParam.put("customConfigurator", "Gttss.DwrXml");
		registrationBean.setInitParameters(initParam);
	     return registrationBean;
	}



	//配置websocket服务器
	@Bean
	public ServerEndpointExporter serverEndpointExporter() {
		return  new ServerEndpointExporter();
	}

	//配置异常界面自动跳转
	@Bean
	public WebServerFactoryCustomizer<ConfigurableWebServerFactory> webServerFactoryWebServerFactoryCustomizer(){
		return  new WebServerFactoryCustomizer<ConfigurableWebServerFactory>() {
			@Override
			public void customize(ConfigurableWebServerFactory factory) {
				ErrorPage errorPage400 = new ErrorPage(HttpStatus.BAD_REQUEST,
						"/error-400");
				ErrorPage errorPage401 = new ErrorPage(HttpStatus.UNAUTHORIZED,
						"/error-401");
				ErrorPage errorPage403 = new ErrorPage(HttpStatus.FORBIDDEN,
						"/error-403");
				ErrorPage errorPage404 = new ErrorPage(HttpStatus.NOT_FOUND,
						"/error-404");
				ErrorPage errorPage500 = new ErrorPage(HttpStatus.INTERNAL_SERVER_ERROR,
						"/error-500");
				ErrorPage errorPage503 = new ErrorPage(HttpStatus.SERVICE_UNAVAILABLE,
						"/error-503");
				factory.addErrorPages(errorPage400, errorPage404,errorPage401,errorPage403,errorPage503,
						errorPage500);

			}
		};
	}

	//系统启动自动运行
	/*
		1、将留言历史记录存放到容器
	 */
	@Override
	public void run(ApplicationArguments args) throws Exception {
		StudentMessage studentMessage = new StudentMessage();
		studentMessage.initMessage(studentMapper);
	}
//		系统关闭时，将数据的加载字段isload设置为未加载‘0’
//	 */
//	public void setMessage(StudentMapper studentMapper){
//		studentMapper.setLoadMessage("0");	//设置未加载
//	}
}
