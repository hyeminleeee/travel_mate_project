package xyz.itwill.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.HtmlUtils;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dao.MateReplyDAO;
import xyz.itwill.dto.Mate;
import xyz.itwill.dto.MateBoard;
import xyz.itwill.dto.MateBoardLike;
import xyz.itwill.service.CourseService;
import xyz.itwill.service.MateBoardLikeService;
import xyz.itwill.service.MateBoardService;
import xyz.itwill.service.MateService;
import xyz.itwill.service.TravelUserService;

@Controller
@RequestMapping("/mate")
@RequiredArgsConstructor
public class MateBoardController {
	private final MateBoardService mateBoardService;
	private final MateReplyDAO mateReplyDao;
	private final CourseService courseService;
	private final TravelUserService travelUserService;
	private final MateBoardLikeService mateboardService;
	private final MateService mateService;
	
	@RequestMapping("list")
	public String list(@RequestParam Map<String, Object> map, Model model) {
		
		model.addAttribute("resultMap", mateBoardService.getMateBoardList(map));
		model.addAttribute("searchMap", map);
		
		
		return "mate/mate_list";
	}
	
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value= "/register", method = RequestMethod.GET)
	public String register() {
		return "mate/mate_register";
	}
	
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value= "/register", method = RequestMethod.POST)
	public String register(@ModelAttribute MateBoard board) {
		board.setBoardTitle(HtmlUtils.htmlEscape(board.getBoardTitle()));
		board.setBoardContent(HtmlUtils.htmlEscape(board.getBoardContent()));
		board.setCourseNo(board.getCourseNo());
		board.setMateMaxCount(board.getMateMaxCount());
		
		mateBoardService.addMateBoard(board);
		return "redirect:/mate/list";
	}
	
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value= "/selectCourse", method = RequestMethod.GET)
	public String selectCourse(@RequestParam Map<String, Object> map, Model model) {
		model.addAttribute("resultMap", courseService.getmateCourseList(map));
		
		return "forward:/WEB-INF/views/mate/mate_course_select.jsp";
	}
	
	@RequestMapping("/detail")
	public String detail(@RequestParam Map<String, Object> map, Model model) {
		int boardNo=Integer.parseInt((String)map.get("boardNo"));
		
		mateBoardService.modifyMateBoardCount(boardNo);
		
		Authentication authentication=SecurityContextHolder.getContext().getAuthentication();
		String loginUserid=authentication.getName();
		MateBoard mateBoard = mateBoardService.getMateBoardByNo(boardNo);
		int totalReply=mateReplyDao.selectMateReplyList(boardNo).size();
		
		model.addAttribute("mateBoard", mateBoard);
		model.addAttribute("mateBoardUser",travelUserService.getTravelUserByUserid(mateBoardService.getMateBoardByNo(boardNo).getBoardWriter()));
		model.addAttribute("course", courseService.getCourseByCourseNo(mateBoard.getCourseNo()));
		model.addAttribute("searchMap", map);
		model.addAttribute("totalReply", totalReply);
		
		if(loginUserid == null || loginUserid.equals("")) {
			
		} else {
			model.addAttribute("loginUser", travelUserService.getTravelUserByUserid(loginUserid));
			MateBoardLike mateboardLike=mateboardService.getMateBoardLikeByMateBoardNoUserId(boardNo, loginUserid);
			model.addAttribute("mateboardLike", mateboardLike);
			model.addAttribute("mateboardLikeCount", mateboardService.getMateBoardLike(boardNo).size());
		}
		
		//채팅방 권한
		String state = "fail";
		
		List<Mate> mateList = mateService.getMateList(boardNo);
		for(Mate mateObj:mateList) {
			if(mateObj.getUserId().equals(loginUserid) && mateObj.getMateStatus() == 1) {
				state = "success";
			}
		}
		
		if(mateBoard.getBoardWriter().equals(loginUserid)) {
			state = "success";
		}
		
	    model.addAttribute("state", state); // state 값을 JSP로 전달
		
		return "mate/mate_detail";
	}
	
	// 코스 Detail 이동
	@RequestMapping("/view")
	public String view(@RequestParam Map<String, Object> map, Model model) {
		int courseNo=Integer.parseInt((String)map.get("num"));
		
		courseService.modifyCourseCount(courseNo);
		model.addAttribute("course", courseService.getCourseByCourseNo(courseNo));

		return "mate/mate_courseview";
	}
	// 글쓰기의 코스 선택
	@RequestMapping("/registerView")
	public String registerView(@RequestParam Map<String, Object> map, Model model) {
		int courseNo=Integer.parseInt((String)map.get("num"));
		
		courseService.modifyCourseCount(courseNo);
		model.addAttribute("course", courseService.getCourseByCourseNo(courseNo));
		
		return "forward:/WEB-INF/views/mate/mate_courseview_register.jsp";
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN') or principal.userId eq #map['boardWriter'] ")
	@RequestMapping(value= "/modify", method = RequestMethod.GET)
	public String modify(@RequestParam Map<String, Object> map, Model model) {
		int boardNo=Integer.parseInt((String)map.get("boardNo"));
		model.addAttribute("mateBoard", mateBoardService.getMateBoardByNo(boardNo));
		model.addAttribute("course", courseService.getCourseByCourseNo(mateBoardService.getMateBoardByNo(boardNo).getCourseNo()));
		model.addAttribute("searchMap", map);
		return "mate/mate_modify";
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN') or principal.userId eq #map['boardWriter']")
	@RequestMapping(value= "/modify", method = RequestMethod.POST)
	public String modify(@ModelAttribute MateBoard board, 
	        @RequestParam Map<String, Object> map, RedirectAttributes redirectAttributes) throws UnsupportedEncodingException {

	    List<Mate> mateList = mateService.getMateList(board.getBoardNo());
	    List<Mate> mList = new ArrayList<Mate>();

	    for(Mate mate:mateList){
	        if(mate.getMateStatus() == 1)
	            mList.add(mate);
	    }

	    // 조건이 맞지 않으면 기존 페이지로 리다이렉트
	    if(mList.size() >= board.getMateMaxCount()) {
	        redirectAttributes.addFlashAttribute("errorMessage", "최대 인원을 초과했습니다.");
	        
	        // 리다이렉트 경로에 필요한 모든 파라미터를 포함
	        return "redirect:/mate/modify?boardNo=" + board.getBoardNo()
	                + "&boardWriter=" + board.getBoardWriter()
	                + "&pageNum=" + map.get("pageNum")
	                + "&pageSize=" + map.get("pageSize")
	                + "&column=" + map.get("column")
	                + "&keyword=" + URLEncoder.encode((String)map.get("keyword"), "UTF-8");
	    }

	    board.setBoardTitle(HtmlUtils.htmlEscape(board.getBoardTitle()));
	    board.setBoardContent(HtmlUtils.htmlEscape(board.getBoardContent()));
	    mateBoardService.modifyMateBoard(board);

	    String pageNum = (String)map.get("pageNum");
	    String pageSize = (String)map.get("pageSize");
	    String column = (String)map.get("column");
	    String keyword = URLEncoder.encode((String)map.get("keyword"), "utf-8");

	    return "redirect:/mate/detail?boardNo=" + board.getBoardNo()
	            + "&pageNum=" + pageNum
	            + "&pageSize=" + pageSize
	            + "&column=" + column
	            + "&keyword=" + keyword;
	}

	
	@PreAuthorize("hasRole('ROLE_ADMIN') or principal.userId eq #boardWriter ")
	@RequestMapping("/remove")
	public String remove(@RequestParam int boardNo, @RequestParam String boardWriter) {
		mateBoardService.removeMateBoard(boardNo);
		return "redirect:/mate/list";
	}
}
