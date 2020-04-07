package Gttss.Pojo;

/*
    开题报告、中期检查、论文类的父类
 */
public abstract class Report {
    String Status;
    String studentId;
    String teacherId;
    String fileName;


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

    abstract public void setOther();
}
