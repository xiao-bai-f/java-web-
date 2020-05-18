package Gttss.Pojo;

import java.sql.Date;

/*
    评定表
 */
public class Scoring {


    String studentId;
    String teacherId;
    String think;
    String express;
    String content;
    String answer;
    String grade;
    java.sql.Date subtime;

    public Scoring(String studentId, String teacherId, String content, String think, String express, String answer, String grade,java.sql.Date subtime) {
        this.content = content;
        this.studentId = studentId;
        this.teacherId = teacherId;
        this.think= think;
        this.express = express;
        this.grade = grade;
        this.answer = answer;
        this.subtime = subtime;
    }
    public Scoring(){

    }

    public void setGrade(String grade) {
        this.grade = grade;
    }

    public String getGrade() {
        return grade;

    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public void setTeacherId(String teacherId) {
        this.teacherId = teacherId;
    }

    public void setThink(String think) {
        this.think = think;
    }

    public void setExpress(String express) {
        this.express = express;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public void setSubtime(java.sql.Date subtime) {
        this.subtime = subtime;
    }

    public String getStudentId() {

        return studentId;
    }

    public String getTeacherId() {
        return teacherId;
    }

    public String getThink() {
        return think;
    }

    public String getExpress() {
        return express;
    }

    public String getContent() {
        return content;
    }

    public String getAnswer() {
        return answer;
    }

    public java.sql.Date getSubtime() {
        return subtime;
    }
}
