package Gttss.Pojo;

import java.sql.Date;
/*
    设置提交时间类
 */
public class SubTime {
    String teacherId;
    java.sql.Date subTopic;
    java.sql.Date subOpenReport;
    java.sql.Date subMidCheck;
    java.sql.Date subThesisFirst;
    java.sql.Date subThesisSecond;
    java.sql.Date subThesisLast;

    public void setTeacherId(String teacherId) {
        this.teacherId = teacherId;
    }

    public void setSubTopic(Date subTopic) {
        this.subTopic = subTopic;
    }

    public void setSubOpenReport(Date subOpenReport) {
        this.subOpenReport = subOpenReport;
    }

    public void setSubMidCheck(Date subMidCheck) {
        this.subMidCheck = subMidCheck;
    }

    public void setSubThesisFirst(Date subThesisFirst) {
        this.subThesisFirst = subThesisFirst;
    }

    public void setSubThesisSecond(Date subThesisSecond) {
        this.subThesisSecond = subThesisSecond;
    }

    public void setSubThesisLast(Date subThesisLast) {
        this.subThesisLast = subThesisLast;
    }

    public String getTeacherId() {

        return teacherId;
    }

    public Date getSubTopic() {
        return subTopic;
    }

    public Date getSubOpenReport() {
        return subOpenReport;
    }

    public Date getSubMidCheck() {
        return subMidCheck;
    }

    public Date getSubThesisFirst() {
        return subThesisFirst;
    }

    public Date getSubThesisSecond() {
        return subThesisSecond;
    }

    public Date getSubThesisLast() {
        return subThesisLast;
    }
        public SubTime(java.sql.Date opentime, java.sql.Date midtime, java.sql.Date firsttime, java.sql.Date secondtime, java.sql.Date lasttime, java.sql.Date topictime, String teacherId){
        this.subTopic =topictime;
        this.subOpenReport = opentime;
        this.subMidCheck = midtime;
        this.subThesisFirst = firsttime;
        this.subThesisSecond = secondtime;
        this.subThesisLast= lasttime;
        this.teacherId = teacherId;

    }


}
