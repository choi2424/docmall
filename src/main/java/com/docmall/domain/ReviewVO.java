package com.docmall.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReviewVO {

	   
	   private Long rew_num;
	   private String mbsp_id;
	   private Integer pro_num;
	   private String rew_content;
	   private Integer rew_score;
	   private Date rew_regdate;
	   
}
