package Gttss.Controller;

import Gttss.Mapper.StudentMapper;
import Gttss.SendMessage.StudentMessage;
import Gttss.TeacherRequest.StudentByIndex;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import xiaobai.Pojo.ResultForm;
import javax.servlet.http.HttpServletRequest;
import java.util.concurrent.ConcurrentHashMap;

@Controller()
//@enabled
public class StudentController {

	@Autowired(required = false)
	StudentMapper studentMapper;

	StudentMessage studentMessage  = new StudentMessage();

	static ConcurrentHashMap<String,StudentMapper> mapperContainer = new ConcurrentHashMap<>();

	/*
		添加聊天记录
	 */
	public int addMessage(String Sender,String Recever,String message){
		StudentMapper studentMapper = mapperContainer.get(Sender);
		return studentMessage.addMessage(Sender,Recever,message,studentMapper);
	}

	public void updateIsRead(String sender,String recever){
		StudentMapper studentMapper = mapperContainer.get(sender);
		studentMessage.updateIsRead(recever,sender,studentMapper);
	}

	public int  getNoReadCount(String sender,String recever){
		StudentMapper studentMapper = mapperContainer.get(recever);
		int count = studentMessage.getNoReadCount(sender,recever,studentMapper);
		return count;
	}


	//登录
	@Transactional
	@RequestMapping(value = "/Student/StudentLogin")
	public String studentLogin(HttpServletRequest request, Model model) {
		mapperContainer.put(request.getParameter("studentId"),studentMapper);
		return StudentByIndex.StudentLogin(request,model,studentMapper);
	}

	//学生主页
	@RequestMapping(value ="/Student/StudentMain")
	public String StudentMain(HttpServletRequest request, Model model) {
		String actionId = request.getParameter("id");
		if(actionId == null){ actionId = "1";}
		switch(actionId) {
			case "1": //显示学生信息
				StudentByIndex.SetStudentInfo(request,model,studentMapper);
			return "Student/StudentMain";
			case "2":
				StudentByIndex.FindTopicInfo(request,model,studentMapper);
				return "Student/SelectTopic";
			case "3":
				StudentByIndex.SetStudentManager(request,model,studentMapper);
				return "Student/ChangeInfo";
			case "4"://教师留言
				StudentByIndex.SetLMessage(request,model,studentMapper);
				return "Student/StudentLMessage";
			case"5":
				StudentByIndex.ApproveTopic(request,model,studentMapper);
				return "Student/ApproveTopic";
			case "6":
				model.addAttribute("reslut",-1);
				return "Student/ChangePwd";
			case "8":
				StudentByIndex.StudentLogOut(request);
				return "Student/StudentLogin";
			case "9"://提交开题报告
				StudentByIndex.SetReportInfo(request,model,studentMapper,"open");
				return "Student/SubReport";
			case "10"://中期检查
				StudentByIndex.SetReportInfo(request,model,studentMapper,"mid");
				return "Student/SubReport";
			case "11"://论文初稿
				StudentByIndex.SetReportInfo(request,model,studentMapper,"first");
				return "Student/SubReport";
			case "12"://论文
				StudentByIndex.SetReportInfo(request,model,studentMapper,"second");
				return "Student/SubReport";
			case "13"://论文终稿
				StudentByIndex.SetReportInfo(request,model,studentMapper,"last");
				return "Student/SubReport";
		}
		return "";
	}

	//修改密码
	@RequestMapping("/Student/ChangePwd")
	public String ChangePwd(HttpServletRequest request,Model model){
		StudentByIndex.ChangePwd(request,model,studentMapper);
		return "Student/ChangePwd";
	}

	//查看试题信息
	@RequestMapping("/Student/findTopic")
	public String findTopic(HttpServletRequest request,Model model){
		StudentByIndex.FindTopicInfo(request,model,studentMapper);
		return "Student/SelectTopic";
	}

	/*
		修改学生的个人信息
			1、将学生的学院、专业、班级等逻辑 添加至数据表中
			2、将学生的个人信息，更新至t_studnet数据表中
	 */

	@RequestMapping("Student/StudentChangeInfo")
	public String StudentChangeInfo(HttpServletRequest request, Model model) {
		StudentByIndex.ChangeInfo(request,model,studentMapper);
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

	//申请试题
	@RequestMapping("/Student/ApprovelTopic")
	public String approveTopic(HttpServletRequest request,Model model){
		StudentByIndex.ApproveTopicAfter(request,model,studentMapper);
		return "Student/ApproveTopic";
	}

	@RequestMapping("/Student/DownloadFile")
	public String DownloadFile(HttpServletRequest request,Model model){
		StudentByIndex.DownloadFile(request,model);
		return "Student/downloadFile";
	}

	//%%%%%%%%%%%%%%%%%%%
	@GetMapping("Student/test")
	public ResultForm Test(String message){
		System.out.println(message);
		message = "hello world!!!";
		return new ResultForm(true,message);
	}

}
