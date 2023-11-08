package com.docmall.service;

import org.springframework.stereotype.Service;

import com.docmall.domain.MemberVO;
import com.docmall.mapper.MemberMapper;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor // 파이널 필드의 매개변수가 있는 생성자를 만들어줌
@Service
public class MemberServiceImpl implements MemberService{
	//자동주입
	private final MemberMapper memberMapper;
	
	/* @RequiredArgsConstructor // 파이널 필드의 매개변수가 있는 생성자를 만들어줌
	private MemberServiceImpl(MemberMapper memberMapper) {
		this.memberMapper = memberMapper;
	}
	*/

	@Override
	public String idCheck(String mbsp_id) {
		// TODO Auto-generated method stub
		return memberMapper.idCheck(mbsp_id);
	}

	@Override
	public void join(MemberVO vo) {
		// TODO Auto-generated method stub
		memberMapper.join(vo);
	}

	@Override
	public MemberVO login(String mbsp_id) {
		// TODO Auto-generated method stub
		return memberMapper.login(mbsp_id);
	}
	
	@Override
	public void modify(MemberVO vo) {
		
		memberMapper.modify(vo);
	}

	@Override
	public void loginTimeUpdate(String mbsp_id) {
		
		memberMapper.loginTimeUpdate(mbsp_id);
	}

	@Override
	public void delete(String mbsp_id) {

		memberMapper.delete(mbsp_id);
	}

	@Override
	public String find_id(String mbsp_name,String mbsp_email) {
		// TODO Auto-generated method stub
		return memberMapper.find_id(mbsp_name, mbsp_email);
	}
}
