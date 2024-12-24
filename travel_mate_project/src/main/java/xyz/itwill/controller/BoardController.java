package xyz.itwill.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/board")
public class BoardController {
	//게시판 이동
	@RequestMapping("/notice")
	public String display(Model model) {
		//model.addAttribute("studentList", studentService.getStudentList());
		return "/board/notice";
	}
}
