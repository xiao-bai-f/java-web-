package Gttss.Mapper;

import java.util.List;

import Gttss.Pojo.*;
import org.apache.ibatis.annotations.*;

@Mapper
public interface TeacherMapper {

	@Select("select topicId from t_topic")
    public List<String> findTopicId();

    public List<Teacher> findTeacher();
	public Teacher findTeacherById(@Param("teacherId")String teacherId);
	public Teacher TeacherLogin(@Param("teacherId")String teacherId,@Param("teacherPwd")String teacherPwd);
	
	//根据教师查找选题学生
	public Student findStudentByIsTopic(@Param("topicId")String topicId);
	public List<Student> findStudentByStudentId(@Param("studentId")String studentId,@Param("collegeId")String collegeId);
	public List<Student> findStudentByClassIdAndStudentName(@Param("studentName")String studentName, @Param("classId")String classId);
	public List<Major>   findStudentByCollegeId(@Param("collegeId")String CollegeId);
	public Classes findClassByMajorIdAndClassId(@Param("classId")String selectName, @Param("majorId")String majorId);
	public List<Student> findStudentByClassIdAndStudentId(@Param("studentId")String selectName, @Param("classId")String classId);
	public List<Major> findMajorByCollegeIdAndMajorName(@Param("majorName")String selectName, @Param("collegeId")String collegeId);
	public List<Classes> findClassByMajorId(@Param("majorId")String majorId);
	
	//根据老师编号查找试题
	public List<Topic> findTopicByTeacherId(@Param("teacherId")String teacherId);
	public List<College> findCollegeByTeacher(@Param("teacherId")String teacherId);
	
	//发布试题
	public int addTopic(Topic topic);

	public int addTeacherTopic(@Param("topicId")String topicId, @Param("schoolId")String schoolId, @Param("teacherId")String teacherId);

	/*
		通过教师编号teacherId查询开题报告、中期检查、论文初稿等
	 */
	@Select("select * from t_OpenReport where teacherId = #{teacherId} and Status ='0'")
	public List<OpenReport> findOpenReportByTeacherId(@Param("teacherId")String teacherId);

	@Select("select * from t_MidReport where teacherId = #{teacherId} and Status ='0' ")
	List<MidReport> findMidReportByTeacherId(@Param("teacherId") String teacherId);

	@Select("select * from t_ThesisFirst where teacherId = #{teacherId} and Status ='0'")
	List<ThesisFirst> findThesisFirstByTeacherId(@Param("teacherId")String teacherId);

	@Select("select * from t_ThesisSecond where teacherId = #{teacherId} and Status ='0'")
	List<ThesisSecond> findThesisSecondByTeacherId(@Param("teacherId")String teacherId);

	@Select("select * from t_ThesisLast where teacherId = #{teacherId} and Status ='0'")
	List<ThesisLast> findThesisLastByTeacherId(@Param("teacherId")String teacherId);

	@Select("select * from t_student where studentId = #{studentId}")
	Student findStudentByStudentId(String studentId);

	@Update("update t_OpenReport set status = #{status} where studentId = #{studentId}")
	int setOpenReportStatus(@Param("studentId") String studentId,@Param("status")String status);

	@Update("update t_MidReport set status = #{status} where studentId = #{studentId}")
	int setMidReportStatus(@Param("studentId") String studentId,@Param("status")String status);

	@Update("update t_ThesisFirst set status = #{status} where studentId = #{studentId}")
	int setThesisFirstStatus(@Param("studentId") String studentId,@Param("status")String status);

	@Select("select * from t_topic where topicName LIKE CONCAT(CONCAT('%',#{topicName}),'%') ")
	List<Topic> findTopicName(@Param("topicName")String topicName);

	@Select("select * from t_topic where topicId = #{topicId}")
	List<Topic> findTopicById(@Param("topicId")String topicId);

	@Insert("insert into t_messagehistory (Sender,Recever,sendTime,message) values (#{sender},#{recever},#{sendtime},#{message})")
	int addMessage(@Param("sender") String sender, @Param("recever") String recever, @Param("message") String message, @Param("sendtime") String sendtime);

	@Insert("insert into t_progress (subTopic,subOpenReport,subMidReport,subThesisFirst,subThesisSecond,subThesisLast,teacherId) values (#{subTopic},#{subOpenReport},#{subMidReport},#{subThesisFirst},#{subThesisSecond},#{subThesisLast},#{teacherId})")
    int addSubTime(SubTime subTime);

	@Select("select * from t_progress where teacherId = #{teacherId}")
	SubTime findSubTime(@Param("teacherId") String teacherId);

	@Update("update t_progress set subTopic = #{subTopic},subOpenReport = #{subOpenReport},subMidCheck=#{subMidCheck},subThesisFirst=#{subThesisFirst},subThesisSecond=#{subThesisSecond},subThesisLast=#{subThesisLast} where teacherId = #{teacherId}")
	int setSubTime(SubTime subTime);

	@Select("select * from t_plead where teacherId = #{teacherId}")
	Plead findPlead(String teacherId);

	@Update("update t_plead set pleadTime = #{pleadTime},pleadAddress = #{pleadAddress} where teacherId = #{teacherId}")
	int setPlead(Plead plead);

	@Insert("insert into t_plead(teacherId,pleadTime,pleadAddress) values (#{teacherId},#{pleadTime},#{pleadAddress})")
	int addPlead(Plead plead);

	Topic findTopicByStudentId(@Param("studentId") String studentId);

	@Select("select * from t_approvetopic where teacherId = #{teacherId}")
    List<ApproveTopic> findTopicListByteacherId(@Param("teacherId") String teacherId);

	@Select("select * from t_student_class where studentId = #{studentId}")
	Classes findClassByStudentId(@Param("studentId") String studentId);

	@Delete("delete from t_approvetopic where studentId = #{studentId}")
	int delectApproveTopic(@Param("studentId") String studentId);

	@Update("update t_topic set topicName = #{topicName},topicRequier = #{topicRequier},topicDesc = #{topicDesc} where topicId = #{topicId}")
	int updateTopic(Topic topic);

	@Delete("delete from t_topic where topicId = #{topicId}")
	int deleteTopic(@Param("topicId") String topicId);

	@Delete("delete from t_teacher_topic where topicId = #{topicId}")
	int deleteTeacher_Topic(@Param("topicId") String topicId);

	@Select("select * from t_openReport where studentId = #{studentId}")
	OpenReport 	findOpenReportByStudentId(@Param("studentId") String studentId);

	@Select("select * from t_midReport where studentId = #{studentId}")
	MidReport 	findMidReportByStudentId(@Param("studentId") String studentId);

	@Select("select * from t_ThesisFirst where studentId = #{studentId}")
	ThesisFirst findThesisFirstByStudentId(@Param("studentId") String studentId);

	@Select("select * from t_ThesisSecond where studentId = #{studentId}")
	ThesisSecond findThesisSecondByStudentId(@Param("studentId") String studentId);

	@Select("select * from t_ThesisLast where studentId = #{studentId}")
	ThesisLast 	findThesisLastByStudentId(@Param("studentId") String studentId);

	@Insert("insert into t_scoring (studentId,teacherId,content,express,think,answer,grade,subtime) values (#{studentId},#{teacherId},#{content},#{express},#{think},#{answer},#{grade},#{subtime})")
    int addScoring(Scoring scoring);

	@Select("select * from t_scoring where studentId = #{studentId}")
	Scoring findScoringById(@Param("studentId") String studentId);

	@Select("select * from t_scoring where teacherId = #{teacherId}")
	List<Scoring> findScoringByteacherId(@Param("teacherId") String teacherId);

	@Update("update t_teacher set teacherName = #{teacherName},teacherEmail = #{teacherEmail},teacherAge=#{teacherAge},teacherTel=#{teacherTel},teacherSex=#{teacherSex}where teacherId = #{teacherId}")
	int updateTeacherById(Teacher teacher);

	@Select("select teacherPassword from t_teacherlogin where teacherId = #{teacherId}")
	String findTeacherPwd(@Param("teacherId") String teacherId);

	@Update("update t_teacherLogin set teacherPassword = #{dPwd} where teacherId = #{teacherId}")
	int updateTeacherPwd(@Param("teacherId") String teacherId, @Param("dPwd") String dPwd);

	@Update("update t_messagehistory set isRead = '1' where Sender = #{sender} and Recever = #{recever}")
	void updateIsRead(@Param("recever") String recever, @Param("sender") String sender);

	@Select("select count(*) from t_messagehistory where Sender=#{sender} and Recever = #{recever} and isRead='0'")
	int getNoReadCount(@Param("sender")String sender,@Param("recever") String recever);
}
