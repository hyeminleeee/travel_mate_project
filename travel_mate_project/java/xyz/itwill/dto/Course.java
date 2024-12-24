package xyz.itwill.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/*
CREATE TABLE COURSE (
    course_no      NUMBER        PRIMARY KEY, -- 코스번호 (PK)
    course_title   VARCHAR2(255),             -- 코스제목
    course_writer  VARCHAR2(100),             -- 작성자
    course_regdate VARCHAR2(50),              -- 작성날짜
    course_update  VARCHAR2(50),              -- 변경날짜
    course_concept VARCHAR2(500),             -- 코스 컨셉
    course_count   NUMBER,                    -- 조회수
    course_image   VARCHAR2(500),             -- 대표사진명 파일명
);
 */ 

//create sequence course_seq; 

@Data
@NoArgsConstructor 
@AllArgsConstructor
public class Course {
	private int courseNo;
	private String courseTitle;
	private String courseWriter;
	private String courseRegdate;
	private String courseUpdate;
	private String courseConcept;
	private int courseCount;
	private String courseImage;
	List<Place> placeList;
	
	//필요여부 확인 주석처리
	private String userNickname;//작성자(닉네임) - TravelUser
	private int replyCount;
	private int likeCount;
	private int rownum;
}
