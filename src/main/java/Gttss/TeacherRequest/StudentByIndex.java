package Gttss.TeacherRequest;

import Gttss.Mapper.TeacherMapper;
import Gttss.MyWebSocket;
import Gttss.Other.StudentClient;
import Gttss.Mapper.StudentMapper;
import Gttss.Pojo.*;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.websocket.ContainerProvider;
import javax.websocket.DeploymentException;
import javax.websocket.Session;
import javax.websocket.WebSocketContainer;
import javax.xml.crypto.Data;

import java.io.*;
import java.net.MalformedURLException;
import java.net.URI;
import java.net.URL;
import java.net.URLConnection;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

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

	//设置日期格式
	static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");



	//登录
	public static String StudentLogin(HttpServletRequest request,Model model,StudentMapper studentMapper){
		if(!isLogin(request)) {
			studentlogin = studentMapper.StudentLogin(request.getParameter("studentId"), request.getParameter("studentPwd"));
			if(studentlogin == null) {return "Student/StudentLogin";	}//登录失败
			student = studentMapper.findStudentById(studentlogin.getStudentId());
			if(student != null) {
				request.getSession().setAttribute("Student",student);
				StudentByIndex.SetStudentInfo(request,model,studentMapper);

				return "Student/StudentMain";
			}else {
				return "Student/StudentLogin";
			}
		}else {
//			student = (Student) request.getSession().getAttribute("Student");
			StudentByIndex.SetStudentInfo(request,model,studentMapper);
			return "Student/StudentMain";
		}
	}

	public static boolean isLogin(HttpServletRequest request){
		if(request.getSession().getAttribute("Student") != null){
			return true;
		}else {
			return false;
		}
	}
	/*
		退出登录
			关闭会话、将student对象指向为空
	 */
	public static void StudentLogOut(HttpServletRequest request){
		request.getSession().invalidate();//销毁会话
		student = null;
		studentlogin = null;
	}
	//连接webSocket
	public static void ConnectWebSocket(HttpServletRequest request,String connectId){
		student = (Student)request.getSession().getAttribute("Student");
		uri = URI.create(connectId+student.getStudentId());
		container = ContainerProvider.getWebSocketContainer();
		try {
			socket_session = container.connectToServer(StudentClient.class,uri);
		} catch (DeploymentException | IOException e) {
			e.printStackTrace();
		}
	}

	//设置学生信息
	public static void SetStudentInfo(HttpServletRequest request ,Model model,StudentMapper studentMapper) {

		student = (Student)request.getSession().getAttribute("Student");
		model.addAttribute("Student",student);
		classes = studentMapper.findClassByStduentId(student.getStudentId());
		if(classes == null) {return;}
		major = studentMapper.findMajorByClassId(classes.getClassId());
		if(major == null) {return;}
		college = studentMapper.findCollegeByMajorId(major.getMajorId());
		if(college == null) {return;}

		request.getSession().setAttribute("Classes",classes);
		request.getSession().setAttribute("Major",major);
		request.getSession().setAttribute("College",college);

		setAllTime(studentMapper,student,model);

		setPlead(studentMapper,student,model);

		setScoring(studentMapper,student,model);

		model.addAttribute("Classes",classes);
		model.addAttribute("Major",major);
		model.addAttribute("College",college);

	}

	/*
		获取学生的总评信息
	 */
	private static void setScoring(StudentMapper studentMapper, Student student, Model model){
		if(student.getIsTopic().equals("1")){
			OpenReport openReport = studentMapper.findOpenReport(student.getStudentId());
			MidReport midReport = studentMapper.findMidReport(student.getStudentId());
			ThesisFirst thesisFirst = studentMapper.findThesisFirst(student.getStudentId());
			ThesisSecond thesisSecond = studentMapper.findThesisSecond(student.getStudentId());
			ThesisLast thesisLast = studentMapper.findThesisLast(student.getStudentId());
			if (openReport == null || midReport == null || thesisFirst == null || thesisSecond == null || thesisLast == null){
				Date date = null;
				try {
					date = sdf.parse("0000-00-00");
				} catch (ParseException e) {
					e.printStackTrace();
				}
				Scoring scoring = new Scoring("待定","待定","待定","待定","待定","待定","待定",new java.sql.Date(date.getTime()));
				model.addAttribute("scoring",scoring);
			}else{
				Scoring scoring = studentMapper.findScoringByStudentId(student.getStudentId());
				model.addAttribute("scoring",scoring);
			}

		}
	}
	/*
		获取教师设置的答辩信息
	 */
	private static void setPlead(StudentMapper studentMapper, Student student, Model model) {
		if(student.getIsTopic().equals("1")){
			Topic topic = studentMapper.findTopicByStudentId(student.getStudentId());
			Teacher teacher = studentMapper.findTeacherByTopicId(topic.getTopicId());
			Plead plead = studentMapper.findPleadByTeacherId(teacher.getTeacherId());
			if (plead != null){
				model.addAttribute("pleadTime",plead.getPleadTime());
				model.addAttribute("pleadAddress",plead.getPleadAddress());
			}else{
				model.addAttribute("pleadTime","待定");
				model.addAttribute("pleadAddress","待定");
			}
		}else{
			model.addAttribute("pleadTime","待定");
			model.addAttribute("pleadAddress","待定");
		}
	}

	/*
		查找所有的报告提交时间
	 */
	static private void setAllTime(StudentMapper studentMapper,Student student,Model model){
		Date currentDate = new Date();
		if(student.getIsTopic().equals("1")) {    //已经选择试题
			Topic topic = studentMapper.findTopicByStudentId(student.getStudentId());
			Teacher teacher = studentMapper.findTeacherByTopicId(topic.getTopicId());
			Progress progress = studentMapper.findProgressByTeacherI(teacher.getTeacherId());
			//是否提交了开题报告、中期检查、初稿等
			OpenReport openReport = studentMapper.findOpenReport(student.getStudentId());
			MidReport midReport = studentMapper.findMidReport(student.getStudentId());
			ThesisFirst thesisFirst = studentMapper.findThesisFirst(student.getStudentId());
			ThesisSecond thesisSecond = studentMapper.findThesisSecond(student.getStudentId());
			ThesisLast thesisLast = studentMapper.findThesisLast(student.getStudentId());

			if (progress != null) {
				//开题报告、中期检查等
				CompareTime(model,progress,openReport,"isStartOpenReport");
				CompareTime(model,progress,midReport,"isStartMidReport");
				CompareTime(model,progress,thesisFirst,"isStartThesisFirst");
				CompareTime(model,progress,thesisSecond,"isStartThesisSecond");
				CompareTime(model,progress,thesisLast,"isStartThesisLast");
			}else{
				model.addAttribute("isStartOpenReport", "未开始");
				model.addAttribute("isStartMidReport", "未开始");
				model.addAttribute("isStartThesisFirst", "未开始");
				model.addAttribute("isStartThesisSecond", "未开始");
				model.addAttribute("isStartThesisLast", "未开始");
			}
		}
	}
	/*
		比价当前时间和提交时间
	 */
	static private void CompareTime(Model model,Progress progress,BaseReport baseReport,String name ){
		Date currentDate = new Date();
		java.sql.Date progressdata = null;
		switch (name){
			case "isStartOpenReport":
				progressdata = progress.getSubOpenReport();
				break;
			case "isStartMidReport":
				progressdata = progress.getSubMidCheck();
				break;
			case "isStartThesisFirst":
				progressdata = progress.getSubThesisFirst();
				break;
			case "isStartThesisSecond":
				progressdata = progress.getSubThesisSecond();
				break;
			case "isStartThesisLast":
				progressdata = progress.getSubThesisLast();
				break;
		}
		if (currentDate.after(progressdata)) {//已经开始要提交报告
			if (baseReport != null) {
				model.addAttribute(name, baseReport.getSubTime() + "提交");
			} else {
				model.addAttribute(name, "未提交");
			}
		} else {    //还未开始
			if (baseReport != null) {
				model.addAttribute(name, baseReport.getSubTime() + "提交");
			} else {
				model.addAttribute(name, "未开始");
			}
		}
	}

	static private void getSession(HttpServletRequest request,Student student,Classes classes,Major major,College college){
		student = (Student)request.getSession().getAttribute("Student");
		classes = (Classes) request.getSession().getAttribute("Classes");
		major = (Major)request.getSession().getAttribute("Major");
		college = (College)request.getSession().getAttribute("College");
	}
	//设置提交开题报告的界面的信息
	/*
	 * 业务逻辑
	 * 1、提交报告之前必须检查是否选择了试题；没事试题，则不能提交
	 * 2、是否已经提交过开题报告了
	 */
	public static void SetReportInfo(HttpServletRequest request,Model model,StudentMapper studentMapper,String type) {
		student = (Student)request.getSession().getAttribute("Student");
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
		model.addAttribute("Student", student);

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
				model.addAttribute("id", 9);
				model.addAttribute("title", "开题报告");
				break;
			case "mid":
				isReport = studentMapper.findIsMidReport(student.getStudentId());
				if(isReport.equals("1")){
					midReport = studentMapper.findMidReport(student.getStudentId());
					Status = midReport.getStatus();
				}
				model.addAttribute("Report", midReport);
				model.addAttribute("id", 10);
				model.addAttribute("title", "中期检查报告");
				break;
			case "first":
				isReport = studentMapper.findIsThesisFirst(student.getStudentId());
				if(isReport.equals("1")){
					thesisFirst = studentMapper.findThesisFirst(student.getStudentId());
					Status = thesisFirst.getStatus();
				}
				model.addAttribute("Report", thesisFirst);
				model.addAttribute("id", 11);
				model.addAttribute("title", "论文初稿");
				break;
			case "second":
				isReport = studentMapper.findIsThesisSecond(student.getStudentId());
				if(isReport.equals("1")){
					thesisSecond = studentMapper.findThesisSecond(student.getStudentId());
					Status = thesisSecond.getStatus();
				}
				model.addAttribute("Report", thesisSecond);
				model.addAttribute("id", 12);
				model.addAttribute("title", "论文定稿");
				break;
			case "last":
				isReport = studentMapper.findIsThesisLast(student.getStudentId());
				if(isReport.equals("1")){
					thesisLast = studentMapper.findThesisLast(student.getStudentId());
					Status = thesisLast.getStatus();
				}
				model.addAttribute("Report", thesisLast);
				model.addAttribute("id", 12);
				model.addAttribute("title", "论文终稿");
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
	public static void FindTopicInfo(HttpServletRequest request,Model model,StudentMapper studentMapper) {
		getSession(request, student, classes, major, college);
		List<Teacher> teacherList = new ArrayList<Teacher>();
		List<Topic> topicList = new ArrayList<Topic>();
		List<Topic> topics = new ArrayList<>();
		String selectId = request.getParameter("selectId");
		String selectName = request.getParameter("selectName");
		teacherList = studentMapper.findTeacherByCollegeId(college.getCollegeId());
		//导师为空
		if (teacherList.isEmpty()) {
			model.addAttribute("TeacherCount", 0);
			return;
		}
		if (selectId != null) {
			switch (selectId) {
				case "1":
					if (!selectName.equals("")) {
						for (Teacher teacher : teacherList) {
							topics = studentMapper.findTopicByTeacherIdAndTopicId(teacher.getTeacherId(), selectName);
							if (!topics.isEmpty()) {
								topicList.addAll(topics);
							}
							topics.clear();
						}
					} else {
						for (Teacher teacher : teacherList) {
							topics = studentMapper.findTopicByTeacherId(teacher.getTeacherId());
							if (!topics.isEmpty()) {
								topicList.addAll(topics);
							}
							topics.clear();
						}
					}

					break;
				case "2":
					if (!selectName.equals("")) {
						for (Teacher teacher : teacherList) {
							topics = studentMapper.findTopicByTeacherIdAndTopicName(teacher.getTeacherId(), selectName);
							if (!topics.isEmpty()) {
								topicList.addAll(topics);
							}
							topics.clear();
						}
					} else {
						for (Teacher teacher : teacherList) {
							topics = studentMapper.findTopicByTeacherId(teacher.getTeacherId());
							if (!topics.isEmpty()) {
								topicList.addAll(topics);
							}
							topics.clear();
						}
					}
					break;
				case "3"://教师编号
					for (Teacher teacher : teacherList) {
						if (teacher.getTeacherId().equals(selectName)) {
							topics = studentMapper.findTopicByTeacherId(teacher.getTeacherId());
							if (!topics.isEmpty()) {
								topicList.addAll(topics);
							}
							topics.clear();
						}
					}
					break;
				case "4"://教师名称
					teacherList = studentMapper.findTeacherByCollegeIdAndTeacherName(college.getCollegeId(),selectName);
					for (Teacher teacher : teacherList) {
						topics = studentMapper.findTopicByTeacherId(teacher.getTeacherId());
						if(!topics.isEmpty()) {
							topicList.addAll(topics);
						}
						topics.clear();
					}
					break;

				case "5":
					for (Teacher teacher : teacherList) {
						topics = studentMapper.findTopicIsSelectedByTeacherId(teacher.getTeacherId(), selectName);
						if (!topics.isEmpty()) {
							topicList.addAll(topics);
						}
						topics.clear();
					}
					break;
			}
		}else{
			for (Teacher teacher : teacherList) {
				topics = studentMapper.findTopicByTeacherId(teacher.getTeacherId());
				if(!topics.isEmpty()) {
					topicList.addAll(topics);
				}
				topics.clear();
			}
		}

		/*
		 * ps:college 为学生登录时，由学生所在班级专业等信息获得，并设置
		 */
		//查找学生所在学院内所有的导师

		//导师为空，没试题可以选择

		
		//查找导师对应提供的试题

		//导师还没有提供试题

		String isTopic = studentMapper.findIsTopic(student.getStudentId());
		//是否已经选择试题、试题列表、试题数量
		model.addAttribute("IsTopic", isTopic);
		model.addAttribute("TopicCount",topicList.size());
		model.addAttribute("TopicList",topicList);
		model.addAttribute("TeacherList",teacherList);
		model.addAttribute("CollegeName",college.getCollegeName());
	}
	

	//接收上传文件
	public static String ReceiveFile(HttpServletRequest request,Model model,StudentMapper studentMapper,MultipartFile file,String fileType){
		student = (Student)request.getSession().getAttribute("Student");
		String contentType = file.getContentType();
		String fileName = file.getOriginalFilename();
		System.out.println("文件类型"+contentType);
		System.out.println("文件名称"+fileName);

		/*
		过滤文件
		 */
		
		//文件上传路径:默认是上传开题报告
		String uploadPath = "UploadFile/OpenReport/";
		fileName = student.getStudentId()+student.getStudentName()+".docx";
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
				uploadPath = "UploadFile/ThesisSecond/";
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
            StudentByIndex.SetReportInfo(request,model,studentMapper,fileType);
            return "Student/SubReport";
		}
		//上传成功
		//更新学生上传开题报告状态（已提交）
		int setrow = 0;
		int addrow = 0;
		BaseReport baseReport = new BaseReport();
		baseReport.setStudentId(student.getStudentId());
		baseReport.setTeacherId(teacher.getTeacherId());
		baseReport.setFileName(fileName);
		baseReport.setSubTime(new java.sql.Date(new Date().getTime()));

		switch(fileType) {
		case "open":
			setrow = studentMapper.setIsOpenReport(student.getStudentId());
			addrow = studentMapper.addOpenReport(baseReport);
			break;
		case "mid":
			setrow = studentMapper.setIsMidReport(student.getStudentId());
			addrow = studentMapper.addMidReport(baseReport);
			break;
//		其他情况，论文初稿等
 		case "first":
			setrow = studentMapper.setIsThesisFirst(student.getStudentId());
			addrow = studentMapper.addThesisFirst(baseReport);
			break;
		case "second":
			setrow = studentMapper.setIsThesisSecond(student.getStudentId());
			addrow = studentMapper.addThesisSecond(baseReport);
			break;
		case "last":
			setrow = studentMapper.setIsThesisLast(student.getStudentId());
			addrow = studentMapper.addThesisLast(baseReport);
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
		student = (Student)request.getSession().getAttribute("Student");
		student = studentMapper.findStudentById(student.getStudentId());
		request.getSession().setAttribute("Student",student);
		StudentByIndex.SetReportInfo(request,model,studentMapper,fileType);
		return "Student/SubReport";
	}

	//设置留言系统界面
	/*
	 * 	教师：教师Id、教师姓名
	 * 	学院：
	 * 	
	 */
	public static void SetLMessage(HttpServletRequest request, Model model, StudentMapper studentMapper) {
		student = (Student)request.getSession().getAttribute("Student");
		Teacher teacher = new Teacher();
		List<Teacher> teacherList = new ArrayList<>();
		List<Teacher> teachers = new ArrayList<>();
		String selectId = request.getParameter("selectId");
		String selectName = request.getParameter("selectName");
		if(!"".equals(selectName) && selectName != null){
			teacher = studentMapper.findTeacherById(selectName);
			if(teacher != null) {
				teacherList.add(teacher);
			}
			teachers = studentMapper.findTeacherByName(selectName);
			if(!teachers.isEmpty()) { teacherList.addAll(teachers);}
		}else{
			teacherList = studentMapper.findTeacherByCollegeId(college.getCollegeId());
			if(teacherList.isEmpty()) {
				return;
			}
		}
		model.addAttribute("studentId",student.getStudentId());
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
		student = (Student)request.getSession().getAttribute("Student");
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
		model.addAttribute("Student",student);
		getSession(request,student,classes,major,college);
		model.addAttribute("Classes",classes);
		model.addAttribute("Major",major);
		model.addAttribute("College",college);
	}

	public static void SetTopic(HttpServletRequest request,Model model,StudentMapper studentMapper){
		student = (Student)request.getSession().getAttribute("Student");
		String topicId = request.getParameter("topicId");
		studentMapper.setIsTopic(student.getStudentId());
		studentMapper.setIsSelected(topicId);
		studentMapper.addStudentTopic(student.getStudentId(),topicId);

	}

	//修改密码
	public static void ChangePwd(HttpServletRequest request,Model model,StudentMapper studentMapper){
		student = (Student)request.getSession().getAttribute("Student");
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

	//修改学生信息
	public static void ChangeInfo(HttpServletRequest request, Model model,StudentMapper studentMapper) {
		student = (Student)request.getSession().getAttribute("Student");
		student.setStudentName(request.getParameter("name"));
		student.setStudentAge(request.getParameter("age"));
		student.setStudentSex(request.getParameter("sex"));
		student.setStudentEducation(request.getParameter("xl"));
		student.setStudentEmail(request.getParameter("mail"));
		student.setStudentTel(request.getParameter("tel"));
		student.setStudentTel(request.getParameter("major"));
		student.setStudentTel(request.getParameter("college"));
		student.setStudentAddress(request.getParameter("provice")+request.getParameter("city")+request.getParameter("county"));
		String studentId = studentMapper.findStudentFromClassse(student.getStudentId());
		if(studentId != null){	//记录了学生所在班级
			studentMapper.deleteStudentFromClasses(studentId);
			studentMapper.addStudentClass(student.getStudentId(),request.getParameter("classes"));
		}
		//		int row3 = studentMapper.addClassMajor(request.getParameter("major"),request.getParameter("classes"));
//		int row4 = studentMapper.addMajorCollege(request.getParameter("major"),request.getParameter("classes"));
		int row = studentMapper.updateStudentInfo(student);
		request.getSession().setAttribute("Student",student);
		SetStudentInfo(request,model,studentMapper);


	}

	static void setSession(HttpServletRequest request ,Student student,Classes classes,Major major,College college){
		request.getSession().setAttribute("Student",student);
		request.getSession().setAttribute("Classes",classes);
		request.getSession().setAttribute("Major",major);
		request.getSession().setAttribute("College",college);
	}

	/*
		申请试题
			1、获得学生所在学院的教师
			2、
	 */
	public static void ApproveTopic(HttpServletRequest request, Model model,StudentMapper studentMapper) {
		getSession(request,student,classes,major,college);
		List<Teacher> teacherList = studentMapper.findTeacherByCollegeId(college.getCollegeId());
		model.addAttribute("teacherList",teacherList);
		model.addAttribute("istrue",0);
	}

	/*
		处理试题申请
	 */
	public static void ApproveTopicAfter(HttpServletRequest request, Model model, StudentMapper studentMapper) {
		String teacherId  = request.getParameter("teacherId");
		String teacherName  = request.getParameter("teacherName");
		String TopicName  = request.getParameter("topicName");
		String TopicRequier  = request.getParameter("topicRequier");
		String TopicDesc  = request.getParameter("topicDesc");
		java.sql.Date approveData = new java.sql.Date(new Date().getTime());
		getSession(request,student,classes,major,college);
		List<Teacher> teacherList = studentMapper.findTeacherByCollegeId(college.getCollegeId());
		model.addAttribute("teacherList",teacherList);
		String studentId = student.getStudentId();

		int row = 0;
		try{
			row = studentMapper.addApproveTopic(TopicName,TopicRequier,TopicDesc,teacherName,teacherId,studentId,approveData);
		}catch (Exception e){
			//捕捉插入异常
			model.addAttribute("istrue",1);
			return;
		}

		if (row>0){
			model.addAttribute("istrue",2);
		}else{
			model.addAttribute("istrue",3);
		}

	}

	public static void DownloadFile(HttpServletRequest request, Model model) {
		student = (Student)request.getSession().getAttribute("Student");
		model.addAttribute("Student",student);
	}

	/*
		申请随机不重复试题编号
	 */
//	static private String getTopicId(StudentMapper studentMapper){
//		String topicId = String.valueOf(new Random().nextInt(1000));
//		List<String> topicIdList = studentMapper.findTopicId();
//		int i= 0;
//		while (i< topicIdList.size()){
//			for (String id:topicIdList) {
//				if (topicId.equals(id)){
//					topicId =  String.valueOf(new Random().nextInt(1000));
//					i=0;
//					break;
//				}else{
//					i++;
//				}
//			}
//		}
//		return topicId;
//	}
}
