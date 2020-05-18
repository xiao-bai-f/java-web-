package Gttss.TeacherRequest;

import java.io.File;
import java.io.IOException;
import java.net.URI;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.websocket.ContainerProvider;
import javax.websocket.DeploymentException;
import javax.websocket.Session;
import javax.websocket.WebSocketContainer;

import Gttss.MyWebSocket;
import Gttss.Pojo.*;
import org.apache.ibatis.annotations.Param;
import org.springframework.ui.Model;

import Gttss.Other.TeacherClient;
import Gttss.Mapper.TeacherMapper;

/*
 * 根据不同的信息，返回不同的内容
 * 
 */
public class TeacherByIndex {
    static Teacher teacher;
    static Teacher teacherlogin;
	private static Session socket_session;
	private static WebSocketContainer container ;
	private static  URI uri;
	private static final String connectId = "ws://localhost:8080/websocket/";
	private static final String path = "D:/eclipse/脚本文件2/Gttss/src/main/webapp/UploadFile/";
    private static List<College> collegeList;
	static SimpleDateFormat sdf =  new SimpleDateFormat("yyyy-MM-dd");
	private static List<String> allFileName = new ArrayList<>();


	static public boolean isLogin(HttpServletRequest request){
		if ((Teacher)request.getSession().getAttribute("Teacher") != null){
			return true;
		}else{
			return false;
		}
	}
	//登录
	static public String TeacherLogin(HttpServletRequest request,Model model,TeacherMapper teacherMapper){
		if (!isLogin(request)) {
			 teacherlogin = TeacherByIndex.TeacherLoginCheck(request, teacherMapper);
			if (teacherlogin == null) {
				return "Teacher/TeacherLogin";
			}
			teacher = teacherMapper.findTeacherById(teacherlogin.getTeacherId());
			if (teacher != null) {    //登陆成功
				//设置教师的学院信息
				request.getSession().setAttribute("Teacher",teacher);
				collegeList = teacher.getCollegeList();
				request.getSession().setAttribute("CollegeList",collegeList);
				//登陆成返回的前端息
				TeacherInformation(request,model,teacherMapper);
				return "Teacher/TeacherMain";
			}else{
				return "Teacher/TeacherLogin";//登陆失败
			}
		} else {//已经登陆
			TeacherByIndex.TeacherInformation(request,model,teacherMapper);
			return "Teacher/TeacherMain";
		}
	}

	//登出
	static public void TeacherLogout(HttpServletRequest request){
		MyWebSocket myWebSocket = new MyWebSocket();
		request.getSession().invalidate();
		teacher = null;
		collegeList = null;
	}

	//设置教师连接会话
	static public Session ConnectWebSocket(HttpServletRequest request,String connectId){
		teacher = (Teacher)request.getSession().getAttribute("Teacher");
		uri = URI.create(connectId + teacher.getTeacherId());
		container = ContainerProvider.getWebSocketContainer();
		try {
			socket_session = container.connectToServer(TeacherClient.class,uri);
		} catch (DeploymentException | IOException e) {
			e.printStackTrace();
		}
		return  socket_session;
	}

	//检查用户登陆信息是否正确
	static public Teacher TeacherLoginCheck(HttpServletRequest request,TeacherMapper teacherMapper) {
		String teacherId = request.getParameter("teacherId");
		String teacherPwd = request.getParameter("teacherPwd");
		Teacher teacherlogin  = teacherMapper.TeacherLogin(teacherId, teacherPwd);
		return teacherlogin;
	}
	/*将登陆教师信息放置前端*/
	static public void TeacherInformation(HttpServletRequest request,Model model,TeacherMapper teacherMapper) {
//		getSession(request,teacher,collegeList);
		teacher = (Teacher)request.getSession().getAttribute("Teacher");
		collegeList = (List<College>)request.getSession().getAttribute("CollegeList");

	    model.addAttribute("Teacher", teacher);
		model.addAttribute("collegeList", collegeList);

		if (collegeList == null){
			model.addAttribute("collegeCount", 0);
		}else {
			model.addAttribute("collegeCount", collegeList.size());
		}

		SubTime subTime = teacherMapper.findSubTime(teacher.getTeacherId());
		if (subTime != null){
			model.addAttribute("SubTime",subTime);
		}else{
			model.addAttribute("SubTime",subTime);
		}

		Plead plead = teacherMapper.findPlead(teacher.getTeacherId());
		if (plead != null){
			model.addAttribute("Plead",plead);
		}else{
			try{
				java.sql.Date data = new java.sql.Date(sdf.parse("0000-00-00").getTime());
				plead = new Plead(teacher.getTeacherId(),data,"未设置");
				model.addAttribute("Plead",plead);
			}catch (Exception e){
				e.printStackTrace();
			}
		}
	}

	static public void getSession(HttpServletRequest request,Teacher teacher, List<College> collegeList){
		teacher = (Teacher)request.getSession().getAttribute("Teacher");
		collegeList = (List<College>)request.getSession().getAttribute("CollegeList");
	}

    //生成1000以内的随机试题编号
	static private String getTopicId(TeacherMapper teacherMapper){
        String topicId = String.valueOf(new Random().nextInt(1000));
        List<String> topicIdList = teacherMapper.findTopicId();
        int i= 0;
        while (i< topicIdList.size()){
            for (String id:topicIdList) {
                if (topicId.equals(id)){
                    topicId =  String.valueOf(new Random().nextInt(1000));
                    i=0;
                    break;
                }else{
                    i++;
                }
            }
        }
        return topicId;
    }

	//获取教师发布的试题信息
	static public Topic PublishTopic(HttpServletRequest request,Model model,TeacherMapper teacherMapper,Teacher teacher) {

		Topic topic = new Topic();

		//根据教师信息，自动加入不现实前端的信息
		/*
			教师姓名、学校编号、试题发布时间、试题名称、编号（不重复）、要求、描述等
		 */
		topic.setTopicId( getTopicId(teacherMapper));
		topic.setTeacherName(teacher.getTeacherName());
		topic.setPublishTime(new java.sql.Date( new Date().getTime()));
		topic.setTopicName(request.getParameter("TopicName"));
		topic.setTopicDesc(request.getParameter("TopicDesc"));
		topic.setTopicRequier(request.getParameter("TopicRequier"));
		topic.setSchoolId(teacher.getSchoolId());
		topic.setIsSelected("no");

		return topic;
	}
	
	//插入试题与试题教师关系至数据库
//	static public boolean addTopicAndTeacher(TeacherMapper teacherMapper,Topic topic,Teacher teacher) {
//		teacher = (Teacher)request.getSession().getAttribute("Teacher");
//		int row1 = teacherMapper.addTopic(topic);
//		int row2 = teacherMapper.addTeacherTopic(topic.getTopicId(),topic.getSchoolId(),teacher.getTeacherId());
//		if((row1 > 0) && (row2>0)) {return true;}
//		else return false;
//	}
	
	//查看试题
	static public void TopicInformation(HttpServletRequest request,Model model,TeacherMapper teacherMapper) {
		teacher = (Teacher)request.getSession().getAttribute("Teacher");
		List<Topic> topicList = new ArrayList<>();
		List<Student> studentList = new ArrayList<>();
		String selectId = request.getParameter("selectId");
		String selectName = request.getParameter("selectName");
		System.out.println(selectId+selectName);
		if(selectId != null) {
			//按条件查找试题
			switch(selectId) {
			case "1"://按照试题名称
				topicList = teacherMapper.findTopicName(selectName);
				findStudentByTopic(teacherMapper,topicList,studentList);
				break;
			case "2"://按照试题编号
				topicList = teacherMapper.findTopicById(selectName);
				findStudentByTopic(teacherMapper,topicList,studentList);
				break;
//			case "3":
//				//导师提供试题
//			case "4":
//				//学生申请试题
			}
		}else {
			//默认查看所有试题
			topicList = teacherMapper.findTopicByTeacherId(teacher.getTeacherId());
			findStudentByTopic(teacherMapper,topicList,studentList);
		}
		model.addAttribute("topicList", topicList);
		model.addAttribute("lineCount", topicList.size());
		model.addAttribute("studentList",studentList);
	}


	static private void findStudentByTopic(TeacherMapper teacherMapper,List<Topic> topicList,List<Student> studentList){
		for (Topic topic : topicList){
			Student student = teacherMapper.findStudentByIsTopic(topic.getTopicId());
			if (student == null ){
				student = new Student();
				student.setStudentName("未选择");
				student.setStudentId("未选择");
			}
			studentList.add(student);
		}
	}

	//学生管理：教师根据不同条件搜索学生
	static public void StudentInformation(HttpServletRequest request,Model model,TeacherMapper teacherMapper) {
		teacher = (Teacher)request.getSession().getAttribute("Teacher");
		model.addAttribute("teacherId",teacher.getTeacherId());
		collegeList = teacher.getCollegeList();
		List<Student> studentList = new ArrayList<>();
		List<Classes> classesList = new ArrayList<Classes>();
		List<Major> majorList = new ArrayList<Major>();
		String selectName = request.getParameter("selectName");
		String selectId = request.getParameter("selectId");
		System.out.println("log:"+selectName);
		if(!"".equals(selectName) && selectName != null) {
			//按学生学号查找
			if (!"".equals(selectId)) {
				if (selectId.equals("1")) {
					//按学生班级查找学生
					Classes classes;
					for (College college : collegeList) {
						majorList = teacherMapper.findStudentByCollegeId(college.getCollegeId());
						for (Major major : majorList) {
							classes = teacherMapper.findClassByMajorIdAndClassId(selectName, major.getMajorId());
							if (classes != null)
								studentList.addAll(classes.getStudentList());
						}
					}
				} else if (selectId.equals("2")) {
					//按已选试题查找学生
					List<Topic> topicList = teacherMapper.findTopicByTeacherId(teacher.getTeacherId());
					if (topicList.isEmpty()) {
						return;
					}

					for (Topic topic : topicList) {
						Student student = teacherMapper.findStudentByIsTopic(topic.getTopicId());
						if (student != null) {
							studentList.add(student);
						}
					}
				} else if (selectId.equals("3")) {
					//按已选试题查找学生
					List<Topic> topicList = teacherMapper.findTopicByTeacherId(teacher.getTeacherId());
					if (topicList.isEmpty()) {
						return;
					}

					for (Topic topic : topicList) {
						Student student = teacherMapper.findStudentByIsTopic(topic.getTopicId());
						if (student != null) {
							studentList.add(student);
						}
					}
				} else {
					//学生学号
					for (College college : collegeList) {
						majorList = teacherMapper.findStudentByCollegeId(college.getCollegeId());
						for (Major major : majorList) {
							for (Classes classes : major.getClassesList()) {
								if (!teacherMapper.findStudentByClassIdAndStudentId(selectName, classes.getClassId()).isEmpty()) {
									studentList.addAll(teacherMapper.findStudentByClassIdAndStudentId(selectName, classes.getClassId()));
								}
							}
						}
					}
					//按专业名称查找
					for (College college : collegeList) {
						majorList = teacherMapper.findMajorByCollegeIdAndMajorName(selectName, college.getCollegeId());
						for (Major major : majorList) {
							classesList = teacherMapper.findClassByMajorId(major.getMajorId());
							for (Classes classes : classesList) {
								System.out.println(classes.getClassId());
								if (!classes.getStudentList().isEmpty()) {
									studentList.addAll(classes.getStudentList());
								}
							}
						}
					}
					//按姓名查询，模糊查询
					for (College college : collegeList) {
						majorList = teacherMapper.findStudentByCollegeId(college.getCollegeId());
						for (Major major : majorList) {
							for (Classes classes : major.getClassesList()) {
								if (!teacherMapper.findStudentByClassIdAndStudentName(selectName, classes.getClassId()).isEmpty())
									studentList.addAll(teacherMapper.findStudentByClassIdAndStudentName(selectName, classes.getClassId()));
							}
						}
					}
				}
			}
		}else {
			//查找所有学生
			//************获取后台数据结构设计***********
			for (College college : collegeList) {
				majorList = teacherMapper.findStudentByCollegeId(college.getCollegeId());
				for (Major major : majorList) {
				 for (Classes classes : major.getClassesList()) {
					 if(classes.getStudentList() != null) { studentList.addAll(classes.getStudentList());}
				 }	
				}
			}
		}
		System.out.println(studentList);
		if(studentList != null) {//有查询结果
			model.addAttribute("studentList", studentList);
			model.addAttribute("lineCount",studentList.size());
		}else {//无查询结果

		}
		
	}

    //审批试题、开题报告等
    /*
        审批开题报告业务流程：
            1、获取已经提交了开题报告的学生
            2、通过学生获取提交的开题报告
            3、给出审批意见
            4、给出审批结果（同意、退回）
     */
    static public void Approval(HttpServletRequest request,Model model, TeacherMapper teacherMapper,
           String approvalType){
		teacher = (Teacher)request.getSession().getAttribute("Teacher");
        List<Student> openReportstudentList = new ArrayList<>();
        List<Student> midReportstudentList = new ArrayList<>();
        List<Student> thesisFirststudentList = new ArrayList<>();
        List<Student> thesisSecondstudentList = new ArrayList<>();
        List<Student> thesisLaststudentList = new ArrayList<>();

        List<Topic> openReporttopicList = new ArrayList<>();
        List<Topic> midReporttopicList = new ArrayList<>();
        List<Topic> thesisFirsttopicList = new ArrayList<>();
        List<Topic> thesisSecondtopicList = new ArrayList<>();
        List<Topic> thesisLasttopicList = new ArrayList<>();

        List<OpenReport> openReportList = new ArrayList<>();
        List<MidReport> midReportList = new ArrayList<>();
        List<ThesisFirst> thesisFirstList = new ArrayList<>();
        List<ThesisSecond> thesisSecondList = new ArrayList<>();
        List<ThesisLast> thesisLastList = new ArrayList<>();

        /*
            1、查找开题报告、中期检查报告、论文初稿等
         */
        openReportList = teacherMapper.findOpenReportByTeacherId(teacher.getTeacherId());
        midReportList = teacherMapper.findMidReportByTeacherId(teacher.getTeacherId());
        thesisFirstList = teacherMapper.findThesisFirstByTeacherId(teacher.getTeacherId());
        thesisSecondList = teacherMapper.findThesisSecondByTeacherId(teacher.getTeacherId());
		thesisLastList = teacherMapper.findThesisLastByTeacherId(teacher.getTeacherId());

        for (OpenReport openReport:openReportList) {
            Student student = teacherMapper.findStudentByStudentId(openReport.getStudentId());
            Topic topic = teacherMapper.findTopicByStudentId(student.getStudentId());
            openReporttopicList.add(topic);
            openReportstudentList.add(student);

        }

        for (MidReport midReport : midReportList) {
            Student student = teacherMapper.findStudentByStudentId(midReport.getStudentId());
            Topic topic = teacherMapper.findTopicByStudentId(student.getStudentId());
            midReportstudentList.add(student);
            midReporttopicList.add(topic);
        }

        for (ThesisFirst thesisFirst : thesisFirstList) {
            Student student = teacherMapper.findStudentByStudentId(thesisFirst.getStudentId());
            Topic topic = teacherMapper.findTopicByStudentId(student.getStudentId());
            thesisFirststudentList.add(student);
            thesisFirsttopicList.add(topic);
        }
		for (ThesisSecond thesisSecond : thesisSecondList) {
			Student student = teacherMapper.findStudentByStudentId(thesisSecond.getStudentId());
            Topic topic = teacherMapper.findTopicByStudentId(student.getStudentId());
			thesisSecondstudentList.add(student);
			thesisSecondtopicList.add(topic);
		}

		for (ThesisLast thesisLast : thesisLastList) {
			Student student = teacherMapper.findStudentByStudentId(thesisLast.getStudentId());
            Topic topic = teacherMapper.findTopicByStudentId(student.getStudentId());
            thesisLaststudentList.add(student);
			thesisLasttopicList.add(topic);
		}
        /*
            当开题报告、论文等列表为空时，交给前端处理
         */
        switch (approvalType){
            case "open":
                model.addAttribute("title","开题报告");
                model.addAttribute("ReportList",openReportList);
                model.addAttribute("studentList",openReportstudentList);
                model.addAttribute("topicList",openReporttopicList);
                model.addAttribute("lineCount",openReportstudentList.size());
                model.addAttribute("id",8);
                break;
            case "mid":
                model.addAttribute("title","中期检查报告");
				model.addAttribute("ReportList",midReportList);
                model.addAttribute("studentList",midReportstudentList);
                model.addAttribute("topicList",midReporttopicList);
                model.addAttribute("lineCount",midReportstudentList.size());
				model.addAttribute("id",9);
                break;
            case "first":
				model.addAttribute("ReportList",thesisFirstList);
                model.addAttribute("title","论文初稿");
                model.addAttribute("studentList",thesisFirststudentList);
                model.addAttribute("topicList",thesisFirsttopicList);
                model.addAttribute("lineCount",thesisFirststudentList.size());
				model.addAttribute("id",10);
                break;
			case "second":
				model.addAttribute("ReportList",thesisSecondList);
				model.addAttribute("title","论文定稿");
				model.addAttribute("studentList",thesisSecondstudentList);
				model.addAttribute("topicList",thesisSecondtopicList);
				model.addAttribute("lineCount",thesisSecondstudentList.size());
				model.addAttribute("id",11);
				break;
			case "last":
				model.addAttribute("ReportList",thesisLastList);
				model.addAttribute("title","论文终稿");
				model.addAttribute("studentList",thesisLaststudentList);
				model.addAttribute("topicList",thesisLasttopicList);
				model.addAttribute("lineCount",thesisLaststudentList.size());
				model.addAttribute("id",12);
				break;
        }
        model.addAttribute("type",approvalType);
    }

    static public void SetSubTime(HttpServletRequest request,TeacherMapper teacherMapper,Model model){
		java.util.Date date1 = null;
		java.util.Date date2 = null;
		java.util.Date date3 = null;
		java.util.Date date4 = null;
		java.util.Date date5 = null;
		java.util.Date date6 = null;
		try{
			date1 = sdf.parse(request.getParameter("open"));
			date2 = sdf.parse(request.getParameter("mid"));
			date3 = sdf.parse(request.getParameter("first"));
			date4 = sdf.parse(request.getParameter("second"));
			date5 = sdf.parse(request.getParameter("last"));
			date6 = sdf.parse(request.getParameter("topic"));
		} catch (Exception e){
			e.printStackTrace();
		}

		java.sql.Date time1 = new java.sql.Date(date1.getTime());
		java.sql.Date time2 = new java.sql.Date(date2.getTime());
		java.sql.Date time3 = new java.sql.Date(date3.getTime());
		java.sql.Date time4 = new java.sql.Date(date4.getTime());
		java.sql.Date time5 = new java.sql.Date(date5.getTime());
		java.sql.Date time6 = new java.sql.Date(date6.getTime());
		SubTime subTime = new SubTime(time1,time2,time3,time4,time5,time6,teacher.getTeacherId());

		SubTime subTime2 = teacherMapper.findSubTime(teacher.getTeacherId());
		if (subTime2 != null){
			int row = teacherMapper.setSubTime(subTime);
				TeacherInformation(request,model,teacherMapper);
		}else{
			int row = teacherMapper.addSubTime(subTime);
				TeacherInformation(request,model,teacherMapper);
		}

	}

	/*
		设置答辩时间和地址
	 */
	public static void SetPlead(HttpServletRequest request, Model model,TeacherMapper teacherMapper) {
		Plead plead = null;
		try{
			Date date = sdf.parse(request.getParameter("pleadTime"));
			java.sql.Date pleadTime = new java.sql.Date(date.getTime());
			String pleadAddress = request.getParameter("pleadAddress");
			teacher = (Teacher)request.getSession().getAttribute("Teacher");
			plead = new Plead(teacher.getTeacherId(),pleadTime,pleadAddress);
		}catch (Exception e){
			e.printStackTrace();
		}
		 Plead plead2  = teacherMapper.findPlead(teacher.getTeacherId());
		if (plead2 != null){
			int row = teacherMapper.setPlead(plead);
			TeacherInformation(request,model,teacherMapper);
		}else{
			int row = teacherMapper.addPlead(plead);
			TeacherInformation(request,model,teacherMapper);
		}

	}

	/*
		设置修改试题
		1、获取所有试题
	 */
	public static void ChangeTopic(HttpServletRequest request, Model model, TeacherMapper teacherMapper) {
		Topic topic = new Topic();
		String topicId = request.getParameter("id");
		String topicName = request.getParameter("name");
		String topicRequier = request.getParameter("requier");
		String topicDesc = request.getParameter("desc");
		topic.setTopicId(topicId);
		topic.setTopicName(topicName);
		topic.setTopicRequier(topicRequier);
		topic.setTopicDesc(topicDesc);
		String action = request.getParameter("action");
		if (action.equals("修改试题")){
			int row = teacherMapper.updateTopic(topic);
			System.out.println("修改成功");
		}else if (action.equals("删除试题")){
			int row1 = teacherMapper.deleteTeacher_Topic(topicId);
			int row = teacherMapper.deleteTopic(topicId);
			System.out.println("删除成功");
		}
		List<Topic> topicList = teacherMapper.findTopicByTeacherId(teacher.getTeacherId());
	}


	/*
		获取试题申报列表
	 */
    public static void getApproveTopicList(HttpServletRequest request, Model model, TeacherMapper teacherMapper) {
		teacher = (Teacher)request.getSession().getAttribute("Teacher");
    	List<ApproveTopic> approveTopicList = teacherMapper.findTopicListByteacherId(teacher.getTeacherId());
    	List<Student> studentList = new ArrayList<>();
    	List<Classes> classesList = new ArrayList<>();
    	if (!approveTopicList.isEmpty()){
    		model.addAttribute("lineCount",approveTopicList.size());
    		model.addAttribute("ApproveTopicList",approveTopicList);
    		System.out.println(approveTopicList.size());
			for (ApproveTopic at: approveTopicList) {
				studentList.add(teacherMapper.findStudentByStudentId(at.getStudentId()));
				classesList.add(teacherMapper.findClassByStudentId(at.getStudentId()));
			}
			model.addAttribute("studentList",studentList);
			model.addAttribute("classesList",classesList);
		}else{
			System.out.println(approveTopicList.size());
			model.addAttribute("lineCount",0);
		}

    }

	/*
		处理试题申请
		1、同意 添加至数据库
	 */
	public static void DealApprovalTopic(HttpServletRequest request, Model model, TeacherMapper teacherMapper) {
		String topicId  = getTopicId(teacherMapper);
		String topicName = request.getParameter("topicName");
		String topicDesc = request.getParameter("topicDesc");
		String topicRequier = request.getParameter("topicRequier");
		String studentId = request.getParameter("studentId");
		String choice = request.getParameter("choice");
		Topic topic = new Topic(topicId,topicName,topicRequier,topicDesc,teacher.getTeacherName(),new java.sql.Date(new Date().getTime()),"no");
		topic.setSchoolId(teacher.getSchoolId());

		if(choice.equals("1")){
			int row1 = teacherMapper.addTopic(topic);
			int row2 = teacherMapper.addTeacherTopic(topicId,teacher.getSchoolId(),teacher.getTeacherId());
			int row3 = teacherMapper.delectApproveTopic(studentId);
			getApproveTopicList(request,model,teacherMapper);
		}else if (choice.equals("0")){
			int row3 = teacherMapper.delectApproveTopic(studentId);
			getApproveTopicList(request,model,teacherMapper);
		}

    }

	public static void downloadFile(HttpServletRequest request, Model model, TeacherMapper teacherMapper) {
		teacher = (Teacher)request.getSession().getAttribute("Teacher");
//		private static final String path = "D:/eclipse/脚本文件2/Gttss/src/main/webapp/UploadFile/";
		addFileName("OpenReport",model);
		addFileName("MidReport",model);
		addFileName("ThesisFirst",model);
		addFileName("ThesisSecond",model);
		addFileName("ThesisLast",model);
//		model.addAttribute("Teacher",teacher);
	}

	private static void addFileName(String type,Model model){
//		allFileName = getFileList(path+"OpenReport");
		allFileName = getFileList(path+type);
		List<String> fileName = new ArrayList<>();
		for (String str : allFileName){
			fileName.add(str);
		}
		model.addAttribute("type",type);
		model.addAttribute(type+"fileName",fileName);
		allFileName.clear();
	}

	public static List<String> getFileList(String path){
		File fileDir = new File(path);
		if(fileDir != null && fileDir.isDirectory()){
			File[] fileList = fileDir.listFiles();
			if (fileList != null){
				for (int i =0 ;i <fileList.length; i++){
					if (fileList[i].isDirectory()){
						getFileList(fileList[i].getAbsolutePath());
					}else{
						String strFileName = fileList[i].getName();
//						if (strFileName != null && strFileName.endsWith(".docx")){
						if (strFileName != null){
							allFileName.add(strFileName);
						}
					}
				}
			}
		}
		return allFileName;
	}

	/*
		总评分
		1、查找所有选择该导师试题的学生
	 */
	public static void Scoring(HttpServletRequest request, Model model, TeacherMapper teacherMapper) {
		List<Student> studentList = new ArrayList<>();
		List<Topic> topicList = new ArrayList<>();
		List<OpenReport> openReportList = new ArrayList<>();
		List<MidReport> midReportList = new ArrayList<>();
		List<ThesisFirst> thesisFirstList = new ArrayList<>();
		List<ThesisSecond> thesisSecondList  = new ArrayList<>();
		List<ThesisLast> thesisLastList = new ArrayList<>();

		List<Topic> alltopicList =	teacherMapper.findTopicByTeacherId(teacher.getTeacherId());
		for (Topic toppic: alltopicList) {
			Student student = teacherMapper.findStudentByIsTopic(toppic.getTopicId());
			if (student != null){
				Scoring scoring = teacherMapper.findScoringById(student.getStudentId());
				if (scoring == null) {
					studentList.add(student);
					topicList.add(toppic);
				}
			}
		}

		for(Student student:studentList){
			OpenReport openReport = teacherMapper.findOpenReportByStudentId(student.getStudentId());
			MidReport midReport = teacherMapper.findMidReportByStudentId(student.getStudentId());
			ThesisFirst thesisFirst = teacherMapper.findThesisFirstByStudentId(student.getStudentId());
			ThesisSecond thesisSecond = teacherMapper.findThesisSecondByStudentId(student.getStudentId());
			ThesisLast thesisLast = teacherMapper.findThesisLastByStudentId(student.getStudentId());
			if(openReport == null){
				openReport = new OpenReport();
				openReport.setFileName("还未提交");
				openReport.setStatus("无状态");
			}
			if (midReport == null) {
				midReport = new MidReport();
				midReport.setFileName("未提交");
				midReport.setStatus("无状态");
			}
			if (thesisFirst == null){
				thesisFirst = new ThesisFirst();
				thesisFirst.setFileName("未提交");
				thesisFirst.setStatus("无状态");
			}
			if (thesisSecond == null){
				thesisSecond = new ThesisSecond();
				thesisSecond.setFileName("未提交");
				thesisSecond.setStatus("无状态");
			}
			if (thesisLast == null){
				thesisLast = new ThesisLast();
				thesisLast.setFileName("未提交");
				thesisLast.setStatus("无状态");
			}

			openReportList.add(openReport);
			midReportList.add(midReport);
			thesisFirstList.add(thesisFirst);
			thesisSecondList.add(thesisSecond);
			thesisLastList.add(thesisLast);
		}
		model.addAttribute("lineCount",studentList.size());
		model.addAttribute("studentList",studentList);
		model.addAttribute("topicList",topicList);
		model.addAttribute("OpenReportList",openReportList);
		model.addAttribute("MidReportList",midReportList);
		model.addAttribute("ThesisFirstList",thesisFirstList);
		model.addAttribute("ThesisSecondList",thesisSecondList);
		model.addAttribute("ThesisLastList",thesisLastList);

	}


	/*
		评分之后端处理
	 */
    public static void afterScoring(HttpServletRequest request, Model model, TeacherMapper teacherMapper) {
		String content = request.getParameter("content");
		String think = request.getParameter("think");
		String express = request.getParameter("express");
		String answer = request.getParameter("answer");
		String grade = request.getParameter("grade");
		String studentId = request.getParameter("studentId");
		System.out.println(studentId);

		Scoring scoring = new Scoring(studentId,teacher.getTeacherId(),content,think,express,answer,grade,new java.sql.Date(new Date().getTime()));

		int row = teacherMapper.addScoring(scoring);

	}

	/*
		查看评分
	 */
	public static void CheckScoring(HttpServletRequest request, Model model, TeacherMapper teacherMapper) {
		List<Scoring> scoringList = teacherMapper.findScoringByteacherId(teacher.getTeacherId());

		if (scoringList != null){
			System.out.println(scoringList.get(0).getSubtime());
			model.addAttribute("lineCount",scoringList.size());
			model.addAttribute("scoringList",scoringList);
		}else{
			model.addAttribute("lineCount	",0);
			model.addAttribute("scoringList",scoringList);
		}
	}

	public static void ChangeInfo(HttpServletRequest request, Model model, TeacherMapper teacherMapper) {
		teacher = (Teacher)request.getSession().getAttribute("Teacher");
		collegeList = (List<College>)request.getSession().getAttribute("CollegeList");

		model.addAttribute("Teacher",teacher);
		model.addAttribute("CollegeList",collegeList);
	}

	public static void afterChangeInfo(HttpServletRequest request, Model model, TeacherMapper teacherMapper) {
		teacher = (Teacher)request.getSession().getAttribute("Teacher");
		String teacherName = request.getParameter("name");
		String teacherAge = request.getParameter("age");
		String teacherSex = request.getParameter("sex");
		String teacherEmail = request.getParameter("mail");
		String teacherTel = request.getParameter("tel");
		teacher.setTeacherAge(teacherAge);
		teacher.setTeacherSex(teacherSex);
		teacher.setTeacherEmail(teacherEmail);
		teacher.setTeacherTel(teacherTel);
		teacher.setTeacherName(teacherName);

		teacherMapper.updateTeacherById(teacher);

		request.getSession().setAttribute("TeacherId",teacherMapper.findTeacherById(teacher.getTeacherId()));
	}

	public static void afterChangePwd(HttpServletRequest request, Model model, TeacherMapper teacherMapper) {
		teacher = (Teacher) request.getSession().getAttribute("Teacher");
		String oldPwd = teacherMapper.findTeacherPwd(teacher.getTeacherId());
		String newPwd = request.getParameter("newpwd");
		String dPwd = request.getParameter("dpwd");
		int result = 1;
		if (oldPwd.equals(newPwd) || !(newPwd.equals(dPwd))){
			System.out.println("新密码不能与旧密码相同");
			result = 0;
		}
		int isChange = teacherMapper.updateTeacherPwd(teacher.getTeacherId(),dPwd);
		if (isChange <=0 ){
			result = 0;
		}
		model.addAttribute("result",result);
	}
}
