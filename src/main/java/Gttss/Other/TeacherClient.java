package Gttss.Other;

import Gttss.TeacherRequest.TeacherByIndex;
import org.directwebremoting.annotations.RemoteProxy;

import javax.websocket.ClientEndpoint;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import java.io.IOException;
import java.util.concurrent.ConcurrentHashMap;

@ClientEndpoint()
@RemoteProxy
public class TeacherClient {
    Session session;
//    String teacherId = TeacherByIndex.getTeacherId();
    static private ConcurrentHashMap<String,TeacherClient> sessionContainer = new ConcurrentHashMap<>();
	//连接成功时自动调用
	@OnOpen()
	public void onOpen(Session session) {
		this.session = session;
//		sessionContainer.put(teacherId,this);
	    System.out.println("教师后台客户端连接成功");
	}

	//发送信息
//    public void sendMessage(String message){
////        TeacherClient teacherClient = sessionContainer.get(teacherId);
//        try {
////            teacherClient.session.getBasicRemote().sendText(message);
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//    }

	//接收来自服务器转发的消息
    @OnMessage
    public void onMessage(String message,Session session) {
        String messages[] = message.split("://");
        System.out.println("来自"+messages[0]+"的信息："+messages[1]);
    }
    
    //关闭连接时自动调用
    @OnClose
    public void onClose() {
    	
    }
}
