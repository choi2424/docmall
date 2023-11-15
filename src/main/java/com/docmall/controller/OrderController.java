package com.docmall.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.docmall.domain.MemberVO;
import com.docmall.dto.CartDTOList;
import com.docmall.service.CartService;
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
}
