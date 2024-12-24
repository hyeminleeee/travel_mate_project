package xyz.itwill.dao;

import java.util.List;
import java.util.Map;

import xyz.itwill.dto.Mate;
import xyz.itwill.dto.MateBoard;

public interface MateDAO {
	int insertMate(Mate mate);
	List<Mate> selectMateList(int boardNo);
	int deleteMateByNo(int mateNo);
	
	List<Mate> selectMateWaitList(int boardNo);
	List<Mate> selectMateAcceptList(int boardNo);
	
	int acceptMateByNo(int mateNo);
	
	//내가 참여한 동행모집 관련
	List<MateBoard> selectJoinMateListByUserIdAndStatus(Map<String, Object> map);
	int selectTotalJoinMateCountByUserIdAndStatus(String userId);
}
