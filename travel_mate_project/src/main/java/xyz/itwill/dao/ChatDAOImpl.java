package xyz.itwill.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.Chat;
import xyz.itwill.mapper.ChatMapper;

@Repository
@RequiredArgsConstructor
public class ChatDAOImpl implements ChatDAO {
	private final SqlSession sqlSession;

	@Override
	public int insertChat(Chat chat) {
		return sqlSession.getMapper(ChatMapper.class).insertChat(chat);
	}

	@Override
	public int deleteChat(int roomNo) {
		return sqlSession.getMapper(ChatMapper.class).deleteChat(roomNo);
	}

	@Override
	public List<Chat> selectChatList(int roomNo) {
		return sqlSession.getMapper(ChatMapper.class).selectChatList(roomNo);
	}

	@Override
	public List<Chat> selectChatListAll(Map<String, Object> map) {
		return sqlSession.getMapper(ChatMapper.class).selectChatListAll(map);
	}
	
}
