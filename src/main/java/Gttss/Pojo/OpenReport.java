package Gttss.Pojo;

public class OpenReport {
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

    public void setStatus(String status) {
        Status = status;
    }

    public String getStatus() {
        return Status;
    }
}
