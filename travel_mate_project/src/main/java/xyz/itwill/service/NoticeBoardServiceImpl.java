package xyz.itwill.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dao.NoticeBoardDAO;
import xyz.itwill.dao.TravelUserDAO;
import xyz.itwill.dto.NoticeBoard;
import xyz.itwill.util.qnaPager;


@Service
@RequiredArgsConstructor
public class NoticeBoardServiceImpl implements NoticeBoardService {
	private final TravelUserDAO travelUserDAO;
	private final NoticeBoardDAO noticeBoardDAO;
	
	@Override
	public void addNoticeBoard(NoticeBoard board) {
		if(travelUserDAO.selectTravelUserByUserid(board.getNoticeId()) == null) {
			throw new RuntimeException("게시글 작성자를 찾을 수 없습니다.");
		}
		
		
		noticeBoardDAO.insertNoticeBoard(board);
		
	}

	@Override
	public void modifyNoticeBoard(NoticeBoard board) {
		if(travelUserDAO.selectTravelUserByUserid(board.getNoticeId()) == null) {
			throw new RuntimeException("게시글 작성자를 찾을 수 없습니다.");
		}
		if(noticeBoardDAO.selectNoticeBoardByNum(board.getNoticeNum()) == null) {
			throw new RuntimeException("변경하고자 하는 게시글을 찾을 수 없습니다.");
		}
		
		noticeBoardDAO.updateNoticeBoard(board);
		
	}

	@Override
	public void removeNoticeBoard(int noticeNum) {
		if(noticeBoardDAO.selectNoticeBoardByNum(noticeNum) == null) {
			throw new RuntimeException("삭제 하고자 하는 게시글을 찾을 수 없습니다.");
		}
		noticeBoardDAO.deleteNoticeBoard(noticeNum);		
	}

	@Override
	public NoticeBoard getNoticeBoardByNum(int noticeNum) {
		NoticeBoard board=noticeBoardDAO.selectNoticeBoardByNum(noticeNum);
		if(board == null) {
			throw new RuntimeException("게시글을 찾을 수 없습니다.");
		}
		return board;
	}

	@Override
	public Map<String, Object> getNoticeBoardList(Map<String, Object> map) {
		int pageNum=1;
		if(map.get("pageNum") != null && !map.get("pageNum").equals("")) {
			pageNum=Integer.parseInt((String)map.get("pageNum"));
		}
		
		int pageSize=10;
		if(map.get("pageSize") != null && !map.get("pageSize").equals("")) {
			pageSize=Integer.parseInt((String)map.get("pageSize"));
		}
		
		int totalBoard=noticeBoardDAO.selectNoticeBoardCount(map);
		int deletedCount = noticeBoardDAO.NselectDeletedBoardCount();
		int blockSize=10;
		
		qnaPager pager = new qnaPager(pageNum, pageSize, totalBoard, blockSize, deletedCount);
		
		map.put("startRow", pager.getStartRow());
		map.put("endRow", pager.getEndRow());
		List<NoticeBoard> boardList=noticeBoardDAO.selectNoticeBoardList(map);
		
		Map<String, Object> result=new HashMap<String, Object>();
		result.put("deletedCount", deletedCount);
		result.put("pager", pager);
		result.put("noticeBoardList", boardList);
		

		return result;
	}

	@Override
	public void updateStatusNoticeBoard(int noticeNum, int noticeStatus) {
	    noticeBoardDAO.updateStatusNoticeBoard(noticeNum, noticeStatus);
	}

	@Override
	public void plusNoticeCount(int noticeNum) {
		 noticeBoardDAO.incrementNoticeCount(noticeNum);
	}

	@Override
	public int getNDeletedBoardCount() {
		return noticeBoardDAO.NselectDeletedBoardCount();
	}
	

}
