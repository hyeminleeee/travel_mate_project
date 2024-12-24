package xyz.itwill.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import xyz.itwill.dto.MateBoardLike;

public interface MateBoardLikeMapper {
	int selectMateBoardLikeCount();
	List<MateBoardLike> selectMateBoardLike(int boardNo);
	int likeUp(MateBoardLike mateboardLike);
	int likeDown(MateBoardLike mateboardLike);
	MateBoardLike selectMateBoardLikeByMateBoardNoUserid(@Param("boardNo") int boardNo, @Param("userId") String userId);
	int deleteMateBoardLike(int boardNo);
}
