CREATE TABLE MBSP_TBL(
        MBSP_ID             VARCHAR2(15),
        MBSP_NAME           VARCHAR2(30)            NOT NULL,
        MBSP_EMAIL          VARCHAR2(50)            NOT NULL,
        MBSP_PASSWORD       CHAR(60)               NOT NULL,        -- 비밀번호 암호화 처리.
        MBSP_ZIPCODE        CHAR(5)                 NOT NULL, -- 우편번호
        MBSP_ADDR           VARCHAR2(100)            NOT NULL,
        MBSP_DEADDR         VARCHAR2(100)            NOT NULL,
        MBSP_PHONE          VARCHAR2(15)            NOT NULL,
        MBSP_POINT          NUMBER DEFAULT 0        NOT NULL,
        MBSP_LASTLOGIN      DATE DEFAULT SYSDATE    NOT NULL,
        MBSP_DATESUB        DATE DEFAULT SYSDATE    NOT NULL,
        MBSP_UPDATEDATE     DATE DEFAULT SYSDATE    NOT NULL
);

--실행 프라임키 설정
ALTER TABLE MBSP_TBL
ADD CONSTRAINT PK_MBSP_ID PRIMARY KEY (MBSP_ID);


-- 아이디 체크
SELECT MBSP_ID FROM MBSP_TBL  WHERE MBSP_ID = 'USER01';

-- 회원가입
INSERT INTO mbsp_tbl (MBSP_ID, MBSP_NAME, MBSP_EMAIL, MBSP_PASSWORD, MBSP_ZIPCODE, MBSP_ADDR, MBSP_DEADDR, MBSP_PHONE) 
VALUES (#{mbsp_id}, #{mbsp_name}, #{mbsp_email}, 
#{mbsp_password}, #{mbsp_zipcode}, #{mbsp_addr}, #{mbsp_deaddr}, #{mbsp_phone});


-- 회원수정폼
UPDATE MBSP_TBL
SET 
    MBSP_EMAIL = #{mbsp_email},MBSP_ZIPCODE = #{mbsp_zipcode},MBSP_ADDR = #{mbsp_addr},MBSP_DEADDR = #{mbsp_deaddr},
    MBSP_PHONE = #{mbsp_phone},MBSP_UPDATEDATE = sysdate
WHERE MBSP_ID = #{mbsp_id};

-- 로그인 유지 시간
UPDATE MBSP_TBL
SET	MBSP_LASTLOGIN = sysdate
WHERE MBSP_ID = #{mbsp_id};
-- 회원탈퇴
DELETE MBSP_TBL
WHERE MBSP_ID = #{mbsp_id};


--아이디및비밀번호찾기
--1)아이디 찾기
SELECT MBSP_ID FROM MBSP_TBL WHERE MBSP_NAME = #{mbsp_name} AND MBSP_EMAIL = #{mbsp_email}
--2)비밀번호 찾기(메일 전송)
SELECT MBSP_EMAIL FROM MBSP_TBL WHERE MBSP_ID = #{mbsp_id} AND MBSP_EMAIL = #{mbsp_email}

-- 관리자 테이블
CREATE TABLE ADMIN_TBL (
    ADMIN_ID    VARCHAR2(15)    PRIMARY KEY,
    ADMIN_PW    CHAR(60)    NOT NULL,
    ADMIN_VISIT_DATE    DATE   -- 관리자 방문시간
);

-- 관리자 비밀번호 1234
INSERT INTO ADMIN_TBL VALUES('admin', '$2a$10$dQFCMr0udCI865eG6SoIcOaNr3Y/dgBX.R4qf6rX5KA3jciSnnNjG',sysdate);
-- 관리자 로그인
SELECT ADMIN_ID,ADMIN_PW, ADMIN_VISIT_DATE FROM ADMIN_TBL WHERE ADMIN_ID = #{admin_id};]
-- 마지막 로그인
UPDATE
			ADMIN_TBL
		SET
			ADMIN_VISIT_DATE = sysdate
		WHERE
			ADMIN_ID = 'admin';]
-- 카테고리 테이블
CREATE TABLE CATEGORY_TBL(
        CG_CODE            NUMBER    PRIMARY KEY,    -- 카테고리 코드
        CG_PARENT_CODE     NUMBER    NULL,           -- 상위카테고리 코드
        CG_NAME            VARCHAR2(50)    NOT NULL,
        FOREIGN KEY(CG_PARENT_CODE) REFERENCES CATEGORY_TBL(CG_CODE)
);

-- 1차 카테고리 : TOP(1) PANTS(2) SHIRTS(3) OUTER(4) SHOES(5) BAG(6) ACC(7)
INSERT INTO category_tbl (CG_CODE,CG_PARENT_CODE,CG_NAME) 
    VALUES (1,NULL,'TOP');
INSERT INTO category_tbl (CG_CODE,CG_PARENT_CODE,CG_NAME) 
    VALUES (2,NULL,'PANTS');
INSERT INTO category_tbl (CG_CODE,CG_PARENT_CODE,CG_NAME) 
    VALUES (3,NULL,'SHIRTS');    
INSERT INTO category_tbl (CG_CODE,CG_PARENT_CODE,CG_NAME) 
    VALUES (4,NULL,'OUTER');        
INSERT INTO category_tbl (CG_CODE,CG_PARENT_CODE,CG_NAME) 
    VALUES (5,NULL,'SHOES');    
INSERT INTO category_tbl (CG_CODE,CG_PARENT_CODE,CG_NAME) 
    VALUES (6,NULL,'BAG');    
INSERT INTO category_tbl (CG_CODE,CG_PARENT_CODE,CG_NAME) 
    VALUES (7,NULL,'ACC');  

-- 1차카테고리 TOP : 1
-- 2차 카테고리 : 긴팔티 니트 맨투맨/후드티 프린팅티 나시 반팔티/7부티
INSERT INTO category_tbl (CG_CODE,CG_PARENT_CODE,CG_NAME) 
    VALUES (8,1,'긴팔티');
INSERT INTO category_tbl (CG_CODE,CG_PARENT_CODE,CG_NAME) 
VALUES (9,1,'니트');
INSERT INTO category_tbl (CG_CODE,CG_PARENT_CODE,CG_NAME) 
VALUES (10,1,'맨투맨&#38;후드티');
INSERT INTO category_tbl (CG_CODE,CG_PARENT_CODE,CG_NAME) 
VALUES (11,1,'프린팅티');
INSERT INTO category_tbl (CG_CODE,CG_PARENT_CODE,CG_NAME) 
VALUES (12,1,'나시');
INSERT INTO category_tbl (CG_CODE,CG_PARENT_CODE,CG_NAME) 
VALUES (13,1,'반팔티&#38;7부티');

-- 1차카테고리 PANTS : 2
-- 2차카테고리 : 밴딩팬츠 청바지 슬랙스 면바지 반바지
INSERT INTO category_tbl (CG_CODE,CG_PARENT_CODE,CG_NAME) 
    VALUES (14,2,'밴딩팬츠');
INSERT INTO category_tbl (CG_CODE,CG_PARENT_CODE,CG_NAME) 
    VALUES (15,2,'청바지');
INSERT INTO category_tbl (CG_CODE,CG_PARENT_CODE,CG_NAME) 
    VALUES (16,2,'슬랙스');
INSERT INTO category_tbl (CG_CODE,CG_PARENT_CODE,CG_NAME) 
    VALUES (17,2,'면바지');
INSERT INTO category_tbl (CG_CODE,CG_PARENT_CODE,CG_NAME) 
    VALUES (18,2,'반바지');
    
-- 1차카테고리 SHIRTS : 3
-- 2차카테고리 : 헨리넥/차이나 베이직 체크/패턴 청남방 스트라이프 

INSERT INTO category_tbl (CG_CODE,CG_PARENT_CODE,CG_NAME) 
    VALUES (19,3,'헨리넥&#38;차이나');
INSERT INTO category_tbl (CG_CODE,CG_PARENT_CODE,CG_NAME) 
    VALUES (20,3,'베이직');
INSERT INTO category_tbl (CG_CODE,CG_PARENT_CODE,CG_NAME) 
    VALUES (21,3,'체크&#38;패턴');
INSERT INTO category_tbl (CG_CODE,CG_PARENT_CODE,CG_NAME) 
    VALUES (22,3,'청남방');
INSERT INTO category_tbl (CG_CODE,CG_PARENT_CODE,CG_NAME) 
    VALUES (23,3,'스트라이프'); 
    
    
-- 1차카테고리 OUTER : 4
-- 2차카테고리 : 패딩 코트 수트/블레이져 자켓 블루종/MA-1 가디건/조끼 후드/집업

INSERT INTO category_tbl (CG_CODE,CG_PARENT_CODE,CG_NAME) 
    VALUES (24,4,'패딩');
INSERT INTO category_tbl (CG_CODE,CG_PARENT_CODE,CG_NAME) 
    VALUES (25,4,'코트');
INSERT INTO category_tbl (CG_CODE,CG_PARENT_CODE,CG_NAME) 
    VALUES (26,4,'수트&#38;블레이져');
INSERT INTO category_tbl (CG_CODE,CG_PARENT_CODE,CG_NAME) 
    VALUES (27,4,'자켓');
INSERT INTO category_tbl (CG_CODE,CG_PARENT_CODE,CG_NAME) 
    VALUES (28,4,'블루종&#38;MA-1');     
INSERT INTO category_tbl (CG_CODE,CG_PARENT_CODE,CG_NAME) 
    VALUES (29,4,'가디건&#38;조끼');     
INSERT INTO category_tbl (CG_CODE,CG_PARENT_CODE,CG_NAME) 
    VALUES (30,4,'후드&#38;집업');  
    
-- 1차카테고리 SHOES : 5
-- 2차카테고리 : 스니커즈 로퍼/구두 키높이신발/깔창 슬리퍼/쪼리/샌들
INSERT INTO category_tbl (CG_CODE,CG_PARENT_CODE,CG_NAME) 
    VALUES (31,5,'스니커즈');
INSERT INTO category_tbl (CG_CODE,CG_PARENT_CODE,CG_NAME) 
    VALUES (32,5,'로퍼&#38;구두');
INSERT INTO category_tbl (CG_CODE,CG_PARENT_CODE,CG_NAME) 
    VALUES (33,5,'키높이신발&#38;깔창');
INSERT INTO category_tbl (CG_CODE,CG_PARENT_CODE,CG_NAME) 
    VALUES (34,5,'슬리퍼&#38;쪼리/샌들');
   
-- 1차카테고리 BAG : 6
-- 2차카테고리 : 백팩 토트/숄더백 크로스백 클러치
INSERT INTO category_tbl (CG_CODE,CG_PARENT_CODE,CG_NAME) 
    VALUES (35,6,'백팩'); 
INSERT INTO category_tbl (CG_CODE,CG_PARENT_CODE,CG_NAME) 
    VALUES (36,6,'토트/숄더백');
INSERT INTO category_tbl (CG_CODE,CG_PARENT_CODE,CG_NAME) 
    VALUES (37,6,'크로스백');
INSERT INTO category_tbl (CG_CODE,CG_PARENT_CODE,CG_NAME) 
    VALUES (38,6,'클러치');    
-- 1차카테고리 ACC : 7
-- 2차카테고리 : 양말/넥타이 모자 머플러/장갑 아이웨어 벨트/시계 기타
INSERT INTO category_tbl (CG_CODE,CG_PARENT_CODE,CG_NAME) 
    VALUES (39,7,'양말/넥타이');
INSERT INTO category_tbl (CG_CODE,CG_PARENT_CODE,CG_NAME) 
    VALUES (40,7,'모자');
INSERT INTO category_tbl (CG_CODE,CG_PARENT_CODE,CG_NAME) 
    VALUES (41,7,'머플러&#38;장갑');
INSERT INTO category_tbl (CG_CODE,CG_PARENT_CODE,CG_NAME) 
    VALUES (42,7,'아이웨어');
INSERT INTO category_tbl (CG_CODE,CG_PARENT_CODE,CG_NAME) 
    VALUES (43,7,'벨트&#38;시계');
INSERT INTO category_tbl (CG_CODE,CG_PARENT_CODE,CG_NAME) 
    VALUES (44,7,'기타');

-- 전체 카테고리 출력
SELECT * FROM CATEGORY_TBL;

-- 1차 카테고리 전부 출력
SELECT CG_CODE, CG_PARENT_CODE, CG_NAME FROM CATEGORY_TBL
WHERE CG_PARENT_CODE IS NULL;

-- 1차 카테고리 TOP의 하위인 2차 카테고리 출력
SELECT * FROM CATEGORY_TBL
WHERE CG_PARENT_CODE = 1;

-- 2차 카테고리 전부 출력
SELECT * FROM CATEGORY_TBL
WHERE CG_PARENT_CODE IS NOT NULL;
drop table PRODUCT_TBL;
drop SEQUENCE SEQ_PRODUCT_TBL;
-- 상품 정보 테이블
CREATE TABLE PRODUCT_TBL(
        PRO_NUM             NUMBER  CONSTRAINT  PK_PRO_NUM         PRIMARY KEY,
        CG_CODE             NUMBER           NULL,
        PRO_NAME            VARCHAR2(50)            NOT NULL,
        PRO_PRICE           NUMBER                  NOT NULL,
        PRO_DISCOUNT        NUMBER                  NOT NULL,
        PRO_PUBLISHER       VARCHAR2(50)            NOT NULL,
        PRO_CONTENT         VARCHAR2(4000)  /* CLOB */                  NOT NULL,       -- 내용이 4000BYTE 초과여부판단?
        PRO_UP_FOLDER       VARCHAR2(50)             NOT NULL,
        PRO_IMG             VARCHAR2(100)             NOT NULL,  -- 날짜폴더경로가 포함하여 파일이름저장
        PRO_AMOUNT          NUMBER                  NOT NULL,
        PRO_BUY             CHAR(1)             NOT NULL,
        PRO_DATE            DATE DEFAULT SYSDATE    NOT NULL,
        PRO_UPDATEDATE      DATE DEFAULT SYSDATE    NOT NULL,
        FOREIGN KEY(CG_CODE) REFERENCES CATEGORY_TBL(CG_CODE)
);    

-- 상품테이블의 상품코드 컬럼에 사용목적
CREATE SEQUENCE SEQ_PRODUCT_TBL;

-- 상품테이블 데이터 집어넣기
INSERT INTO 
    PRODUCT_TBL 
        PRO_NUM, CG_CODE, PRO_NAME, PRO_PRICE, PRO_DISCOUNT, 
        PRO_PUBLISHER, PRO_CONTENT, PRO_UP_FOLDER, PRO_IMG, PRO_AMOUNT, PRO_BUY
    VALUES
        (SEQ_PRODUCT_TBL,#{cg_code},#{pro_name},#{pro_price},#{pro_discount},
        #{pro_publisher},#{pro_content},#{pro_up_folder},#{pro_img},#{pro_amount},#{pro_buy});

SELECT * FROM PRODUCT_TBL;        

<!-- 공통된 SQL구문작업 : 검색조건 -->
   <sql id="criteria">
   		<trim prefix="(" suffix=") AND" prefixOverrides="OR">
   			<foreach collection="typeArr" item="type">
   				<trim prefix="OR">
   					<choose>
   						<when test="type == 'N'.toString()">
							PRO_NAME like '%' || #{keyword} || '%'
   						</when>
   						<when test="type == 'C'.toString()">
							PRO_NUM like '%' || #{keyword} || '%'
   						</when>
   						<when test="type == 'P'.toString()">
							PRO_PUBLISHER like '%' || #{keyword} || '%'
   						</when>
   					</choose>
   				</trim>
   			</foreach>
   		</trim>	
   </sql>
   
   <!-- 게시판  -->
   <select id="getListWithPaging" resultType="com.demo.domain.BoardVO" parameterType="com.demo.domain.Criteria">
   		<![CDATA[
   		SELECT PRO_NUM, CG_CODE, PRO_NAME, PRO_PRICE, PRO_DISCOUNT, PRO_PUBLISHER, PRO_CONTENT, PRO_UP_FOLDER, PRO_IMG, PRO_AMOUNT, PRO_BUY, PRO_DATE, PRO_UPDATEDATE
		FROM (
    		SELECT /*+ INDEX_DESC(PRODUCT_TBL pk_pro_num) */
    			ROWNUM RN, PRO_NUM, CG_CODE, PRO_NAME, PRO_PRICE, PRO_DISCOUNT, PRO_PUBLISHER, PRO_CONTENT, PRO_UP_FOLDER, PRO_IMG, PRO_AMOUNT, PRO_BUY, PRO_DATE, PRO_UPDATEDATE
    		FROM 
                PRODUCT_TBL 
    		WHERE
			]]>
			
			<include refid="criteria"></include>
			
			<![CDATA[     		
    		 ROWNUM <= #{pageNum} * #{amount}
    		)
		WHERE RN > (#{pageNum} -1) * #{amount}
		]]> 
   </select>
   
   -- 전체 데이터수 -->
SELECT COUNT(*) 
FROM PRODUCT_TBL 
WHERE <include refid="criteria"></include> PRO_NUM > 0

   
-- 체크상품 수정작업
UPDATE PRODUCT_TBL SET PRO_PRICE = #{pro_price}, PRO_BUY = #{pro_buy} WHERE PRO_NUM = #{pro_num}; 

-- 상품수정 폼 페이지
SELECT 
    PRO_NUM, CG_CODE, PRO_NAME, PRO_PRICE, PRO_DISCOUNT, PRO_PUBLISHER, PRO_CONTENT, 
    PRO_UP_FOLDER, PRO_IMG, PRO_AMOUNT, PRO_BUY, PRO_DATE, PRO_UPDATEDATE
FROM PRODUCT_TBL WHERE PRO_NUM = #{pro_num};

--2차카테고리 9의 부모 카테고리 정보
select CG_CODE, CG_PARENT_CODE, CG_NAME from CATEGORY_TBL where CG_CODE = #{CG_CODE};

--1차카테고리의 자식 카테고리 정보
select CG_CODE, CG_PARENT_CODE, CG_NAME from CATEGORY_TBL where CG_PARENT_CODE = #{CG_PARENT_CODE};
-- 상품 수정
UPDATE PRODUCT_TBL 
SET CG_CODE = , PRO_NAME = , PRO_PRICE = , PRO_DISCOUNT = , PRO_PUBLISHER = , 
PRO_CONTENT = , PRO_UP_FOLDER = , PRO_IMG = , PRO_AMOUNT = , PRO_BUY = , PRO_UPDATEDATE = SYSDATE
WHERE PRO_NUM = ;

-- 상품 삭제
DELETE FROM PRODUCT_TBL WHERE PRO_NUM = #{pro_num};

-- 장바구니
CREATE TABLE CART_TBL(
        CART_CODE        NUMBER,
        PRO_NUM         NUMBER          NOT NULL,
        MBSP_ID         VARCHAR2(15)    NOT NULL,
        CART_AMOUNT      NUMBER          NOT NULL,
        FOREIGN KEY(PRO_NUM) REFERENCES PRODUCT_TBL(PRO_NUM),
        FOREIGN KEY(MBSP_ID) REFERENCES MBSP_TBL(MBSP_ID),
        CONSTRAINT PK_CART_CODE primary key(CART_CODE) 
);

create sequence seq_cart_code;

-- 장바구니에 로그인 사용자가 상품을 추가시, 존재 할경우는 수량변경, 존재 하지않는 경우 장바구니 추가(담기)
merge into cart_tbl
using dual
on (MBSP_ID = 'id값' and PRO_NUM = '상품코드')
when matched then
    update
        set CART_AMOUNT = CART_AMOUNT + 수량
when not matched then
    insert(cart_code, pro_num, mbsp_id, cart_amount)
    values(seq_cart_code.nextval,#{pro_num},#{mbsp_id},#{cart_amount})

-- 장바구니 목록
SELECT C.CART_CODE, C.PRO_NUM, C.CART_AMOUNT ,P.PRO_NAME, P.PRO_PRICE, P.PRO_IMG, P.PRO_DISCOUNT, P.PRO_UP_FOLDER
FROM PRODUCT_TBL P INNER JOIN CART_TBL C ON P.PRO_NUM = C.PRO_NUM
WHERE C.MBSP_ID = 'user01';

-- 장바구니 수량변경
UPDATE CART_TBL
SET CART_AMOUNT = #{cart_amount}
WHERE CART_CODE = #{cart_code}

-- 장바구니 개별삭제
DELETE FROM CART_TBL
WHERE CART_CODE = #{cart_code}

-- 주문 테이블
--5.주문내용 테이블. 구매자의 정보
CREATE TABLE ORDER_TBL(
        ORD_CODE            NUMBER                  ,--PRIMARY KEY, -- 주문 코드
        MBSP_ID             VARCHAR2(15)            NOT NULL, -- 구매자 ID
        ORD_NAME            VARCHAR2(30)            NOT NULL, -- 수령자 성명
        ORD_ZIPCODE         CHAR(5)                 NOT NULL, -- 우편주소
        ORD_ADDR_BASIC      VARCHAR2(50)            NOT NULL, -- 주소
        ORD_ADDR_DETAIL     VARCHAR2(50)            NOT NULL, -- 상세주소
        ORD_TEL             VARCHAR2(20)            NOT NULL, -- 전화번호
        ORD_PRICE           NUMBER                  NOT NULL, -- 총주문금액. 선택
        ORD_REGDATE         DATE DEFAULT SYSDATE    NOT NULL, -- 주문날자
        ORD_STATUS          VARCHAR2(20)            NOT NULL, -- 주문 상태
        PAYMENT_STATUS      VARCHAR2(20)            NOT NULL -- 결제 상태
        --FOREIGN KEY(MBSP_ID)    REFERENCES MBSP_TBL(MBSP_ID)
);

ALTER TABLE ORDER_TBL
ADD CONSTRAINT PK_ORDER_TBL PRIMARY KEY(ORD_CODE);

--6.주문상세 테이블  (구매한 물품의 정보)
CREATE TABLE ORDETAIL_TBL(
        ORD_CODE        NUMBER      NOT NULL REFERENCES ORDER_TBL(ORD_CODE),
        PRO_NUM         NUMBER      NOT NULL REFERENCES PRODUCT_TBL(PRO_NUM),
        DT_AMOUNT       NUMBER      NOT NULL,
        DT_PRICE        NUMBER      NOT NULL,  -- 역정규화
        PRIMARY KEY (ORD_CODE ,PRO_NUM) 
);



drop table ORDER_TBL;

-- 주문번호 : 시퀀스생성
CREATE SEQUENCE SEQ_ORD_CODE;

drop SEQUENCE SEQ_ORD_CODE;
-- 결제테이블 
CREATE TABLE PAYMENT (
        PAY_CODE            NUMBER          NOT NULL, -- 일련번호
        ODR_CODE            NUMBER          NOT NULL, -- 주문번호
        MBSP_ID             VARCHAR2(50)    NOT NULL, -- 회원ID
        PAY_METHOD          VARCHAR2(50)    NOT NULL, -- 결제방식
        PAY_DATE            DATE            NULL,     -- 결제일
        PAY_TOT_PRICE       NUMBER          NOT NULL, -- 결제금액
        PAY_NOBANK_PRICE    NUMBER          NOT NULL, -- 무통장입금금액
        PAY_NOBANK_USER     VARCHAR2(50)    NULL,     -- 무통장입금지명
        PAY_NOBANK          VARCHAR2(50)    NULL,     -- 입금은행
        PAY_BANK_ACCOUNT    VARCHAR2(20)    NULL      -- 계좌번호  
        
        PAY_MEMO            VARCHAR2(100)   NULL      -- 메모        
);

drop sEQUENCE SEQ_PAYMENT_CODE;

commit;

CREATE SEQUENCE SEQ_PAYMENT_CODE;

-- 주문 테이블
INSERT INTO 
    ORDER_TBL(
    ord_code, mbsp_id, ord_name, ord_zipcode, ord_addr_basic, ord_addr_detail, ord_tel, ord_price, ord_regdate, 
    ord_status, payment_status
    )
VALUES
	(#{ord_code}, #{mbsp_id}, #{ord_name}, #{ord_zipcode}, #{ord_addr_basic}, #{ord_addr_detail}, 
    #{ord_tel}, #{ord_regdate}, sysdate, #{ord_status}, #{payment_status})
			
-- 주문상세 테이블 참조 (장바구니 테이블 참조)
INSERT ORDETAIL_TBL (ord_code, pro_num, dt_amount, dt_price)
SELECT #{odr_code},c.PRO_NUM, c.CART_AMOUNT  , p.pro_price
FROM CART_TBL c inner join PRODUCT_TBL p on c.pro_num = p.pro_num
WHERE MBSP_ID = #{mbsp_id}

-- 장바구니 테이블 삭제
DELETE FROM CART_TBL WHERE MBSP_ID = #{mbsp_id}

-- 결제 테이블 저장
INSERT INTO 
    PAYMENT (PAY_CODE, ODR_CODE, MBSP_ID, PAY_METHOD, PAY_DATE, PAY_TOT_RICE, PAY_NOBANK_PRICE, PAY_NOBANK_USER, PAY_NOBANK, PAY_MEMO ,PAY_BANK_ACCOUNT)
VALUES
    (SEQ_PAYMENT_CODE.NEXTVAL,#{odr_code},#{mbsp_id},#{pay_method},sysdate,#{pay_tot_price},#{pay_nobank_price},#{pay_nobank_user},#{pay_nobank},#{pay_memo},#{pay_bank_account})
    
--7.리뷰 테이블
CREATE TABLE REVIEW_TBL(
        REW_NUM         NUMBER,
        MBSP_ID         VARCHAR2(15)                NOT NULL,
        PRO_NUM         NUMBER                      NOT NULL,
        REW_CONTENT     VARCHAR2(200)               NOT NULL,
        REW_SCORE       NUMBER                      NOT NULL,
        REW_REGDATE     DATE DEFAULT SYSDATE        NOT NULL,
        FOREIGN KEY(MBSP_ID) REFERENCES MBSP_TBL(MBSP_ID),
        FOREIGN KEY(PRO_NUM) REFERENCES PRODUCT_TBL(PRO_NUM)
);ㄴ

ALTER TABLE REVIEW_TBL
ADD CONSTRAINT PK_REVIEW_TBL PRIMARY KEY(REW_NUM);



create sequence SEQ_REVIEW_TBL;

-- 리뷰 작성
INSERT INTO 
    REVIEW_TBL (REW_NUM, MBSP_ID, PRO_NUM, REW_CONTENT, REW_SCORE, REW_REGDATE)
VALUES
    (SEQ_REVIEW_TBL.NEXTVAL,);

-- 리뷰 상품 후기
<![CDATA[
		select 
    		REW_NUM, MBSP_ID, PRO_NUM, REW_CONTENT, REW_SCORE, REW_REGDATE
		from 
		    (
		    select /*+INDEX_DESC(REVIEW_TBL PK_REVIEW_TBL) */
		        rownum rn, REW_NUM, MBSP_ID, PRO_NUM, REW_CONTENT, REW_SCORE, REW_REGDATE
		    from 
		        REVIEW_TBL
		    where 
		    	PRO_NUM = #{pro_num}
		    	and    
		        rownum <= #{cri.pageNum} * #{cri.amount}
		    )
		where 
		    rn > (#{cri.pageNum} -1) * #{cri.amount}
		]]>

-- 리뷰 페이징 


  
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
    


commit;
