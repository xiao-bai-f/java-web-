package Gttss.Pojo;

import java.util.List;

public class Teacher {
	private String teacherName ;
	private String teacherId;
	private String teacherAge;
	private String teacherSex;
	private String teacherTel;
	private String teacherEmail;
	private String isHeadTeacher;
	private String schoolId;
	private List<Topic> topicList;
	private List<College> collegeList;
	
	
	public List<Topic> getTopicList() {
		return topicList;
	}
	public void setTopicList(List<Topic> topicList) {
		this.topicList = topicList;
	}
	public List<College> getCollegeList() {
		return collegeList;
	}
	public void setCollegeList(List<College> collegeList) {
		this.collegeList = collegeList;
	}
	public String getSchoolId() {
		return schoolId;
	}
	public void setSchoolId(String schoolId) {
		this.schoolId = schoolId;
	}
	public String getTeacherAge() {
		return teacherAge;
	}
	public void setTeacherAge(String teacherAge) {
		this.teacherAge = teacherAge;
	}
	public String getTeacherSex() {
		return teacherSex;
	}
	public void setTeacherSex(String teacherSex) {
		this.teacherSex = teacherSex;
	}
	public String getTeacherTel() {
		return teacherTel;
	}
	public void setTeacherTel(String teacherTrl) {
		this.teacherTel = teacherTrl;
	}
	public String getTeacherEmail() {
		return teacherEmail;
	}
	public void setTeacherEmail(String teacherEmail) {
		this.teacherEmail = teacherEmail;
	}
	public String getIsHeadTeacher() {
		return isHeadTeacher;
	}
	public void setIsHeadTeacher(String isHeadTeacher) {
		this.isHeadTeacher = isHeadTeacher;
	}
	public String getTeacherName() {
		return teacherName;
	}
	public String getTeacherId() {
		return teacherId;
	}
	public void setTeacherName(String teacherName) {
		this.teacherName = teacherName;
	}
	public void setTeacherId(String teacherId) {
		this.teacherId = teacherId;
	}
	public String toString() {
		return "教师姓名："+teacherName+"\t教师编号:"+teacherId+"\n";
	}
}
