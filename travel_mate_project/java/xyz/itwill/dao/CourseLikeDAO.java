package xyz.itwill.dao;

import java.util.List;

import xyz.itwill.dto.CourseLike;

public interface CourseLikeDAO {
	int selectCourseLikeCount();
	List<CourseLike> selectCourseLike(int courseNo);
	int likeUp(CourseLike courseLike);
	int likeDown(CourseLike courseLike);
	CourseLike selectCourseLikeByCourseNoUserid(int courseNo, String userId);
	int deleteCourseLike(int courseNo);
}
