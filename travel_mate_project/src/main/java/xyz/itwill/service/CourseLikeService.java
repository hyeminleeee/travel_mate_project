package xyz.itwill.service;

import java.util.List;

import xyz.itwill.dto.CourseLike;

public interface CourseLikeService {
	List<CourseLike> getCourseLike(int courseNo);
	void addLike(CourseLike courseLike);
	void removeLike(CourseLike courseLike);
	CourseLike getCourseLikeByCourseNoUserId(int courseNo, String userId);
	void deleteCourseLike(int courseNo);
}
