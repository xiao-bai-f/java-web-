package Gttss.TeacherRequest;

import java.io.IOException;
import java.net.URI;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.websocket.ContainerProvider;
import javax.websocket.DeploymentException;
import javax.websocket.Session;
import javax.websocket.WebSocketContainer;

import Gttss.Pojo.*;
import org.springframework.ui.Model;

import Gttss.TeacherClient;
import Gttss.Mapper.TeacherMapper;

/*
 * 根据不同的信息，返回不同的内容
 * 
 */
public class TeacherByIndex {
//    private Teacher teacher;
//    private List<College> collegeList;
	static SimpleDateFormat sdf =  new SimpleDateFormat();
	static Date date = new Date();

	//判断是否重复登录
	static public boolean TeacherIsLogin(HttpServletRequest request) {
		return request.getSession().getAttribute("Teacher")==null?true:false;
	}
	//检查用户登陆信息是否正确
	static public Teacher TeacherLoginCheck(HttpServletRequest request,TeacherMapper teacherMapper) {
		String teacherId = request.getParameter("teacherId");
		String teacherPwd = request.getParameter("teacherPwd");
		Teacher teacherlogin  = teacherMapper.TeacherLogin(teacherId, teacherPwd);
		return teacherlogin;
	}
	/*将登陆教师信息放置前端*/
	static public void TeacherInformation(Model model,Teacher teacher, List<College> collegeList) {
	    model.addAttribute("Teacher", teacher);
		model.addAttribute("collegeList", collegeList);
		model.addAttribute("collegeCount", collegeList.size());
	}
	//创建webSocket会话
	static public Session OpenWebSocket(WebSocketContainer container,Session socket_session,URI uri) {
		container = ContainerProvider.getWebSocketContainer();
		try {
			socket_session = container.connectToServer(TeacherClient.class,uri);
		} catch (DeploymentException | IOException e) {
			e.printStackTrace();
		}
		return socket_session;
	}
	
	//获取教师发布的试题信息
	static public Topic PublishTopic(HttpServletRequest request,Model model, Teacher teacher) {
		Topic topic = new Topic();
		//根据教师信息，自动加入不现实前端的信息
		topic.setTeacherName(teacher.getTeacherName());
		topic.setSchoolId(teacher.getSchoolId());
		//设置时间格式，获取当前时间
		sdf.applyPattern("yyyy-MM-dd HH:mm:ss a");
		String currentDate = sdf.format(date);
		//由教师填写，再加入的前端信息
		topic.setTopicName(request.getParameter("TopicName"));
		topic.setTopicId(request.getParameter("TopicId"));
		topic.setTopicDesc(request.getParameter("TopicDesc"));
		topic.setTopicRequier(request.getParameter("TopicRequier"));
		
		//自动生成
		return topic;
	}
	
	//插入试题与试题教师关系至数据库
	static public boolean addTopicAndTeacher(TeacherMapper teacherMapper,Topic topic,Teacher teacher) {
		int row1 = teacherMapper.addTopic(topic);
		int row2 = teacherMapper.addTeacherTopic(topic.getTopicId(),topic.getSchoolId(),teacher.getTeacherId());
		System.out.println("----log1----");
		if((row1 > 0) && (row2>0)) {return true;}
		else return false;
	}
	
	//查看试题
	static public void TopicInformation(HttpServletRequest request,Model model,TeacherMapper teacherMapper) {
		Teacher teacher = (Teacher)request.getSession().getAttribute("Teacher");
		List<Topic> topicList = new ArrayList<>();
		topicList = teacherMapper.findTopicByTeacherId(teacher.getTeacherId());
		String selectId = request.getParameter("selectId");
		String selectName = request.getParameter("selectName");
		if(selectId != null) {
			//按条件查找试题
			switch(selectId) {
			case "1":
				//按照试题名称
				
			case "2":
				//按照试题编号
			case "3":
				//导师提供试题
			case "4":
				//学生申请试题
			}
		}else {
			//默认查看所有试题
		}

		
		model.addAttribute("topicList", topicList);
		model.addAttribute("lineCount", topicList.size());
	}
	
	//学生管理：教师根据不同条件搜索学生
	static public void StudentInformation(HttpServletRequest request,Model model,TeacherMapper teacherMapper) {
		List<Student> studentList = new ArrayList<>();
		List<Classes> classesList = new ArrayList<Classes>();
		List<Major> majorList = new ArrayList<Major>();
		Teacher teacher = (Teacher)request.getSession().getAttribute("Teacher");
		List<College> collegeList = teacher.getCollegeList();
		String selectId = request.getParameter("selectId");
		String selectName = request.getParameter("selectName");
		if(selectId != null) {
			switch(selectId) {
				case "1":
					//按学生学号查找
					for (College college : collegeList) {
						majorList = teacherMapper.findStudentByCollegeId(college.getCollegeId());
						for (Major major : majorList) {
							 for (Classes classes : major.getClassesList()) {
									if(!teacherMapper.findStudentByClassIdAndStudentId(selectName,classes.getClassId()).isEmpty()) {
										studentList.addAll(teacherMapper.findStudentByClassIdAndStudentId(selectName,classes.getClassId()));
									}
							}	
						}
						break;
					}
					break;
				case"2":
					//按专业名称查找
					System.out.println("专业名称查询" );
					for (College college : collegeList) {
						majorList = teacherMapper.findMajorByCollegeIdAndMajorName("信息与计算科学",college.getCollegeId());
						System.out.println(majorList);
						for (Major major : majorList) {
							classesList = teacherMapper.findClassByMajorId(major.getMajorId());
							//查询不到classesList
//							System.out.println(classesList.get(0));
							for (Classes classes : classesList) {
								System.out.println(classes.getClassId());
								if(!classes.getStudentList().isEmpty()) {
									System.out.println("get one ----");
									studentList.addAll(studentList);
									System.out.println(studentList);
								}
							}
						}
					}
					break;
				case"3":
					//按姓名查询，模糊查询
					for (College college : collegeList) {
						majorList = teacherMapper.findStudentByCollegeId(college.getCollegeId());
						for (Major major : majorList) {
							for (Classes classes : major.getClassesList()) {
								if(!teacherMapper.findStudentByClassIdAndStudentName(selectName,classes.getClassId()).isEmpty())
									studentList.addAll(teacherMapper.findStudentByClassIdAndStudentName(selectName,classes.getClassId()));
							}
						}
					}
						break;
				case"4":
					//按学生班级查找学生
					Classes classes ;
					for (College college : collegeList) {
						majorList = teacherMapper.findStudentByCollegeId(college.getCollegeId());
						for (Major major : majorList) {
							classes = teacherMapper.findClassByMajorIdAndClassId(selectName,major.getMajorId());
							if(classes != null)
								studentList = classes.getStudentList();
						}
					}
					break;
				case"5":
					//按已选试题查找学生
                    List<Topic> topicList = teacherMapper.findTopicByTeacherId(teacher.getTeacherId());
                    if (topicList.isEmpty()){
                        return;
                    }
                    for (Topic topic: topicList ) {
                       Student student = teacherMapper.findStudentByIsTopic(topic.getTopicId());
                        if (student != null){
                            studentList.add(student);
                        }
                    }
					break;
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
    static public void Approval(HttpServletRequest request,Model model,Teacher teacher, TeacherMapper teacherMapper,
           String approvalType){

        List<Student> openReportstudentList = new ArrayList<>();
        List<Student> midReportstudentList = new ArrayList<>();
        List<Student> thesisFirststudentList = new ArrayList<>();
        List<Student> thesisSecondstudentList = new ArrayList<>();
        List<Student> thesisLaststudentList = new ArrayList<>();

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
            if (student != null){
                openReportstudentList.add(student);
                student = null;
            }
        }

        for (MidReport midReport : midReportList) {
            Student student = teacherMapper.findStudentByStudentId(midReport.getStudentId());
            if (student != null){
                midReportstudentList.add(student);
                student = null;
            }
        }

        for (ThesisFirst thesisFirst : thesisFirstList) {
            Student student = teacherMapper.findStudentByStudentId(thesisFirst.getStudentId());
            if (student != null){
                thesisFirststudentList.add(student);
                student = null;
            }
        }
		for (ThesisSecond thesisSecond : thesisSecondList) {
			Student student = teacherMapper.findStudentByStudentId(thesisSecond.getStudentId());
			if (student != null){
				thesisSecondstudentList.add(student);
				student = null;
			}
		}
		for (ThesisLast thesisLast : thesisLastList) {
			Student student = teacherMapper.findStudentByStudentId(thesisLast.getStudentId());
			if (student != null){
				thesisLaststudentList.add(student);
				student = null;
			}
		}
        /*
            当开题报告、论文等列表为空时，交给前端处理
         */
        switch (approvalType){
            case "open":
                model.addAttribute("type","open");
                model.addAttribute("ReportList",openReportList);
                model.addAttribute("studentList",openReportstudentList);
                model.addAttribute("lineCount",openReportstudentList.size());
                break;
            case "mid":
				model.addAttribute("ReportList",midReportList);
                model.addAttribute("type","mid");
                model.addAttribute("studentList",midReportstudentList);
                model.addAttribute("lineCount",midReportstudentList.size());
                break;
            case "first":
				model.addAttribute("ReportList",thesisFirstList);
                model.addAttribute("type","first");
                model.addAttribute("studentList",thesisFirststudentList);
                model.addAttribute("lineCount",thesisFirststudentList.size());
                break;
			case "second":
				model.addAttribute("ReportList",thesisSecondList);
				model.addAttribute("type","first");
				model.addAttribute("studentList",thesisSecondstudentList);
				model.addAttribute("lineCount",thesisSecondstudentList.size());
				break;
			case "last":
				model.addAttribute("ReportList",thesisLastList);
				model.addAttribute("type","first");
				model.addAttribute("studentList",thesisLaststudentList);
				model.addAttribute("lineCount",thesisLaststudentList.size());
				break;
        }
    }

}
