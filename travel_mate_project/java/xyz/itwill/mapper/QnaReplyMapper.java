package xyz.itwill.mapper;

import java.util.List;

import xyz.itwill.dto.QnaReply;

public interface QnaReplyMapper {
	int insertQnaReply(QnaReply reply);
	List<QnaReply> selectQnaReplyList(int boardNum);
}