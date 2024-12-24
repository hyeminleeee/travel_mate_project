package xyz.itwill.dto;

import lombok.Data;
/*
create table qna_board(num number primary key, writer varchar2(100)
, subject varchar2(500), content varchar2(4000), regdate date
, root number, step number default 0,indent number default 0
, verify number default 0 ,originalWriter VARCHAR2(100));

create sequence qna_board_seq;

*/
@Data
public class QnaBoard {
	private int num;
	private String writer;	
	private String subject;
	private String content;
	private String regdate;
	private int root;
	private int step;
	private int indent;
	private int verify;// 0 미답변 1 답변
	private String originalWriter;
	
	private String userName;	//작성자(이름)
	private int rownum;
}
