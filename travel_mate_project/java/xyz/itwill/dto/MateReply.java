package xyz.itwill.dto;

import lombok.Data;

@Data
public class MateReply {
	private int replyNo;
	private String replyWriter;//작성자(아이디)
	private String replyContent;
	private String replyRegdate;
	private int boardNo;
	
	private String replyUserName;//작성자(이름)
}
