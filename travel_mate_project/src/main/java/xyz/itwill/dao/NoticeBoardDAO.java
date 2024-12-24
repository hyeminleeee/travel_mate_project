package xyz.itwill.dao;

import java.util.List;
import java.util.Map;

import xyz.itwill.dto.NoticeBoard;

public interface NoticeBoardDAO {
    int insertNoticeBoard(NoticeBoard board);
    int updateNoticeBoard(NoticeBoard board);
    int deleteNoticeBoard(int noticeNum);
    NoticeBoard selectNoticeBoardByNum(int noticeNum);
    int selectNoticeBoardCount(Map<String, Object> map);
    List<NoticeBoard> selectNoticeBoardList(Map<String, Object> map);
    
    int updateStatusNoticeBoard(int noticeNum, int noticeStatus);
    
    int incrementNoticeCount(int noticeNum);
    int NselectDeletedBoardCount();
}
