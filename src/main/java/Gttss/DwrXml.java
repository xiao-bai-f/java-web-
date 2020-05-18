package Gttss;

import ch.qos.logback.classic.LoggerContext;
import org.directwebremoting.Container;
import org.directwebremoting.create.NewCreator;
import org.directwebremoting.extend.Configurator;
import org.directwebremoting.extend.CreatorManager;

/*
    dwr的配置类
        创建创造器：
            确定需要被调用的后端类：TeacherClient和StudentClient
 */
public class DwrXml implements Configurator {

    @Override
    public void configure(Container container){
        CreatorManager creatorManager = container.getBean(CreatorManager.class);
        NewCreator creator = new NewCreator();
        creator.setClass("Gttss.SendMessage.StudentMessage");
        creator.setJavascript("StudentMessage");

        NewCreator creator2 = new NewCreator();
        creator2.setClass("Gttss.Controller.StudentController");
        creator2.setJavascript("StudentController");

        NewCreator creator3 = new NewCreator();
        creator3.setClass("Gttss.Controller.TeacherController");
        creator3.setJavascript("TeacherController");

        creatorManager.addCreator(creator);
        creatorManager.addCreator(creator2);
        creatorManager.addCreator(creator3);
    }

}
