package com.docmall.service;

import com.docmall.domain.MemberVO;

public interface MemberService {

	String idCheck(String mbsp_id);
	
	void join(MemberVO vo);
	
	MemberVO login(String mbsp_id);
	
	void modify(MemberVO vo);
	
	void loginTimeUpdate(String mbsp_id);
	
	void delete(String mbsp_id);
	
	String find_id(String mbsp_name,String mbsp_email);
	
	MemberVO find_pw(String mbsp_id,String mbsp_email);
	
	void change_password(String mbsp_id,String mbsp_password);
}
