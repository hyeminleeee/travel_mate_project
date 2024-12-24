package xyz.itwill.dto;

import java.sql.Date;

import lombok.Data;

/*
CREATE TABLE chat (
	    room_no NUMBER,
	    writer VARCHAR2(20),
	    content VARCHAR2(250),
	    regDate DATE
	);
*/


@Data
public class Chat {
	private int roomNo;
	private String writer;
	private String content;
	private Date regdate;
	

}
