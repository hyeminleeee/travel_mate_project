package xyz.itwill.dao;

import java.util.List;
import java.util.Map;

import xyz.itwill.dto.Course;

public interface CourseDAOSub {
	List<Course> selectCourseListByUserId(Map<String, Object> map);
    int selectTotalCourseCountById(String userId);
	List<Course> selectLikeCourseListByUserId(Map<String, Object> map);
    int selectLikeTotalCourseCountById(String userId);
	
}
