package Gttss.Pojo;

import java.util.List;

public class Student extends StudentParent{
	String isTopic;
	Classes classes;
	List<Student> studentList;
	
	public String getIsTopic() {
		return isTopic;
	}
	public void setIsTopic(String isTopic) {
		this.isTopic = isTopic;
	}
	public Classes getClasses() {
		return classes;
	}
	public void setClasses(Classes classes) {
		this.classes = classes;
	}
	public List<Student> getStudentList() {
		return studentList;
	}
	public void setStudentList(List<Student> studentList) {
		this.studentList = studentList;
	}

	
}
