package xyz.itwill.controller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.Mate;
import xyz.itwill.service.MateBoardService;
import xyz.itwill.service.MateService;

@RestController
@RequiredArgsConstructor
@RequestMapping("/mateList")
public class MateController {
	private final MateService mateService;
	private final MateBoardService mateBoardService;
	
	@PostMapping("/register")
	public String register(@RequestBody @Valid Mate mate) {
		List<Mate> mList = mateService.getMateList(mate.getBoardNo());
		
		if(checkMateMaxCount(mList, mate.getBoardNo()))
			return "full";	// 인원 풀
		
		for(Mate mateObj:mList) {
			if(mateObj.getUserId().equals(mate.getUserId()) ) {
				if(mateObj.getMateStatus() == 1)
					return "already"; // 이미 참가되었음
				else 
					return "fail"; // 신청한 적이 있음
			}
		}
				
		mateService.addMate(mate);
		return "success";
	}
	
	@GetMapping("list")
	public List<Mate> list(@RequestParam int boardNo) {
		List<Mate> mList = mateService.getMateList(boardNo);
		return mList;
	}
	
	@GetMapping("listWait")
	public List<Mate> listWait(@RequestParam int boardNo) {
		List<Mate> mList = mateService.getMateWaiList(boardNo);
		return mList;
	}
	
	@GetMapping("listAccept")
	public List<Mate> listAccept(@RequestParam int boardNo) {
		List<Mate> mList = mateService.getMateAcceptList(boardNo);
		return mList;
	}
	
	@PostMapping("/remove")
	public String remove(@RequestBody @Valid Mate mate) {
		mateService.removeMate(mate.getMateNo());
		return "success";
	}
	
	@GetMapping("/accept")
	public String accecpt(@RequestParam int mateNo, int boardNo) {
		
		List<Mate> mList = mateService.getMateList(boardNo);
		
		if(checkMateMaxCount(mList, boardNo))
			return "full";
		
		mateService.acceptMateByNo(mateNo);
		return "success";
	}
	
	@GetMapping("/refusal")
	public String refusal(@RequestParam int mateNo) {
		mateService.removeMate(mateNo);
		return "success";
	}
	
	// true: 인원 초과, false: 여유 있음
	private boolean checkMateMaxCount(List<Mate> mList, int boardNo) {
		int mateCount=0;
		for(Mate mateObj:mList) {
			if(mateObj.getMateStatus() == 1) {
				mateCount++;
			}
		}
		int mateMaxCount = mateBoardService.getMateBoardByNo(boardNo).getMateMaxCount();
		if(mateCount >=mateMaxCount) {
			return true;
		}
		
		return false;
	}
}
