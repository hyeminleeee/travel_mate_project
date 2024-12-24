package xyz.itwill.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import xyz.itwill.dto.CourseLike;

public interface CourseLikeMapper {
	int selectCourseLikeCount();
	List<CourseLike> selectCourseLike(int courseNo);
	int likeUp(CourseLike courseLike);
	int likeDown(CourseLike courseLike);
	CourseLike selectCourseLikeByCourseNoUserid(@Param("courseNo") int courseNo, @Param("userId") String userId);
	int deleteCourseLike(int courseNo);
}
