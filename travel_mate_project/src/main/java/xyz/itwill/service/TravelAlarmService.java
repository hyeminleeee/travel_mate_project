package xyz.itwill.service;

import java.util.Map;

import xyz.itwill.dto.TravelAlarm;

public interface TravelAlarmService {
	Map<String, Object> getTravelAlarmByUserid(Map<String, Object> map);
	int getAlarmCount(TravelAlarm alarm);
	void addMateSubmitAlarm(TravelAlarm travelAlarm);
	void modifyAlarmRead(int alarmId);
}
