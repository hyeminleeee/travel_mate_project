package xyz.itwill.dto;

import lombok.Data;

/*
create table course_reply(reply_no number primary key, reply_writer varchar2(100), reply_content varchar2(1000)
	, reply_regdate date, course_no number, constraint reply_course_no_fk foreign key(course_no) 
	references course(course_no) on delete cascade);

create sequence course_reply_seq;
 */

@Data
public class CourseReply {
	private int replyNo;
	private String replyWriter;//작성자(닉네임)
	private String replyContent;
	private String replyRegdate;
	private String replyUpdate;
	private int courseNo;
	private String userId;//작성자(아이디)
	private String userNickname;
}
