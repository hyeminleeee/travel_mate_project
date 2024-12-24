package xyz.itwill.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.util.HtmlUtils;

import lombok.RequiredArgsConstructor;
import xyz.itwill.auth.CustomUserDetails;
import xyz.itwill.dto.CourseReply;
import xyz.itwill.service.CourseReplyService;
import xyz.itwill.service.TravelUserService;

@RestController
@RequiredArgsConstructor
@RequestMapping("/reply")
public class CourseReplyController {
	private final CourseReplyService courseReplyService;
	private final TravelUserService travelUserService;
	
	@Transactional
	@PostMapping("/register")
	public String register(@RequestBody @Valid CourseReply reply, Authentication authentication) {
		CustomUserDetails user=(CustomUserDetails)authentication.getPrincipal();
		reply.setReplyWriter(user.getUserId()); 
		reply.setUserId(user.getUserId());
		reply.setReplyContent(HtmlUtils.htmlEscape(reply.getReplyContent()));
		courseReplyService.addCourseReply(reply);
		return "success";
	}
	
	@GetMapping("/list") 
	public Map<String, Object> list(@RequestParam int courseNo){
		Authentication authentication=SecurityContextHolder.getContext().getAuthentication();
		String loginUserid=authentication.getName();
		String userNickname=travelUserService.getTravelUserByUserid(loginUserid).getUserNickname();
		
		List<CourseReply> replyList=courseReplyService.getCourseReplyList(courseNo);
		
		/*
		for(CourseReply reply : replyList) {
			reply.setUserId(loginUserid);
		}
		*/
		
		Map<String, Object> response=new HashMap<>();
		response.put("replyList", replyList);
		response.put("loginUserid", loginUserid);
		response.put("userNickname", userNickname);
		
		return response;
	}
	
	@Transactional
	@PostMapping("/remove")
	public String remove(@RequestBody @Valid CourseReply reply) {
		courseReplyService.removeCourseReply(reply.getReplyNo());
		return "success";
	}
	
	@PostMapping("/modify")
	public String modify(@RequestBody @Valid CourseReply reply) {
		reply.setReplyContent(HtmlUtils.htmlEscape(reply.getReplyContent()));
		courseReplyService.modifyCourseReply(reply);
		return "success";
	}
	
	@GetMapping("/count")
	public String replyCount() {
		return "success";
	}
}
