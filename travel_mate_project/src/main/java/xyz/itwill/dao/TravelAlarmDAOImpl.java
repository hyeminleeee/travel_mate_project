package xyz.itwill.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.TravelAlarm;
import xyz.itwill.mapper.TravelAlarmMapper;

@Repository
@RequiredArgsConstructor
public class TravelAlarmDAOImpl implements TravelAlarmDAO {
	private final SqlSession sqlSession;
	
	@Override
	public List<TravelAlarm> selectUserAlarmByUserId(Map<String, Object> map) {
		return sqlSession.getMapper(TravelAlarmMapper.class).selectUserAlarmByUserId(map);
	}

	@Override
	public int selectAlarmCount(TravelAlarm alarm) {
		return sqlSession.getMapper(TravelAlarmMapper.class).selectAlarmCount(alarm);
	}
	
	@Override
	public int selectTotalAlarmByUserId(String userId) {
		return sqlSession.getMapper(TravelAlarmMapper.class).selectTotalAlarmByUserId(userId);
	}

	@Override
	public int updateAlarmRead(int alarmId) {
		return sqlSession.getMapper(TravelAlarmMapper.class).updateAlarmRead(alarmId);
	}
	
	@Override
	public int insertMateSubmitAlarm(TravelAlarm travelAlarm) {
		return sqlSession.getMapper(TravelAlarmMapper.class).insertMateSubmitAlarm(travelAlarm);
	}

	

}
