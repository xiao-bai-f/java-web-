package Gttss;

import java.io.IOException;
import java.util.concurrent.ConcurrentHashMap;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import org.springframework.stereotype.Component;

/*
 * webSocket的具体实现类:
 */
@ServerEndpoint(value="/websocket/{connectId}")
@Component
public class MyWebSocket {
	//静态变量，记录当前在线的连接数量
	private static int onlineCount = 0;
	
	//concurrent包的线程安全set，用来存放每个客户端对应的MyWebSocket对象
	private static ConcurrentHashMap<String,MyWebSocket> webSocketSet = new ConcurrentHashMap<String,MyWebSocket>(); 
	//
	private Session session;
	private String connectId ;
    //仅仅当连接是才会调用
	@OnOpen
    public void onOpen(@PathParam("connectId") String connectId, Session session) {
        this.session = session;
        this.connectId = connectId;
        webSocketSet.put(connectId,this);     
        addOnlineCount();           //在线数加1
        System.out.println("有新连接用户"+connectId+"加入！当前在线人数为" + getOnlineCount());
    }

    /**
     * 连接关闭调用的方法
     */
    @OnClose
    public void onClose(@PathParam("connect") String connectId,Session session) {
        MyWebSocket closewb = webSocketSet.remove(connectId);  //从set中删除
        subOnlineCount();           //在线数减1
        System.out.println("有一连接"+connectId+"关闭！当前在线人数为" + getOnlineCount());
    }

    /*
     * 收到客户端消息后调用的方法
     * @param message 客户端发送过来的消息
     * @throws IOException 
     */
    @OnMessage
    public void onMessage(String message,Session session) throws IOException {
        System.out.println("来自客户端"+connectId+"的消息:" + message);
        for (MyWebSocket mwb :  webSocketSet.values()) {
        	if(mwb.connectId.equals("101")) {
				System.out.println("转发消息至101客户端");
				sendMessage(mwb.session,message);
			}
		}
    }
    
    //转发消息
    public void sendMessage(Session session,String message){
    	try {
			session.getBasicRemote().sendText(message);
		} catch (IOException e) {
			e.printStackTrace();
			//出现网络问题时
		}
    }
    
    public void sendMessage(String message) throws IOException {
    	this.session.getBasicRemote().sendText(message);//显示在自己界面
    	//转达到学生界面
        //this.session.getAsyncRemote().sendText(message);
    }

    
    // 发生错误时调用
    @OnError
    public void onError(Session session, Throwable error) {
        System.out.println("发生错误");
        error.printStackTrace();
    }
    
    public static synchronized int getOnlineCount() {
        return onlineCount;
    }

    public static synchronized void addOnlineCount() {
        MyWebSocket.onlineCount++;
    }

    public static synchronized void subOnlineCount() {
        MyWebSocket.onlineCount--;
    }

}
