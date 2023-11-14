package com.docmall.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CartDTOList {
	
	private Long cart_code;
	private Integer pro_num; 
	private int cart_amount;
	
	private String pro_name;
	private int pro_price;
	private int pro_discount;
	private String pro_up_folder;
	private String pro_img;
	
	
	
}
