package xyz.itwill.dao;

import java.util.List;
import java.util.Map;
import xyz.itwill.dto.QnaBoard;

public interface QnaBoardDAO {
    int insertQnaBoard(QnaBoard board);
    int updateQnaBoard(QnaBoard board);
    int deleteQnaBoard(int num);
    QnaBoard selectQnaBoardByNum(int num);
    int selectQnaBoardCount(Map<String, Object> map);
    List<QnaBoard> selectQnaBoardList(Map<String, Object> map);
    
    int updateVerifyQnaBoard(QnaBoard board);
    int replyInsertQnaBoard(QnaBoard board); 
    int replySeqUpdate(QnaBoard parent);
    
    int selectDeletedBoardCount();
}

