package com.docmall.service;

import java.util.List;

import com.docmall.domain.CategoryVO;

public interface AdCategoryService {
	
	List<CategoryVO> firstCategoryList();
	
	List<CategoryVO> secondCategoryList(Integer cg_parent_code);
	
	CategoryVO get(Integer cg_code);
}
