package Gttss.Pojo;

import java.util.List;

public class Classes {
	String classId;
	List<Student> studentList;
	Major major;
	
	public Major getMajor() {
		return major;
	}

	public void setMajor(Major major) {
		this.major = major;
	}

	public List<Student> getStudentList() {
		return studentList;
	}

	public void setStudentList(List<Student> student) {
		this.studentList = student;
	}

	public String getClassId() {
		return classId;
	}

	public void setClassId(String classId) {
		this.classId = classId;
	}
}
