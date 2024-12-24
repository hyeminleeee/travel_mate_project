package xyz.itwill.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.TravelAuth;
import xyz.itwill.dto.TravelUser;
import xyz.itwill.mapper.TravelUserMapper;

@Repository
@RequiredArgsConstructor
public class TravelUserDAOImpl implements TravelUserDAO {
	private final SqlSession sqlSession;

	@Override
	public int insertTravelUser(TravelUser user) {
		return sqlSession.getMapper(TravelUserMapper.class).insertTravelUser(user);
	}

	@Override
	public int insertTravelAuth(TravelAuth auth) {
		return sqlSession.getMapper(TravelUserMapper.class).insertTravelAuth(auth);
	}

	@Override
	public void updateTravelUser(TravelUser user) {
		sqlSession.getMapper(TravelUserMapper.class).updateTravelUser(user);
	}

	@Override
	public TravelUser selectTravelUserByUserid(String userId) {
		return sqlSession.getMapper(TravelUserMapper.class).selectTravelUserByUserid(userId);
	}

	@Override
	public TravelUser selectTravelUserByUserNickname(String userNickname) {
		return sqlSession.getMapper(TravelUserMapper.class).selectTravelUserByUserNickname(userNickname);
	}

	@Override
	public List<TravelUser> selectTravelUserList(Map<String, Object> map) {
		return sqlSession.getMapper(TravelUserMapper.class).selectTravelUserList(map);
	}	

	@Override
	public void updateDisable(TravelUser user) {
		sqlSession.getMapper(TravelUserMapper.class).updateDisable(user);
	}

	@Override
	public TravelUser selectTravelUserForFindId(Map<String, Object> map) {
		return sqlSession.getMapper(TravelUserMapper.class).selectTravelUserForFindId(map);
	}	


}
