package xyz.itwill.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.util.HtmlUtils;

import lombok.RequiredArgsConstructor;
import xyz.itwill.auth.CustomUserDetails;
import xyz.itwill.dto.MateReply;
import xyz.itwill.service.MateReplyService;
import xyz.itwill.service.TravelUserService;

@RestController
@RequiredArgsConstructor
@RequestMapping("/matereply")
public class MateReplyController {
	private final MateReplyService mateReplyService;
	private final TravelUserService travelUserService;
	
	@PostMapping("/register")
	public String register(@RequestBody @Valid MateReply reply, Authentication authentication) {
		CustomUserDetails user=(CustomUserDetails)authentication.getPrincipal();
		reply.setReplyWriter(user.getUserId());
		reply.setReplyContent(HtmlUtils.htmlEscape(reply.getReplyContent()));
		mateReplyService.addMateReply(reply);
		return "success";
	}
	
	@GetMapping("/list")
	public Map<String, Object> list(@RequestParam int boardNo) {
		Authentication authentication=SecurityContextHolder.getContext().getAuthentication();
		String loginUserid=authentication.getName();
		
		List<MateReply> replyList = mateReplyService.getMateReplyList(boardNo);
		for(int i=0;i<replyList.size();i++) {
			String userName=travelUserService.getTravelUserByUserid(replyList.get(i).getReplyWriter()).getUserNickname();
			replyList.get(i).setReplyUserName(userName);
		}
		
		Map<String, Object> response=new HashMap<>();
		response.put("replyList", replyList);
		response.put("userId", loginUserid);
		return response;
	}
	
	@PostMapping("/remove")
	public String remove(@RequestBody @Valid MateReply reply) {
		mateReplyService.removeMateReply(reply.getReplyNo());
		return "success";
	}
	
	@PostMapping("/modify")
	public String modify(@RequestBody @Valid MateReply reply) {
		reply.setReplyContent(HtmlUtils.htmlEscape(reply.getReplyContent()));
		mateReplyService.modifyMateReply(reply);
		return "success";
	}
}
