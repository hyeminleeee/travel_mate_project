package xyz.itwill.controller;

import java.util.List;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;
import xyz.itwill.auth.CustomUserDetails;
import xyz.itwill.dto.Chat;
import xyz.itwill.dto.Mate;
import xyz.itwill.service.ChatService;
import xyz.itwill.service.MateService;

@Controller
@RequestMapping("/chat")
@RequiredArgsConstructor
public class ChatController {
	private final ChatService chatService;
	private final MateService mateService; 
	
	@RequestMapping("")
	public String home() {
		return "chat/home";
	}
	
	@RequestMapping("/room/{boardNo}")
	public String chatRoom(Model model, Authentication authentication, @PathVariable int boardNo) {
		
		CustomUserDetails user = (CustomUserDetails)authentication.getPrincipal(); //로그인 정보
		String nickName = user.getUserNickname(); //닉네임 설정
		
		model.addAttribute("roomNo", boardNo); // 채팅방 번호 - 이후 방번호 설정 예정
		model.addAttribute("nickName", nickName);
		return "forward:/WEB-INF/views/chat/chatRoom.jsp";
	}
	
	@PostMapping("/callChats") 
	@ResponseBody
	public List<Chat> callChats(@RequestParam int roomNo, Model model){
		return chatService.getChatList(roomNo);
	}
	
	@PostMapping("/write") 
	@ResponseBody
	public String callChats(@ModelAttribute Chat chat){
		chatService.addChat(chat);
		return "success";
				
	}
}
