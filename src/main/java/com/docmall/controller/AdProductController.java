package com.docmall.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.docmall.domain.ProductVO;
import com.docmall.dto.Criteria;
import com.docmall.dto.PageDTO;
import com.docmall.service.AdProductService;
import com.docmall.util.FileUtils;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/admin/product/*")
@Controller
@RequiredArgsConstructor
public class AdProductController {
	
	private final AdProductService adProductService;
	
	// 메인및 썸네일 이미지 업로드 폴더경로 주입작업
	@Resource(name = "uploadPath") // servlet-context.xml 에서 bean이름 참조
	private String uploadPath;
	
	// CKEditor에서 사용되는 업로드 폴더경로
	@Resource(name = "uploadCKPath") // servlet-context.xml 에서 bean이름 참조
	private String uploadCKPath;
	
	//상품등록 폼
	@GetMapping("/pro_insert")
	public void pro_insert() {
		
		log.info("상품등록 폼");
	}
	
	
	// 상품정보 저장
	// 파일업로드 기능 :	1)스프링에서 내장된 기본라이브러리 
	// 				2)외부라이브러리를 이용. (commons-fileupload)를 이용(pom.xml). servlet-context.xml 에서 
	// MultipartFile uploadFile : <input type="file" class="form-control" name="iploadFile" id="uploadFile">
	@PostMapping("/pro_insert")
	public String pro_insert(ProductVO vo,MultipartFile uploadFile ,RedirectAttributes rttr) {
		
		log.info("상품정보 :" + vo);
		
		// 1)파일업로드 작업 . 선수작업 필요 : FileUtils 클래스 작업
		String dateFolder = FileUtils.getDateFolder();
		String savedFileName = FileUtils.uploadFile(uploadPath, dateFolder, uploadFile);
		
		vo.setPro_img(savedFileName);
		vo.setPro_up_folder(dateFolder);
		
		// 2)상품정보 저장
		adProductService.pro_insert(vo);
		
		return "redirect:/admin/product/pro_list";
	}
	
	// CKEDITOR 업로드 탭에서 파일 업로드시 동작하는 매핑주소
	// MultipartFile upload : 업로드된 파일을 참조하는 객체
	// MultipartFile upload 변수와 CKEDITOR의 <input type="file" name="upload" size="38">일치
	// HttpServletRequest 클래스 : jsp의 Request객체 클래스 , 클라이언트의 요청을 담고있는 객체
	// HttpServletResponse 클래스 : jsp의 Response객체 클래스 . 클라이언트로 보낼 서버측의 응답정보를 가지고 있는 객체.
	@PostMapping("/imageUpload")
	public void imageUpload(HttpServletRequest req, HttpServletResponse res, MultipartFile upload) {
		
		// try 코드 사용전에 선언한 목적 try 밖에서도 사용할려고
		OutputStream out = null;
		PrintWriter printWriter = null; // 클라이언트에게 서버의  응답정보를 보낼때 사용.
		
		/* 	jsp 파일은
		 	<%@ page language="java" contentType="text/html; charset=UTF-8"
    		pageEncoding="UTF-8"%>
    		이게 있어서 아래작업을 안해도된다
		*/
		
		// 클라이언트에게 보내는 응답설정
		res.setCharacterEncoding("utf-8");
		res.setContentType("text/html; charset=utf-8");
		
		try {
			
			// 1) 파일 업로드 작업
			String fileName = upload.getOriginalFilename(); // 클라이언트에서 전송한 파일이름
			byte[] bytes = upload.getBytes(); // 업로드 한 파일을 byte배열로 읽어들임.
			
			String ckUploadPath = uploadCKPath + fileName;
			
			log.info("CKEditor파일경로 : " + ckUploadPath);
			
			out = new FileOutputStream(new File(ckUploadPath)); // 0kb 파일생성
			
			out.write(bytes); // 출력스트림 작업
			out.flush();
			
			// 2) 파일 업로드 작업후 파일정보를 CKEditor로 보내는 작업
			printWriter = res.getWriter();
			
			// 브라우저의 CKEditor에서 사용한 파일정보를 참조하는 경로설정
			// 1)톰캣 Context Path에서 Add External Web Module 작업을 해야 함.
	        // Path : /upload, Document Base : C:\\dev\\upload\\ckeditor 설정
	        // 2)Tomcat server.xml에서 <Context docBase="업로드경로" path="/매핑주소" reloadable="true"/>
			// <Context docBase="C:\\dev\\upload\ckeditor" path="/ckupload" reloadable="true"/>
	        
			// ckupload에서 업로드된 파일경로를 보내준다. (매핑주소의 파일명이 포함)
	        String fileUrl = "/ckupload/" + fileName;
	        // {"filename":"abc.gif", "uploaded":1, "url":"/upload/abc.gif"}
	        printWriter.println("{\"filename\":\"" +  fileName + "\", \"uploaded\":1,\"url\":\"" + fileUrl + "\"}");
//	        printWriter.printf("{\"filename\":\"%s\",\"uploaded\":1\"url\":\"%s\"}",fileName,fileUrl );
	        printWriter.flush();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(out != null) {
				try {
					out.close();
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}
			if(printWriter != null) printWriter.close();
		}
	}
	
	//상품리스트
	@GetMapping("/pro_list")
	public void pro_list(Criteria cri,Model model) throws Exception {
		cri.setAmount(5);
		
		List<ProductVO> pro_list = adProductService.pro_list(cri);
		
		// 날짜폴더의 역슬래시를 슬래시로 바꾸는 작업 . 이유 : 역슬래시로 되어있는 정보가 스프링으로 보내는 요청데이터에 사용되면 에러발생.
		pro_list.forEach(vo ->{
			vo.setPro_up_folder(vo.getPro_up_folder().replace("\\", "/"));
		});
		
		model.addAttribute("pro_list",pro_list);
		
		int totelCount = adProductService.getTotelCount(cri);
		model.addAttribute("pageMaker",new PageDTO(cri, totelCount));
		
	}
	
	// 상품 리스트에서 보여줄 이미지 <img sec="매핑주소">
	@ResponseBody
	@GetMapping("/imageDisplay") // /admin/product/imageDisplay
	public ResponseEntity<byte[]> imgDisplay(String dateFolderName, String fileName) throws Exception {
			
		return FileUtils.getFile(uploadPath + dateFolderName, fileName);
	}
		
			
	
}
