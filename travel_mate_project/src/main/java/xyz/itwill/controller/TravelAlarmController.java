package xyz.itwill.controller;

import java.util.Map;

import javax.validation.Valid;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.Mate;
import xyz.itwill.dto.TravelAlarm;
import xyz.itwill.service.MateService;
import xyz.itwill.service.TravelAlarmService;
import xyz.itwill.service.TravelUserService;

@Controller
@RequestMapping(value="/travel_alarm")
@RequiredArgsConstructor
public class TravelAlarmController {

	private final TravelAlarmService travelAlarmService;
	private final TravelUserService travelUserService;
	private final MateService mateService;
	
	//동행신청 시 알림 테이블에 추가
	@PostMapping("/register")
    @ResponseBody
	public String register(@RequestBody @Valid TravelAlarm travelAlarm) {
		if(travelAlarmService.getAlarmCount(travelAlarm) == 0) {
			travelAlarmService.addMateSubmitAlarm(travelAlarm);
			return "success";
		}
		
		return "fail";
	}
	
	//동행신청 수락관련
	@PostMapping("/mate_accept")
    @ResponseBody
	public String mateAcceptSubmit(@RequestParam("boardNo") int boardNo, 
            @RequestParam("targetUserId") String targetUserId, Authentication authentication) {
		// Mate 객체 생성 및 DB에 추가
        Mate mate = new Mate();
        mate.setBoardNo(boardNo);
        mate.setUserId(targetUserId); // 알림을 발생시킨 사용자 ID
        
		mateService.addMate(mate);
		
		// 알림 수락 후 리다이렉트
        return "redirect:/account/travel_noti"; // 알림 목록 페이지로 리다이렉트
	}
	
	//읽음처리
	@PostMapping("/alarm_read")
	@ResponseBody
	public String travelAlarmRead(@RequestBody Map<String, Integer> requestBody, Authentication authentication) {
		 int alarmId = requestBody.get("alarmId");
		travelAlarmService.modifyAlarmRead(alarmId);
		return "success";
	}
	
	
}