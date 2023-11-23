package com.docmall.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.docmall.domain.ReviewVO;
import com.docmall.dto.Criteria;

public interface ReviewMapper {
	
	// 리뷰 추가
	void review_insert(ReviewVO vo);
	
	// 리뷰 상품후기 목록 데이터
	List<ReviewVO> list(@Param("pro_num") Integer pro_num,@Param("cri") Criteria cri);
	
	// 페이징 데이터
	int listCount(Integer pro_num);
}
