package xyz.itwill.dao;

import java.util.List;
import java.util.Map;

import xyz.itwill.dto.Course;
import xyz.itwill.dto.CourseLike;
import xyz.itwill.dto.Place;

public interface CourseDAO {
	int insertCourse(Course course);
	int insertPlace(Place place);
	Course selectCourseByCourseNo(int courseNo);
	int selectCourseSeq();
	List<Course> selectCourseList(Map<String, Object> map);
	int selectCourseCount(Map<String, Object> map); 
	int updateCourse(Course course);
	int updatePlace(Place place);
	int deleteCourse(int courseNo);
	int deletePlace(Map<String, Object> map);
	int updateCourseCount(int courseNo);
	List<Course> selectAdminCourseList();
	Course selectCourseLikeCount(int courseNo); 
}
