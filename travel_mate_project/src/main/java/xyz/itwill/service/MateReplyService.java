package xyz.itwill.service;

import java.util.List;

import xyz.itwill.dto.MateReply;

public interface MateReplyService {
	void addMateReply(MateReply reply);
	List<MateReply> getMateReplyList(int boardNo);
	void removeMateReply(int replyNo);
	void modifyMateReply(MateReply reply);
}
