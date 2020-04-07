package Gttss.Pojo;

import java.util.List;

public class College {
	String collegeId;
	String collegeName;
	String schoolId;
	String schoolName;
	List<College> collegeList;
	
	List<Major> majorList;
	public List<Major> getMajorList() {
		return majorList;
	}
	public void setMajorList(List<Major> majorList) {
		this.majorList = majorList;
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
	public String getSchoolName() {
		return schoolName;
	}
	public void setSchoolName(String schoolName) {
		this.schoolName = schoolName;
	}
	public String getCollegeId() {
		return collegeId;
	}
	public void setCollegeId(String collegeId) {
		this.collegeId = collegeId;
	}
	public String getCollegeName() {
		return collegeName;
	}
	public void setCollegeName(String collegeName) {
		this.collegeName = collegeName;
	}
}
