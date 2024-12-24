package xyz.itwill.service;

import java.util.List;
import java.util.Map;

import xyz.itwill.dto.Mate;

public interface MateService {
	void addMate(Mate mate);
	List<Mate> getMateList(int boardNo);
	void removeMate(int mateNo);
	List<Mate> getMateWaiList(int boardNo);
	List<Mate> getMateAcceptList(int boardNo);
	
	void acceptMateByNo(int mateNo);
	
	//내가 참여한 동행모집 관련
	Map<String, Object> getJoinMateListByUserIdAndStatus(Map<String, Object> map);
}
