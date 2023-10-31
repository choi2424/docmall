package com.docmall.domain;

import java.util.Date;

import lombok.Data;

@Data
public class AdminVO {
	
	// 멤버 필드 작업
	private String admin_id;
	private String admin_pw;
	private Date admin_visit_date;  //관리자 방문시간
}
