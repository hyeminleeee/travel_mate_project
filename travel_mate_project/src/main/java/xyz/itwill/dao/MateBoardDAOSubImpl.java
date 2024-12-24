package xyz.itwill.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.MateBoard;
import xyz.itwill.mapper.MateBoardMapper;
import xyz.itwill.mapper.MateBoardMapperSub;

@Repository
@RequiredArgsConstructor
public class MateBoardDAOSubImpl implements MateBoardDAOSub {
	private final SqlSession sqlSession;
	
	@Override
	public List<MateBoard> selectMateBoardListByUserId(Map<String, Object> map) {
		return sqlSession.getMapper(MateBoardMapperSub.class).selectMateBoardListByUserId(map);
	}

	@Override
	public int selectTotalMateBoardByUserId(String userId) {
		return sqlSession.getMapper(MateBoardMapperSub.class).selectTotalMateBoardByUserId(userId);
	}

	@Override
	public List<MateBoard> selectLikeMateBoardListByUserId(Map<String, Object> map) {
		return sqlSession.getMapper(MateBoardMapperSub.class).selectLikeMateBoardListByUserId(map);
	}

	@Override
	public int selectLikeMateBoardTotalCountById(String userId) {
		return sqlSession.getMapper(MateBoardMapperSub.class).selectLikeMateBoardTotalCountById(userId);
	}

}
