package xyz.itwill.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.QnaReply;
import xyz.itwill.mapper.QnaReplyMapper;

@Repository
@RequiredArgsConstructor
public class QnaReplyDAOImpl implements QnaReplyDAO {
	private final SqlSession sqlSession;

	@Override
	public int insertQnaReply(QnaReply reply) {
		return sqlSession.getMapper(QnaReplyMapper.class).insertQnaReply(reply);
	}

	@Override
	public List<QnaReply> selectQnaReplyList(int boardNum) {
		return sqlSession.getMapper(QnaReplyMapper.class).selectQnaReplyList(boardNum);
	}
}

