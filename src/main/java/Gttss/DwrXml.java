package Gttss;

import ch.qos.logback.classic.LoggerContext;
import org.directwebremoting.Container;
import org.directwebremoting.create.NewCreator;
import org.directwebremoting.extend.Configurator;
import org.directwebremoting.extend.CreatorManager;


public class DwrXml implements Configurator {

    @Override
    public void configure(Container container){
        CreatorManager creatorManager
                = container.getBean(CreatorManager.class);
        NewCreator creator = new NewCreator();
        creator.setClass("Gttss.Config.TestDwr");
        creator.setJavascript("testDwr");
        creatorManager.addCreator(creator);
    }

}
