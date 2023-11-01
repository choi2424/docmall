package com.docmall.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ProductVO {
	
	private Integer pro_num; // 상품번호 , 시퀀스생성
	private Integer cg_code; // 2차 카테고리 코드
	private String pro_name; // 상품이름
	private int pro_price;  // 상품가격
	private int pro_discount; // 상품할인율
	private String pro_publisher; // 상품제조사
	private String pro_content; // 상품설명
	private String pro_up_folder; // 이미지폴더
	private String pro_img; // 이미파일
	private int pro_amount; // 상품수량
	private String pro_buy; // 판매가능여부
	private Date pro_date; // 상품등록날짜
	private Date pro_updatedate; // 상품 수정날짜
}
