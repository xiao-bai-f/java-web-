package Gttss.Controller;

import Gttss.Mapper.TeacherMapper;
import Gttss.Pojo.College;
import Gttss.Pojo.Teacher;
import Gttss.Pojo.Topic;
import Gttss.TeacherRequest.TeacherByIndex;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;
import javax.websocket.WebSocketContainer;

import java.io.File;
import java.io.IOException;
import java.net.URI;
import java.util.List;

@Controller
public class TeacherController {

    @Autowired(required = false)
    TeacherMapper teacherMapper;
    private Teacher teacher;
    private Session socket_session;    //webSocket协议的会话
    private WebSocketContainer container = null;
    private List<College> collegeList;
    private Topic topic = new Topic();
    private URI uri = null;
    HttpSession session;

    //教师登陆
    @RequestMapping("/Teacher/TeacherLogin")
    public String TeacherLogin(HttpServletRequest request, Model model) {
        session = request.getSession();    //会话管理
        if (TeacherByIndex.TeacherIsLogin(request)) {    //会话为空，第一次登陆
            Teacher teacherlogin = TeacherByIndex.TeacherLoginCheck(request, teacherMapper);
            if (teacherlogin == null) {
                return "Teacher/TeacherLogin";
            }
            Teacher teacher = teacherMapper.findTeacherById(teacherlogin.getTeacherId());
            if (teacher != null) {    //登陆成功
                //设置教师的学院信息
                List<College> collegeList = teacher.getCollegeList();
                uri = URI.create("ws://localhost:8080/websocket/" + teacher.getTeacherId());
                //设置教师连接会话
                socket_session = TeacherByIndex.OpenWebSocket(container, socket_session, uri);

                //登陆成功返回的前端信息
                TeacherByIndex.TeacherInformation(model, teacher, collegeList);

                //设置教师登陆信息
                this.teacher = teacher;
                this.collegeList = collegeList;

                //将教师信息添加至会话中
                session.setAttribute("Teacher", teacher);
                session.setAttribute("TeacherLogin", teacherlogin);
                session.setAttribute("CollegeList", collegeList);
                //返回教师登陆主页
                return "Teacher/TeacherMain";
            } else return "Teacher/TeacherLogin";//登陆失败
        } else {//已经登陆
            //获取教师在会话中的信息
            this.collegeList = (List<College>) session.getAttribute("College");
            this.teacher = (Teacher) session.getAttribute("Teacher");

            TeacherByIndex.TeacherInformation(model, teacher, collegeList);
            return "Teacher/TeacherMain";
        }
    }


    //教师主页信息
    @RequestMapping(name = "/Teacher/TeacherMain")
    public String TeacherMain(HttpServletRequest request, Model model, HttpSession session) {
        String actionId = request.getParameter("id");
        if (actionId == null) actionId = "1";
        switch (actionId) {
            case "1": //当参数为1，代表着访问教师主页信息
                TeacherByIndex.TeacherInformation(model, teacher, collegeList);
                return "Teacher/TeacherMain";
            case "2": //试题管理
                //将教师发布的试题信息插入试题数据表中
                return "Teacher/TopicManage";
            case "7"://试题查看
                TeacherByIndex.TopicInformation(request, model, teacherMapper);
                return "Teacher/CheckTopic";
            case "8"://审批试题、开题报告、论文初稿等
                TeacherByIndex.Approval(request, model, teacher, teacherMapper, "open");
                return "Teacher/ApprovalFile";
            case "9"://审批中期检查报告
                TeacherByIndex.Approval(request, model, teacher, teacherMapper, "mid");
                return "Teacher/ApprovalFile";
            case "10"://审批论文初稿
                TeacherByIndex.Approval(request, model, teacher, teacherMapper, "first");
                return "Teacher/ApprovalFile";
            case "11"://审批论文
                TeacherByIndex.Approval(request, model, teacher, teacherMapper, "second");
                return "Teacher/ApprovalFile";
            case "12"://审批论文终稿
                TeacherByIndex.Approval(request, model, teacher, teacherMapper, "last");
                return "Teacher/ApprovalFile";
            case "3"://查看学生
                TeacherByIndex.StudentInformation(request, model, teacherMapper);
                return "Teacher/CheckStudent";
            case "4"://学生留言
                TeacherByIndex.StudentInformation(request, model, teacherMapper);
                return "Teacher/StudentMessage";
            case "6":    //退出登陆
                //销毁会话，回到登陆界面
                session.invalidate();
                try {
                    socket_session.close();
                } catch (IOException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
                //垃圾回收机制，当指针指向为空时，自动回收
                this.teacher = null;
                this.topic = null;
                this.collegeList = null;
                this.container = null;
                this.uri = null;
                System.gc();
                return "Teacher/TeacherLogin";
        }
        return "Teacher/TeacherMain";
    }

    //试题管理 - 插入试题
    @RequestMapping(value = "/Teacher/TopicManage", method = RequestMethod.POST)
    public String TopicManage(HttpServletRequest request, Model model, HttpSession session) {
        //发布试题
        this.topic = TeacherByIndex.PublishTopic(request, model, teacher);
        //将数据存放至数据库
        if (TeacherByIndex.addTopicAndTeacher(teacherMapper, topic, teacher)) {
            return "redirect:/TopicManage?id=7";//插入成功，跳转查看试题界面
        } else {
            return "Teacher/TopicManage";
        }    //插入失败,重新插入
    }

    //查看试题
    @RequestMapping(value = "/Teacher/CheckTopic", method = RequestMethod.POST)
    public String CheckTopic(HttpServletRequest request, Model model) {
        TeacherByIndex.TopicInformation(request, model, teacherMapper);
        return "";
    }

    //查看学生
    @RequestMapping(value = "/Teacher/CheckStudent", method = RequestMethod.POST)
    public String CheckStudent(HttpServletRequest request, Model model) {
        TeacherByIndex.StudentInformation(request, model, teacherMapper);
        return "Teacher/CheckStudent";
    }

    //处理教师审批结果
    @Transactional
    @RequestMapping(value = "/Teacher/DealApproval")
    public String DealApproval(HttpServletRequest request) {
        StringBuffer sb = new StringBuffer();
        int row = 0;
        String studentId = request.getParameter("studentId");
        String studentName = request.getParameter("studentName");
        String type = request.getParameter("type");
        String opinion = request.getParameter("opinion");
        String fileName = request.getParameter("fileName");
        sb.append(request.getParameter("opinionText"));

        if (opinion.equals("同意")) {
            switch (type) {
                case "open":
                    row = teacherMapper.setOpenReportStatus(studentId, "1");
                    break;
                case "mid":
                    row = teacherMapper.setMidReportStatus(studentId,"1");
                    break;
                case "first":
                    row = teacherMapper.setThesisFirstStatus(studentId,"1");
            }
            if (row > 0) {
                //审批完成
                System.out.println("审批通过");
            } else {
                System.out.println("发生异常");
            }
        } else if (opinion.equals("退回")) {
            //将开题报告的状态设置为退回
			//将开题报告原件删除、设置表t_openReport的状态设置为退回
            String path = "D:/eclipse/脚本文件2/Gttss/src/main/webapp";
            String midPath = "";
            switch (type){
                case "open":
                    midPath = "/UploadFile/OpenReport/";
                    row = teacherMapper.setOpenReportStatus(studentId, "2");
                    break;
                case "mid":
                    midPath = "/UploadFile/MidReport/";
                    row = teacherMapper.setMidReportStatus(studentId, "2");
                    break;
                case "first":
                    midPath = "/UploadFile/ThesisFirst/";
                    row = teacherMapper.setThesisFirstStatus(studentId, "2");
                    break;
            }
            String filepath = path+ midPath + fileName;
            File file = new File(filepath);
            if (file.exists()) {
                file.delete(); //删除文件
                System.out.println("文件删除");
            }
            if (row > 0) {
                System.out.println("回退成功");
            } else {
                System.out.println("回退发生异常");
            }
        }
        return  "studentMain?id=1";
    }
}
