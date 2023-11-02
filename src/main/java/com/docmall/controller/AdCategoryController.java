package com.docmall.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.docmall.domain.CategoryVO;
import com.docmall.service.AdCategoryService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/category")
// @RestController (@ResponseBody + @Controller): 모든 매핑주소가 ajax호출로 사용하는 경우
public class AdCategoryController {
	
	private final AdCategoryService adCategoryService;
	
	// 1차 카테고리 선택에 따른 2차카테고리 정보를 클라이언트에게 제공.
	// 일반주소 /admin/category/secondCategoty/cg_parent_code=1
	// RestFull 개별론 주소 /admin/category/secondCategoty/1.json
	// 주소의 일부분을 값으로 사용하고자 할 경우 {} 중괄호 사용
	@ResponseBody //@Controller 어노테이션 안에서 ajax 호출을 사용하려면 @ResponseBody를 붙여줘야한다
	@GetMapping("/secondCategory/{cg_parent_code}")
	public ResponseEntity<List<CategoryVO>> secondCategory(@PathVariable("cg_parent_code")Integer cg_parent_code) throws Exception{
		
//		log.info("1차카테고리 코드 : " + cg_parent_code);
		
		ResponseEntity<List<CategoryVO>> entity = null;
		
		entity = new ResponseEntity<List<CategoryVO>>(adCategoryService.secondCategoryList(cg_parent_code), HttpStatus.OK);
		
		// List<CategoryVO> list = adCategoryService.secondCategoryList(cg_parent_code)
		// list객체 -> JSON 로 변환하는 라이브러리.(jackson-databind 라이브러리:pom.xml참고)
		
		return entity;
		
	}
	
	
}
