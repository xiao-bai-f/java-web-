package Gttss.Pojo;

import java.sql.Date;
import java.util.List;

public class Topic {
	String topicId;
	String topicName;
	String teacherName;
	String topicDesc;
	String topicRequier;
	String schoolId;
	String isSelected;
	java.sql.Date publishTime;

	public Topic(){

	}

    public Topic(String topicId, String topicName, String topicRequier, String topicDesc, String teacherName,java.sql.Date publishTime,String isSelected) {
    	this.topicId =topicId;
    	this.topicName =topicName;
    	this.topicRequier =topicRequier;
    	this.topicDesc =topicDesc;
    	this.teacherName =teacherName;
    	this.publishTime = publishTime;
    	this.isSelected=isSelected;
    }

    public Date getPublishTime() {
		return publishTime;
	}

	public void setPublishTime(Date publishTime) {
		this.publishTime = publishTime;
	}

	public String getIsSelected() {
		return isSelected;
	}
	public void setIsSelected(String isSelected) {
		this.isSelected = isSelected;
	}
	List<Topic> topicList;
	
	public List<Topic> getTopicList() {
		return topicList;
	}
	public void setTopicList(List<Topic> topicList) {
		this.topicList = topicList;
	}
	public String getTopicId() {
		return topicId;
	}
	public void setTopicId(String topicId) {
		this.topicId = topicId;
	}
	public String getTopicName() {
		return topicName;
	}
	public void setTopicName(String topicName) {
		this.topicName = topicName;
	}
	public String getTeacherName() {
		return teacherName;
	}
	public void setTeacherName(String teacherName) {
		this.teacherName = teacherName;
	}
	public String getTopicDesc() {
		return topicDesc;
	}
	public void setTopicDesc(String topicDesc) {
		this.topicDesc = topicDesc;
	}
	public String getTopicRequier() {
		return topicRequier;
	}
	public void setTopicRequier(String topicRequier) {
		this.topicRequier = topicRequier;
	}
	public String getSchoolId() {
		return schoolId;
	}
	public void setSchoolId(String schoolId) {
		this.schoolId = schoolId;
	}

}
