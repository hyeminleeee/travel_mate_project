package xyz.itwill.service;

import java.util.List;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dao.MateReplyDAO;
import xyz.itwill.dto.MateReply;

@Service
@RequiredArgsConstructor
public class MateReplyServiceImpl implements MateReplyService {
	private final MateReplyDAO mateReplyDAO;
	
	@Override
	public void addMateReply(MateReply reply) {
		mateReplyDAO.insertMateReply(reply);
	}
	@Override
	public List<MateReply> getMateReplyList(int boardNo) {
		return mateReplyDAO.selectMateReplyList(boardNo);
	}
	@Override
	public void removeMateReply(int replyNo) {
		mateReplyDAO.deleteMateReplyByReplyNo(replyNo);
		
	}
	@Override
	public void modifyMateReply(MateReply reply) {
		mateReplyDAO.updateMateReply(reply);
	}
	
}
