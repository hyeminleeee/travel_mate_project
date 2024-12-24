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
import xyz.itwill.dto.MateBoardLike;
import xyz.itwill.service.MateBoardLikeService;

@RestController
@RequestMapping("/mateboardlike")
@RequiredArgsConstructor
public class MateBoardLikeController {
	private final MateBoardLikeService mateboardLikeService;
	
	@ResponseBody
	@GetMapping("/likeUp")
	public Map<String, Object> likeUp(@RequestParam("boardNo") int boardNo, Authentication authentication) {
	    CustomUserDetails user = (CustomUserDetails) authentication.getPrincipal();

	    String status = "fail";
	    // 좋아요를 이미 눌렀는지 확인
	    if (mateboardLikeService.getMateBoardLikeByMateBoardNoUserId(boardNo, user.getUserId()) == null) {
	        MateBoardLike like = new MateBoardLike();
	        like.setBoardNo(boardNo);
	        like.setUserId(user.getUserId());
	        like.setLikeStatus(1);
	        mateboardLikeService.addLike(like);
	        status = "success";
	    }

	    // 좋아요 개수를 가져옴
	    int likeCount = mateboardLikeService.getMateBoardLike(boardNo).size();

	    // 응답을 위한 Map 생성
	    Map<String, Object> response = new HashMap<>();
	    response.put("status", status);
	    response.put("likeCount", likeCount);

	    return response;
	}

	
	@ResponseBody
	@GetMapping("/likeDown")
	public Map<String, Object> likeDown(@RequestParam("boardNo") int boardNo, Authentication authentication) {
		CustomUserDetails user=((CustomUserDetails)authentication.getPrincipal());
		
		
		MateBoardLike like=mateboardLikeService.getMateBoardLikeByMateBoardNoUserId(boardNo, user.getUserId());
		
		String status = "fail";
		if(like != null) {
			mateboardLikeService.removeLike(like);	
			status = "success";
		}
		
	    // 좋아요 개수를 가져옴
	    int likeCount = mateboardLikeService.getMateBoardLike(boardNo).size();
		
		Map<String, Object> response = new HashMap<>();
	    response.put("status", status);
	    response.put("likeCount", likeCount);
	    
		return response;
	} 
	
}
