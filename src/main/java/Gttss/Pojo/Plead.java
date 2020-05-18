package Gttss.Pojo;

import java.sql.Date;

public class Plead {
    String teacherId;
    java.sql.Date pleadTime;
    String pleadAddress;

    public Plead(){

    }

    public String getTeacherId() {
        return teacherId;
    }

    public Date getPleadTime() {
        return pleadTime;
    }

    public String getPleadAddress() {
        return pleadAddress;
    }

    public void setTeacherId(String teacherId) {

        this.teacherId = teacherId;
    }

    public void setPleadTime(Date pleadTime) {
        this.pleadTime = pleadTime;
    }

    public void setPleadAddress(String pleadAddress) {
        this.pleadAddress = pleadAddress;
    }

    public Plead(String teacherId, java.sql.Date pleadTime, String pleadAddress){
        this.teacherId = teacherId;
        this.pleadAddress = pleadAddress;
        this.pleadTime = pleadTime;

    }
}
