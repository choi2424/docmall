package com.docmall.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.docmall.domain.MemberVO;
import com.docmall.domain.OrderVO;
import com.docmall.dto.CartDTOList;
import com.docmall.kakaopay.ReadyResponse;
import com.docmall.service.CartService;
import com.docmall.service.KakaoPayServiceImpl;
import com.docmall.service.OrderService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/user/order/*")
@RequiredArgsConstructor
public class OrderController {
	
	private final OrderService orderService;
	private final CartService cartService;
	private final KakaoPayServiceImpl kakaoPayServiceImpl;
	
	// 주문정보 페이지
	@GetMapping("/order_info")
	public void order_info(HttpSession session,Model model) throws Exception{
		
		// 주문정보 목록
		String mbsp_id = ((MemberVO)session.getAttribute("loginStatus")).getMbsp_id();
		
		List<CartDTOList> order_info = cartService.cart_list(mbsp_id);
		
		// 장바구니 물품 총액
		double order_price = 0;
		
		for (CartDTOList vo : order_info) {
		    vo.setPro_up_folder(vo.getPro_up_folder().replace("\\", "/"));
		    order_price += ((double)vo.getPro_price() - (vo.getPro_price() * vo.getPro_discount() / 100)) * (double)vo.getCart_amount();
		}
		
		model.addAttribute("order_info", order_info);
		model.addAttribute("order_price", order_price);
	}
	
	// 카카오페이 결제선택을 진행했을 경우
	// 1)결제 준비 요청
	@GetMapping(value = "/orderPay" , produces = "application/json")
	public @ResponseBody ReadyResponse payReady(String paymethod, OrderVO o_vo,/* OrderDetailVO od_vo,PaymentVO p_vo,*/
			int totalprice, HttpSession session ) throws Exception {
		
		/*
		 	1)주문정보구성
		 	- 주문테이블 : (OrderVO) : ord_status , payment_status 정보가 존재 안함
		 	- 주문상세테이블 (OrderDetailVO) :
		 		- 장바구니에서 데이터를 참조
		 		- 결제테이블 : 보류
		 	주문상세테이블 , 결제테이블에 저장이 필요한 정보구성
		 	2)카카오페이 결제에 필요한 정보구성,
		 	스프링에서 처리할수 있는 부분
		 */
		
		
		String mbsp_id = ((MemberVO)session.getAttribute("loginStatus")).getMbsp_id();
		o_vo.setMbsp_id(mbsp_id); // 아이디값 할당
		
		// 시퀀스를 주문번호로 사용 : 동일한 주문번호값이 사용.
		// 주문테이블 저장 
		
		Long ord_code = (long)orderService.getOrderseq();
		o_vo.setOrd_code(ord_code); // 주문번호 저장
		
		log.info("결제방법 : " + paymethod);
		log.info("주문정보 : " + o_vo);
		
		o_vo.setOrd_status("주문완료");
		o_vo.setPayment_status("결제완료");
		
		List<CartDTOList> cart_list = cartService.cart_list(mbsp_id);
		
		String itemName = cart_list.get(0).getPro_name() + "외" + String.valueOf(cart_list.size()-1) + "건";
		
		//주문,주문상세 정보저장 , 장바구니 삭제
		orderService.order_insert(o_vo);
		
		
		// 1)kakao Pay 결제 준비 요청
		ReadyResponse readyResponse = kakaoPayServiceImpl.payReady(o_vo.getOrd_code(), itemName, cart_list.size(), mbsp_id, totalprice);
		
		log.info("결제고유번호 : " + readyResponse.getTid());
		log.info("결제요청URL : " + readyResponse.getNext_redirect_pc_url());
		
		// 카카오페이 결제승인 요청작업에 필요한 정보준비
		session.setAttribute("tid", readyResponse.getTid());
		session.setAttribute("oder_code", o_vo.getOrd_code());
		
		return readyResponse;
	}
	
	
	// 결제 승인 요청 작업 http://localhost:9090/user/order/orderApproval
	@GetMapping("/orderApproval")
	public String orderApproval(@RequestParam("pg_token") String pg_token, HttpSession session) {
		
		// 2)kakao Pay 결제승인요청 작업
		Long oder_code = (Long)session.getAttribute("oder_code");
		String tid = (String)session.getAttribute("tid");
		String mbsp_id = ((MemberVO)session.getAttribute("loginStatus")).getMbsp_id();
		
		kakaoPayServiceImpl.payApprove(oder_code, tid, pg_token, mbsp_id);
		
		session.removeAttribute("oder_code");
		session.removeAttribute("tid");
		
		return "redirect:/user/order/orderComplete";
		
	}
	
	// 결제 완료페이지
	@GetMapping("/orderComplete")
	public void orderComplete() {
		
	}
	
	// 결제 취소시	http://localhost:9090/user/order/orderCancel
	@GetMapping("/orderCancel")
	public void orderCancel() {
		
	}
	
	
	// 결제 실패시	http://localhost:9090/user/order/orderFail
	@GetMapping("/orderFail")
	public void orderFail() {
		
	}
}