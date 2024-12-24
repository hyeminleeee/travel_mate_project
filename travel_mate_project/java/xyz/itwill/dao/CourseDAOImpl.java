package xyz.itwill.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.Course;
import xyz.itwill.dto.CourseLike;
import xyz.itwill.dto.Place;
import xyz.itwill.mapper.CourseMapper;

@Repository
@RequiredArgsConstructor
public class CourseDAOImpl implements CourseDAO {
	private final SqlSession sqlSession;
	
	@Override
	public int insertCourse(Course course) {
		return sqlSession.getMapper(CourseMapper.class).insertCourse(course);
	}

	@Override
	public int insertPlace(Place place) {
		return sqlSession.getMapper(CourseMapper.class).insertPlace(place);
	}

	@Override
	public Course selectCourseByCourseNo(int courseNo) {
		return sqlSession.getMapper(CourseMapper.class).selectCourseByCourseNo(courseNo);
	}

	@Override
	public int selectCourseSeq() {
		return sqlSession.getMapper(CourseMapper.class).selectCourseSeq();
	}

	@Override
	public List<Course> selectCourseList(Map<String, Object> map) {
		return sqlSession.getMapper(CourseMapper.class).selectCourseList(map);
	}

	@Override
	public int selectCourseCount(Map<String, Object> map) {
		return sqlSession.getMapper(CourseMapper.class).selectCourseCount(map); 
	}

	@Override
	public int updateCourse(Course course) {
		return sqlSession.getMapper(CourseMapper.class).updateCourse(course);
	}

	@Override
	public int updatePlace(Place place) {
		return sqlSession.getMapper(CourseMapper.class).updatePlace(place);
	}

	@Override
	public int deleteCourse(int courseNo) {
		return sqlSession.getMapper(CourseMapper.class).deleteCourse(courseNo);
	}

	@Override
	public int deletePlace(Map<String, Object> map) {
		return sqlSession.getMapper(CourseMapper.class).deletePlace(map); 
	}

	@Override
	public int updateCourseCount(int courseNo) {
		return sqlSession.getMapper(CourseMapper.class).updateCourseCount(courseNo);
	}

	@Override
	public List<Course> selectAdminCourseList() {
		return sqlSession.getMapper(CourseMapper.class).selectAdminCourseList();
	}

	@Override
	public Course selectCourseLikeCount(int courseNo) {
		return sqlSession.getMapper(CourseMapper.class).selectCourseLikeCount(courseNo);
	}
	
}
