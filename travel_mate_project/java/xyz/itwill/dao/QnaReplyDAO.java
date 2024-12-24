package xyz.itwill.dao;

import java.util.List;

import xyz.itwill.dto.QnaReply;

public interface QnaReplyDAO {
	int insertQnaReply(QnaReply reply);
	List<QnaReply> selectQnaReplyList(int boardNum);
}