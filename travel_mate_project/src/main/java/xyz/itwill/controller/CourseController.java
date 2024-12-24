package xyz.itwill.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.lang.StringEscapeUtils;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;

import lombok.RequiredArgsConstructor;
import xyz.itwill.auth.CustomUserDetails;
import xyz.itwill.dao.CourseDAO;
import xyz.itwill.dao.CourseReplyDAO;
import xyz.itwill.dto.Course;
import xyz.itwill.dto.CourseLike;
import xyz.itwill.dto.Place;
import xyz.itwill.dto.TravelUser;
import xyz.itwill.service.CourseLikeService;
import xyz.itwill.service.CourseService;
import xyz.itwill.service.CourseServiceImpl;
import xyz.itwill.service.TravelUserService;

@Controller
@RequestMapping("/course")
@RequiredArgsConstructor
public class CourseController {
	private final CourseService courseService;
	private final WebApplicationContext context; //스프링 컨테이너
	private final TravelUserService travelUserService;
	private final CourseReplyDAO courseReplyDAO;
	private final CourseDAO courseDAO;
	private final CourseLikeService courseLikeService;

	// Ajax-JSON list 전달
	@GetMapping("/placeList/{courseNumber}")
	@ResponseBody
	public Course courseSend(@PathVariable int courseNumber) {
		return courseService.getCourseByCourseNo(courseNumber);
	}
	
	// 코스 쓰기 이동
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/write")
	public String write(Model model) {
		return "course/write";
	}
	
	// 코스 쓰기 등록
	@PostMapping("/write")
	@Transactional
	public String write(@ModelAttribute Course course, @RequestParam MultipartFile mainImage, Authentication authentication) throws IllegalStateException, IOException {

		if(!mainImage.isEmpty()) { //메인이미지 존재여부 확인
			String uploadDirectory=context.getServletContext().getRealPath("/resources/images/upload/course");
			String uploadFilename=UUID.randomUUID().toString()+"_"+mainImage.getOriginalFilename(); 
			
			File file=new File(uploadDirectory, uploadFilename); //파일 객체 생성
			mainImage.transferTo(file); //메인 이미지 파일 저장
			
			
			course.setCourseImage(uploadFilename); //이미지 파일명 저장
							 
		}
		
		int courseNo = courseService.getCourseByCourseSeq(); //게시글번호
		
		course.setCourseNo(courseNo); //게시글번호 입력
		
		CustomUserDetails user = (CustomUserDetails)authentication.getPrincipal(); //로그인 정보
		course.setCourseWriter(user.getUserId()); //닉네임 설정
		
		String escapeTitle = StringEscapeUtils.escapeHtml(course.getCourseTitle());
		course.setCourseTitle(escapeTitle);
		
		courseService.addCourse(course);
		
		List<Place> placeList = course.getPlaceList(); //게시글 내 place요소 리스트
		
		for(Place place : placeList) {
			place.setPlaceNo(courseNo); //요소가 속한 게시글번호
			
			String escapePlace = StringEscapeUtils.escapeHtml(place.getPlaceContent());
			place.setPlaceContent(escapePlace);
	
			if(!place.getImageFile().isEmpty()) { //place에 대한 이미지 존재여부 확인
				MultipartFile imageFile = place.getImageFile();
				String uploadDirectory=context.getServletContext().getRealPath("/resources/images/upload/course");
				String uploadFilename=UUID.randomUUID().toString()+"_"+imageFile.getOriginalFilename(); 
				
				File file=new File(uploadDirectory, uploadFilename); //파일 객체 생성
				imageFile.transferTo(file); //이미지 파일 저장
				
				place.setPlaceImage(uploadFilename); //이미지 파일명 저장				
			}
			courseService.addPlace(place);
		}
		return "redirect:/course/view/?num="+courseNo; 
	}

	// 코스 view 이동 
	@RequestMapping("/view")
	public String view(@RequestParam Map<String, Object> map, Model model, Principal principal) {
		int courseNo=Integer.parseInt((String)map.get("num"));
		int totalReply=courseReplyDAO.selectCourseReplyCount(courseNo);
		model.addAttribute("totalReply", totalReply);

		//로그인 정보가 null 인 경우 login 페이지 이동
		if(principal == null) {
			return "redirect:/account/login";
		} else {
			String userId=principal.getName();
			TravelUser travelUser=travelUserService.getTravelUserByUserid(userId); 
			model.addAttribute("travelUser", travelUser); 
			
			//코스 게시글 view 페이지 이동시 조회수 증가
			courseService.modifyCourseCount(courseNo); 
			
			CourseLike courseLike=courseLikeService.getCourseLikeByCourseNoUserId(courseNo, userId);
			model.addAttribute("courseLike", courseLike);
		}
		
		//작성자 nickName으로 출력하게 하기 위한 코드
		Course course=courseService.getCourseByCourseNo(courseNo);
		String userId=course.getCourseWriter();
		TravelUser user=travelUserService.getTravelUserByUserid(userId);
		course.setUserNickname(user.getUserNickname());
		
		model.addAttribute("course", course);		
		model.addAttribute("searchMap", map);
		model.addAttribute("courseLikeCount", courseDAO.selectCourseLikeCount(courseNo));		
		
		return "course/view";
	}

	// 코스 리스트 이동
	@RequestMapping("/list")
	public String list(@RequestParam Map<String, Object> map, Model model) {		
		model.addAttribute("resultMap", courseService.getCourseList(map)); 
		
		model.addAttribute("searchMap", map);
		return "course/list";
	}
	
	// 코스수정 이동
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/modify/{courseNo}")
	public String modify(@PathVariable int courseNo, Model model) {
		model.addAttribute("resultMap", courseService.getCourseByCourseNo(courseNo));
		return "course/modify";
	}
	
	// 코스수정 등록
	@PostMapping("/modify")
	@Transactional
	public String modify(@ModelAttribute Course course, @RequestParam MultipartFile mainImage, @RequestParam int updateIndex, Map<String, Object> map) throws IllegalStateException, IOException {

		if(!mainImage.isEmpty()) { //메인이미지 존재여부 확인
			String uploadDirectory=context.getServletContext().getRealPath("/resources/images/upload/course");
			String uploadFilename=UUID.randomUUID().toString()+"_"+mainImage.getOriginalFilename(); 
			
			File file=new File(uploadDirectory, uploadFilename); //파일 객체 생성
			mainImage.transferTo(file); //메인 이미지 파일 저장
			
			course.setCourseImage(uploadFilename); //이미지 파일명 저장		 
		}
		
		String escapeTitle = StringEscapeUtils.escapeHtml(course.getCourseTitle());
		course.setCourseTitle(escapeTitle);
		
		courseService.modifyCourse(course);
		
		int courseNo = course.getCourseNo();
		
		
		List<Place> placeList = course.getPlaceList(); //게시글 내 place요소 리스트
		
		for(int i=0; i < 10; i++) {
			
			if(i < placeList.size()) {
				Place place = placeList.get(i);
				
				if(place.getPlaceOrder() <= updateIndex+1) {
					//update - 기존 place에 수정
					place.setPlaceNo(courseNo); //코스번호 등록
					
					String escapePlace = StringEscapeUtils.escapeHtml(place.getPlaceContent());
					place.setPlaceContent(escapePlace);
					
					if(!place.getImageFile().isEmpty()) { //place에 대한 이미지 존재여부 확인
						MultipartFile imageFile = place.getImageFile();
						String uploadDirectory=context.getServletContext().getRealPath("/resources/images/upload/course");
						String uploadFilename=UUID.randomUUID().toString()+"_"+imageFile.getOriginalFilename(); 
						
						File file=new File(uploadDirectory, uploadFilename); //파일 객체 생성
						imageFile.transferTo(file); //이미지 파일 저장
						
						place.setPlaceImage(uploadFilename); //이미지 파일명 저장
					}
					courseService.modifyPlace(place);
					
				} else {
					//insert - 새로 추가한 place
					place.setPlaceNo(courseNo); //코스번호 등록
					
					String escapePlace = StringEscapeUtils.escapeHtml(place.getPlaceContent());
					place.setPlaceContent(escapePlace);
					
					if(!place.getImageFile().isEmpty()) { //place에 대한 이미지 존재여부 확인
						MultipartFile imageFile = place.getImageFile();
						String uploadDirectory=context.getServletContext().getRealPath("/resources/images/upload/course");
						String uploadFilename=UUID.randomUUID().toString()+"_"+imageFile.getOriginalFilename(); 
						
						File file=new File(uploadDirectory, uploadFilename); //파일 객체 생성
						imageFile.transferTo(file); //이미지 파일 저장
						
						place.setPlaceImage(uploadFilename); //이미지 파일명 저장			
					}
					courseService.addPlace(place);
				}
			
			} else if(i <= updateIndex) { //기존 코스의 place요소보다 줄어든 경우(기존 요소 삭제 필요)
				//courseService.removePlace(courseNo, i+1);
				
				map.put("placeNo", courseNo);
				map.put("placeOrder", i+1);
				courseService.removePlace(map);
				
			} else {
				return "redirect:/course/view/?num="+courseNo; //테스트용으로 해당글 수정페이지로이동 (이후 detail 페이지로 이동예정)
			}		
		}
		return "redirect:/course/view/?num="+courseNo;
	}
	
	//코스 삭제
	@RequestMapping("/remove")
	public String remove(@RequestParam int courseNo) {
		//삭제할 게시글 좋아요 삭제
		courseLikeService.deleteCourseLike(courseNo);
		
		//삭제할 게시글 댓글 삭제
		//courseReplyDAO.deleteCourseReplyByReplyNo(courseNo);
		
		//삭제할 게시글의 알람 삭제
		
		
		//게시글 삭제
		courseService.removeCourse(courseNo);
		return "redirect:/course/list";
	}
}