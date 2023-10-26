package com.docmall.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class LoginDTO {
	
	private String mbsp_id; // 아이디 프라임키
	private String mbsp_password; // 비밀번호 암호화
}
