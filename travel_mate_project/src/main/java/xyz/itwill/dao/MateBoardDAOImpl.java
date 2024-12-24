package xyz.itwill.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.MateBoard;
import xyz.itwill.mapper.MateBoardMapper;

@Repository
@RequiredArgsConstructor
public class MateBoardDAOImpl implements MateBoardDAO {
	private final SqlSession sqlSession;
	
	@Override
	public int insertMateBoard(MateBoard board) {
		return sqlSession.getMapper(MateBoardMapper.class).insertMateBoard(board);
	}

	@Override
	public int updateMateBoard(MateBoard board) {
		return sqlSession.getMapper(MateBoardMapper.class).updateMateBoard(board);
	}

	@Override
	public int deleteMateBoard(int boardNo) {
		return sqlSession.getMapper(MateBoardMapper.class).deleteMateBoard(boardNo);
	}

	@Override
	public MateBoard selectMateBoardByNo(int boardNo) {
		return sqlSession.getMapper(MateBoardMapper.class).selectMateBoardByNo(boardNo);
	}

	@Override
	public int selectMateBoardCount(Map<String, Object> map) {
		return sqlSession.getMapper(MateBoardMapper.class).selectMateBoardCount(map);
	}

	@Override
	public List<MateBoard> selectMateBoardList(Map<String, Object> map) {
		return sqlSession.getMapper(MateBoardMapper.class).selectMateBoardList(map);
	}

	@Override
	public int updateMateBoardCount(int boardNo) {
		return sqlSession.getMapper(MateBoardMapper.class).updateMateBoardCount(boardNo);
	}
	
	@Override
	public List<MateBoard> selectAdminMateBoardList() {
		return sqlSession.getMapper(MateBoardMapper.class).selectAdminMateBoardList();
	}
}
