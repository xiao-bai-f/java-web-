package Gttss.Mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.*;

@Mapper
public interface MessageMapper {
    @Insert("insert into t_messagehistory (Sender,Recever,sendTime,message) values (#{sender},#{recever},#{sentime},#{message})")
    int addMessage(@Param("sender") String sender, @Param("recever") String recever, @Param("message") String message, @Param("sendtime") String sendtime);

}
