package Gttss.TeacherRequest;

import Gttss.MyWebSocket;
import Gttss.StudentClient;
import Gttss.TeacherClient;
import Gttss.Mapper.StudentMapper;
import Gttss.Pojo.*;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.websocket.ContainerProvider;
import javax.websocket.DeploymentException;
import javax.websocket.Session;
import javax.websocket.WebSocketContainer;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URI;
import java.util.ArrayList;
import java.util.List;

public class StudentByIndex {

	/*
		这些静态变量都会在登录时自动加载
	 */
	static Student student;
	static Student studentlogin;
	private static Classes classes;
	private static Major major;
	private static College college;
	private static Session socket_session;
	private static WebSocketContainer container ;
	private static  URI uri;
	private static final String connectId = "ws://localhost:8080/websocket/";
	/*
	 * 后端主页设置学生信息
	 */
	private static Teacher teacher =  new Teacher();
	private static Topic topic = new Topic();

	/*
		登录：1、第一次登录
				2、重复登录
	 */
	public static String StudentLogin(HttpServletRequest request,Model model,StudentMapper studentMapper){
		if(student == null) {
			studentlogin = studentMapper.StudentLogin(request.getParameter("studentId"), request.getParameter("studentPwd"));
			if(studentlogin == null) {return "Student/StudentLogin";	}//登录失败
			student = studentMapper.findStudentById(studentlogin.getStudentId());
			StudentByIndex.SetStudentInfo(model,studentMapper);
			if(student != null) {
				ConnectWebSocket(connectId);
				return "Student/StudentMain";
			}else {
				return "Student/StudentLogin";
			}
		}else {
			StudentByIndex.SetStudentInfo(model,studentMapper);
			return "Student/StudentMain";
		}
	}

	/*
		退出登录
			关闭会话、将student对象指向为空
	 */
	public static void StudentLogOut(){
		MyWebSocket wb = new MyWebSocket();
		wb.onClose(student.getStudentId(),socket_session);
		try {
			socket_session.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		student = null;
		studentlogin = null;
	}
	//连接webSocket
	public static void ConnectWebSocket(String connectId){
		uri = URI.create(connectId+student.getStudentId());
		container = ContainerProvider.getWebSocketContainer();
		try {
			socket_session = container.connectToServer(StudentClient.class,uri);
		} catch (DeploymentException | IOException e) {
			e.printStackTrace();
		}
	}

	//设置学生信息
	public static void SetStudentInfo(Model model,StudentMapper studentMapper) {
		model.addAttribute("Student",student);
		classes = studentMapper.findClassByStduentId(student.getStudentId());
		if(classes == null) {return;}
		major = studentMapper.findMajorByClassId(classes.getClassId());
		if(major == null) {return;}
		college = studentMapper.findCollegeByMajorId(major.getMajorId());
		if(college == null) {return;}
		model.addAttribute("Classes",classes);
		model.addAttribute("Major",major);
		model.addAttribute("College",college);
	}

	//设置提交开题报告的界面的信息
	/*
	 * 业务逻辑
	 * 1、提交报告之前必须检查是否选择了试题；没事试题，则不能提交
	 * 2、是否已经提交过开题报告了
	 */
	public static void SetReportInfo(Model model,StudentMapper studentMapper,String type) {
		student = studentMapper.findStudentByStudentId(student.getStudentId());
		model.addAttribute("isTopic", student.getIsTopic());
		topic = studentMapper.findTopicByStudentId(student.getStudentId());
		if(topic != null){
			teacher = studentMapper.findTeacherByTopicId(topic.getTopicId());
		}
		model.addAttribute("Teacher", teacher);
		model.addAttribute("Topic", topic);
		model.addAttribute("Classes", classes);
		model.addAttribute("College", college);
		model.addAttribute("Major", major);

		OpenReport openReport = new OpenReport();
		MidReport midReport = new MidReport();
		ThesisFirst thesisFirst = new ThesisFirst();
		ThesisSecond thesisSecond = new ThesisSecond();
		ThesisLast thesisLast = new ThesisLast();

		String Status = "未提交";
		String isReport = "";
		switch (type){
			case "open":
				isReport = studentMapper.findIsOpenReport(student.getStudentId());
				if(isReport.equals("1")){	//已经提交了文件
					openReport = studentMapper.findOpenReport(student.getStudentId());
					Status = openReport.getStatus();
				}
				model.addAttribute("Report", openReport);
				break;
			case "mid":
				isReport = studentMapper.findIsMidReport(student.getStudentId());
				if(isReport.equals("1")){
					midReport = studentMapper.findMidReport(student.getStudentId());
					Status = midReport.getStatus();
				}
				model.addAttribute("Report", midReport);
				System.out.println(midReport);
				break;
			case "first":
				isReport = studentMapper.findIsThesisFirst(student.getStudentId());
				if(isReport.equals("1")){
					thesisFirst = studentMapper.findThesisFirst(student.getStudentId());
					Status = thesisFirst.getStatus();
				}
				model.addAttribute("Report", thesisFirst);
				System.out.println(thesisFirst);
				break;
			case "second":
				isReport = studentMapper.findIsThesisSecond(student.getStudentId());
				if(isReport.equals("1")){
					thesisSecond = studentMapper.findThesisSecond(student.getStudentId());
					Status = thesisSecond.getStatus();
				}
				model.addAttribute("Report", thesisSecond);
				break;
			case "last":
				isReport = studentMapper.findIsThesisLast(student.getStudentId());
				if(isReport.equals("1")){
					thesisLast = studentMapper.findThesisLast(student.getStudentId());
					Status = thesisLast.getStatus();
				}
				model.addAttribute("Report", thesisLast);
				break;
		}
			switch (Status){
				case "0":
					Status = "待审批";
					break;
				case "1":
					Status = "通过";
					break;
				case "2":
					Status = "已退回";
					break;
			}
		model.addAttribute("type",type);
		model.addAttribute("isReport", isReport);
		model.addAttribute("Status", Status);
	}
	//设置选择课题界面的信息
	/*
	 * 1、学生能看到的试题：仅仅限制于所在的学院导师提供的试题
	 * 2、学生是否已经确定了试题：是则不能再选择试题
	 * 3、判断试题是否已经被选择
	 */
	public static void FindTopicInfo(Model model,StudentMapper studentMapper) {
		List<Teacher> teacherList = new ArrayList<Teacher>();
		/*
		 * ps:college 为学生登录时，由学生所在班级专业等信息获得，并设置
		 */
		//查找学生所在学院内所有的导师
		teacherList = studentMapper.findTeacherByCollegeId(college.getCollegeId());
		
		//导师为空
		if(teacherList.isEmpty()) {
			model.addAttribute("EmptyTeacher", 0);
			return;
			
		}//导师为空，没事试题可以选择
		List<Topic> topicList = new ArrayList<Topic>();
		List<Topic> topics = new ArrayList<>();
		
		//查找导师对应提供的试题
		for (Teacher teacher : teacherList) {
			topics = studentMapper.findTopicByTeacherId(teacher.getTeacherId());
			if(!topics.isEmpty()) {
				topicList.addAll(topics);
			}
			topics.clear();
		}
		//导师还没有提供试题
		if(topicList.isEmpty()) {
			model.addAttribute("TopicEmpty", 0);
			return;
		}
		String isTopic = studentMapper.findIsTopic(student.getStudentId());
		//通过数据模型，传送到前端
		model.addAttribute("IsTopic", isTopic);
		model.addAttribute("TopicCount",topicList.size());
		model.addAttribute("TopicList",topicList);
	}
	

	//接收上传文件
	public static String ReceiveFile(HttpServletRequest request,Model model,StudentMapper studentMapper,MultipartFile file,String fileType){
		String contentType = file.getContentType();
		String fileName = file.getOriginalFilename();
		System.out.println("文件类型"+contentType);
		System.out.println("文件名称"+fileName);

		/*
		过滤文件
		 */
		
		//文件上传路径:默认是上传开题报告
		String uploadPath = "UploadFile/OpenReport/";
		fileName = student.getStudentId()+student.getStudentName();
		switch(fileType) {
			case "open":
				uploadPath = "UploadFile/OpenReport/";
				break;
			case "mid":
				uploadPath = "UploadFile/MidReport/";
				break;
			case "first":
				uploadPath = "UploadFile/ThesisFirst/";
				break;
			case "second" :
				uploadPath = "UploadFile/ThesisSecond";
				break;
			case "last":
				uploadPath = "UploadFile/ThesisLast/";
				break;
		}
		String filePath = request.getSession().getServletContext().getRealPath(uploadPath);
		try {
			File targetFile = new File(filePath);
			if(!targetFile.exists()) {
				targetFile.mkdirs();
			}
			FileOutputStream out = new FileOutputStream(filePath+fileName);
			out.write(file.getBytes());
			out.flush();
			out.close();
		}catch (Exception e) {
			//上传失败
			System.out.println(e);
            StudentByIndex.SetReportInfo(model,studentMapper,fileType);
            return "Student/SubReport";
		}
		//上传成功
		//更新学生上传开题报告状态（已提交）
		int setrow = 0;
		int addrow = 0;
		switch(fileType) {
		case "open":
			setrow = studentMapper.setIsOpenReport(student.getStudentId());
			addrow = studentMapper.addOpenReport(student.getStudentId(),teacher.getTeacherId(),fileName);
			break;
		case "mid":
			setrow = studentMapper.setIsMidReport(student.getStudentId());
			addrow = studentMapper.addMidReport(student.getStudentId(),teacher.getTeacherId(),fileName);
			break;
//		其他情况，论文初稿等
 		case "first":
			setrow = studentMapper.setIsThesisFirst(student.getStudentId());
			addrow = studentMapper.addThesisFirst(student.getStudentId(),teacher.getTeacherId(),fileName);
			break;
		case "second":
			setrow = studentMapper.setIsThesisSecond(student.getStudentId());
			addrow = studentMapper.addThesisSecond(student.getStudentId(),teacher.getTeacherId(),fileName);
			break;
		case "last":
			setrow = studentMapper.setIsThesisLast(student.getStudentId());
			addrow = studentMapper.addThesisLast(student.getStudentId(),teacher.getTeacherId(),fileName);
			break;
		}
		if(setrow > 0) {
			//更新成功
			System.out.println("更新成功");
			System.out.println("插入审批队列成功");
		}else {
			//更新失败
			System.out.println("更新失败");
			System.out.println("插入审批队列失败");
		}
		//根据情况但会对应的jsp界面
		StudentByIndex.SetReportInfo(model,studentMapper,fileType);
		return "Student/SubReport";
	}

	//专业信息
	public static void MajorInformation(HttpServletRequest request,Model model,StudentMapper studentMapper) {

	}
	
	
	//设置留言系统界面
	/*
	 * 	教师：教师Id、教师姓名
	 * 	学院：
	 * 	
	 */
	public static void SetLMessage(HttpServletRequest request, Model model, StudentMapper studentMapper) {
		Teacher teacher = new Teacher();
		List<Teacher> teacherList = new ArrayList<>();
		List<Teacher> teachers = new ArrayList<>();
		String selectId = request.getParameter("selectId");
		String selectName = request.getParameter("selectName");
		if(selectId != null){
			switch(selectId) {
				case "1":
					teacher = studentMapper.findTeacherById(selectName);
					if(teacher != null) {teacherList.add(teacher);}
					break;
				case "2":
					teachers = studentMapper.findTeacherByName(selectName);
					if(!teachers.isEmpty()) { teacherList.addAll(teachers);}
					break;
			}
		}else{
			teacherList = studentMapper.findTeacherByCollegeId(college.getCollegeId());
			if(teacherList.isEmpty()) {
				return;
			}
		}
		model.addAttribute("teacherList", teacherList);
		model.addAttribute("lineCount", teacherList.size());
	}
	/*
		学生设置个人信息
			所属：班级、专业、学院、学校、以及学历等
			个人邮箱、地址、年龄等信息
		1、将学院信息通过model传递至前端
			学院、专业、班级等
	 */
	public static void SetStudentManager(HttpServletRequest request, Model model, StudentMapper studentMapper) {
		List<Major> majorList = new ArrayList<>();
		List<College> collegeList = new ArrayList<>();
		List<Classes> classess = new ArrayList<>();
		List<Classes> classList = new ArrayList<>();
		majorList = studentMapper.findMajor();
		for (Major major : majorList) {
			classess = studentMapper.findClassByMajorId(major.getMajorId());
			if (!classess.isEmpty()){
				for (Classes classes: classess) {
					classes.setMajor(major);
				}
				classList.addAll(classess);
				classess.clear();
			}
		}
		collegeList = studentMapper.findCollege();
		model.addAttribute("collegeList", collegeList);
		model.addAttribute("collegeCount", collegeList.size());
		model.addAttribute("classList",classList);
		model.addAttribute("classCount",classList.size());
		model.addAttribute("majorList", majorList);
		model.addAttribute("majorCount", majorList.size());
		System.out.println(classList.toString());
	}

	public static void SetTopic(HttpServletRequest request,Model model,StudentMapper studentMapper){
		String topicId = request.getParameter("topicId");
		studentMapper.setIsTopic(student.getStudentId());
		studentMapper.setIsSelected(topicId);
		studentMapper.addStudentTopic(student.getStudentId(),topicId);
		System.out.println("****选择成功");
	}

	public static void ChangePwd(HttpServletRequest request,Model model,StudentMapper studentMapper){
		String oldPwd = studentMapper.findStudentPwd(student.getStudentId());
		String newPwd = request.getParameter("newpwd");
		String dPwd = request.getParameter("dpwd");
		int result = 1;
		if (oldPwd.equals(newPwd) || !(newPwd.equals(dPwd))){
			System.out.println("新密码不能与旧密码相同");
			result = 0;
		}
		int isChange = studentMapper.UpdateStudentPwd(dPwd,student.getStudentId());
		if (isChange <=0 ){
			result = 0;
		}
		model.addAttribute("result",result);
	}

}
