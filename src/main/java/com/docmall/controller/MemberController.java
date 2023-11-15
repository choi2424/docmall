package com.docmall.controller;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.docmall.domain.MemberVO;
import com.docmall.dto.LoginDTO;
import com.docmall.service.MemberService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/member/**")
@Controller
@RequiredArgsConstructor // final 필드만 매개변수가 있는 생성자를 만들어주고 스프링에 인하여 생성자 주입을 받게된다.
public class MemberController {
	
	// https://dev-coco.tistory.com/70
	
	// 생성자를 통하여 주입받는 필드에 인터페이스를 사용하는 이유? 유지보수때문에
	
	private final MemberService memberService;
	
	private final PasswordEncoder passwordEncoder;
	
	@GetMapping("/join")
	public void join() {
		
		log.info("called... join");
	}
	
	// 비동기방식. ajax문법으로 호출
	// 아이디 중복체크
	// ResponseEntity클래스 ? httpentity를 상속받는, 결과 데이터와 HTTP 상태 코드를 직접 제어할 수 있는 클래스이다.
	// 3가지 구성요소 HttpStatus , HttpHeaders , HttpBody
	// ajax기능과 함께 사용	
	@GetMapping("/idCheck")
	public ResponseEntity<String> idCheck(String mbsp_id){
		
		log.info("아이디 : " + mbsp_id);
		
		ResponseEntity<String>  entity = null;
		
		// 서비스 메서드 호출구문 작업.
		String idUse = "";
		if(memberService.idCheck(mbsp_id) != null) {
			idUse = "no"; // 아이디가 존재하여 , 사용 불가능
		}else {
			idUse = "yes"; // 아이디가 존재하지 않아 , 사용 가능
		}
		
		entity = new ResponseEntity<String>(idUse , HttpStatus.OK);
		
		return entity;
	}
	
	// 회원정보저장 -> 다른주소로 이동 (redirect)
	@PostMapping("/join")
	public String join(MemberVO vo , RedirectAttributes rttr) {
		
		log.info("회원정보 : " + vo);
		
		vo.setMbsp_password(passwordEncoder.encode(vo.getMbsp_password()));
		
		log.info("암호화된 비밀번호 : " + vo.getMbsp_password());
		
		// DB저장
		memberService.join(vo);
		
		return "redirect:/member/login";
	}
	
	// 로그인폼 페이지
	@GetMapping("/login")
	public void login() {
		
	}
	
	// 로그인 인증성공 -> 메인페이지(/) 주소이동. 2)로그인 인증실패 -> 로그인 폼주소로 이동
	// String mbsp_id , String mbsp_password
	@PostMapping("/login")
	public String login(LoginDTO dto,RedirectAttributes rttr,HttpSession session) {
		
		log.info("로그인 : " + dto);
		
		MemberVO db_vo = memberService.login(dto.getMbsp_id());
		
		String url = "";
		String msg = "";
		
		// 아이디가 존재하면 true 존재하지 않으면 false
		if(db_vo != null) {
			// 사용자가 입력한 비밀번호(평문 텍스트) 와 DB에서 가져온 암호화된 비밀번호 일치여부 검사.  
			if(passwordEncoder.matches(dto.getMbsp_password(), db_vo.getMbsp_password())) {
				// 로그인 성공결과로 서버측의 메모리를 사용하는 세션형태작업
				session.setAttribute("loginStatus", db_vo);
				url = "/"; // 메인페이지 주소
				
			}else {
				// 비밀번호가 일치하지 않음
				url = "/member/login"; // 로그인 폼주소
				msg = "비밀번호가 일치하지않습니다";
				rttr.addFlashAttribute("msg", msg); // 로그인 폼 jsp파일에서 사용목적
			}
		}else {
			// 아이디가 일치하지 않음
			url = "/member/login"; // 로그인 폼주소
			msg = "아이디가 일치하지않습니다";
			rttr.addFlashAttribute("msg", msg);
		}
		
		return "redirect:" + url;
	}
	
	// 로그아웃
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		
		session.invalidate();
		
		return "redirect:/";
	}
	
	// 회원수정페이지로 이동전 인증 확인 폼
	@GetMapping("/confirmPw")
	public void confirmPw(HttpSession session) {
		log.info("회원수정 전 confirm 확인");
	}
	
	// 회원수정페이지
	@PostMapping("/confirmPw")
	public String confirmPw(LoginDTO dto,RedirectAttributes rttr,HttpSession session) throws Exception {
		
		log.info("회원수정전 인증 재확인 : " + dto);
		
		MemberVO db_vo = memberService.login(dto.getMbsp_id());
		
		String url = "";
		String msg = "";
		
		// 아이디가 일치하면
		if(db_vo != null) {
			// 사용자가 입력한 비밀번호(평문 텍스트) 와 DB에서 가져온 암호화된 비밀번호 일치여부 검사.  
			if(passwordEncoder.matches(dto.getMbsp_password(), db_vo.getMbsp_password())) {
				url = "/member/modify"; // 회원수정폼 주소			
			}else {
				// 비밀번호가 일치하지 않음
				url = "/member/confirmPw"; //비밀번호확인 폼
				msg = "비밀번호가 일치하지않습니다";
				rttr.addFlashAttribute("msg", msg); // 로그인 폼 jsp파일에서 사용목적
			}
		}else {
			// 아이디가 일치하지 않음
			url = "/member/confirmPw"; // 로그인 폼주소
			msg = "아이디가 일치하지않습니다";
			rttr.addFlashAttribute("msg", msg); // 로그인 폼 jsp파일에서 사용목적
		}
		return "redirect:" + url;
		
	}
	
	//회원수정 폼 : 인증 사용자의 회원가입정보 뷰(View)에 출력
	@GetMapping("/modify")
	public void modify(HttpSession session, Model model) throws Exception {
		
		String mbsp_id = ((MemberVO)session.getAttribute("loginStatus")).getMbsp_id();
		
		
		MemberVO db_vo = memberService.login(mbsp_id);
		model.addAttribute("memberVO",db_vo);
	}
	
	@PostMapping("/modify")
	public String modify(MemberVO vo, HttpSession session, RedirectAttributes rttr) throws Exception {
		log.info("정보수정 : " + vo);
		
		// 로그인 시 인증목적으로 세션작업을 한 정보에서 아이디를 받아온다.
		MemberVO db_vo = (MemberVO) session.getAttribute("loginStatus");
		
		String mbsp_id = db_vo.getMbsp_id();
		
		vo.setMbsp_id(mbsp_id);
		
		memberService.modify(vo);
		
		// header.jsp 에서 전자우편이 수정된 내용으로 반영이 안되기 때문.
		db_vo.setMbsp_email(vo.getMbsp_email()); // 수정한 데이터를 바로 세션에 업로드.
		session.setAttribute("loginStatus", db_vo);
		
		rttr.addFlashAttribute("msg", "success");
		
		return "redirect:/";
	}
	
	// 회원수정페이지로 이동전 인증 확인 폼
	@GetMapping("/confirmPw2")
	public void confirmPw2(HttpSession session) {
		log.info("회원수정 전 confirmPw2 확인");
	}
	
	// 회원수정 인증
	@PostMapping("/confirmPw2")
	public String confirmPw2(LoginDTO dto,RedirectAttributes rttr,HttpSession session) throws Exception {
			
		log.info("회원수정전 인증 재확인 : " + dto);
		
		MemberVO db_vo = memberService.login(dto.getMbsp_id());
		
		String url = "";
		String msg = "";
		
		// 아이디가 일치하면
		if(db_vo != null) {
			// 사용자가 입력한 비밀번호(평문 텍스트) 와 DB에서 가져온 암호화된 비밀번호 일치여부 검사.  
			if(passwordEncoder.matches(dto.getMbsp_password(), db_vo.getMbsp_password())) {
				url = "/member/mypage"; // 회원수정폼 주소			
			}else {
				// 비밀번호가 일치하지 않음
				url = "/member/confirmPw2"; //비밀번호확인 폼
				msg = "비밀번호가 일치하지않습니다";
				rttr.addFlashAttribute("msg", msg); // 로그인 폼 jsp파일에서 사용목적
			}
		}else {
			// 아이디가 일치하지 않음
			url = "/member/confirmPw2"; // 로그인 폼주소
			msg = "아이디가 일치하지않습니다";
			rttr.addFlashAttribute("msg", msg); // 로그인 폼 jsp파일에서 사용목적
		}
		return "redirect:" + url;
	}
	
	// 마이페이지 폼
	@GetMapping("/mypage")
	public void mypage(HttpSession session, Model model) {
		String mbsp_id = ((MemberVO)session.getAttribute("loginStatus")).getMbsp_id();
		
		
		MemberVO db_vo = memberService.login(mbsp_id);
		model.addAttribute("memberVO",db_vo);
	}
	
	// 회원탈퇴 폼
	@GetMapping("/delConfirmPw")
	public void delConfirmPw() {
		
	}
	
	// 회원탈퇴
	@PostMapping("/delete")
	public String delete (LoginDTO dto, HttpSession session, RedirectAttributes rttr) throws Exception {
		
		log.info("로그인 : " + dto);
		
		MemberVO db_vo = memberService.login(dto.getMbsp_id());
		
		String url = "";
		String msg = "";
		
		// 아이디가 존재하면 true, 존재하지 않으면 false
		if(db_vo != null) {
			// 사용자가 입력한 비밀번호(평문 텍스트)와 DB테이블의 암호화된 비밀번호 일치여부 검사. 
			if(passwordEncoder.matches(dto.getMbsp_password(), db_vo.getMbsp_password())) {
				url = "/"; // 메인 페이지 주소
				session.invalidate(); // 세션 소멸
				
				// 회원탈퇴 작업.
				memberService.delete(dto.getMbsp_id());
				
			}else {
				url = "/member/delConfirmPw"; // 회원탈퇴 폼 주소
				msg = "비밀번호가 일치하지 않습니다.";
				rttr.addFlashAttribute("msg", msg); // 회원탈퇴 폼 jsp파일에서 사용할 목적
				
				log.info("a");
			}
		}else {
			// 아이디가 일치하지 않을 때.
			url = "/member/delConfirmPw"; // 회원탈퇴 폼 주소
			msg = "아이디가 일치하지 않습니다.";
			rttr.addFlashAttribute("msg", msg); // 회원탈퇴 폼 jsp파일에서 사용할 목적
			
			log.info("b");
		
		}
		
		return "redirect:" + url;
	}
	
	// 아이디 찾기 폼
	@GetMapping("/find_id")
	public void find_id() {
		
	}
	
	// 아이디 찾기
	@PostMapping("/find_id")
	public String find_id(String mbsp_name,String mbsp_email,RedirectAttributes rttr) {
		String msg = "";
		String url = "";
		String result = memberService.find_id(mbsp_name, mbsp_email);
		if(result == null) {
			msg = "이름이나 이메일이 정확하지 않습니다";
			url = "/member/find_id";
			rttr.addFlashAttribute("msg", msg);
		}else {
			msg = "아이디는" + result + "입니다";
			url = "/member/login";
			rttr.addFlashAttribute("msg", msg);
		}
		return "redirect:" + url;
	}
	
	// 비밀번호 찾기 폼
	@GetMapping("/find_pw")
	public void find_pw() {
		
	}
	
	// 비밀번호 찾기
	@PostMapping("/find_pw")
	public String find_pw(String mbsp_id,String mbsp_email,RedirectAttributes rttr,HttpSession session) {
		String msg = "";
		String url = "";
		MemberVO result = memberService.find_pw(mbsp_id, mbsp_email);
		if(result == null) {
			msg = "아이디나 이메일이 정확하지 않습니다";
			url = "/member/find_pw";
			rttr.addFlashAttribute("msg", msg);
		}else {
			msg = "비밀번호를 변경해주세요";
			url = "/member/change_password";
			rttr.addFlashAttribute("msg", msg);
			session.setAttribute("change_password", result);
		}
		
		
		return "redirect:" + url;
	}
	
	// 비밀번호 변경 폼
	@GetMapping("/change_password")
	public void change_password() {
		
	}
	
	// 비밀번호 변경
	@PostMapping("/change_password")
	public String change_password(HttpSession session,String mbsp_id,String mbsp_password,RedirectAttributes rttr) {
		
		MemberVO vo = (MemberVO)session.getAttribute("change_password");
		
		mbsp_id = vo.getMbsp_id();
		
		// db저장
		memberService.change_password(mbsp_id, passwordEncoder.encode(mbsp_password));
		
		session.removeAttribute("change_password");
		
		return "redirect:/member/login";
		
		
	}
}
