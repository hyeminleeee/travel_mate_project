package xyz.itwill.service;

import java.util.List;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dao.MateBoardLikeDAO;
import xyz.itwill.dto.MateBoardLike;

@Service
@RequiredArgsConstructor
public class MateBoardLikeServiceImpl implements MateBoardLikeService {
	private final MateBoardLikeDAO mateboardLikeDAO;

	@Override
	public List<MateBoardLike> getMateBoardLike(int boardNo) {
		return mateboardLikeDAO.selectMateBoardLike(boardNo);
	}

	@Override
	public void addLike(MateBoardLike mateboardLike) {
		mateboardLikeDAO.likeUp(mateboardLike);
	}

	@Override
	public void removeLike(MateBoardLike mateboardLike) {
		mateboardLikeDAO.likeDown(mateboardLike);
	}

	@Override
	public MateBoardLike getMateBoardLikeByMateBoardNoUserId(int boardNo, String userId) {
		return mateboardLikeDAO.selectMateBoardLikeByMateBoardNoUserid(boardNo, userId);
	}

	@Override
	public void deleteMateBoardLike(int boardNo) {
		mateboardLikeDAO.deleteMateBoardLike(boardNo);
	}
}
