package xyz.itwill.dao;

import java.util.List;

import xyz.itwill.dto.CourseReply;

public interface CourseReplyDAO {
	int insertCourseReply(CourseReply reply);
	List<CourseReply> selectCourseReplyList(int courseNo);
	int deleteCourseReplyByReplyNo(int replyNo);
	int updateCourseReplyByReplyNo(CourseReply reply);
	int selectCourseReplyCount(int courseNo);
}
