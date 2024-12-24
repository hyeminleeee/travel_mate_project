package xyz.itwill.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dao.MateBoardDAO;
import xyz.itwill.dao.MateBoardDAOSub;
import xyz.itwill.dao.TravelUserDAO;
import xyz.itwill.dto.Course;
import xyz.itwill.dto.MateBoard;
import xyz.itwill.util.Pager;

@Service
@RequiredArgsConstructor
public class MateBoardServiceSubImpl implements MateBoardServiceSub {
	private final TravelUserDAO travelUserDAO;
	private final MateBoardDAOSub mateBoardDAOSub;
	
	@Override
	public Map<String, Object> getMateBoardListByUserId(Map<String, Object> map) {
		int pageNum=1;
		String userId = (String) map.get("userId");
		
		if(map.get("pageNum") != null && !map.get("pageNum").equals("")) {
			pageNum=Integer.parseInt((String)map.get("pageNum"));
		}

		int pageSize=10;
		if(map.get("pageSize") != null && !map.get("pageSize").equals("")) {
			pageSize=Integer.parseInt((String)map.get("pageSize"));
		}
		
		int totalMateBoard=mateBoardDAOSub.selectTotalMateBoardByUserId(userId);
		
		int blockSize=10;
		
		Pager pager=new Pager(pageNum, pageSize, totalMateBoard, blockSize);
		//System.out.println("pageNum = " + pageNum );
		//System.out.println("pageSize = " + pageSize );
		//System.out.println("totalCourse = " + totalMateBoard );
		//System.out.println("blockSize = " + blockSize );
		
		
		map.put("startRow", pager.getStartRow());
		map.put("endRow", pager.getEndRow());
		//System.out.println("map = "+map);
		List<MateBoard> mateBoardList=mateBoardDAOSub.selectMateBoardListByUserId(map);
		//System.out.println("mateBoardList = "+mateBoardList);
		
		Map<String, Object> result=new HashMap<String, Object>();
		result.put("pager", pager);
		result.put("mateBoardList", mateBoardList); 
		
		return result;
	}

	@Override
	public Map<String, Object> getLikeMateBoardListByUserId(Map<String, Object> map) {
		int pageNum=1;
		String userId = (String) map.get("userId");
		
		if(map.get("pageNum") != null && !map.get("pageNum").equals("")) {
			pageNum=Integer.parseInt((String)map.get("pageNum"));
		}

		int pageSize=10;
		if(map.get("pageSize") != null && !map.get("pageSize").equals("")) {
			pageSize=Integer.parseInt((String)map.get("pageSize"));
		}
		
		int totalMateBoard=mateBoardDAOSub.selectLikeMateBoardTotalCountById(userId);
		
		int blockSize=10;
		
		Pager pager=new Pager(pageNum, pageSize, totalMateBoard, blockSize);
		//System.out.println("pageNum = " + pageNum );
		//System.out.println("pageSize = " + pageSize );
		//System.out.println("totalCourse = " + totalMateBoard );
		//System.out.println("blockSize = " + blockSize );
		
		
		map.put("startRow", pager.getStartRow());
		map.put("endRow", pager.getEndRow());
		//System.out.println("map = "+map);
		List<MateBoard> mateBoardList=mateBoardDAOSub.selectLikeMateBoardListByUserId(map);
		//System.out.println("mateBoardList = "+mateBoardList);
		
		Map<String, Object> result=new HashMap<String, Object>();
		result.put("pager", pager);
		result.put("mateBoardList", mateBoardList); 
		
		return result;
	}
	
	
	
}
