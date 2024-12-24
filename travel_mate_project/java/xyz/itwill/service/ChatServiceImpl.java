package xyz.itwill.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dao.ChatDAO;
import xyz.itwill.dto.Chat;

@Service
@RequiredArgsConstructor
public class ChatServiceImpl implements ChatService {
	private final ChatDAO chatDAO;

	@Override
	public void addChat(Chat chat) {
		chatDAO.insertChat(chat);
		
	}

	@Override
	public void removeChat(int roomNo) {
		chatDAO.deleteChat(roomNo);
		
	}

	@Override
	public List<Chat> getChatList(int roomNo) {
		List<Chat> chatList = chatDAO.selectChatList(roomNo);
		return chatList;
	}

	@Override
	public List<Chat> getChatListAll(Map<String, Object> map) {
		List<Chat> chatList = chatDAO.selectChatListAll(map);
		return chatList;
	}
	

}
