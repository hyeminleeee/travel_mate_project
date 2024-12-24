package xyz.itwill.controller;

import java.util.Map;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.TravelUser;
import xyz.itwill.service.ChatService;
import xyz.itwill.service.CourseService;
import xyz.itwill.service.MateBoardService;
import xyz.itwill.service.TravelUserService;

@Controller
@RequestMapping("/adminPage")
@RequiredArgsConstructor
public class AdminPageController {
	private final MateBoardService mateBoardService;
	private final TravelUserService travelUserService;
	private final CourseService courseService;
	private final ChatService chatService;
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@RequestMapping("")
	public String adminPage(@RequestParam Map<String, Object> map, Model model) {
		model.addAttribute("mateBoardList", mateBoardService.getAdminMateBoardList()); //코스
		model.addAttribute("courseList", courseService.getAdminCourseList()); //코스
		model.addAttribute("travelUserList", travelUserService.getTravelUserAll(map)); //회원
		model.addAttribute("currentPage", "adminPage"); // 현재 페이지 정보 추가
		return "adminPage/mgmt";
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@RequestMapping("/mgmtUser")
	public String adminUser(@RequestParam Map<String, Object> map, Model model) {
		model.addAttribute("travelUserList", travelUserService.getTravelUserAll(map));
		model.addAttribute("searchMap", map);
		return "adminPage/mgmtUser";
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@RequestMapping("/mgmtChat")
	public String adminChat(@RequestParam Map<String, Object> map, Model model) {
		model.addAttribute("chatList", chatService.getChatListAll(map));
		model.addAttribute("searchMap", map);
		return "adminPage/mgmtChat";
	}
	
	@GetMapping("/userModify/{id}/{status}")
	@ResponseBody
	public String modify(@PathVariable String id, @PathVariable String status) {		
		TravelUser user = new TravelUser();
		user.setUserId(id);
		user.setUserEnabled(status);
		travelUserService.modifyDisable(user);
		return "success";
	}
	
	
}
