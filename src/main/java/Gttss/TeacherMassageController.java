package Gttss;

import java.util.concurrent.CopyOnWriteArraySet;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint(value = "")
public class TeacherMassageController {
	private Session session;
	private static CopyOnWriteArraySet<TeacherMassageController> arraySet = new CopyOnWriteArraySet<TeacherMassageController>(); 
	@OnOpen
	public void onOpen(Session session) {
		this.session = session;
		arraySet.add(this);
		//this.addOnlineNum();
	}
	
	@OnClose
	public void onClose() {
		arraySet.remove(this);
		System.out.println("断开连接");
	}
	
	@OnError
	public void onError(Session session,Throwable error) {
		System.out.println("发生错误");
		error.printStackTrace();
	}
	
}
