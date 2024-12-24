package xyz.itwill.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dao.MateBoardDAO;
import xyz.itwill.dao.TravelUserDAO;
import xyz.itwill.dto.MateBoard;
import xyz.itwill.util.Pager;

@Service
@RequiredArgsConstructor
public class MateBoardServiceImpl implements MateBoardService {
	private final TravelUserDAO travelUserDAO;
	private final MateBoardDAO mateBoardDAO;
	
	@Transactional
	@Override
	public void addMateBoard(MateBoard board) {
		
		if(travelUserDAO.selectTravelUserByUserid(board.getBoardWriter()) == null) {
			throw new RuntimeException("게시글 작성자를 찾을 수 없습니다.");
		}
		
		mateBoardDAO.insertMateBoard(board);
	}
	
	@Transactional
	@Override
	public void modifyMateBoard(MateBoard board) {
		if(travelUserDAO.selectTravelUserByUserid(board.getBoardWriter()) == null) {
			throw new RuntimeException("게시글 작성자를 찾을 수 없습니다.");
		}
		
		if(mateBoardDAO.selectMateBoardByNo(board.getBoardNo()) == null) {
			throw new RuntimeException("변경하고자 하는 게시글을 찾을 수 없습니다.");
		}
		
		mateBoardDAO.updateMateBoard(board);
	}
	
	@Transactional
	@Override
	public void removeMateBoard(int boardNo) {
		if(mateBoardDAO.selectMateBoardByNo(boardNo) == null) {
			throw new RuntimeException("삭제 하고자 하는 게시글을 찾을 수 없습니다.");
		}
		mateBoardDAO.deleteMateBoard(boardNo);
	}
	
	@Override
	public MateBoard getMateBoardByNo(int boardNo) {
		MateBoard board=mateBoardDAO.selectMateBoardByNo(boardNo);
		if(board == null) {
			throw new RuntimeException("게시글을 찾을 수 없습니다.");
		}
		return board;
	}
	
	@Override
	public Map<String, Object> getMateBoardList(Map<String, Object> map) {
		int pageNum=1;
		if(map.get("pageNum") != null && !map.get("pageNum").equals("")) {
			pageNum=Integer.parseInt((String)map.get("pageNum"));
		}
		
		int pageSize=10;
		if(map.get("pageSize") != null && !map.get("pageSize").equals("")) {
			pageSize=Integer.parseInt((String)map.get("pageSize"));
		}
		
		int totalBoard=mateBoardDAO.selectMateBoardCount(map);
		
		int blockSize=10;
		
		Pager pager=new Pager(pageNum, pageSize, totalBoard, blockSize);
		
		map.put("startRow", pager.getStartRow());
		map.put("endRow", pager.getEndRow());
		List<MateBoard> boardList=mateBoardDAO.selectMateBoardList(map);
		
		Map<String, Object> result=new HashMap<String, Object>();
		result.put("pager", pager);
		result.put("mateBoardList", boardList);
		
		return result;
	}
	
	@Override
	public void modifyMateBoardCount(int boardNo) {
		mateBoardDAO.updateMateBoardCount(boardNo);
	}

	@Override
	public List<MateBoard> getAdminMateBoardList() {
		return mateBoardDAO.selectAdminMateBoardList();
	}
}
