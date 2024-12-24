package xyz.itwill.service;

import java.util.List;
import java.util.Map;

import xyz.itwill.dto.Course;
import xyz.itwill.dto.Place;

public interface CourseService {
	void addCourse(Course course);
	void addPlace(Place place);
	Course getCourseByCourseNo(int courseNo);
	int getCourseByCourseSeq();
	Map<String, Object> getCourseList(Map<String, Object> map);
	void modifyCourse(Course course);
	void modifyPlace(Place place);
	void removeCourse(int courseNo);
	void removePlace(Map<String, Object> map);
	void modifyCourseCount(int courseNo);
	List<Course> getAdminCourseList();
	
	Map<String, Object> getmateCourseList(Map<String, Object> map);
	
}
