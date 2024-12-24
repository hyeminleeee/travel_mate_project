package xyz.itwill.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dao.CourseDAO;
import xyz.itwill.dao.CourseDAOSub;
import xyz.itwill.dto.Course;
import xyz.itwill.dto.Place;
import xyz.itwill.util.Pager;

@Service
@RequiredArgsConstructor
public class CourseServiceSubImpl implements CourseServiceSub {
	private final CourseDAOSub courseDAOSub;

	@Override
	public Map<String, Object> getCourseListByUserId(Map<String, Object> map) {
		int pageNum=1;
		String userId = (String)map.get("userId");
		
		if(map.get("pageNum") != null && !map.get("pageNum").equals("")) {
			pageNum=Integer.parseInt((String)map.get("pageNum"));
		}

		int pageSize=10;
		if(map.get("pageSize") != null && !map.get("pageSize").equals("")) {
			pageSize=Integer.parseInt((String)map.get("pageSize"));
		}
		
		int totalCourse=courseDAOSub.selectTotalCourseCountById(userId);
		
		int blockSize=10;
		
		Pager pager=new Pager(pageNum, pageSize, totalCourse, blockSize);		
		
		map.put("startRow", pager.getStartRow());
		map.put("endRow", pager.getEndRow());
		System.out.println("map = "+map);
		List<Course> courseList=courseDAOSub.selectCourseListByUserId(map);
		System.out.println("courseList = "+courseList);
		
		Map<String, Object> result=new HashMap<String, Object>();
		result.put("pager", pager);
		result.put("courseList", courseList); 
		
		return result;
	}

	@Override
	public Map<String, Object> getLikeCourseListByUserId(Map<String, Object> map) {
		int pageNum=1;
		String userId = (String)map.get("userId");
		
		if(map.get("pageNum") != null && !map.get("pageNum").equals("")) {
			pageNum=Integer.parseInt((String)map.get("pageNum"));
		}

		int pageSize=10;
		if(map.get("pageSize") != null && !map.get("pageSize").equals("")) {
			pageSize=Integer.parseInt((String)map.get("pageSize"));
		}
		
		int totalCourse=courseDAOSub.selectLikeTotalCourseCountById(userId);
		
		int blockSize=10;
		
		Pager pager=new Pager(pageNum, pageSize, totalCourse, blockSize);		
		
		map.put("startRow", pager.getStartRow());
		map.put("endRow", pager.getEndRow());
		System.out.println("map = "+map);
		List<Course> courseList=courseDAOSub.selectLikeCourseListByUserId(map);
		System.out.println("courseList = "+courseList);
		
		Map<String, Object> result=new HashMap<String, Object>();
		result.put("pager", pager);
		result.put("courseList", courseList); 
		
		return result;
	}

	
}