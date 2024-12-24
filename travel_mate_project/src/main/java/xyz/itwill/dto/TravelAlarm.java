package xyz.itwill.dto;

import lombok.Data;

/*
CREATE TABLE travel_alarm (
    alarm_id number PRIMARY KEY ,
    alarm_user_id VARCHAR(255) NOT NULL,
    target_user_id VARCHAR(255) NOT NULL,
    target_course_no number,
    target_board_no number,
    action_type VARCHAR(50) NOT NULL,
    alarm_date date,
    FOREIGN KEY (alarm_user_id) REFERENCES TRAVEL_USER(user_id),
    FOREIGN KEY (target_user_id) REFERENCES TRAVEL_USER(user_id),
    FOREIGN KEY (target_course_no) REFERENCES COURSE(course_no),
    FOREIGN KEY (target_board_no) REFERENCES MATE_BOARD(board_no)
);

create sequence travel_alarm_seq;
*/
@Data
public class TravelAlarm {
	private int alarmId;            // 알림 고유 ID
    private String alarmUserId;     // 알림을 받은 사용자 ID
    private String targetUserId;    // 알림을 발생시킨 사용자 ID
    private int targetCourseNo;     // 관련된 코스 번호 (NULL 가능)
    private int targetBoardNo;      // 관련된 모집글 번호 (NULL 가능)
    private String actionType;      // 알림의 유형 (e.g., 'COMMENT', 'LIKE', 'APPLY')
    private String alarmDate;       // 알림 생성 날짜
    
    private String targetUserNickname; //알림을 발생시킨 사용자 닉네임
    private String targetCourseTitle; //알림이 발생한 코스추천 게시글 제목
    private String targetBoardTitle; //알림이 발생한 동행모집 게시글 제목
    private int alarmRead; //알림 읽음 여부(1 : 읽지 않음, 0 : 읽음) - 디폴트 : 1
    
}
