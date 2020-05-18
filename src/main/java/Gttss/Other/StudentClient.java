package Gttss.Other;

import Gttss.TeacherRequest.StudentByIndex;
import org.springframework.stereotype.Component;

import javax.websocket.ClientEndpoint;
import javax.websocket.OnClose;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import java.io.IOException;
import java.util.concurrent.ConcurrentHashMap;

@Component
@ClientEndpoint
public class StudentClient {
	//连接成功时自动调用
//    String connectId = StudentByIndex.getStudentId();
//    HttpSession httpSession =
    private static ConcurrentHashMap<String,StudentClient> sessionContainer = new ConcurrentHashMap<String,StudentClient>();
    Session session;
    @OnOpen()
	public void onOpen(Session session) {
        this.session = session;
//        sessionContainer.put(connectId,this);
//		System.out.println(connectId+"后台客户端连接成功");
	}

	//发送消息,将消息发送至服务器
    public void sendMessage(String message){
        String messages[] = message.split("://");
        try {
            StudentClient studentClient =  sessionContainer.get(messages[0]);
            studentClient.session.getBasicRemote().sendText(messages[1]+"://"+messages[2]);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    
    //关闭连接时自动调用
    @OnClose
    public void onClose() {
    	System.out.println("会话关闭");
    }
}
