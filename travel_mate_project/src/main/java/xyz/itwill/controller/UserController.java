package xyz.itwill.controller;

import java.time.LocalDate;
import java.time.Period;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.RandomStringUtils;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.HtmlUtils;

import lombok.RequiredArgsConstructor;
import xyz.itwill.auth.CustomUserDetails;
import xyz.itwill.dao.CourseDAO;
import xyz.itwill.dao.CourseReplyDAO;
import xyz.itwill.dto.TravelAlarm;
import xyz.itwill.dto.TravelAuth;
import xyz.itwill.dto.TravelUser;
import xyz.itwill.service.CourseReplyService;
import xyz.itwill.service.CourseService;
import xyz.itwill.service.CourseServiceSub;
import xyz.itwill.service.MateBoardServiceSub;
import xyz.itwill.service.MateService;
import xyz.itwill.service.TravelAlarmService;
import xyz.itwill.service.TravelUserService;
@Controller
@RequiredArgsConstructor
@RequestMapping(value = "/account")
public class UserController {
	private final TravelUserService travelUserService;
	private final PasswordEncoder passwordEncoder;
	private final CourseServiceSub courseServiceSub;
	private final CourseReplyDAO courseReplyDAO;
	private final CourseDAO courseDAO;
	private final MateBoardServiceSub mateBoardServiceSub;
	private final TravelAlarmService travelAlarmService;
	private final MateService mateService;
	
	//로그인 이동
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String accountLogin() {
		return "account/account_login";
	}
	
	//로그인 실패 시 이동
	@RequestMapping(value = "/failLogin", method = RequestMethod.GET)
	public String failLogin() {
		return "account/failLogin";
	}
	
	//회원가입 이동
	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public String accountSignup() {
		return "account/account_signup"; 
	}
	
	//회원가입
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String accountSignup(@ModelAttribute TravelUser user, @RequestParam String userAge) {
		
		user.setUserId(HtmlUtils.htmlEscape(user.getUserId()));
		user.setUserPw(passwordEncoder.encode(user.getUserPw()));
		user.setUserName(HtmlUtils.htmlEscape(user.getUserName()));
		user.setUserNickname(HtmlUtils.htmlEscape(user.getUserNickname()));
		user.setUserEmail(HtmlUtils.htmlEscape(user.getUserEmail()));
		user.setUserPhone(user.getUserPhone());
		user.setUserIntroduction(HtmlUtils.htmlEscape(user.getUserIntroduction()));
		
		DateTimeFormatter formatter=DateTimeFormatter.ofPattern("yyyyMMdd");
		LocalDate birthdate=LocalDate.parse(userAge, formatter);
		
		int age=Period.between(birthdate, LocalDate.now()).getYears();
		
		String ageGroup=calculateAgeGroup(age);
		
		user.setUserAge(ageGroup);
		
		user.setUserGender(user.getUserGender());
		
		travelUserService.addTravelUser(user);

		TravelAuth auth=new TravelAuth(user.getUserId(), "ROLE_USER");
		
		travelUserService.addTravelAuth(auth);
		
		return "account/account_signup_success";
	}
	
	//아이디 중복체크
	@GetMapping("/checkId")
	@ResponseBody
	public String checkId(@RequestParam String userId) {
		TravelUser user=travelUserService.getTravelUserByUserid(userId);
		
		if(user == null) {
			return "available";			
		} else {
			return "exist";
		}
	}
	
	//닉네임 중복체크
	@GetMapping("/checkNick")
	@ResponseBody
	public String checkNick(@RequestParam String userNickname) {
		TravelUser user=travelUserService.getTravelUserByUserNickname(userNickname);
		
		if(user == null) {
			return "available";			
		} else {
			return "exist";
		}
	}
	
	//회원가입 성공 후 이동
	@RequestMapping(value = "/account_signup_success", method = RequestMethod.GET)
	public String accountSignupSuccess() {
		return "account/account_signup_success";
	}
	
	//마이페이지 이동
	@PreAuthorize("hasAnyRole('ROLE_USER', 'ROLE_ADMIN')")
	@RequestMapping(value = "/mypage", method = RequestMethod.GET)
	public String accountMypage(Model model) {
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    String userId = authentication.getName(); // 사용자 ID 또는 username 가져오기
		
	    TravelUser travelUser = travelUserService.getTravelUserByUserid(userId);
	    model.addAttribute("loginUser", travelUser);
	    model.addAttribute("currentPage", "mypage"); // 현재 페이지 정보 추가
		return "account/account_mypage";
	}
	
	//마이페이지 수정
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public String accountMypageModify(Authentication authentication, Model model) {
		 CustomUserDetails user=(CustomUserDetails)authentication.getPrincipal();
			
		TravelUser travelUser = travelUserService.getTravelUserByUserid(user.getUserId());
		model.addAttribute("loginUser", travelUser);
		return "account/account_mypage_modify";
	}
	
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String accountMypageModify(@ModelAttribute TravelUser travelUser
			, Model model) {
				
		// 비밀번호 수정 시 비밀번호 암호화 처리
        if (travelUser.getUserPw() != null && !travelUser.getUserPw().isEmpty()) {
            travelUser.setUserPw(passwordEncoder.encode(travelUser.getUserPw()));
        }
        travelUser.setUserNickname(HtmlUtils.htmlEscape(travelUser.getUserNickname()));
        travelUser.setUserEmail(HtmlUtils.htmlEscape(travelUser.getUserEmail()));
        travelUser.setUserPhone(HtmlUtils.htmlEscape(travelUser.getUserPhone()));
        travelUser.setUserIntroduction(HtmlUtils.htmlEscape(travelUser.getUserIntroduction()));
        travelUser.setUserAge(HtmlUtils.htmlEscape(travelUser.getUserAge()));
		
        //유저 정보 업데이트
        travelUserService.modifyTravelUser(travelUser);
        
		return "redirect:/account/mypage?userId="+travelUser.getUserId();
	}
	
	
	//내 여행코스
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value = "/travel_course", method = RequestMethod.GET)
	public String accountTravelCourse(Authentication authentication, @RequestParam Map<String, Object> map, Model model) {
		
		CustomUserDetails user=(CustomUserDetails)authentication.getPrincipal();
		
		TravelUser travelUser = travelUserService.getTravelUserByUserid(user.getUserId());
		model.addAttribute("loginUser", travelUser);
		model.addAttribute("currentPage", "travel_course"); // 현재 페이지 정보 추가
		
		// userNickname을 map에 추가
	    map.put("userId", travelUser.getUserId());
			    
		model.addAttribute("resultMap", courseServiceSub.getCourseListByUserId(map));
		model.addAttribute("searchMap", map);
		
		return "account/account_travelcourse";
	}
	
	//내 동행모집
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value = "/travel_mate", method = RequestMethod.GET)
	public String accountTravelMate(Authentication authentication, @RequestParam Map<String, Object> map, Model model) {
		
		CustomUserDetails user=(CustomUserDetails)authentication.getPrincipal();
		
		TravelUser travelUser = travelUserService.getTravelUserByUserid(user.getUserId());
		model.addAttribute("loginUser", travelUser);
		model.addAttribute("currentPage", "travel_mate"); // 현재 페이지 정보 추가
		
	    map.put("userId", travelUser.getUserId());
		
		model.addAttribute("resultMap", mateBoardServiceSub.getMateBoardListByUserId(map));
		model.addAttribute("searchMap", map);
				
		return "account/account_travelmate";
	}
	
	//내 참여여행
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value = "/travel_join", method = RequestMethod.GET)
	public String accountTravelJoin(Authentication authentication, @RequestParam Map<String, Object> map, Model model) {
		
		CustomUserDetails user=(CustomUserDetails)authentication.getPrincipal();
		
		TravelUser travelUser = travelUserService.getTravelUserByUserid(user.getUserId());
		model.addAttribute("loginUser", travelUser);
		model.addAttribute("currentPage", "travel_join"); // 현재 페이지 정보 추가
		
		 map.put("userId", travelUser.getUserId());
			
		model.addAttribute("resultMap", mateService.getJoinMateListByUserIdAndStatus(map));
		model.addAttribute("searchMap", map);
	
		return "account/account_traveljoin";
	}
	
	//내가 좋아요한 글(코스추천)
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value = "/travel_courselike", method = RequestMethod.GET)
	public String accountTravelCourseLike(Authentication authentication, @RequestParam Map<String, Object> map, Model model) {
		
		if (authentication == null || !authentication.isAuthenticated()) {
	        return "redirect:/account/login"; // 로그인 페이지로 리다이렉트
	    }
		
		CustomUserDetails user=(CustomUserDetails)authentication.getPrincipal();
		
		TravelUser travelUser = travelUserService.getTravelUserByUserid(user.getUserId());
		model.addAttribute("loginUser", travelUser);
		model.addAttribute("currentPage", "travel_courselike"); // 현재 페이지 정보 추가
		
		map.put("userId", travelUser.getUserId());
		
		model.addAttribute("resultMap", courseServiceSub.getLikeCourseListByUserId(map));
		model.addAttribute("searchMap", map);
		return "account/account_courselike";
	}
	//내가 좋아요한 글(친구모집)
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value = "/travel_matelike", method = RequestMethod.GET)
	public String accountTravelMateLike(Authentication authentication, @RequestParam Map<String, Object> map, Model model) {
		if (authentication == null || !authentication.isAuthenticated()) {
	        return "redirect:/account/login"; // 로그인 페이지로 리다이렉트
	    }
		CustomUserDetails user=(CustomUserDetails)authentication.getPrincipal();
		
		TravelUser travelUser = travelUserService.getTravelUserByUserid(user.getUserId());
		model.addAttribute("loginUser", travelUser);
		model.addAttribute("currentPage", "travel_matelike"); // 현재 페이지 정보 추가
		
		map.put("userId", travelUser.getUserId());
		
		model.addAttribute("resultMap", mateBoardServiceSub.getLikeMateBoardListByUserId(map));
		model.addAttribute("searchMap", map);
		
		return "account/account_matelike";
	}
	
	//알림
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value = "/travel_noti", method = RequestMethod.GET)
	public String accountTravelNoti(Authentication authentication, @RequestParam Map<String, Object> map, Model model) {
		
		CustomUserDetails user=(CustomUserDetails)authentication.getPrincipal();
		
		TravelUser travelUser = travelUserService.getTravelUserByUserid(user.getUserId());
		
		model.addAttribute("loginUser", travelUser);
		model.addAttribute("currentPage", "travel_noti"); // 현재 페이지 정보 추가
		
		map.put("userId", travelUser.getUserId());
		
		model.addAttribute("resultMap", travelAlarmService.getTravelAlarmByUserid(map));
		model.addAttribute("searchMap", map);
		
		return "account/account_travelnoti";
		
	}
	
	
	//회원 수정시 닉네임 중복검사
	@RequestMapping(value = "/checkNickname", method = RequestMethod.GET)
    @ResponseBody
    public boolean checkNickname(@RequestParam String userNickname, Authentication authentication) {
		
		CustomUserDetails user=(CustomUserDetails)authentication.getPrincipal();
		
		String currentNickname=user.getUserNickname();
		
		 if (userNickname.equals(currentNickname)) {
		        return false; // 중복 아님
		 }
		
        TravelUser travelUser = travelUserService.getTravelUserByUserNickname(userNickname);
        return travelUser != null; // 닉네임이 존재하면 true 반환 (중복)
    }
	
	//회원탈퇴
	@RequestMapping(value = "/userDisable", method = RequestMethod.POST)
	public String userDisable(HttpServletRequest request, HttpServletResponse response, Authentication authentication, Model model) {
		CustomUserDetails user=(CustomUserDetails)authentication.getPrincipal();
		
		TravelUser travelUser = travelUserService.getTravelUserByUserid(user.getUserId());
		
		travelUser.setUserStatus(0);
		travelUser.setUserEnabled("0");
		
		travelUserService.modifyDisable(travelUser);
		
		// 로그아웃 처리
	    SecurityContextLogoutHandler logoutHandler = new SecurityContextLogoutHandler();
	    logoutHandler.logout(request, response, authentication); // 각 매개변수는 자동으로 주입됨
		
		return "redirect:/account/login";
		
	}
	
	//아이디 찾기 이동
	@GetMapping("/findId")
	public String findId() {
		return "/account/account_findId";
	}
	
	//아이디 찾기
	@PostMapping("/findIdCheck")
	public String findId(@RequestParam Map<String, Object> map, Model model) {
		String userName=(String)map.get("userName");

		String userEmail=(String)map.get("userEmail");
		
		TravelUser user=travelUserService.getTravelUserForFindId(map);

		Map<String, Object> result=new HashMap<>();
		if(user == null) {
			result.put("response", "fail");
		} else {
			result.put("response", "success");
			
			String userId=user.getUserId();
			
			result.put("userId", userId);
		}
		model.addAttribute("result", result);
		return "/account/findIdCheck";
	}
	
	//비밀번호 찾기 이동
	@GetMapping("/findPw")
	public String findPw() {
		return "/account/account_findPw";
	}
	
	//비밀번호 찾기
	@PostMapping("/findPwCheck")
	public String findPw(@RequestParam Map<String, Object> map, Model model) {
		String userId=(String)map.get("userId");
		
		String userName=(String)map.get("userName");
		
		String userEmail=(String)map.get("userEmail");
		
		TravelUser user=travelUserService.getTravelUserForFindId(map);
		
		Map<String, Object> result=new HashMap<>();
		if(user == null) {
			result.put("response", "fail");
		} else {
			result.put("response", "success");
			
			//임시 비밀번호 난수값으로 발급
			String newPw=RandomStringUtils.randomAlphanumeric(10);
			
			//임시 비밀번호 암호화 처리 후 업데이트
			user.setUserPw(passwordEncoder.encode(newPw));
			travelUserService.modifyTravelUser(user);
			
			//뷰에는 암호화 되지 않은 임시 비밀번호 전달
			result.put("newPw", newPw);
		}
		model.addAttribute("result", result);
		return "/account/findPwCheck";
	}
	
	///////////////////////////////////////////////////////
	//회원샘플 추가
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	@ResponseBody
	public String addUser() {
		TravelUser user1=new TravelUser("abc123", passwordEncoder.encode("123456"), "홍길동", "동서번쩍", "abc@itwill.xyz", "010-1111-1111", "안녕하세요 홍길동입니다."
				, "20대", "남", "2024-09-27", 1, "1", null);
		TravelUser user2=new TravelUser("opq456", passwordEncoder.encode("123456"), "임꺽정", "도적", "opq@itwill.xyz", "010-2222-2222", "안녕하세요 임꺽정입니다."
				, "40대", "남", "2024-09-27", 1, "1", null);
		
		travelUserService.addTravelUser(user1);
		travelUserService.addTravelUser(user2);
		
		TravelAuth auth1=new TravelAuth("abc123", "ROLE_ADMIN");
		TravelAuth auth2=new TravelAuth("opq456", "ROLE_USER");
		
		travelUserService.addTravelAuth(auth1);
		travelUserService.addTravelAuth(auth2);
		
		return "success";
		
	}
	
	//회원정보 중 생년월일로 XX대 변경
    private String calculateAgeGroup(int age) {
        if (age >= 10 && age < 20) {
            return "10대";
        } else if (age >= 20 && age < 30) {
            return "20대";
        } else if (age >= 30 && age < 40) {
            return "30대";
        } else if (age >= 40 && age < 50) {
            return "40대";
        } else if (age >= 50 && age < 60) {
            return "50대";
        } else {
            return "기타";  // 60대 이상 등
        }
    }
	
}
