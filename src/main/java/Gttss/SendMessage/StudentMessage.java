package Gttss.SendMessage;


import Gttss.Mapper.MessageMapper;
import Gttss.Mapper.StudentMapper;
import Gttss.Mapper.TeacherMapper;
import Gttss.Pojo.Message;
import org.directwebremoting.annotations.RemoteProxy;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;

@Component
@RemoteProxy
public class StudentMessage  {

    @Autowired(required = false)
    MessageMapper messageMapper;

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    boolean issender;
    HashMap<Integer,Boolean> isSenderMap =  new HashMap();
    String sendTime;
    HashMap<Integer,String> timeMap = new HashMap<>();
    //声明一个数组存放聊天信息以及聊天对象
    List<Message> messageList;
    String Sender;//定义发送信息的对象
    String Recever; //定义信息接收者
    //存放信息的容器，对应信息的版本号
    HashMap<Integer,String> message = new HashMap<>();
    List<Integer> versionList =  new ArrayList<>();
    static ConcurrentHashMap<ArrayList<String>,StudentMessage> messageContainer = new ConcurrentHashMap<>();//信息存放容器
    boolean isHave = false; //默认不存在

    //初始化留言数据信息
    public void initMessage(StudentMapper studentMapper){
        messageList = studentMapper.findMessageHistory();//从数据库拉聊天记录
        if (messageList.isEmpty()){
            return;
        }
        System.out.println("拉取总数："+messageList.size());
        for (Message message:messageList){
            setMessage(message.getSender(),message.getRecever(),message.getMessage());
        }
    }

    //存信息,每个信息都有一个版本号version，线程安全？
    public void setMessage(String Sender, String Recever, String message){
        int lastVersion = 0;
        ArrayList<String> newobject = null;
        for (ArrayList<String> list:messageContainer.keySet()){
            if (list.get(0).equals(Recever) && list.get(1).equals(Sender)){
                newobject = list;
            }
        }

        if (newobject != null){
            StudentMessage newstudentMeesage = messageContainer.get(newobject);
            if (newstudentMeesage != null){
                if(!newstudentMeesage.message.isEmpty()){
                    for ( int version : newstudentMeesage.message.keySet()){
                        if (version >= lastVersion){
                            lastVersion = version+1;
                        }
                    }
                }
            }
        }

        for (List<String> object: messageContainer.keySet()) {  //容器中存有sender与recever的聊天记录
            if (object.get(0) != null && object.get(1) != null) {
                if (Sender.equals(object.get(0)) && Recever.equals(object.get(1))) {
                    StudentMessage studentMeesage = messageContainer.get(object);
                    /*
                        获取容器上一个版本号
                     */
                    if(studentMeesage !=null){
                        if(!studentMeesage.message.isEmpty()){
                            for ( int version : studentMeesage.message.keySet()){
                                if (version >= lastVersion){
                                    lastVersion = version+1;
                                }
                            }
                        }
                    }
                    if (studentMeesage == null) {
                        studentMeesage = new StudentMessage();
                        studentMeesage.sendTime = sdf.format(new Date());
                        studentMeesage.Sender = Sender;
                        studentMeesage.Recever = Recever;
                        studentMeesage.message.put(lastVersion,message);
                        studentMeesage.versionList.add(lastVersion);
                    }else{
                        studentMeesage.sendTime = sdf.format(new Date());
                        studentMeesage.Sender = Sender;
                        studentMeesage.Recever = Recever;
                        studentMeesage.message.put(lastVersion,message);
                        studentMeesage.versionList.add(lastVersion);
                    }
                    isHave = true;
                    break;
                }
            }
        }
        if (!isHave){//容器中没有存放sender与recever的聊天记录
            ArrayList<String> object = new ArrayList<>();
            object.add(Sender);
            object.add(Recever);
            StudentMessage studentMeesage = new StudentMessage();
            studentMeesage.Sender = Sender;
            studentMeesage.Recever = Recever;
            studentMeesage.message.put(lastVersion,message);
            studentMeesage.versionList.add(lastVersion);
            messageContainer.put(object,studentMeesage);
            isHave = false;
        }

    }

    //将信息更新至以及读取
    public void updateIsRead(String sender,String recever,StudentMapper studentMapper){
            studentMapper.updateIsRead(recever,sender);
            System.out.println("更新");
    }

    public void updateIsRead(String sender,String recever,TeacherMapper teacherMapper){
        teacherMapper.updateIsRead(recever,sender);
        System.out.println("更新");
    }

    //获取留言数量
    public int getNoReadCount(String sender,String recever,StudentMapper studentMapper){
           return studentMapper.getNoReadCount(sender,recever);
    }

    public int getNoReadCount(String sender,String recever,TeacherMapper teacherMapper){
        return teacherMapper.getNoReadCount(sender,recever);
    }

    //学生端添加数据
    public int addMessage(String Sender, String Recever, String message,StudentMapper studentMapper){
        SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        System.out.println("当前时间"+sdf.format(new Date()));//获取当前时间
        String time= sdf.format(new Date());
        return studentMapper.addMessage(Sender,Recever,message,time);
    }

    //教师端添加数据
    public int addMessage(String Sender, String Recever, String message,TeacherMapper teacherMapper){
        SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        System.out.println("当前时间"+sdf.format(new Date()));//获取当前时间
        String time= sdf.format(new Date());
        return teacherMapper.addMessage(Sender,Recever,message,time);
    }

    //取信息,只取最后一条,
    public String getMessage(String sender,String Recever){
        for (StudentMessage studentMeesage:messageContainer.values()) {
            if(sender.equals(studentMeesage.Sender) && Recever.equals(studentMeesage.Recever)){   //接收者与存放的对上了，获得信息数组
                System.out.println(studentMeesage.message.get(studentMeesage.message.size()-1));
                return "<div style='margin-left:200px'>"+studentMeesage.sendTime+"</div>"+studentMeesage.message.get(studentMeesage.versionList.get(studentMeesage.versionList.size()-1));
            }
        }
        return null;
    }

    //初始化默认，取最后count条记录
    public String[] get5Message(String sender, String Recever,int count) {
        int[] version1= null;
        int[] version2= null;
        int[] allVersion = null;
        for (StudentMessage studentMeesage : messageContainer.values()) {
            System.out.println(studentMeesage.message.toString());
            HashMap<Integer, String> message = new HashMap<>();
            if (getVersion(sender,Recever,studentMeesage,count) != null){
                issender = true;
                version1  = getVersion(sender,Recever,studentMeesage,count);

            }
           if(getVersion(Recever,sender,studentMeesage,count) != null){
                issender=false;
                version2  = getVersion(Recever,sender,studentMeesage,count);
            }
        }
        if(version1 !=null && version2 != null){
            allVersion = new int[version1.length+version2.length];    //从大到小
            for (int i = 0; i <version1.length; i++){
                allVersion[i] = version1[i];
            }
            for (int j = 0;j<version2.length;j++){
                allVersion[version1.length-1+j] = version2[j];
            }
            int temp = 0;
            for (int i = 0; i<allVersion.length-1 ; i++){
                for (int j=0;j<allVersion.length-i-1;j++){
                    if (allVersion[j]<allVersion[j+1]){
                        temp = allVersion[j];
                        allVersion[j] = allVersion[j+1];
                        allVersion[j+1] = temp;
                    }
                }
            }
        }else if(version1 == null && version2 == null){
            allVersion = null;
        }else if (version1 != null){
            allVersion = version1;
        }else if (version2 != null){
            allVersion = version2;
        }

        if (allVersion != null){
            //根据版本号获取对应的信息
            HashMap<Integer,String> allmessage = new HashMap<>();
            for (StudentMessage studentMessage : messageContainer.values()) {
                if(sender.equals(studentMessage.Recever) && Recever.equals(studentMessage.Sender)){
                    allmessage.putAll( studentMessage.message);
                }if(sender.equals(studentMessage.Sender) && Recever.equals(studentMessage.Recever)){
                    allmessage.putAll(studentMessage.message);
                }
            }
         if (count>allVersion.length){
                count = allVersion.length;
         }
         String[] str = new String[count];
         for (int i = 0; i<count; i++){
             if (isSenderMap.get(allVersion[i]) == true){
                 str[i] = "<div style=\"margin:10px;\"><div style=\"margin-left:400px;\">"+timeMap.get(allVersion[i])+"</div>"+allmessage.get(allVersion[i])+"</div>";
             }else{
                 str[i] = "<div style=\"margin:10px;color:green;\"><div style=\"margin-left:400px;\">"+timeMap.get(allVersion[i])+"</div>"+allmessage.get(allVersion[i])+"</div>";
             }
         }
            return str;
        }
        return null;
    }


    public int[] getVersion(String sender ,String Recever,StudentMessage studentMessage,int count){
            if(sender.equals(studentMessage.Sender) && Recever.equals(studentMessage.Recever)){   //接收者与存放的对上了，获得信息数组
                if(studentMessage.versionList.size()<=count){
                    int[] versions = new int[studentMessage.versionList.size()];
                    //取出所有的版本号
                    for (int i =0; i<studentMessage.versionList.size();i++){
                        versions[i] = studentMessage.versionList.get(studentMessage.versionList.size()-1-i);
                        timeMap.put(versions[i],studentMessage.sendTime);
                        isSenderMap.put(versions[i],issender);

                    }
                    return versions;
                }else{
                    int[] versions = new int[count];
                    //取出最后count个版本号
                    for (int i =0; i<count;i++){
                        versions[i] = studentMessage.versionList.get(studentMessage.versionList.size()-1-i);
                        timeMap.put(versions[i],studentMessage.sendTime);
                        isSenderMap.put(versions[i],issender);
                    }
                    return versions;
                }
            }
            return null;
        }

    //取所有信息
    public String[] getAllMessage(String sender, String Recever){
        for (StudentMessage studentMeesage:messageContainer.values()) {
            System.out.println(studentMeesage.message.toString());
            if(sender.equals(studentMeesage.Sender) && Recever.equals(studentMeesage.Recever)){   //接收者与存放的对上了，获得信息数组
                String[] message =  new String[studentMeesage.message.size()];
                for (int i =0; i<studentMeesage.message.size();i++){
                    message[i] = studentMeesage.message.get(studentMeesage.message.size()-i);
                }
                return message;
            }
        }
        return null;
    }


}
