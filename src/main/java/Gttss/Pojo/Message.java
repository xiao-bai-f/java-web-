package Gttss.Pojo;

public class Message {
    String Sender;
    String Recever;
    String sendTime;
    String message;

    public void setMessage(String message) {
        this.message = message;
    }

    public void setSendTime(String sendTime) {

        this.sendTime = sendTime;
    }

    public void setRecever(String recever) {

        Recever = recever;
    }

    public void setSender(String sender) {

        Sender = sender;
    }

    public String getSendTime() {

        return sendTime;
    }

    public String getRecever() {

        return Recever;
    }

    public String getSender() {

        return Sender;
    }

    public String getMessage() {

        return message;
    }
}
