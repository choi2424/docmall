package com.docmall.mapper;

import org.apache.ibatis.annotations.Param;

import com.docmall.domain.OrderVO;

public interface OrderMapper {
	
	int getOrderseq(); // 주문번호에 사용할 시퀀스
	
	// 주문하기
	//1) 주문테이블 저장
	void order_insert(OrderVO o_vo); 
	
	// void order_detail_insert(OrderDetailVO od_vo); 사용안함
	
	//2) 주문상세테이블 저장. 장바구니테이블 참조.
	void order_detail_insert( 
			@Param("ord_code") Long ord_code,
			@Param("mbsp_id") String mbsp_id
	); 
	
	// 결제테이블
	
	//3) 장바구니 테이블의 데이터 삭제
	void cart_del(String mbsp_id);
}
