package com.docmall.domain;

import java.util.Date;

import lombok.Data;

@Data
public class OrderVO {
	
	private Long ord_code; // db의 시퀀스 사용
	private String mbsp_id; // 인증세션에서 참조
	
	// 주문정보페이지에서 전송에서 받음
	private String ord_name;
	private String ord_zipcode;
	private String ord_addr_basic;
	private String ord_addr_detail;
	private String ord_tel;
	private int ord_price;
	
	private Date ord_regdate; // sysdate
	
	private String ord_status;
	private String payment_status;
	
}
