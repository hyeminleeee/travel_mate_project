package xyz.itwill.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.NoticeBoard;
import xyz.itwill.mapper.NoticeBoardMapper;
import xyz.itwill.mapper.QnaBoardMapper;

@Repository
@RequiredArgsConstructor

public class NoticeBoardDAOImpl implements NoticeBoardDAO{
	 private final SqlSession sqlSession;
	
	 @Override
	public int insertNoticeBoard(NoticeBoard board) {		
		return sqlSession.getMapper(NoticeBoardMapper.class).insertNoticeBoard(board);
	}

	@Override
	public int updateNoticeBoard(NoticeBoard board) {
		return sqlSession.getMapper(NoticeBoardMapper.class).updateNoticeBoard(board);
	}

	@Override
	public int deleteNoticeBoard(int noticeNum) {	
		return sqlSession.getMapper(NoticeBoardMapper.class).deleteNoticeBoard(noticeNum);
	}

	@Override
	public NoticeBoard selectNoticeBoardByNum(int noticeNum) {	
		return sqlSession.getMapper(NoticeBoardMapper.class).selectNoticeBoardByNum(noticeNum);
	}

	@Override
	public int selectNoticeBoardCount(Map<String, Object> map) {	
		return sqlSession.getMapper(NoticeBoardMapper.class).selectNoticeBoardCount(map);
	}

	@Override
	public List<NoticeBoard> selectNoticeBoardList(Map<String, Object> map) {
		return sqlSession.getMapper(NoticeBoardMapper.class).selectNoticeBoardList(map);
	}

	 @Override
	    public int updateStatusNoticeBoard(int noticeNum, int noticeStatus) {
	        return sqlSession.getMapper(NoticeBoardMapper.class).updateStatusNoticeBoard(noticeNum, noticeStatus);
	    }

	@Override
	public int incrementNoticeCount(int noticeNum) {
		
		return sqlSession.getMapper(NoticeBoardMapper.class).incrementNoticeCount(noticeNum);
	}

	@Override
	public int NselectDeletedBoardCount() {
		
		return sqlSession.getMapper(NoticeBoardMapper.class).NselectDeletedBoardCount();
	}
	
}
