package xyz.itwill.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import xyz.itwill.dto.NoticeBoard;


public interface NoticeBoardMapper {
    int insertNoticeBoard(NoticeBoard board);
    int updateNoticeBoard(NoticeBoard board);
    int deleteNoticeBoard(int noticeNum);
    NoticeBoard selectNoticeBoardByNum(int noticeNum);
    int selectNoticeBoardCount(Map<String, Object> map);
    List<NoticeBoard> selectNoticeBoardList(Map<String, Object> map);
    
    int updateStatusNoticeBoard(@Param("noticeNum") int noticeNum, @Param("noticeStatus") int noticeStatus);
    
    int incrementNoticeCount(int noticeNum);
    int NselectDeletedBoardCount();
}
