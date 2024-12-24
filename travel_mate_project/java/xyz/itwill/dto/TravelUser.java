package xyz.itwill.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/*
create table travel_user(
user_id varchar2(100) primary key
, user_pw varchar2(100)
, user_name varchar2(50)
, user_nickname varchar2(50)
, user_email varchar2(50)
, user_phone varchar2(20)
, user_introduction varchar2(1000)
, user_age varchar2(30)
, user_gender varchar2(30)
, user_regdate date
, user_status number(1)
, user_enabled varchar2(1)
);
*/

@Data
@NoArgsConstructor
@AllArgsConstructor
public class TravelUser {
	private String userId;
	private String userPw;
	private String userName;
	private String userNickname;
	private String userEmail;
	private String userPhone;
	private String userIntroduction;
	private String userAge;
	private String userGender;
	private String userRegdate;
	private int userStatus;
	private String userEnabled;
	private List<TravelAuth> travelAuthList; //1:N 관계의 조인에서 N을 저장하기 위한 필드
}
