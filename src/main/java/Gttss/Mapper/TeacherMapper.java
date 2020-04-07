package Gttss.Mapper;

import java.util.List;

import Gttss.Pojo.*;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

@Mapper
public interface TeacherMapper {
	
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
	@Select("select * from t_OpenReport where teacherId = #{teacherId}")
	public List<OpenReport> findOpenReportByTeacherId(@Param("teacherId")String teacherId);

	@Select("select * from t_MidReport where teacherId = #{teacherId}")
	List<MidReport> findMidReportByTeacherId(@Param("teacherId") String teacherId);

	@Select("select * from t_ThesisFirst where teacherId = #{teacherId}")
	List<ThesisFirst> findThesisFirstByTeacherId(@Param("teacherId")String teacherId);

	@Select("select * from t_ThesisSecond where teacherId = #{teacherId}")
	List<ThesisSecond> findThesisSecondByTeacherId(@Param("teacherId")String teacherId);

	@Select("select * from t_ThesisLast where teacherId = #{teacherId}")
	List<ThesisLast> findThesisLastByTeacherId(@Param("teacherId")String teacherId);

	@Select("select * from t_student where studentId = #{studentId}")
	Student findStudentByStudentId(String studentId);

	@Update("update t_OpenReport set status = #{status} where studentId = #{studentId}")
	int setOpenReportStatus(@Param("studentId") String studentId,@Param("status")String status);

	@Update("update t_MidReport set status = #{status} where studentId = #{studentId}")
	int setMidReportStatus(@Param("studentId") String studentId,@Param("status")String status);

	@Update("update t_ThesisFirst set status = #{status} where studentId = #{studentId}")
	int setThesisFirstStatus(@Param("studentId") String studentId,@Param("status")String status);



}
