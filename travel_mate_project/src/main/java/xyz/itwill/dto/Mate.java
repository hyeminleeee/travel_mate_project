package xyz.itwill.dto;

import lombok.Data;

//create table mate(mate_no number primary key, board_no number, user_id varchar2(100));
//create sequence mate_seq;

@Data
public class Mate {
	private int mateNo;
	private int boardNo;
	private String userId;
	
	private int mateStatus;
	
	
	
	private String userName;
	private String userNickname;//작성자(닉네임) - TravelUser
	
	private String userAge;
	private String userGender;
	private String userIntroduction;
	
}
