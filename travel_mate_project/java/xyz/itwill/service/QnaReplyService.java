package xyz.itwill.service;

import java.util.List;

import xyz.itwill.dto.QnaReply;

public interface QnaReplyService {
	void addQnaReply(QnaReply reply);
	List<QnaReply> getQnaReplyList(int boardNum);
}
