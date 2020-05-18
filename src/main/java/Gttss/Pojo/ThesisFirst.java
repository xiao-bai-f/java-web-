package Gttss.Pojo;

public class ThesisFirst extends BaseReport{
    String Status;
    String studentId;
    String teacherId;
    String fileName;
    java.sql.Date subTime;

    public void setSubTime(java.sql.Date subTime) {
        this.subTime = subTime;
    }

    public java.sql.Date getSubTime() {
        return subTime;
    }
    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getFileName() {
        return fileName;

    }
    public String getTeacherId() {
        return teacherId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public void setTeacherId(String teacherId) {

        this.teacherId = teacherId;
    }

    public String getStudentId() {
        return studentId;
    }
    public String getStatus() {
        return Status;
    }

    public void setStatus(String status) {
        Status = status;
    }
}
