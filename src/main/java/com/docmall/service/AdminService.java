package com.docmall.service;

import java.util.Date;

import com.docmall.domain.AdminVO;

public interface AdminService {
	
	AdminVO admin_ok(String admin_id);
	
	void admin_visit_date(String admin_id);
}
