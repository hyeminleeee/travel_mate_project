package xyz.itwill.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.MateReply;
import xyz.itwill.mapper.MateReplyMapper;

@Repository
@RequiredArgsConstructor
public class MateReplyDAOImpl implements MateReplyDAO {
	private final SqlSession sqlSession;

	@Override
	public int insertMateReply(MateReply reply) {
		return sqlSession.getMapper(MateReplyMapper.class).insertMateReply(reply);
	}

	@Override
	public List<MateReply> selectMateReplyList(int boardNo) {
		return sqlSession.getMapper(MateReplyMapper.class).selectMateReplyList(boardNo);
	}

	@Override
	public int deleteMateReplyByReplyNo(int replyNo) {
		return sqlSession.getMapper(MateReplyMapper.class).deleteMateReplyByReplyNo(replyNo);
	}

	@Override
	public int updateMateReply(MateReply reply) {
		return sqlSession.getMapper(MateReplyMapper.class).updateMateReply(reply);
	}
}
