package xyz.itwill.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.Mate;
import xyz.itwill.dto.MateBoard;
import xyz.itwill.mapper.MateMapper;

@Repository
@RequiredArgsConstructor
public class MateDAOImpl implements MateDAO {
	private final SqlSession sqlSession; 
	
	@Override
	public int insertMate(Mate mate) {
		return sqlSession.getMapper(MateMapper.class).insertMate(mate);
	}

	@Override
	public List<Mate> selectMateList(int boardNo) {
		return sqlSession.getMapper(MateMapper.class).selectMateList(boardNo);
	}

	@Override
	public int deleteMateByNo(int mateNo) {
		return sqlSession.getMapper(MateMapper.class).deleteMateByNo(mateNo);
	}

	@Override
	public List<Mate> selectMateWaitList(int boardNo) {
		return sqlSession.getMapper(MateMapper.class).selectMateWaitList(boardNo);
	}

	@Override
	public List<Mate> selectMateAcceptList(int boardNo) {
		return sqlSession.getMapper(MateMapper.class).selectMateAcceptList(boardNo);
	}

	@Override
	public int acceptMateByNo(int mateNo) {
		return sqlSession.getMapper(MateMapper.class).acceptMateByNo(mateNo);
	}
	
	//내가 참여한 동행모집 관련
	@Override
	public List<MateBoard> selectJoinMateListByUserIdAndStatus(Map<String, Object> map) {
		return sqlSession.getMapper(MateMapper.class).selectJoinMateListByUserIdAndStatus(map);
	}
	
	@Override
	public int selectTotalJoinMateCountByUserIdAndStatus(String userId) {
		return sqlSession.getMapper(MateMapper.class).selectTotalJoinMateCountByUserIdAndStatus(userId);
	}
	
}
