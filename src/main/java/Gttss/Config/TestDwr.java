package Gttss.Config;

import org.directwebremoting.annotations.RemoteMethod;
import org.directwebremoting.annotations.RemoteProxy;
import org.springframework.stereotype.Service;

@Service
@RemoteProxy
public class TestDwr {
	@RemoteMethod
	public void test_1(String str) {
		System.out.println("第一次测试dwr"+str);
	}
}
