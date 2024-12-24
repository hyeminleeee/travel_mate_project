package xyz.itwill.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.MateBoardLike;
import xyz.itwill.mapper.CourseLikeMapper;
import xyz.itwill.mapper.MateBoardLikeMapper;

@Repository
@RequiredArgsConstructor
public class MateBoardLikeDAOImpl implements MateBoardLikeDAO {
	private final SqlSession sqlSession;

	@Override
	public int selectMateBoardLikeCount() {
		return sqlSession.getMapper(MateBoardLikeMapper.class).selectMateBoardLikeCount();
	}

	@Override
	public List<MateBoardLike> selectMateBoardLike(int boardNo) {
		return sqlSession.getMapper(MateBoardLikeMapper.class).selectMateBoardLike(boardNo);
	}

	@Override
	public int likeUp(MateBoardLike mateboardLike) {
		return sqlSession.getMapper(MateBoardLikeMapper.class).likeUp(mateboardLike);
	}

	@Override
	public int likeDown(MateBoardLike mateboardLike) {
		return sqlSession.getMapper(MateBoardLikeMapper.class).likeDown(mateboardLike);
	}

	@Override
	public MateBoardLike selectMateBoardLikeByMateBoardNoUserid(int boardNo, String userId) {
		return sqlSession.getMapper(MateBoardLikeMapper.class).selectMateBoardLikeByMateBoardNoUserid(boardNo, userId);
	}

	@Override
	public int deleteMateBoardLike(int boardNo) {
		return sqlSession.getMapper(CourseLikeMapper.class).deleteCourseLike(boardNo);
	}
}
