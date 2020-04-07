package Gttss;

import org.directwebremoting.servlet.DwrListener;
import org.directwebremoting.servlet.DwrServlet;
import org.directwebremoting.spring.DwrSpringServlet;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletListenerRegistrationBean;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.ImportResource;
import org.springframework.web.socket.server.standard.ServerEndpointExporter;

import java.util.HashMap;
import java.util.Map;

@Configuration
@SpringBootApplication
//@ImportResource(locations = "classpath:spring.xml")
public class AppTest {
	//启动程序
	public static void main(String[] args) {
		SpringApplication.run(AppTest.class, args);
	}
	
	//注册dwr的拦截器
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

	@Bean
	public ServletListenerRegistrationBean dwrListener() {
		return new ServletListenerRegistrationBean(new DwrListener());
	}

	//配置websocket服务器
	@Bean
	public ServerEndpointExporter serverEndpointExporter() {
		return  new ServerEndpointExporter();
	}
}
