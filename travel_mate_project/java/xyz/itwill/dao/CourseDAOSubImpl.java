package xyz.itwill.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.Course;
import xyz.itwill.dto.Place;
import xyz.itwill.mapper.CourseMapper;
import xyz.itwill.mapper.CourseMapperSub;

@Repository
@RequiredArgsConstructor
public class CourseDAOSubImpl implements CourseDAOSub {
	private final SqlSession sqlSession;
	
	@Override
	public List<Course> selectCourseListByUserId(Map<String, Object> map) {
		return sqlSession.getMapper(CourseMapperSub.class).selectCourseListByUserId(map);
	}

	@Override
	public int selectTotalCourseCountById(String userId) {
		return sqlSession.getMapper(CourseMapperSub.class).selectTotalCourseCountById(userId);
	}

	@Override
	public List<Course> selectLikeCourseListByUserId(Map<String, Object> map) {
		return sqlSession.getMapper(CourseMapperSub.class).selectLikeCourseListByUserId(map);
	}

	@Override
	public int selectLikeTotalCourseCountById(String userId) {
		return sqlSession.getMapper(CourseMapperSub.class).selectLikeTotalCourseCountById(userId);
	}
	
}
