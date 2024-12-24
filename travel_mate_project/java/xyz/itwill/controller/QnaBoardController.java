package xyz.itwill.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.security.Principal;
import java.util.Map;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.HtmlUtils;

import lombok.RequiredArgsConstructor;
import xyz.itwill.auth.CustomUserDetails;
import xyz.itwill.dto.QnaBoard;
import xyz.itwill.dto.TravelUser;
import xyz.itwill.service.QnaBoardService;
import xyz.itwill.service.TravelUserService;

@Controller
@RequestMapping("/qnaboard")
@RequiredArgsConstructor
public class QnaBoardController {
    private final QnaBoardService qnaBoardService;
    private final TravelUserService travelUserService;
    
    @PreAuthorize("isAuthenticated()")
    @RequestMapping("/list")
    public String list(@RequestParam Map<String, Object> map, Model model) {
    	Map<String, Object> resultMap = qnaBoardService.getQnaBoardList(map);
    	model.addAttribute("resultMap", resultMap);
        model.addAttribute("searchMap", map);
              
        return "qnaboard/qnaboard_list";
    }
    
    
    @PreAuthorize("isAuthenticated()")
    @RequestMapping(value= "/register", method = RequestMethod.GET)
    public String register() {
        return "qnaboard/qnaboard_register";
    }
    
    @PreAuthorize("isAuthenticated()")
    @RequestMapping(value= "/register", method = RequestMethod.POST)
    public String register(@ModelAttribute QnaBoard board) {
        board.setSubject(HtmlUtils.htmlEscape(board.getSubject()));
        board.setContent(HtmlUtils.htmlEscape(board.getContent()));
        
        qnaBoardService.addQnaBoard(board);
        return "redirect:/qnaboard/list";
    }
    
    
    @PreAuthorize("isAuthenticated()")
    @RequestMapping("/detail")
    public String detail(@RequestParam Map<String, Object> map, Model model, Authentication authentication) {
        int num = Integer.parseInt((String) map.get("num"));
        model.addAttribute("qnaBoard", qnaBoardService.getQnaBoardByNum(num));
        model.addAttribute("searchMap", map);
        
        CustomUserDetails user=(CustomUserDetails)authentication.getPrincipal();
        TravelUser travelUser = travelUserService.getTravelUserByUserid(user.getUserId());
        model.addAttribute("loginUser", travelUser);
        
        
        return "qnaboard/qnaboard_detail";
    }
    
    @PreAuthorize("hasRole('ROLE_ADMIN') or principal.userId eq #map['writer'] ")
    @RequestMapping(value= "/modify", method = RequestMethod.GET)
    public String modify(@RequestParam Map<String, Object> map, Model model) {
        int num = Integer.parseInt((String) map.get("num"));
        model.addAttribute("qnaBoard", qnaBoardService.getQnaBoardByNum(num));
        model.addAttribute("searchMap", map);
        return "qnaboard/qnaboard_modify";
    }
    
    @PreAuthorize("hasRole('ROLE_ADMIN') or principal.userId eq #map['writer']")
    @RequestMapping(value= "/modify", method = RequestMethod.POST)
    public String modify(@ModelAttribute QnaBoard board, BindingResult result,
                         @RequestParam Map<String, Object> map, Model model) throws UnsupportedEncodingException {
        board.setSubject(HtmlUtils.htmlEscape(board.getSubject()));
        board.setContent(HtmlUtils.htmlEscape(board.getContent()));    
        
        qnaBoardService.modifyQnaBoard(board);
        
        String pageNum = (String) map.get("pageNum");
        String pageSize = (String) map.get("pageSize");
        String column = (String) map.get("column");
        String keyword = URLEncoder.encode((String) map.get("keyword"), "utf-8");
        
        return "redirect:/qnaboard/detail?num=" + board.getNum() + "&pageNum=" + pageNum
                + "&pageSize=" + pageSize + "&column=" + column + "&keyword=" + keyword;
    }
    
    @PreAuthorize("hasRole('ROLE_ADMIN') or principal.userId eq #writer ")
    @RequestMapping("/remove")
    public String remove(@RequestParam int num, @RequestParam String writer) {
        qnaBoardService.removeQnaBoard(num);
        return "redirect:/qnaboard/list";
    }
    
    @PreAuthorize("hasRole('ROLE_ADMIN') or principal.userId eq #originalWriter")
    @RequestMapping(value = "/reply", method = RequestMethod.GET)
    public String reply(@RequestParam Map<String, Object> map, Model model, Authentication authentication) {
        int num = Integer.parseInt((String) map.get("num"));
        model.addAttribute("qnaBoard", qnaBoardService.getQnaBoardByNum(num));
        model.addAttribute("searchMap", map);
        
        
        CustomUserDetails user=(CustomUserDetails)authentication.getPrincipal();
        
        TravelUser travelUser = travelUserService.getTravelUserByUserid(user.getUserId());
        model.addAttribute("loginUser", travelUser);
		
  
        return "qnaboard/qnaboard_reply"; // 답변하기 JSP로 이동
    }

    @PreAuthorize("hasRole('ROLE_ADMIN') or principal.userId eq #originalWriter")
    @RequestMapping(value = "/reply", method = RequestMethod.POST)
    public String reply(@ModelAttribute QnaBoard board, @RequestParam String originalWriter, Principal principal) {
        board.setSubject(HtmlUtils.htmlEscape(board.getSubject()));
        board.setContent(HtmlUtils.htmlEscape(board.getContent()));
        
        // originalWriter를 board에 설정
        board.setOriginalWriter(originalWriter);
        
        // 현재 사용자의 ID를 writer에 설정
        String userId = principal.getName();
        board.setWriter(userId);
        
        qnaBoardService.addQnaBoardReply(board);
        
        return "redirect:/qnaboard/list"; // 답글을 단 원 게시글로 리다이렉트
    }
}