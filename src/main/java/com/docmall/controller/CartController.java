package com.docmall.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.docmall.domain.CartVO;
import com.docmall.domain.MemberVO;
import com.docmall.dto.CartDTOList;
import com.docmall.service.CartService;
import com.docmall.util.FileUtils;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RequiredArgsConstructor
@RequestMapping("/user/cart/*")
@Controller
public class CartController {

	private final CartService cartService;
	
	// 메인및 썸네일 이미지 업로드 폴더경로 주입작업
	@Resource(name = "uploadPath") // servlet-context.xml 에서 bean이름 참조
	private String uploadPath;
	
	@ResponseBody
	@PostMapping("/cart_add")
	public ResponseEntity<String> cart_add(CartVO vo, HttpSession session) throws Exception {
		
		ResponseEntity<String> entity = null;
		
		// ajax방식에서 상품코드,수량 2개의 정보만 전송되어옴 .(로그인한 사용자의 아이디정보 추가작업)
		String mbsp_id = ((MemberVO)session.getAttribute("loginStatus")).getMbsp_id();
		vo.setMbsp_id(mbsp_id);
		
		cartService.cart_add(vo);
		entity = new ResponseEntity<String>("success",HttpStatus.OK);
		
		return entity;
	}
	
	// 장바구니 목록
	@GetMapping("/cart_list")
	public void cart_list(HttpSession session,Model model) throws Exception {
		
		String mbsp_id = ((MemberVO)session.getAttribute("loginStatus")).getMbsp_id();
		
		List<CartDTOList> cart_list = cartService.cart_list(mbsp_id);
		
		// 장바구니 물품 총액
		double cart_total_price = 0;
		
		for (CartDTOList vo : cart_list) {
		    vo.setPro_up_folder(vo.getPro_up_folder().replace("\\", "/"));
		    cart_total_price += ((double)vo.getPro_price() - (vo.getPro_price() * vo.getPro_discount() / 100)) * (double)vo.getCart_amount();
		}
		
		model.addAttribute("cart_list", cart_list);
		model.addAttribute("cart_total_price", cart_total_price);
	}
	
	// 장바구니 이미지
	// 상품 리스트에서 보여줄 이미지 <img sec="매핑주소">
	@ResponseBody
	@GetMapping("/imageDisplay") // /user/cart/imageDisplay
	public ResponseEntity<byte[]> imgDisplay(String dateFolderName, String fileName) throws Exception {
				
			return FileUtils.getFile(uploadPath + dateFolderName, fileName);
	}
	
	// 수량변경코드
	@ResponseBody
	@PostMapping("/amount_change")
	public ResponseEntity<String> amount_change(Long cart_code,int cart_amount) throws Exception {
		
		ResponseEntity<String> entity = null;
		
		cartService.amount_change(cart_code, cart_amount);
		
		entity = new ResponseEntity<String>("success",HttpStatus.OK);
		
		return entity;
	}
	
	// 카트 리스트 개별삭제 ajax 사용
	@ResponseBody
	@PostMapping("/cart_list_del")
	public ResponseEntity<String> cart_list_del(Long cart_code) throws Exception {
		
		ResponseEntity<String> entity = null;
		
		cartService.cart_list_del(cart_code);
		
		entity = new ResponseEntity<String>("success",HttpStatus.OK);
		
		return entity;
	}
	
	// 카트 리스트 개별삭제 ajax 미사용
	@GetMapping("/cart_list_del")
	public String cart_list_del2(Long cart_code) throws Exception {
		
		cartService.cart_list_del(cart_code);
		
		return "redirect:/user/cart/cart_list";
	}
	
	// 카트 체크선택 삭제
	@ResponseBody
	@PostMapping("/cart_checked_del")
	public ResponseEntity<String> cart_checked_del(@RequestParam("cart_code_arr[]") List<Long> cart_code_arr) throws Exception {
		
//		log.info("카트코드 : " + cart_code_arr);
		
		ResponseEntity<String> entity = null;
		
		cartService.cart_checked_del(cart_code_arr);
		
		entity = new ResponseEntity<String>("success",HttpStatus.OK);
		
		return entity;
	}
}
