package xyz.itwill.dao;

import java.util.List;

import xyz.itwill.dto.MateReply;

public interface MateReplyDAO {
	int insertMateReply(MateReply reply);
	List<MateReply> selectMateReplyList(int boardNo);
	int deleteMateReplyByReplyNo(int replyNo);
	int updateMateReply(MateReply reply);
}
