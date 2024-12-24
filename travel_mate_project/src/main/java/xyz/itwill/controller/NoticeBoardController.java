package xyz.itwill.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.security.Principal;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.HtmlUtils;

import lombok.RequiredArgsConstructor;
import lombok.extern.java.Log;
import lombok.extern.log4j.Log4j2;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import xyz.itwill.auth.CustomUserDetails;
import xyz.itwill.dto.NoticeBoard;

import xyz.itwill.dto.TravelUser;
import xyz.itwill.service.NoticeBoardService;

import xyz.itwill.service.TravelUserService;

@Controller
@RequestMapping("/noticeboard")
@RequiredArgsConstructor
@Slf4j
public class NoticeBoardController {
    private final NoticeBoardService noticeBoardService;   
    private final TravelUserService travelUserService;
    
    private static final Logger logger = LoggerFactory.getLogger(NoticeBoardController.class);
    
    @PreAuthorize("isAuthenticated()")
    @RequestMapping("/list")
    public String list(@RequestParam Map<String, Object> map, Model model) {
    	Map<String, Object> resultMap = noticeBoardService.getNoticeBoardList(map);
        model.addAttribute("resultMap",resultMap );
        model.addAttribute("searchMap", map);
                   
        return "noticeboard/noticeboard_list";
                     
    }
 
    
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @RequestMapping(value= "/register", method = RequestMethod.GET)
    public String register() {
        return "noticeboard/noticeboard_register";
    }
    
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @RequestMapping(value= "/register", method = RequestMethod.POST)
    public String register(@ModelAttribute NoticeBoard board) {
        board.setNoticeSubject(HtmlUtils.htmlEscape(board.getNoticeSubject()));
        board.setNoticeContent(HtmlUtils.htmlEscape(board.getNoticeContent()));
        
        noticeBoardService.addNoticeBoard(board);
        
        return "redirect:/noticeboard/list";
    }
    
    @PreAuthorize("isAuthenticated()")
    @RequestMapping("/detail")
    public String detail(@RequestParam Map<String, Object> map, Model model, Authentication authentication) {
        int noticeNum = Integer.parseInt((String) map.get("noticeNum"));
        // 조회수 증가
        noticeBoardService.plusNoticeCount(noticeNum);
        
        model.addAttribute("noticeBoard", noticeBoardService.getNoticeBoardByNum(noticeNum));
        model.addAttribute("searchMap", map);
        
        CustomUserDetails user=(CustomUserDetails)authentication.getPrincipal();
        
        TravelUser travelUser = travelUserService.getTravelUserByUserid(user.getUserId());
        model.addAttribute("loginUser", travelUser);
        
        
        return "noticeboard/noticeboard_detail";
    }
   
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @RequestMapping(value= "/modify", method = RequestMethod.GET)
    public String modify(@RequestParam Map<String, Object> map, Model model) {
        int noticeNum = Integer.parseInt((String) map.get("noticeNum"));
        model.addAttribute("noticeBoard", noticeBoardService.getNoticeBoardByNum(noticeNum));
        model.addAttribute("searchMap", map);
        return "noticeboard/noticeboard_modify";
    }
    
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @RequestMapping(value= "/modify", method = RequestMethod.POST)
    public String modify(@ModelAttribute NoticeBoard board, BindingResult result,
                         @RequestParam Map<String, Object> map, Model model) throws UnsupportedEncodingException {
        board.setNoticeSubject(HtmlUtils.htmlEscape(board.getNoticeSubject()));
        board.setNoticeContent(HtmlUtils.htmlEscape(board.getNoticeContent()));    
        
        noticeBoardService.modifyNoticeBoard(board);
        
        String pageNum = (String) map.get("pageNum");
        String pageSize = (String) map.get("pageSize");
        String column = (String) map.get("column");
        String keyword = URLEncoder.encode((String) map.get("keyword"), "utf-8");
        
        return "redirect:/noticeboard/detail?noticeNum=" + board.getNoticeNum() + "&pageNum=" + pageNum
                + "&pageSize=" + pageSize + "&column=" + column + "&keyword=" + keyword;
    }
    
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @RequestMapping("/remove")
    public String remove(@RequestParam int noticeNum, @RequestParam String noticeId) {
        noticeBoardService.removeNoticeBoard(noticeNum);
        return "redirect:/noticeboard/list";
    }
    
    @RequestMapping(value = "/updateStatus", method = RequestMethod.POST)
    @ResponseBody 
    public ResponseEntity<String> updateNoticeStatus(@RequestBody NoticeBoard board) {
        int noticeNum = board.getNoticeNum();
        int noticeStatus = board.getNoticeStatus();
        
        logger.info("Request Body: {}", board);
        
        try {
            // 상태 업데이트
            noticeBoardService.updateStatusNoticeBoard(noticeNum, noticeStatus);
            logger.info("Updated Notice Status for Notice Number {}: {}", noticeNum, noticeStatus);
            return ResponseEntity.ok("success");
        } catch (Exception e) {
            logger.error("Failed to update notice status for Notice Number {}: {}", noticeNum, e.getMessage());
            return ResponseEntity.status(500).body("error");
        }
    }
   
}