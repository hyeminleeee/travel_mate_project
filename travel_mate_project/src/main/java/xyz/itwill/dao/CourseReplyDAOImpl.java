package xyz.itwill.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.CourseReply;
import xyz.itwill.mapper.CourseReplyMapper;

@Repository
@RequiredArgsConstructor
public class CourseReplyDAOImpl implements CourseReplyDAO {
	private final SqlSession sqlSession;
	
	@Override
	public int insertCourseReply(CourseReply reply) {
		return sqlSession.getMapper(CourseReplyMapper.class).insertCourseReply(reply);
	}

	@Override
	public List<CourseReply> selectCourseReplyList(int courseNo) {
		return sqlSession.getMapper(CourseReplyMapper.class).selectCourseReplyList(courseNo);
	}

	@Override
	public int deleteCourseReplyByReplyNo(int replyNo) {
		return sqlSession.getMapper(CourseReplyMapper.class).deleteCourseReplyByReplyNo(replyNo);
	}

	@Override
	public int updateCourseReplyByReplyNo(CourseReply reply) {
		return sqlSession.getMapper(CourseReplyMapper.class).updateCourseReplyByReplyNo(reply);
	}

	@Override
	public int selectCourseReplyCount(int courseNo) {
		return sqlSession.getMapper(CourseReplyMapper.class).selectCourseReplyCount(courseNo);
	}

}
