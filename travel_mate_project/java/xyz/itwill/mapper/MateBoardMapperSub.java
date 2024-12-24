package xyz.itwill.mapper;

import java.util.List;
import java.util.Map;

import xyz.itwill.dto.Course;
import xyz.itwill.dto.MateBoard;

public interface MateBoardMapperSub {
	List<MateBoard> selectMateBoardListByUserId(Map<String, Object> map);
    int selectTotalMateBoardByUserId(String userId);
	List<MateBoard> selectLikeMateBoardListByUserId(Map<String, Object> map);
    int selectLikeMateBoardTotalCountById(String userId);
}
