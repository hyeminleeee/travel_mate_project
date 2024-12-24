package xyz.itwill.controller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.BindException;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.QnaReply;
import xyz.itwill.service.QnaReplyService;

@RestController
@RequiredArgsConstructor
@RequestMapping("/qnareply")
public class QnaReplyController {
	private final QnaReplyService qnaReplyService;

	//BindingResult 객체 : @Valid 어노테이션을 사용해 객체 필드값에 대한 검증시 문제가 발생될
	//경우 관련 에러를 저장하기 위한 객체 - Errors 객체의 자식 객체
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/register")
	public String register(@RequestBody @Valid QnaReply reply, BindingResult bindingResult) 
			throws BindException {
		if(bindingResult.hasErrors()) {
			throw new BindException(bindingResult);
		}
		
		qnaReplyService.addQnaReply(reply);
		return "success";
	}
	
	@GetMapping("/list/{boardNum}")
	public List<QnaReply> list(@PathVariable int boardNum) {
		return qnaReplyService.getQnaReplyList(boardNum);
	}
}