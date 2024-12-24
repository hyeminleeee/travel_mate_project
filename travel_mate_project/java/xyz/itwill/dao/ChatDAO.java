package xyz.itwill.dao;

import java.util.List;
import java.util.Map;

import xyz.itwill.dto.Chat;

public interface ChatDAO {
	int insertChat(Chat chat);
	int deleteChat(int roomNo);
	List<Chat> selectChatList(int roomNo);
	List<Chat> selectChatListAll(Map<String, Object> map);
}
