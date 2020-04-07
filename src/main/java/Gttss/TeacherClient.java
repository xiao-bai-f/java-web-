package Gttss;

import javax.websocket.ClientEndpoint;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;

@ClientEndpoint()
public class TeacherClient {
	//连接成功时自动调用
	@OnOpen()
	public void onOpen(Session session) {
		System.out.println("教师后台客户端连接成功");
	}
	
	//接收来自服务器的消息
    @OnMessage
    public void onMessage(String message,Session session) {
        System.out.println("Client onMessage: " + message);
    }
    
    //关闭连接时自动调用
    @OnClose
    public void onClose() {
    	
    }
}
