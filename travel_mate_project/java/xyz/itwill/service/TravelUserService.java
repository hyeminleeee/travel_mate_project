package xyz.itwill.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import xyz.itwill.dto.TravelAuth;
import xyz.itwill.dto.TravelUser;

public interface TravelUserService {
	void addTravelUser(TravelUser user);
	void addTravelAuth(TravelAuth auth);
	void modifyTravelUser(TravelUser user);
	TravelUser getTravelUserByUserid(String userId); //실제 인증할때 얘는 필요없다.
	TravelUser getTravelUserByUserNickname(String userNickname);
	List<TravelUser> getTravelUserAll(Map<String, Object> map);
	void modifyDisable(TravelUser user);
	TravelUser getTravelUserForFindId(Map<String, Object> map);
}
