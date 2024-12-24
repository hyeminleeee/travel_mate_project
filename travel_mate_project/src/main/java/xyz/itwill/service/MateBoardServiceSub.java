package xyz.itwill.service;

import java.util.Map;

import xyz.itwill.dto.MateBoard;

public interface MateBoardServiceSub {
	Map<String, Object> getMateBoardListByUserId(Map<String, Object> map);
	Map<String, Object> getLikeMateBoardListByUserId(Map<String, Object> map);
}
