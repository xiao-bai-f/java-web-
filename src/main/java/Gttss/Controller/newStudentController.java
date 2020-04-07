package Gttss.Controller;


import Gttss.TeacherRequest.NewStudentByIndex;
import org.springframework.web.bind.annotation.RequestMapping;

public class newStudentController extends StudentController {
//   private final StudentByIndex studentByIndex = new StudentByIndex();
    NewStudentByIndex newStudentByIndex = new NewStudentByIndex();
    @RequestMapping("/testss")
    public String Test(){
        System.out.println("子类测试");
        newStudentByIndex.getStudent();
        return "/Student/StudentMain";
    }
}
