package com.docmall.service;

import com.docmall.domain.OrderVO;

public interface OrderService {
	
	int getOrderseq();
	
	// 주문하기
	void order_insert(OrderVO o_vo); 
}