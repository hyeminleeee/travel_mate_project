package xyz.itwill.service;

import java.util.List;

import xyz.itwill.dto.MateBoardLike;

public interface MateBoardLikeService {
	List<MateBoardLike> getMateBoardLike(int boardNo);
	void addLike(MateBoardLike mateboardLike);
	void removeLike(MateBoardLike mateboardLike);
	MateBoardLike getMateBoardLikeByMateBoardNoUserId(int boardNo, String userId);
	void deleteMateBoardLike(int boardNo);
}
