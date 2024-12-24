package xyz.itwill.service;

import java.util.List;
import java.util.Map;

import xyz.itwill.dto.MateBoard;

public interface MateBoardService {
	void addMateBoard(MateBoard board);
	void modifyMateBoard(MateBoard board);
	void removeMateBoard(int boardNo);
	MateBoard getMateBoardByNo(int boardNo);
	Map<String, Object> getMateBoardList(Map<String, Object> map);
	void modifyMateBoardCount(int boardNo);
	List<MateBoard> getAdminMateBoardList();
}
