package com.docmall.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.docmall.domain.OrderVO;
import com.docmall.domain.PaymentVO;
import com.docmall.mapper.OrderMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class OrderServiceImpl implements OrderService {
	
	private final OrderMapper orderMapper;

	@Override
	public int getOrderseq() {
		// TODO Auto-generated method stub
		return orderMapper.getOrderseq();
	}
	
	@Transactional // 메서드 기능중 하나라도 실패하면 성공한 나머지 작업도 롤백처리
	@Override
	public void order_insert(OrderVO o_vo,PaymentVO p_vo) {

		// 주문테이블 저장
		orderMapper.order_insert(o_vo);
		
		// 주문상세테이블 저장. 장바구니테이블 참조.
		orderMapper.order_detail_insert(o_vo.getOrd_code(), o_vo.getMbsp_id());
		
		// 장바구니 테이블 데이터 삭제
		orderMapper.cart_del(o_vo.getMbsp_id());
		
		// 결제테이블 저장
		orderMapper.payment_insert(p_vo);
	}
}
