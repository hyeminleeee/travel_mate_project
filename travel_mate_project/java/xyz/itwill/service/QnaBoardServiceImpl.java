package xyz.itwill.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dao.QnaBoardDAO;
import xyz.itwill.dao.TravelUserDAO;
import xyz.itwill.dto.QnaBoard;
import xyz.itwill.util.qnaPager;

@Service
@RequiredArgsConstructor
public class QnaBoardServiceImpl implements QnaBoardService {
	private final TravelUserDAO travelUserDAO;
	private final QnaBoardDAO qnaBoardDAO;

	@Transactional
	@Override
	public void addQnaBoard(QnaBoard board) {
		
		if(travelUserDAO.selectTravelUserByUserid(board.getWriter()) == null) {
			throw new RuntimeException("게시글 작성자를 찾을 수 없습니다.");
		}
		
		
		qnaBoardDAO.insertQnaBoard(board);
	}

	@Transactional
	@Override
	public void modifyQnaBoard(QnaBoard board) {
		
		if(travelUserDAO.selectTravelUserByUserid(board.getWriter()) == null) {
			throw new RuntimeException("게시글 작성자를 찾을 수 없습니다.");
		}
		if(qnaBoardDAO.selectQnaBoardByNum(board.getNum()) == null) {
			throw new RuntimeException("변경하고자 하는 게시글을 찾을 수 없습니다.");
		}
		
		qnaBoardDAO.updateQnaBoard(board); 
		
	}

	@Transactional
	@Override
	public void removeQnaBoard(int num) {
		if(qnaBoardDAO.selectQnaBoardByNum(num) == null) {
			throw new RuntimeException("삭제 하고자 하는 게시글을 찾을 수 없습니다.");
		}
		qnaBoardDAO.deleteQnaBoard(num);
	}

	@Override
	public QnaBoard getQnaBoardByNum(int num) {
		QnaBoard board=qnaBoardDAO.selectQnaBoardByNum(num);
		if(board == null) {
			throw new RuntimeException("게시글을 찾을 수 없습니다.");
		}
		return board;
	}

	@Override
	public Map<String, Object> getQnaBoardList(Map<String, Object> map) {
		int pageNum = 1;
        if (map.get("pageNum") != null && !map.get("pageNum").equals("")) {
            pageNum = Integer.parseInt((String) map.get("pageNum"));
        }

        int pageSize = 10;
        if (map.get("pageSize") != null && !map.get("pageSize").equals("")) {
            pageSize = Integer.parseInt((String) map.get("pageSize"));
        }

        int totalBoard = qnaBoardDAO.selectQnaBoardCount(map);
        int deletedCount = qnaBoardDAO.selectDeletedBoardCount(); // Get the count of deleted boards
        int blockSize = 10;

        qnaPager pager = new qnaPager(pageNum, pageSize, totalBoard, blockSize, deletedCount); // Use qnaPager
        
        
        map.put("startRow", pager.getStartRow());
        map.put("endRow", pager.getEndRow());
        List<QnaBoard> boardList = qnaBoardDAO.selectQnaBoardList(map);

        Map<String, Object> result = new HashMap<>();
        result.put("deletedCount", deletedCount);
        result.put("pager", pager);
        result.put("qnaBoardList", boardList);
        
        return result;
    }
	
	@Transactional
	@Override
	public void addQnaBoardReply(QnaBoard board) {
	    if (travelUserDAO.selectTravelUserByUserid(board.getWriter()) == null) {
	        throw new RuntimeException("게시글 작성자를 찾을 수 없습니다.");
	    }

	    //1,0,0 원본글 -> step = step + 1 where root = #{root} and step > #{step}
	    qnaBoardDAO.replySeqUpdate(board);
	    //원본글 verify 0 ->1 update  0:답변 미확인 1:답변확인
	    qnaBoardDAO.updateVerifyQnaBoard(board);
	    
	    // root, step, indent 값을 설정합니다.
	    board.setRoot(board.getRoot()); // root는 원 게시글의 root
	    board.setStep(board.getStep() + 1); // step을 증가
	    board.setIndent(board.getIndent() + 1); // indent를 증가

	   
	    qnaBoardDAO.replyInsertQnaBoard(board); // 게시글 삽입
	    
	    
	   // board.setVerify(1); // 답글의 verify 값을 1로 설정
	    qnaBoardDAO.updateVerifyQnaBoard(board); // 답글의 verify 업데이트
	}

	@Override
	public void updateReplySequence(QnaBoard parent) {
		 qnaBoardDAO.replySeqUpdate(parent); 
		
	}

	@Override
	public void updateVerifyQnaBoard(QnaBoard board) {
        qnaBoardDAO.updateVerifyQnaBoard(board);
    }		
	
	 @Override
	    public int getDeletedBoardCount() {
	        return qnaBoardDAO.selectDeletedBoardCount();
	    }

}