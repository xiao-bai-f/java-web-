package Gttss.Controller;

import Gttss.Mapper.StudentMapper;
import Gttss.Mapper.TeacherMapper;
import Gttss.Pojo.College;
import Gttss.Pojo.SubTime;
import Gttss.Pojo.Teacher;
import Gttss.Pojo.Topic;
import Gttss.SendMessage.StudentMessage;
import Gttss.TeacherRequest.TeacherByIndex;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;
import javax.websocket.WebSocketContainer;

import java.io.*;
import java.net.MalformedURLException;
import java.net.URI;
import java.net.URL;
import java.net.URLConnection;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;

@Controller
public class TeacherController {

    @Autowired(required = false)
    TeacherMapper teacherMapper;

    StudentMessage studentMessage = new StudentMessage();

    static ConcurrentHashMap<String, TeacherMapper> mapperContainer = new ConcurrentHashMap<>();

    public int addMessage(String Sender, String Recever, String message) {
        TeacherMapper teacherMapper = mapperContainer.get(Sender);
        return studentMessage.addMessage(Sender, Recever, message, teacherMapper);
    }
    public void updateIsRead(String sender,String recever){
        TeacherMapper teacherMapper = mapperContainer.get(sender);
        studentMessage.updateIsRead(recever,sender,teacherMapper);
    }

    public int  getNoReadCount(String sender,String recever){
        TeacherMapper teacherMapper = mapperContainer.get(recever);
        int count = studentMessage.getNoReadCount(sender,recever,teacherMapper);
        return count;
    }

    //教师登陆
    @RequestMapping( value = "/Teacher/TeacherLogin")
    public String TeacherLogin(HttpServletRequest request, Model model) {
        mapperContainer.put(request.getParameter("teacherId"), teacherMapper);
        return TeacherByIndex.TeacherLogin(request, model, teacherMapper);
    }


    //教师主页信息
    @GetMapping(value = "Teacher/TeacherMain")
    public String TeacherMain(HttpServletRequest request, Model model) {
        String actionId = request.getParameter("id");
        if (actionId == null) actionId = "1";
        switch (actionId) {
            case "1": //当参数为1，代表着访问教师主页信息
                TeacherByIndex.TeacherInformation(request, model,teacherMapper);
                return "Teacher/TeacherMain";
            case "2": //试题管理
                //将教师发布的试题信息插入试题数据表中
                model.addAttribute("isfail","0");
                return "Teacher/TopicManage";
            case "7"://试题查看
                TeacherByIndex.TopicInformation(request, model, teacherMapper);
                return "Teacher/CheckTopic";
            case "8"://审批试题、开题报告、论文初稿等
                TeacherByIndex.Approval(request, model, teacherMapper, "open");
                return "Teacher/ApprovalFile";
            case "9"://审批中期检查报告
                TeacherByIndex.Approval(request, model, teacherMapper, "mid");
                return "Teacher/ApprovalFile";
            case "10"://审批论文初稿
                TeacherByIndex.Approval(request, model, teacherMapper, "first");
                return "Teacher/ApprovalFile";
            case "11"://审批论文
                TeacherByIndex.Approval(request, model, teacherMapper, "second");
                return "Teacher/ApprovalFile";
            case "12"://审批论文终稿
                TeacherByIndex.Approval(request, model, teacherMapper, "last");
                return "Teacher/ApprovalFile";
            case "3"://查看学生
                TeacherByIndex.StudentInformation(request, model, teacherMapper);
                return "Teacher/CheckStudent";
            case "4"://学生留言
                TeacherByIndex.StudentInformation(request, model, teacherMapper);
                return "Teacher/StudentMessage";
            case "5"://设置提交时间
                return "Teacher/SetSubTime";
            case "6":    //退出登陆
                TeacherByIndex.TeacherLogout(request);
                return "Teacher/TeacherLogin";
            case "13":
                TeacherByIndex.getApproveTopicList(request,model,teacherMapper);
                return "Teacher/ApproveTopic";
        }
        return "Teacher/TeacherMain";
    }

    //试题管理 - 插入试题
    @Transactional
    @RequestMapping(value = "/Teacher/TopicManage", method = RequestMethod.POST)
    public String TopicManage(HttpServletRequest request, Model model) {
        //发布试题
        Topic topic;
        Teacher teacher = (Teacher) request.getSession().getAttribute("Teacher");
        topic = TeacherByIndex.PublishTopic(request, model, teacherMapper, teacher);
        //将数据存放至数据库
        int row1 = teacherMapper.addTopic(topic);
        int row2 = teacherMapper.addTeacherTopic(topic.getTopicId(), teacher.getSchoolId(), teacher.getTeacherId());
        if ((row1 > 0) && (row2 > 0)) {
            model.addAttribute("isfail",1);
            return "Teacher/TopicManage";
        } else {
            model.addAttribute("isfail",2);
            return "Teacher/TopicManage";
        }
    }

    //查看试题
    @RequestMapping(value = "/Teacher/CheckTopic", method = RequestMethod.POST)
    public String CheckTopic(HttpServletRequest request, Model model) {
        TeacherByIndex.TopicInformation(request, model, teacherMapper);
        return "/Teacher/CheckTopic";
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
//        String studentName = request.getParameter("studentName");
        String type = request.getParameter("type");
        String opinion = request.getParameter("opinion");   //审批结果
        String fileName = request.getParameter("fileName"); //文件名称
        sb.append(request.getParameter("opinionText"));     //审批意见
        System.out.println("*****"+type);
        if (opinion.equals("同意")) {
            switch (type) {
                case "open":
                    row = teacherMapper.setOpenReportStatus(studentId, "1");

                    break;
                case "mid":
                    row = teacherMapper.setMidReportStatus(studentId, "1");
                    break;
                case "first":
                    row = teacherMapper.setThesisFirstStatus(studentId, "1");
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
            switch (type) {
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
            String filepath = path + midPath + fileName;
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
        return "/Teacher/TeacherMain";
    }


    //设置提交时间
    @RequestMapping(value = "/Teacher/SetSubTime")
    public String SetSubTime(HttpServletRequest request,Model model) {
        TeacherByIndex.SetSubTime(request,teacherMapper,model);
        return "Teacher/TeacherMain";
    }

    /*
        设置答辩信息
     */
    @RequestMapping(value = "/Teacher/SetPlead")
    public String SetPlead(HttpServletRequest request,Model model){
        TeacherByIndex.SetPlead(request,model,teacherMapper);
        return "Teacher/TeacherMain";
    }
    /*
        修改试题
     */
    @RequestMapping(value = "Teacher/ChangeTopic")
    public String ChangeTopic(HttpServletRequest request,Model model){
        TeacherByIndex.ChangeTopic(request,model,teacherMapper);
        return "redirect:/Teacher/TeacherMain?id=7";
    }

    /*
        审批试题
     */
    @RequestMapping(value = "/Teacher/ApproveTopic")
    public String ApproveTopic(HttpServletRequest request,Model model){
        TeacherByIndex.DealApprovalTopic(request,model,teacherMapper);
        return "/Teacher/ApproveTopic";
    }

    /*
        下载文件
     */
    @RequestMapping(value = "/Teacher/DownloadFile")
    public String DownloadFile(HttpServletRequest request , Model model){
        TeacherByIndex.downloadFile(request,model,teacherMapper);
        return "/Teacher/DownloadFile";
    }

    @RequestMapping(value = "/Teacher/download")
    public String Download(HttpServletRequest request , Model model) throws MalformedURLException {
        int bytesum = 0;
        int byteread = 0;
        String path = request.getParameter("path");
        System.out.println(path);
        URL url = new URL(path);
//        URL url = new URL("http://localhost:8080/StudentLogin.jsp");
        try{
            URLConnection connection = url.openConnection();
            InputStream inputStream = connection.getInputStream();
            FileOutputStream fs = new FileOutputStream("C:/Users/hp/Desktop/download/123.docx");
            byte[] buffer = new byte[1204];
            int length;
            while ((byteread = inputStream.read(buffer)) != -1) {
                  bytesum += byteread;
                  System.out.println(bytesum);
                  fs.write(buffer, 0, byteread);
            }
        }catch (FileNotFoundException e){
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        TeacherByIndex.getApproveTopicList(request,model,teacherMapper);
        return "Teacher/ApproveTopic";
    }

    /*
        总评分
     */
    @RequestMapping(value = "/Teacher/Scoring")
    public String Scoring(HttpServletRequest request,Model model){
        TeacherByIndex.Scoring(request,model,teacherMapper);
        return "/Teacher/Scoring";
    }

    @RequestMapping(value = "/Teacher/afterScoring")
    public String afterScoring(HttpServletRequest request,Model model){
        TeacherByIndex.afterScoring(request,model,teacherMapper);
        return "redirect:/Teacher/Scoring";
    }

    @RequestMapping(value = "/Teacher/CheckScoring")
    public String CheckScoring(HttpServletRequest request,Model model){
        TeacherByIndex.CheckScoring(request,model,teacherMapper);
        return "/Teacher/CheckScoring";
    }

    @RequestMapping(value = "/Teacher/ChangeInfo")
    public String ChangeInfo(HttpServletRequest request,Model model){
        TeacherByIndex.ChangeInfo(request,model,teacherMapper);
        return "/Teacher/ChangeInfo";
    }

    @RequestMapping(value = "/Teacher/afterChangeInfo")
    public String afterChangeInfo(HttpServletRequest request,Model model){
        TeacherByIndex.afterChangeInfo(request,model,teacherMapper);
        return "redirect:/Teacher/TeacherMain?id=1";
    }

    @RequestMapping(value = "/Teacher/ChangePwd")
    public String ChangePwd(HttpServletRequest request,Model model){
        model.addAttribute("reslut",-1);
        return "/Teacher/ChangePwd";
    }

    @RequestMapping(value = "/Teacher/afterChangePwd")
    public String afterChangePwd(HttpServletRequest request,Model model){
        TeacherByIndex.afterChangePwd(request,model,teacherMapper);
        return "Teacher/ChangePwd";
    }

}