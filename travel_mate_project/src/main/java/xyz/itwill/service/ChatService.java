package xyz.itwill.service;

import java.util.List;
import java.util.Map;

import xyz.itwill.dto.Chat;

public interface ChatService {
	void addChat(Chat chat);
	void removeChat(int roomNo);
	List<Chat> getChatList(int roomNo);
	List<Chat> getChatListAll(Map<String, Object> map);

}
