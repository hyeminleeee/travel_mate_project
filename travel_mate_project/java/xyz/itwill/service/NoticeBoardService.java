package xyz.itwill.service;

import java.util.Map;

import xyz.itwill.dto.NoticeBoard;

public interface NoticeBoardService {
    void addNoticeBoard(NoticeBoard board);
    void modifyNoticeBoard(NoticeBoard board);
    void removeNoticeBoard(int noticeNum);
    NoticeBoard getNoticeBoardByNum(int noticeNum);
    Map<String, Object> getNoticeBoardList(Map<String, Object> map);
   
    void updateStatusNoticeBoard(int noticeNum, int noticeStatus);

    void plusNoticeCount(int noticeNum);
    int getNDeletedBoardCount();
}
