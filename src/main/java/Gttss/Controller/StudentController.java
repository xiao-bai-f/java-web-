package Gttss.Controller;

import Gttss.Mapper.StudentMapper;
import Gttss.TeacherRequest.StudentByIndex;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import javax.servlet.http.HttpServletRequest;

@Controller()
public class StudentController implements StudentControllerInterface{

	@Autowired(required = false)
	StudentMapper studentMapper;
	//登录
	@RequestMapping("/Student/StudentLogin")
	public String studentLogin(HttpServletRequest request, Model model) {
		return StudentByIndex.StudentLogin(request,model,studentMapper);
	}
	
	//学生主页
	@RequestMapping("/Student/StudentMain")
	public String StudentMain(HttpServletRequest request, Model model) {
		String actionId = request.getParameter("id");
		if(actionId == null){ actionId = "1";}
		switch(actionId) {
			case "1": //显示学生信息
				StudentByIndex.SetStudentInfo(model,studentMapper);
			return "Student/StudentMain";
			case "2":
				StudentByIndex.FindTopicInfo(model,studentMapper);
				return "Student/SelectTopic";
			case "3":
				StudentByIndex.SetStudentManager(request,model,studentMapper);
				return "Student/SetStudentManager";
			case "4"://教师留言
				StudentByIndex.SetLMessage(request,model,studentMapper);
				return "Student/StudentLMessage";
			case "6":
				model.addAttribute("reslut",-1);
				return "Student/ChangePwd";
			case "8":
				StudentByIndex.StudentLogOut();
				return "Student/StudentLogin";
			case "9"://提交开题报告
				StudentByIndex.SetReportInfo(model,studentMapper,"open");
				return "Student/SubReport";
			case "10"://中期检查
				StudentByIndex.SetReportInfo(model,studentMapper,"mid");
				return "Student/SubReport";
			case "11"://论文初稿
				StudentByIndex.SetReportInfo(model,studentMapper,"first");
				return "Student/SubReport";
			case "12"://论文
				StudentByIndex.SetReportInfo(model,studentMapper,"second");
				return "Student/SubReport";
			case "13"://论文终稿
				StudentByIndex.SetReportInfo(model,studentMapper,"last");
				return "Student/SubReport";
		}
		return "";
	}

	//修改密码
	@RequestMapping("/Student/ChangePwd")
	public String ChangePwd(HttpServletRequest request,Model model){
		return "Student/ChangePwd";
	}
	
	//到达注册端之前
	@RequestMapping("/Student/StudentRegisterBefore")
	public String StudentRegisterBefore(HttpServletRequest request, Model model) {
		StudentByIndex.MajorInformation(request,model,studentMapper);
		return "Student/SetStudentManager";
	}
	/*
		修改学生的个人信息
			1、将学生的学院、专业、班级等逻辑 添加至数据表中
			2、将学生的个人信息，更新至t_studnet数据表中
	 */

	@RequestMapping("Student/SetStudentManagerAfter")
	public String StudentRegisterAfter(HttpServletRequest request, Model model) {
//		System.out.println(request.getParameter("college"));
//		student.setStudentName(request.getParameter("name"));
//		student.setStudentAge(request.getParameter("age"));
//		student.setStudentSex(request.getParameter("sex"));
//		student.setStudentEducation(request.getParameter("xl"));
//		student.setStudentEmail(request.getParameter("mail"));
//		student.setStudentTel(request.getParameter("tel"));
//		student.setStudentAddress(request.getParameter("provice")+request.getParameter("city")+request.getParameter("county"));
//		System.out.println(student.getStudentSex());
//		String studentId = studentMapper.findStudentFromClassse(student.getStudentId());
//		if(studentId != null){	//记录了学生所在班级
//			  studentMapper.deleteStudentFromClasses(studentId);
//			  studentMapper.addStudentClass(student.getStudentId(),request.getParameter("classes"));
//		}
//
////		int row3 = studentMapper.addClassMajor(request.getParameter("major"),request.getParameter("classes"));
////		int row4 = studentMapper.addMajorCollege(request.getParameter("major"),request.getParameter("classes"));
//		int row2 = studentMapper.updateStudentInfo(student);
//		model.addAttribute("student", student);
		return "Student/StudentMain";
	}
	
	//上传文件
	@RequestMapping("/Student/UploadFile")
	@Transactional()
	public String UploadFile(HttpServletRequest request,Model model,@RequestParam("file")MultipartFile file) {
		return StudentByIndex.ReceiveFile(request,model,studentMapper,file,request.getParameter("fileType"));
	}
	
	//确定选择试题
	/*
	 * 插入必要信息
	 * 1、将表t_student中isTopic字段设置为1
	 * 2、将表t_topic中的isSelected设置为yes
	 * 3、将表t_student_topic加入studentId和topicId
	 * 4、返回值试题选择前端界面
	 */
	@Transactional()
	@RequestMapping("/Student/selectTopic")
	public String selectTopic(HttpServletRequest request,Model model) {
		StudentByIndex.SetTopic(request,model,studentMapper);
		return "Student/SelectTopic";
	}

}
