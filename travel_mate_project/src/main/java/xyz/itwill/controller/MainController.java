package xyz.itwill.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import xyz.itwill.auth.CustomUserDetails;

@Slf4j
@Controller
@RequiredArgsConstructor
public class MainController {
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String display(Authentication authentication) {
		if(authentication != null) { //로그인 사용자가 있는 경우
			//Authentication.getPrincipal() : 로그인 사용자 및 권장 정보가 저장된 UserDetails 
			//객체(CustomUserDetails 객체)를 반환하는 메소드
			//=> Object 객체를 반환하므로 명시적 객체 형변환 후 사용
			CustomUserDetails user=(CustomUserDetails)authentication.getPrincipal();
		
			log.warn("아이디 = "+user.getUserId()); 
			log.warn("이름 = "+user.getUserMemberName()); 
			log.warn("이메일 = "+user.getUserEmail()); 
		}
		
		return "main";
	}
	
}
