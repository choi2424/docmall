package com.docmall.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.docmall.domain.CategoryVO;
import com.docmall.mapper.UserCategoryMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserCategoryServiceImpl implements UserCategoryService {
	
	private final UserCategoryMapper userCategoryMapper;

	@Override
	public List<CategoryVO> secondCategoryList(Integer cg_parent_code) {
		// TODO Auto-generated method stub
		return userCategoryMapper.secondCategoryList(cg_parent_code);
	}
}
