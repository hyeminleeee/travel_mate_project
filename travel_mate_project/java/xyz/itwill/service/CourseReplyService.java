package xyz.itwill.service;

import java.util.List;

import xyz.itwill.dto.CourseReply;

public interface CourseReplyService {
	void addCourseReply(CourseReply reply);
	List<CourseReply> getCourseReplyList(int courseNo);
	void removeCourseReply(int replyNo);
	void modifyCourseReply(CourseReply reply);
}
