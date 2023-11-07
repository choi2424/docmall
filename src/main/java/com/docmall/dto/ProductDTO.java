package com.docmall.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@AllArgsConstructor // 모든 필드를 대상으로 매개변수가 있는 생성자메서드 생성
@Data
public class ProductDTO {
	private Integer pro_num; // 상품번호 , 시퀀스생성
	
	private int pro_price;  // 상품가격
	private String pro_buy; // 판매가능여부
}
