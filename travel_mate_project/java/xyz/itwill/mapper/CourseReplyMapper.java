package xyz.itwill.mapper;

import java.util.List;

import xyz.itwill.dto.CourseReply;

public interface CourseReplyMapper {
	int insertCourseReply(CourseReply reply);
	List<CourseReply> selectCourseReplyList(int courseNo);
	int deleteCourseReplyByReplyNo(int replyNo);
	int updateCourseReplyByReplyNo(CourseReply reply);
	int selectCourseReplyCount(int courseNo);
}
