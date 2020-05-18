package Gttss.Pojo;

import java.sql.Date;

public class ApproveTopic {
    String topicName;
    String teacherName;
    String topicDesc;
    String topicRequier;
    java.sql.Date approveData;

    public void setTopicName(String topicName) {
        this.topicName = topicName;
    }

    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    public void setTopicDesc(String topicDesc) {
        this.topicDesc = topicDesc;
    }

    public void setTopicRequier(String topicRequier) {
        this.topicRequier = topicRequier;
    }

    public void setApproveData(Date approveData) {
        this.approveData = approveData;
    }

    public void setTeacherId(String teacherId) {
        this.teacherId = teacherId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    String teacherId;
    String studentId;

    public String getTopicName() {
        return topicName;
    }

    public String getTeacherName() {
        return teacherName;
    }

    public String getTopicDesc() {
        return topicDesc;
    }

    public String getTopicRequier() {
        return topicRequier;
    }

    public Date getApproveData() {
        return approveData;
    }

    public String getTeacherId() {
        return teacherId;
    }

    public String getStudentId() {
        return studentId;
    }
}
