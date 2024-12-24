package xyz.itwill.dto;

import lombok.Data;

//create table mate_boardlike(like_no number primary key, board_no number, user_id varchar2(100), like_status number);
//create SEQUENCE mateboard_like_seq;

@Data
public class MateBoardLike {
	private int likeNo;
	private int boardNo;
	private String userId;
	private int likeStatus;//좋아요 상태(0,1)
}
