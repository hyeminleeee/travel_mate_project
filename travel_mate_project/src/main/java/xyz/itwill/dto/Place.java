package xyz.itwill.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/*
CREATE TABLE PLACE (
    place_no       NUMBER,                  -- 코스 번호 (FK)
    place_order    NUMBER,                  -- 장소 순서
    place_x        NUMBER,                  -- 장소 경도
    place_y        NUMBER,                  -- 장소 위도
    place_name     VARCHAR2(255),           -- 장소 이름
    place_content  VARCHAR2(1000),          -- 장소 소개
    place_image    VARCHAR2(500),           -- 장소 이미지
    CONSTRAINT fk_course_no FOREIGN KEY (place_no) REFERENCES COURSE(course_no)
);
 */ 

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Place {
	private int placeNo;
	private int placeOrder;
	private double placeX;
	private double placeY;
	private String placeName;
	private String placeContent;
	private String placeImage;
	
	private MultipartFile imageFile; // 이미지 파일(이미지 저장 후 파일명으로 변환하여 placeImage로 저장)
}
