package Gttss.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/*
    配置当访问到异常或者错误界面的跳转controller
 */
@Controller
public class ErrorController {
    @RequestMapping("/error-400")
    public String error_400(){
        return "Error/error-400";
    }

    @RequestMapping("/error-401")
    public String error_401(){
        return "Error/error-401";
    }

    @RequestMapping("/error-403")
    public String error_403(){
        return  "Error/error-403";
    }

    @RequestMapping("/error-404")
    public String error_404(){
        return "Error/error-404";
    }

    @RequestMapping("/error-500")
    public String error_500(){
        return  "Error/error-500";
    }

    @RequestMapping("/error-503")
    public String error_503(){
        return "Error/error-503";
    }
}
