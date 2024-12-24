package xyz.itwill.service;

import java.util.List;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dao.CourseReplyDAO;
import xyz.itwill.dto.CourseReply;

@Service
@RequiredArgsConstructor
public class CourseReplyServiceImpl implements CourseReplyService {
	private final CourseReplyDAO courseReplyDAO;

	@Override
	public void addCourseReply(CourseReply reply) {
		courseReplyDAO.insertCourseReply(reply);
	}

	@Override
	public List<CourseReply> getCourseReplyList(int courseNo) {
		return courseReplyDAO.selectCourseReplyList(courseNo);
	}

	@Override
	public void removeCourseReply(int replyNo) {
		courseReplyDAO.deleteCourseReplyByReplyNo(replyNo);
	}

	@Override
	public void modifyCourseReply(CourseReply reply) {
		courseReplyDAO.updateCourseReplyByReplyNo(reply);
	}
}
