package xyz.itwill.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import xyz.itwill.dto.TravelAuth;
import xyz.itwill.dto.TravelUser;

public interface TravelUserDAO {
	int insertTravelUser(TravelUser user);
	int insertTravelAuth(TravelAuth auth);
	void updateTravelUser(TravelUser user);
	TravelUser selectTravelUserByUserid(String userId);
	TravelUser selectTravelUserByUserNickname(String userNickname);
	List<TravelUser> selectTravelUserList(Map<String, Object> map);
	void updateDisable(TravelUser user);
	TravelUser selectTravelUserForFindId(Map<String, Object> map);
}
