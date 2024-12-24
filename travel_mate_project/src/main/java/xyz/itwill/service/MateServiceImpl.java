package xyz.itwill.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dao.MateDAO;
import xyz.itwill.dao.TravelUserDAO;
import xyz.itwill.dto.Mate;
import xyz.itwill.dto.MateBoard;
import xyz.itwill.dto.TravelUser;
import xyz.itwill.util.Pager;

@Service
@RequiredArgsConstructor
public class MateServiceImpl implements MateService {
	private final MateDAO mateDAO;
	private final TravelUserDAO userDAO;
	
	@Override
	public void addMate(Mate mate) {
		mateDAO.insertMate(mate);
	}

	@Override
	public List<Mate> getMateList(int boardNo) {
		List<Mate> mateDAOList = mateDAO.selectMateList(boardNo);
		for(int i=0;i<mateDAOList.size();i++) {
			String userName = userDAO.selectTravelUserByUserid(mateDAOList.get(i).getUserId()).getUserName();
			mateDAOList.get(i).setUserName(userName);
		}
		return mateDAOList;
	}

	@Override
	public void removeMate(int mateNo) {
		mateDAO.deleteMateByNo(mateNo);
	}

	@Override
	public List<Mate> getMateWaiList(int boardNo) {
		List<Mate> mateDAOList = mateDAO.selectMateWaitList(boardNo);
		for(int i=0;i<mateDAOList.size();i++) {
			TravelUser user = userDAO.selectTravelUserByUserid(mateDAOList.get(i).getUserId());
			mateDAOList.get(i).setUserName(user.getUserName());
			mateDAOList.get(i).setUserAge(user.getUserAge());
			mateDAOList.get(i).setUserGender(user.getUserGender());
			mateDAOList.get(i).setUserIntroduction(user.getUserIntroduction());
		}
		return mateDAOList;
	}

	@Override
	public List<Mate> getMateAcceptList(int boardNo) {
		List<Mate> mateDAOList = mateDAO.selectMateAcceptList(boardNo);
		for(int i=0;i<mateDAOList.size();i++) {
			String userName = userDAO.selectTravelUserByUserid(mateDAOList.get(i).getUserId()).getUserName();
			mateDAOList.get(i).setUserName(userName);
		}
		return mateDAOList;
	}

	@Override
	public void acceptMateByNo(int mateNo) {
		mateDAO.acceptMateByNo(mateNo);
		
	}
	
	//내가 참여한 동행모집 관련
	@Override
	public Map<String, Object> getJoinMateListByUserIdAndStatus(Map<String, Object> map) {
		int pageNum=1;
		String userId = (String)map.get("userId");
		
		if(map.get("pageNum") != null && !map.get("pageNum").equals("")) {
			pageNum=Integer.parseInt((String)map.get("pageNum"));
		}

		int pageSize=10;
		if(map.get("pageSize") != null && !map.get("pageSize").equals("")) {
			pageSize=Integer.parseInt((String)map.get("pageSize"));
		}
		
		int totalMate=mateDAO.selectTotalJoinMateCountByUserIdAndStatus(userId);
		
		int blockSize=10;
		
		Pager pager=new Pager(pageNum, pageSize, totalMate, blockSize);		
		
		map.put("startRow", pager.getStartRow());
		map.put("endRow", pager.getEndRow());
		//System.out.println("map = "+map);
		List<MateBoard> mateBoardList=mateDAO.selectJoinMateListByUserIdAndStatus(map);
		//System.out.println("mateBoardList = "+mateBoardList);
		
		Map<String, Object> result=new HashMap<String, Object>();
		result.put("pager", pager);
		result.put("mateBoardList", mateBoardList); 
		
		return result;
	}
	
}
