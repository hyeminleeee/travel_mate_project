package xyz.itwill.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.CourseLike;
import xyz.itwill.mapper.CourseLikeMapper;

@Repository
@RequiredArgsConstructor
public class CourseLikeDAOImpl implements CourseLikeDAO {
	private final SqlSession sqlSession;
	
	@Override
	public int selectCourseLikeCount() {
		return sqlSession.getMapper(CourseLikeMapper.class).selectCourseLikeCount();
	}

	@Override
	public List<CourseLike> selectCourseLike(int courseNo) {
		return sqlSession.getMapper(CourseLikeMapper.class).selectCourseLike(courseNo);
	}

	@Override
	public int likeUp(CourseLike courseLike) {
		return sqlSession.getMapper(CourseLikeMapper.class).likeUp(courseLike);
	}

	@Override
	public int likeDown(CourseLike courseLike) {
		return sqlSession.getMapper(CourseLikeMapper.class).likeDown(courseLike);
	}

	@Override
	public CourseLike selectCourseLikeByCourseNoUserid(int courseNo, String userId) {
		return sqlSession.getMapper(CourseLikeMapper.class).selectCourseLikeByCourseNoUserid(courseNo, userId);
	}

	@Override
	public int deleteCourseLike(int courseNo) {
		return sqlSession.getMapper(CourseLikeMapper.class).deleteCourseLike(courseNo);
	}



}
