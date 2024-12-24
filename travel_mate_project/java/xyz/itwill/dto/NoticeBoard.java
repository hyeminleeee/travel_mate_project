package xyz.itwill.dto;

import lombok.Data;

/*
 create table travel_notice(
notice_num number primary key 
, notice_id varchar2(100) constraint notice_user_fk references travel_user(user_id)
, notice_subject varchar2(500)
, notice_content varchar2(4000)
, notice_count number
, notice_regdate date
, notice_status number(1)); //0 : 상단고정글, 1 : 일반글, 2 : 삭제글
create sequence travel_notice_seq;		
 */

@Data
public class NoticeBoard {
	private int noticeNum;
	private String noticeId;
	private String noticeSubject;
	private String noticeContent;
	private int noticeCount;
	private String noticeRegdate;
	private int noticeStatus;
	
	private String userName;//작성자 이름
	private int rn;
}


