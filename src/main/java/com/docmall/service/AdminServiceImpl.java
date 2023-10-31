package com.docmall.service;

import java.util.Date;

import org.springframework.stereotype.Service;

import com.docmall.domain.AdminVO;
import com.docmall.mapper.AdminMapper;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service // bean 생성및등록 : adminServiceImpl
public class AdminServiceImpl implements AdminService {
	
	private final AdminMapper adminMapper;

	@Override
	public AdminVO admin_ok(String admin_id) {
		// TODO Auto-generated method stub
		return adminMapper.admin_ok(admin_id);
	}

	@Override
	public void admin_visit_date(String admin_id) {
		// TODO Auto-generated method stub
		adminMapper.admin_visit_date(admin_id);
	}




}
