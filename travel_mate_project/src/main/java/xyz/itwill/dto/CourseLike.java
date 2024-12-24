package xyz.itwill.dto;

import lombok.Data;

@Data
public class CourseLike {
	private int likeNo;
	private int courseNo;
	private String userId;
	private int likeStatus;//좋아요 상태(0,1)
}
