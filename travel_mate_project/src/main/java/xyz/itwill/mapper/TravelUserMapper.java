package xyz.itwill.mapper;

import java.util.List;
import java.util.Map;

import xyz.itwill.dto.TravelAuth;
import xyz.itwill.dto.TravelUser;

public interface TravelUserMapper {
	int insertTravelUser(TravelUser user);
	int insertTravelAuth(TravelAuth auth);
	int updateTravelUser(TravelUser user);
	TravelUser selectTravelUserByUserid(String userId);
	TravelUser selectTravelUserByUserNickname(String userNickname);
	int updateUserStatusAndEnabled(TravelUser user);
	List<TravelUser> selectTravelUserList(Map<String, Object> map);
	int updateDisable(TravelUser user);
	TravelUser selectTravelUserForFindId(Map<String, Object> map);

}
