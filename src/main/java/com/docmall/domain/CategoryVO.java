package com.docmall.domain;

import lombok.Data;

@Data
public class CategoryVO {
	
	private Integer cg_code; // 1차,2차 카테고리코드
	private Integer cg_parent_code; // 1차 카테고리 코드
	private String cg_name; // 카테고리 이름
			
}
