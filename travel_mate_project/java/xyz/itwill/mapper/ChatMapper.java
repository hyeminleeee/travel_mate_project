package xyz.itwill.mapper;

import java.util.List;
import java.util.Map;

import xyz.itwill.dto.Chat;

public interface ChatMapper {
	int insertChat(Chat chat);
	int deleteChat(int roomNo);
	List<Chat> selectChatList(int roomNo);
	List<Chat> selectChatListAll(Map<String, Object> map);
}
