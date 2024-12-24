package xyz.itwill.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dao.TravelUserDAO;
import xyz.itwill.dto.TravelAuth;
import xyz.itwill.dto.TravelUser;

@Service
@RequiredArgsConstructor
public class TravelUserServiceImpl implements TravelUserService {
	private final TravelUserDAO travelUserDAO;

	@Override
	public void addTravelUser(TravelUser user) {
		travelUserDAO.insertTravelUser(user);
	}

	@Override
	public void addTravelAuth(TravelAuth auth) {
		travelUserDAO.insertTravelAuth(auth);

	}

	@Override
	public void modifyTravelUser(TravelUser user) {
		travelUserDAO.updateTravelUser(user);
	}

	@Override
	public TravelUser getTravelUserByUserid(String userId) {
		return travelUserDAO.selectTravelUserByUserid(userId);
	}

	@Override
	public TravelUser getTravelUserByUserNickname(String userNickname) {
		return travelUserDAO.selectTravelUserByUserNickname(userNickname);
	}

	@Override
	public List<TravelUser> getTravelUserAll(Map<String, Object> map) {
		return travelUserDAO.selectTravelUserList(map);
	}

	@Override
	public void modifyDisable(TravelUser user) {
		travelUserDAO.updateDisable(user);
	}

	@Override
	public TravelUser getTravelUserForFindId(Map<String, Object> map) {
		return travelUserDAO.selectTravelUserForFindId(map);
	}



	
}
