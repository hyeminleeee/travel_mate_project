package xyz.itwill.mapper;

import java.util.List;
import java.util.Map;

import xyz.itwill.dto.MateBoard;

public interface MateBoardMapper {
	int insertMateBoard(MateBoard board);
	int updateMateBoard(MateBoard board);
	int deleteMateBoard(int boardNo);
	MateBoard selectMateBoardByNo(int boardNo);
	int selectMateBoardCount(Map<String, Object> map);
	List<MateBoard> selectMateBoardList(Map<String, Object> map);
	int updateMateBoardCount(int boardNo);
	List<MateBoard> selectAdminMateBoardList();
}
