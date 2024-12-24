package xyz.itwill.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;
import xyz.itwill.auth.CustomUserDetails;
import xyz.itwill.dto.CourseLike;
import xyz.itwill.dto.MateBoardLike;
import xyz.itwill.service.CourseLikeService;

@RestController
@RequestMapping("/like")
@RequiredArgsConstructor
public class CourseLikeController {
	private final CourseLikeService courseLikeService;
	
	@ResponseBody
	@GetMapping("/likeUp")
	//public String likeUp(@RequestParam("courseNo") int courseNo, Authentication authentication) {
	public Map<String, Object> likeUp(@RequestParam("courseNo") int courseNo, Authentication authentication) {
		CustomUserDetails user=((CustomUserDetails)authentication.getPrincipal());
		
		/*
		CourseLike like=new CourseLike();
		like.setCourseNo(courseNo);
		like.setUserId(user.getUserId());
		like.setLikeStatus(1);
		courseLikeService.addLike(like);
		return "success";
		*/
		
		String status = "fail";
	    // 좋아요를 이미 눌렀는지 확인
	    if (courseLikeService.getCourseLikeByCourseNoUserId(courseNo, user.getUserId()) == null) {
	    	CourseLike like = new CourseLike();
	    	like.setCourseNo(courseNo);
			like.setUserId(user.getUserId());
			like.setLikeStatus(1);
			courseLikeService.addLike(like);
	        status = "success";
	    }

	    // 좋아요 개수를 가져옴
	    int likeCount = courseLikeService.getCourseLike(courseNo).size();

	    // 응답을 위한 Map 생성
	    Map<String, Object> response = new HashMap<>();
	    response.put("status", status);
	    response.put("likeCount", likeCount);

	    return response;
	}
	
	@ResponseBody
	@GetMapping("/likeDown")
	//public String likeDown(@RequestParam("courseNo") int courseNo, Authentication authentication) {
	public Map<String, Object> likeDown(@RequestParam("courseNo") int courseNo, Authentication authentication) {
		CustomUserDetails user=((CustomUserDetails)authentication.getPrincipal());
		
		/*
		CourseLike like=courseLikeService.getCourseLikeByCourseNoUserId(courseNo, user.getUserId());
		courseLikeService.removeLike(like);
		return "success";
		*/
		
		CourseLike like=courseLikeService.getCourseLikeByCourseNoUserId(courseNo, user.getUserId());
		
		String status = "fail";
		if(like != null) {
			courseLikeService.removeLike(like);
			status = "success";
		}
		
	    // 좋아요 개수를 가져옴
	    int likeCount = courseLikeService.getCourseLike(courseNo).size();
		
		Map<String, Object> response = new HashMap<>();
	    response.put("status", status);
	    response.put("likeCount", likeCount);
	    
		return response;
	} 
}
