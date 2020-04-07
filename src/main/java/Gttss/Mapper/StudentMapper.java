package Gttss.Mapper;

import Gttss.Pojo.*;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface StudentMapper {

	public List<Major> findMajor();

	public Student StudentLogin(@Param("studentId")String studentId,@Param("studentPwd") String studentPwd);

	public Student findStudentById(@Param("studentId")String studentId);

	public Classes findClassByStduentId(@Param("studentId")String studentId);

	public Major findMajorByClassId(@Param("classId")String classId);

	public College findCollegeByMajorId(@Param("majorId")String majorId);
	
	
	//查找学院专业信息
	public List<Topic> findTopic();
	//查找学院信息
	public List<College> findCollege();

	public List<Teacher> findTeacherByCollegeId(@Param("collegeId")String collegeId);

	public List<Topic> findTopicByTeacherId(@Param("teacherId")String teacherId);

	public Topic findTopicByStudentId(@Param("studentId")String studentId);

	public Teacher findTeacherByTopicId(@Param("topicId")String topicId);

	/*
		1、将学生试题选择、报告、中期检查、论文等提交的状态更新为已经提交状态“1”
		2、将试题状态设置为被选择”yes“
	 */
	@Update("update t_topic set isSelected = 'yes'  where topicId = #{topicId}")
	public int setIsSelected(@Param("topicId")String topicId);

	@Update("update t_student set isTopic = '1'  where studentId = #{studentId}")
	public int setIsTopic(@Param("studentId")String studentId);

	@Update("update t_student set isOpenReport = '1'  where studentId = #{studentId}")
	public int setIsOpenReport(@Param("studentId")String studentId);

	@Update("update t_student set isMidReport = '1'  where studentId = #{studentId}")
	public int setIsMidReport(@Param("studentId")String studentId);

	@Update("update t_student set isThesisFirst = '1'  where studentId = #{studentId}")
	public int setIsThesisFirst(@Param("studentId")String studentId);

	@Update("update t_student set isThesisSecond = '1'  where studentId = #{studentId}")
	int setIsThesisSecond(@Param("studentId")String studentId);

	@Update("update t_student set isThesisLast = '1'  where studentId = #{studentId}")
	int setIsThesisLast(@Param("studentId")String studentId);
	/*
		1、将学生的开题报告、论文初稿等文件信息添加至数据库，并将文件状态设置为待审批
		2、将学生的选择试题与学生id绑定在t_student_topic表中
	 */
	@Insert("insert into t_student_topic (studentId,topicId) values (#{studentId},#{topicId})" )
	public int addStudentTopic(@Param("studentId")String studentId, @Param("topicId")String topicId);

	@Insert("insert  into t_openReport (teacherId ,studentId ,status,name) values (#{teacherId},#{studentId},'0',#{fileName})")
    public int addOpenReport(@Param("studentId") String studentId, @Param("teacherId") String teacherId,@Param("fileName")String fileName);

	@Insert("insert  into t_midReport (teacherId ,studentId ,status,name) values (#{teacherId},#{studentId},'0',#{fileName})")
	public int addMidReport(@Param("studentId")String studentId, @Param("teacherId") String teacherId,@Param("fileName")String fileName);

	@Insert("insert  into t_ThesisFirst (teacherId ,studentId ,status,name) values (#{teacherId},#{studentId},'0',#{fileName})")
	public int addThesisFirst(@Param("studentId")String studentId, @Param("teacherId")String teacherId,@Param("fileName")String fileName);

	@Insert("insert  into t_ThesisSecond (teacherId ,studentId ,status,name) values (#{teacherId},#{studentId},'0',#{fileName})")
	int addThesisSecond(@Param("studentId")String studentId, @Param("teacherId")String teacherId,@Param("fileName")String fileName);

	@Insert("insert  into t_ThesisLast (teacherId ,studentId ,status,name) values (#{teacherId},#{studentId},'0',#{fileName})")
	int addThesisLast(@Param("studentId")String studentId, @Param("teacherId")String teacherId,@Param("fileName")String fileName);


	String findOpenReport(@Param("studentId") String studentId, @Param("teacherId") String teacherId);

	/*
		查找学生对试题、开题报告、中期检查等文件的提交状态（提交、审批、退回等）
	 */
	@Select("select isTopic from t_student where studentId = #{studentId}")
	public String findIsTopic(@Param("studentId")String studentId);
	
	@Select("select isOpenReport from t_student where studentId = #{studentId}")
	public String findIsOpenReport(@Param("studentId")String studentId);
	
	@Select("select isMidReport from t_student where studentId = #{studentId}")
	public String findIsMidReport(@Param("studentId") String studentId);

	@Select("select isThesisFirst from t_student where studentId = #{studentId}")
	String findIsThesisFirst(@Param("studentId") String studentId);

	@Select("select isThesisSecond from t_student where studentId = #{studentId}")
	String findIsThesisSecond(@Param("studentId") String studentId);

	@Select("select isThesisLast from t_student where studentId = #{studentId}")
	String findIsThesisLast(@Param("studentId") String studentId);



	/*
		异常报错，返回多个查找值
	 */
	@Select("select * from t_openReport where studentId = #{studentId}")
	public OpenReport findOpenReport(@Param("studentId")String studentId);
	
	@Select("select * from t_midReport where studentId = #{studentId}")
	public MidReport findMidReport(@Param("studentId")String studentId);

	@Select("select * from t_ThesisFirst where studentId = #{studentId}")
	public ThesisFirst findThesisFirst(@Param("studentId")String studentId);

	@Select("select * from t_ThesisSecond where studentId = #{studentId}")
	ThesisSecond findThesisSecond(@Param("studentId") String studentId);

	@Select("select * from t_ThesisLast where studentId = #{studentId}")
	ThesisLast findThesisLast(@Param("studentId") String studentId);

	@Select("select * from t_teacher  where teacherId = #{selectName}")
	public Teacher findTeacherById(@Param("selectName") String selectName);

	public List<Teacher> findTeacherByName(@Param("selectName")String selectName);

	@Select("select * from t_student where studentId = #{studentId}")
	Student findStudentByStudentId(@Param("studentId") String studentId);

	@Select("select * from t_class")
	List<Classes> findClasses();


	List<Classes> findClassByMajorId(@Param("majorId") String majorId);

//	@Update("update t_student set studentName = \"#{studentName}\", studentAge = \"#{studentAge}\",studentSex = \"#{studentSex}\", studentEmail = \"#{studentEmail}\",studentTel = \"#{studentTel}\", studentEducation = \"#{studentEducation}\", studentAddress = \"#{studentAddress}\" where studentId = \"#{studentId}\"")
	@Update("update t_student set studentName = #{studentName},studentAge=#{studentAge},studentSex = #{studentSex},studentEmail = #{studentEmail},studentTel = #{studentTel},studentEducation = #{studentEducation},studentAddress = #{studentAddress} where studentId = #{studentId}")
	int updateStudentInfo(Student student);

	@Insert("insert into t_student_class (studentId,classId) values (#{studentId},#{classId})")
	int addStudentClass(@Param("studentId") String studentId,@Param("classId") String classId);

	@Select("select studentId from t_student_class where studentId = #{studentId}")
	String findStudentFromClassse(@Param("studentId") String studentId);

	@Delete("delete from t_student_class where studentId = #{studentId}")
	int deleteStudentFromClasses(@Param("studentId") String studentId);

	@Select("select studentpassword from t_studentLogin where studentId = #{studentId}")
	String findStudentPwd(@Param("studentId") String studentId);

	@Update("update t_studentlogin set studentpassword = #{pwd} where studentId = #{studentId}")
    int UpdateStudentPwd(@Param("pwd") String pwd,@Param("studentId") String studentId);
}
