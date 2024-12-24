package xyz.itwill.service;

import java.util.Map;

import xyz.itwill.dto.Course;

public interface CourseServiceSub {
	Map<String, Object> getCourseListByUserId(Map<String, Object> map);
	Map<String, Object> getLikeCourseListByUserId(Map<String, Object> map);
}
