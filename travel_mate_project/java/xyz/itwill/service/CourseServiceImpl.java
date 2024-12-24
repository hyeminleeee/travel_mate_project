package xyz.itwill.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dao.CourseDAO;
import xyz.itwill.dto.Course;
import xyz.itwill.dto.Place;
import xyz.itwill.dto.TravelUser;
import xyz.itwill.util.Pager;

@Service
@RequiredArgsConstructor
public class CourseServiceImpl implements CourseService {
	private final CourseDAO courseDAO;
	private final TravelUserService travelUserService;
	
	@Transactional
	@Override
	public void addCourse(Course course) {
		courseDAO.insertCourse(course);
	}

	@Override
	public void addPlace(Place place) {
		courseDAO.insertPlace(place);
	}

	@Override
	public Course getCourseByCourseNo(int courseNo) {
		return courseDAO.selectCourseByCourseNo(courseNo);
	}

	@Override
	public int getCourseByCourseSeq() {
		return courseDAO.selectCourseSeq();
	}

	@Override
	public Map<String, Object> getCourseList(Map<String, Object> map) {
		int pageNum=1;
		if(map.get("pageNum") != null && !map.get("pageNum").equals("")) {
			pageNum=Integer.parseInt((String)map.get("pageNum"));
		}

		int pageSize=10;
		if(map.get("pageSize") != null && !map.get("pageSize").equals("")) {
			pageSize=Integer.parseInt((String)map.get("pageSize"));
		}
		
		int totalCourse=courseDAO.selectCourseCount(map);
		
		int blockSize=10;
		
		Pager pager=new Pager(pageNum, pageSize, totalCourse, blockSize);
		
		map.put("startRow", pager.getStartRow());
		map.put("endRow", pager.getEndRow());
		List<Course> courseList=courseDAO.selectCourseList(map);
		
		//작성자 nickName으로 출력하게 하기 위한 코드
		for(Course course : courseList) {
			int courseNo=course.getCourseNo();
			String userId=courseDAO.selectCourseByCourseNo(courseNo).getCourseWriter();
			String userNickname=travelUserService.getTravelUserByUserid(userId).getUserNickname();
			
			course.setUserNickname(userNickname);
		}
		
		Map<String, Object> result=new HashMap<String, Object>();
		result.put("pager", pager);
		result.put("courseList", courseList); 
		
		return result;
	}

	@Override
	public void modifyCourse(Course course) {
		courseDAO.updateCourse(course);
		
	}

	@Override
	public void modifyPlace(Place place) {
		courseDAO.updatePlace(place);
		
	}

	@Override
	public void removeCourse(int courseNo) {
		courseDAO.deleteCourse(courseNo);
		
	}

	@Override
	public void removePlace(Map<String, Object> map) {
		courseDAO.deletePlace(map);
		
	}

	@Override
	public void modifyCourseCount(int courseNo) {
		courseDAO.updateCourseCount(courseNo);
	}

	@Override
	public List<Course> getAdminCourseList() {
		return courseDAO.selectAdminCourseList();
	}

	@Override
	public Map<String, Object> getmateCourseList(Map<String, Object> map) {
		int pageNum=1;
		if(map.get("pageNum") != null && !map.get("pageNum").equals("")) {
			pageNum=Integer.parseInt((String)map.get("pageNum"));
		}

		int pageSize=10;
		if(map.get("pageSize") != null && !map.get("pageSize").equals("")) {
			pageSize=Integer.parseInt((String)map.get("pageSize"));
		}
		
		int totalCourse=courseDAO.selectCourseCount(map);
		
		int blockSize=10;
		
		Pager pager=new Pager(pageNum, totalCourse, totalCourse, blockSize);
		
		map.put("startRow", pager.getStartRow());
		map.put("endRow", pager.getEndRow());
		List<Course> courseList=courseDAO.selectCourseList(map);
		
		//작성자 nickName으로 출력하게 하기 위한 코드
		for(Course course : courseList) {
			int courseNo=course.getCourseNo();
			String userId=courseDAO.selectCourseByCourseNo(courseNo).getCourseWriter();
			String userNickname=travelUserService.getTravelUserByUserid(userId).getUserNickname();
			
			course.setUserNickname(userNickname);
		}
		
		Map<String, Object> result=new HashMap<String, Object>();
		result.put("pager", pager);
		result.put("courseList", courseList); 
		
		return result;
	}

}














