package com.docmall.domain;

import lombok.Data;

// 관리자 기능
// 관리자 주문상세 정보 저장목적 VO클래스.(주문 상세 테이블과 상품 테이블 조인 결과)

@Data
public class OrderDetailInfoVO {

   /*
   -- 주문 상세 정보를 가져올 쿼리문. (주문상세테이블, 상품테이블 조인)
   -- JOIN : 1. 오라클 조인 2. ANSI-SQL 표준조인

   -- 오라클
   SELECT
       ot.ORD_CODE, ot.PRO_NUM, ot.DT_AMOUNT,
       pt.CG_CODE, pt.PRO_NAME, pt.PRO_PRICE, pt.PRO_UP_FOLDER, pt.PRO_IMG, pt.PRO_AMOUNT, pt.PRO_BUY
   FROM
       ORDETAIL_TBL ot, PRODUCT_TBL pt
   WHERE
       ot.PRO_NUM = pt.PRO_NUM
   AND
       ot.ORD_CODE = #{}
    */
   
   // OrderdetailVO
   private Long    ord_code;
   private Integer   pro_num;
   private int      dt_amount;
   
   // ProductVO
   // private Integer pro_num; // 시퀀스 생성. 상품코드
   
   private Integer cg_code; // 2차카테고리코드
   private   String   pro_name;
   private   int      pro_price; // dt_price와 중복된다.
   private   int      pro_discount;
   private   String   pro_publisher;
   
   private   String   pro_up_folder;  // 스프링에서 별도로 처리
   private   String   pro_img;   // // 스프링에서 별도로 처리
   
   private   int      pro_amount;
   
   // 추가
   private   int      ord_price;
   
}