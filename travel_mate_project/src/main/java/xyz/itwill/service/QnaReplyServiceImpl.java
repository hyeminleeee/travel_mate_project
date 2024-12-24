package xyz.itwill.service;

import java.util.List;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dao.QnaBoardDAO;
import xyz.itwill.dao.QnaReplyDAO;
import xyz.itwill.dao.TravelUserDAO;
import xyz.itwill.dto.QnaReply;

@Service
@RequiredArgsConstructor
public class QnaReplyServiceImpl implements QnaReplyService {
	private final QnaReplyDAO qnaReplyDAO;
	private final TravelUserDAO travelUserDAO;
	private final QnaBoardDAO qnaBoardDAO;

	@Override
	public void addQnaReply(QnaReply reply) {
		if(travelUserDAO.selectTravelUserByUserid(reply.getWriter()) == null) {
			throw new RuntimeException("작성자를 찾을 수 없습니다.");
		}
		
		qnaReplyDAO.insertQnaReply(reply);
	}

	@Override
	public List<QnaReply> getQnaReplyList(int boardNum) {
		if(qnaBoardDAO.selectQnaBoardByNum(boardNum) == null) {
			throw new RuntimeException("게시글을 찾을 수 없습니다.");
		}
			
		return qnaReplyDAO.selectQnaReplyList(boardNum);
	}
}