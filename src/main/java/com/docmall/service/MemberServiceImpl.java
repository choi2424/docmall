package com.docmall.service;

import org.springframework.stereotype.Service;

import com.docmall.mapper.MemberMapper;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor // 파이널 필드의 매개변수가 있는 생성자를 만들어줌
@Service
public class MemberServiceImpl implements MemberService{
	//자동주입
	private final MemberMapper memberMapper;

	@Override
	public String idCheck(String mbsp_id) {
		// TODO Auto-generated method stub
		return memberMapper.idCheck(mbsp_id);
	}
	
	/* @RequiredArgsConstructor // 파이널 필드의 매개변수가 있는 생성자를 만들어줌
	private MemberServiceImpl(MemberMapper memberMapper) {
		this.memberMapper = memberMapper;
	}
	*/
}
