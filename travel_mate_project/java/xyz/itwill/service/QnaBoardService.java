package xyz.itwill.service;

import java.util.Map;
import xyz.itwill.dto.QnaBoard;

public interface QnaBoardService {
    void addQnaBoard(QnaBoard board);
    void modifyQnaBoard(QnaBoard board);
    void removeQnaBoard(int num);
    QnaBoard getQnaBoardByNum(int num);
    Map<String, Object> getQnaBoardList(Map<String, Object> map);
    
    void updateVerifyQnaBoard(QnaBoard board);
    void addQnaBoardReply(QnaBoard board);
    void updateReplySequence(QnaBoard parent);
    
    int getDeletedBoardCount();
}
