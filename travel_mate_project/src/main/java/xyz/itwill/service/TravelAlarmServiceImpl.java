package xyz.itwill.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dao.TravelAlarmDAO;
import xyz.itwill.dto.TravelAlarm;
import xyz.itwill.util.Pager;

@Service
@RequiredArgsConstructor
public class TravelAlarmServiceImpl implements TravelAlarmService {
	private final TravelAlarmDAO travelAlarmDAO;

	@Override
	public Map<String, Object> getTravelAlarmByUserid(Map<String, Object> map) {
		int pageNum=1;
		String userId = (String) map.get("userId");
		
		if(map.get("pageNum") != null && !map.get("pageNum").equals("")) {
			pageNum=Integer.parseInt((String)map.get("pageNum"));
		}

		int pageSize=10;
		if(map.get("pageSize") != null && !map.get("pageSize").equals("")) {
			pageSize=Integer.parseInt((String)map.get("pageSize"));
		}
		
		int totalTravelAlarm=travelAlarmDAO.selectTotalAlarmByUserId(userId);
		
		int blockSize=10;
		
		Pager pager=new Pager(pageNum, pageSize, totalTravelAlarm, blockSize);		
		
		map.put("startRow", pager.getStartRow());
		map.put("endRow", pager.getEndRow());
		System.out.println("map = "+map);
		List<TravelAlarm> alarmList=travelAlarmDAO.selectUserAlarmByUserId(map);
		System.out.println("travelAlarmList = "+alarmList);
		
		Map<String, Object> result=new HashMap<String, Object>();
		result.put("pager", pager);
		result.put("alarmList", alarmList); 
		
		return result;
	}
	
	@Override
	public int getAlarmCount(TravelAlarm alarm) {
		return travelAlarmDAO.selectAlarmCount(alarm);
	}

	@Override
	public void addMateSubmitAlarm(TravelAlarm travelAlarm) {
		travelAlarmDAO.insertMateSubmitAlarm(travelAlarm);
	}

	@Override
	public void modifyAlarmRead(int alarmId) {
		travelAlarmDAO.updateAlarmRead(alarmId);
	}

}
