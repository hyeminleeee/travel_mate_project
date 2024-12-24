package xyz.itwill.dto;

import lombok.Data;

//create table mate_board(num number primary key, writer varchar2(100)
//, subject varchar2(500), content varchar2(4000), regdate date);
//create sequence mate_board_seq;

@Data
public class MateBoard {
	private int boardNo;
	private String boardWriter;//작성자(아이디)
	private String boardTitle;
	private String boardContent;
	private String boardRegdate;
	private String boardImage;
	private int boardCount;
	private int courseNo;
	
	private String userName;
	
	private String userNickname;//작성자(닉네임) - TravelUser
	private int mateCount; // 동행 참여자 수
	private int replyCount;
	private int likeCount;
	private int mateMaxCount;
	
	private int rownum;
}
