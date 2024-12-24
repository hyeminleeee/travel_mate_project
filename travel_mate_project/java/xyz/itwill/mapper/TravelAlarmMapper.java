package xyz.itwill.mapper;

import java.util.List;
import java.util.Map;

import xyz.itwill.dto.TravelAlarm;

public interface TravelAlarmMapper {
	List<TravelAlarm> selectUserAlarmByUserId(Map<String, Object> map);
	int selectTotalAlarmByUserId(String userId);
	int selectAlarmCount(TravelAlarm alarm);
	int updateAlarmRead(int alarmId);
	int insertMateSubmitAlarm(TravelAlarm travelAlarm);
}
