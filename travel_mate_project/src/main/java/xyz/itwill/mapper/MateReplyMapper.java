package xyz.itwill.mapper;

import java.util.List;

import xyz.itwill.dto.MateReply;

public interface MateReplyMapper {
	int insertMateReply(MateReply reply);
	List<MateReply> selectMateReplyList(int boardNo);
	int deleteMateReplyByReplyNo(int replyNo);
	int updateMateReply(MateReply reply);
}
