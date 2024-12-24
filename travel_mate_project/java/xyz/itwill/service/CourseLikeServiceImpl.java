package xyz.itwill.service;

import java.util.List;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dao.CourseLikeDAO;
import xyz.itwill.dto.CourseLike;

@Service
@RequiredArgsConstructor
public class CourseLikeServiceImpl implements CourseLikeService {
	private final CourseLikeDAO courseLikeDAO;
	
	@Override
	public List<CourseLike> getCourseLike(int courseNo) {
		return courseLikeDAO.selectCourseLike(courseNo);
	}

	@Override
	public void addLike(CourseLike courseLike) {
		courseLikeDAO.likeUp(courseLike);
	}

	@Override
	public void removeLike(CourseLike courseLike) {
		courseLikeDAO.likeDown(courseLike);
	}

	@Override
	public CourseLike getCourseLikeByCourseNoUserId(int courseNo, String userId) {
		return courseLikeDAO.selectCourseLikeByCourseNoUserid(courseNo, userId);
	}

	@Override
	public void deleteCourseLike(int courseNo) {
		courseLikeDAO.deleteCourseLike(courseNo);
	}

}
