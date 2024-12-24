package xyz.itwill.dao;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.QnaBoard;
import xyz.itwill.mapper.QnaBoardMapper;

@Repository
@RequiredArgsConstructor
public class QnaBoardDAOImpl implements QnaBoardDAO {
    private final SqlSession sqlSession;

    @Override
    public int insertQnaBoard(QnaBoard board) {
        return sqlSession.getMapper(QnaBoardMapper.class).insertQnaBoard(board);
    }

    @Override
    public int updateQnaBoard(QnaBoard board) {
        return sqlSession.getMapper(QnaBoardMapper.class).updateQnaBoard(board);
    }

    @Override
    public int deleteQnaBoard(int num) {
        return sqlSession.getMapper(QnaBoardMapper.class).deleteQnaBoard(num);
    }

    @Override
    public QnaBoard selectQnaBoardByNum(int num) {
        return sqlSession.getMapper(QnaBoardMapper.class).selectQnaBoardByNum(num);
    }

    @Override
    public int selectQnaBoardCount(Map<String, Object> map) {
        return sqlSession.getMapper(QnaBoardMapper.class).selectQnaBoardCount(map);    
    }

    @Override
    public List<QnaBoard> selectQnaBoardList(Map<String, Object> map) {
        return sqlSession.getMapper(QnaBoardMapper.class).selectQnaBoardList(map);
    }

    @Override
    public int replyInsertQnaBoard(QnaBoard board) {
        return sqlSession.getMapper(QnaBoardMapper.class).replyInsertQnaBoard(board);
    }

    @Override
    public int replySeqUpdate(QnaBoard parent) {
        return sqlSession.getMapper(QnaBoardMapper.class).replySeqUpdate(parent);
    }

	@Override
	public int updateVerifyQnaBoard(QnaBoard board) {
		
		return sqlSession.getMapper(QnaBoardMapper.class).updateVerifyQnaBoard(board);
	}

	@Override
	public int selectDeletedBoardCount() {
		
		return sqlSession.getMapper(QnaBoardMapper.class).selectDeletedBoardCount();
	}

	
}