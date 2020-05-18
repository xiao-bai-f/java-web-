package Gttss.Pojo;

import java.sql.Date;

/*
    关于时间进度
 */
public class Progress {

    java.sql.Date subTopic;
    java.sql.Date subOpenReport;
    java.sql.Date subMidCheck;
    java.sql.Date subThesisFirst;
    java.sql.Date subThesisSecond;
    java.sql.Date subThesisLast;

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
}
