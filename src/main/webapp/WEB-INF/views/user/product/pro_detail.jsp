<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.101.0">
    <title>Pricing example · Bootstrap v4.6</title>
    
    <!-- Bootstrap core CSS -->
    <%@include file="/WEB-INF/views/comm/plugin2.jsp" %>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="https://jqueryui.com/resources/demos/style.css">
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
    <script id="reviewTemplate" type="text/x-handlebars-template">
      <table class="table table-sm">
        <thead>
          <tr>
            <th scope="col">번호</th>
            <th scope="col">리뷰내용</th>
            <th scope="col">별평점</th>
            <th scope="col">날짜</th>
            <th scope="col">비고</th>
          </tr>
        </thead>
        <tbody>
          {{#each .}}
            <tr>
              <th scope="row" class="rew_num">{{rew_num}}</th>
              <td class="rew_content">{{rew_content}}</td>
              <td class="star rew_score">{{displayStar rew_score}}</td>
              <td class="rew_regdate">{{convertDate rew_regdate}}</td>
              <td >{{authControlView mbsp_id rew_num rew_score}}</td>
            </tr>
          {{/each}}
        </tbody>
      </table>
    </script>
    
    <script>
      $( function() {
        $( "#tabs" ).tabs();
      } );
    </script>


    <!-- Favicons -->


    <style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }

      /* 별 모양 평점 기본선택자. */
      p#star_rv_score a.rv_score {
        font-size: 22px;
        text-decoration: none;
        color: lightblue;
      }

      

      /* 별점에 마우스 오버했을 경우 사용되는 CSS선택자. */
      .start , p#star_rv_score a.rv_score.on {
        color: gold;
      }
    </style>

   
  </head>
  <body>
    
<%@include file="/WEB-INF/views/comm/header.jsp" %>

<%@include file="/WEB-INF/views/comm/category_menu.jsp" %>

<div class="pricing-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
 <p>${cg_name }</p>
</div>

<div class="container">
  <div class="card-deck mb-3 text-center row">
    <div class="col-md-6">
      <img class="btn_pro_img" data-pro_num="${productVO.pro_num}" width="100%" src="/user/product/imageDisplay?dateFolderName=${productVO.pro_up_folder }&fileName=${productVO.pro_img}">
    </div>
    <div class="col-md-6">
      <div class="row text-left">
        <div class="col-4">
          상품이름 : 
        </div>
        <div class="col-8">
          ${productVO.pro_name }
        </div>
      </div>
      <div class="row text-left">
        <div class="col-4">
          가격 : 
        </div>
        <div class="col-8">
          <span id="unit_price">${productVO.pro_price}</span>
        </div>
      </div>
      <div class="row text-left">
        <div class="col-4">
          수량 : 
        </div>
        <div class="col-8">
          <input type="number" id="btn_quantity" value="1" style="width: 60px; ">
        </div>
      </div>
      <div class="row text-left">
        <div class="col-4">
          총상품금액 : 
        </div>
        <div class="col-8">
          <span id="tot_price">${productVO.pro_price}</span>
        </div>
      </div>
      <div class="row">
        <div class="col-md-6">
          <button type="button" name="btn_order" class="btn btn-primary" data-pro_num="${productVO.pro_num}">구매하기</button>
        </div>
        <div class="col-md-6">
          <button type="button" name="btn_cart_add" class="btn btn-primary" data-pro_num="${productVO.pro_num}">장바구니</button>
        </div>
      </div>
    </div>
  </div>
  <div class="row">
    <div class="col-md-12">
      <div id="tabs">
        <ul>
          <li><a href="#tabs_prodetail">상품설명</a></li>
          <li><a href="#tabs_proreview">상품후기</a></li>
        </ul>
        <div id="tabs_prodetail">
          <p>${productVO.pro_content}</p>
        </div>
        <div id="tabs_proreview">
          <p>상품후기 목록</p>
          <div class="row">
            <div class="col-md-12" id="review_list">

            </div>
          </div>
          <div class="row" style="text-align: right;">
            <div class="col-8" id="review_paging">

            </div>
            <div class="col-4"><button class="btn btn-primary" id="btn_review_write">상품후기작성</button></div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>


<div class="row text-center">
	<div class="col-md-12">
			
	<!--1)페이지번호 클릭할 때 사용  [이전]  1	2	3	4	5 [다음]  -->
	<!--2)목록에서 상품이미지 또는 상품명 클릭할 때 사용   -->
  <form id="actionForm" action="" method="get">
    <input type="hidden" name="pageNum" id="pageNum" value="${pageMaker.cri.pageNum}" />
    <input type="hidden" name="amount"  id="amount" value="${pageMaker.cri.amount}" />
    <input type="hidden" name="type" id="type" value="${pageMaker.cri.type}" />
    <input type="hidden" name="keyword" id="keyword" value="${pageMaker.cri.keyword}" />
    
    <input type="hidden" name="cg_code" id="cg_code" value="${cg_code}" />
    <input type="hidden" name="cg_name" id="cg_name" value="${cg_name}" />
  </form>
	</div>
</div>

  <%@include file="/WEB-INF/views/comm/footer.jsp" %>
</div>

<%-- <%@include file="/WEB-INF/views/comm/plugin.jsp" %> --%>
  <!-- 카테고리 메뉴 자바스크립트 작업소스 -->
  <script src="/js/category_menu.js"></script>
  
  <script>
	$(document).ready(function() {

		let actionForm = $("#actionForm");

    //장바구니 추가
    $("button[name='btn_cart_add']").on("click", function() {
      // console.log("장바구니");
      // alert("확인")
      $.ajax({
        url: '/user/cart/cart_add',
        type : 'post',
        data : { pro_num: $(this).data("pro_num"),cart_amount : $("#btn_quantity").val()},
        dataType : 'text',
        success : function(result) {
          if(result == "success") {
            alert("장바구니에 추가됨");
            if(confirm("장바구니로 이동하시겠습니까?")){
              location.href = "/user/cart/cart_list"
            }
          }
        }
      });
    });

    // 수량변경시
    $("#btn_quantity").on("change",function() {
      let tot_price = $("#unit_price").text() * $("#btn_quantity").val();

      // 총상품금액 표시
      $("#tot_price").text(tot_price);
    });

    // 상품후기작성 폼
    $("#btn_review_write").on("click",function() {
      $("#btn_review_save").show();
      $("#btn_review_modify").hide();
    })
    // 구매하기
    $("button[name='btn_order']").on("click", function() {
      
      let url = "/user/order/order_ready?pro_num=" + $(this).data("pro_num") + "&cart_amount=" + $("#btn_quantity").val()
      console.log(url);
      location.href = url;
    });
    
    // 상품후기 작성
    $("#btn_review_write").on("click", function () {
      $('#review_modal').modal('show')
      $("p#star_rv_score a.rv_score").parent().children().removeClass("on");
      $("#rew_content").val("");
    });
    
    // 별 평점 클릭시. 평점 태그 5개 ★
    $("p#star_rv_score a.rv_score").on("click", function(e) {
      e.preventDefault();
      
      // $(this) : 클릭한 a태그
      // 선택 했을 때 이전 선택자 제거작업.
      $(this).parent().children().removeClass("on");
      
      // 선택한 a태그인 별과 이전 별에 class에 .on을 입혀 바꿔주는 작업.
      $(this).addClass("on").prevAll("a").addClass("on");
      
    });
    
    // 상품평 목록 불러오기 (이벤트 사용 x 직접호출)
    let review_page = 1; // 목록에서 첫번째 페이지를 의미.
    let url = `/user/review/list/${productVO.pro_num}/` + review_page;

    getReviewInfo(url);

    function getReviewInfo(url) {
      
      $.getJSON(url,function(data) {

        // console.log("상품후기" , data.list[0].rew_content);
        // console.log("페이징정보" , data.pageMaker.total);
        // review_list

        printReviewList(data.list,$("#review_list"),$("#reviewTemplate"));

        // review_paging
        printPaging(data.pageMaker,$("#review_paging"));

      });
    }

    // 1) 상품 후기작업함수
    let printReviewList = function(reviewData, target , template) {
      let templateObj = Handlebars.compile(template.html());
      let reviewHtml = templateObj(reviewData);

      // 상품후기목록 위치를 참조하여 , 추가
      target.children().remove();
      target.append(reviewHtml);
    }

    // 2) 페이징기능 작업함수
    let printPaging = function(pageMaker , target) {

      let pagingStr = '<nav id="navigation" aria-label="Page navigation example">';
      pagingStr += '<ul class="pagination">';
      
      // 이전표시여부
      if(pageMaker.prev){
        pagingStr += '<li class="page-item"><a class="page-link" href="'+ (pageMaker -1) + '">[prev]</a></li>';
      }
      // 페이지 번호출력
      for(let i = pageMaker.startPage; i<=pageMaker.endPage; i++){
        let className = pageMaker.cri.pageNum == i ? 'active' : '';
        pagingStr += '<li class="page-item"' + className + '><a class="page-link" href="'+ i +'">' + i + '</a></li>';
      }

      // 다음표시여부
      if(pageMaker.prev){
        pagingStr += '<li class="page-item"><a class="page-link" href="'+ (pageMaker.startPage +1) + '">[prev]</a></li>';
      }


      pagingStr += '</ul>';
      pagingStr += '</nav>';

      target.children().remove();
      target.append(pagingStr);
    }



    // 사용자 정의 Helper (핸들바의 함수정의)
    // 상품후기 등록일 Date포멧 설정
    Handlebars.registerHelper("convertDate", function(reviewtime) {

      const dateObj = new Date(reviewtime);
      let year = dateObj.getFullYear();
      let month = dateObj.getMonth();
      let date = dateObj.getDate();
      let hour = dateObj.getHours();
      let minute = dateObj.getMinutes();

      return year + "/" + month + "/" + date + " " + hour + ":" + minute;
    })

    // 별평점 숫자 -> 별로 출력하기
    Handlebars.registerHelper("displayStar", function(rating) {

      let starStr = "";
      switch(rating) {
        case 1 :
          starStr = "★☆☆☆☆";
          break;
        case 2 :
          starStr = "★★☆☆☆";
          break;
        case 3 :
          starStr = "★★★☆☆";
          break;
        case 4 :
          starStr = "★★★★☆";
          break;
        case 5 :
          starStr = "★★★★★";
          break;
      }
      return starStr;
    })

    // 상품후기 수정/삭제 버튼 표시
    Handlebars.registerHelper("authControlView",function(mbsp_id,rew_num,rew_score) {
      let str = "";
      let login_id = '${sessionScope.loginStatus.mbsp_id}';

      // 로그인 한 사용자와 상품후기 등록 사용자의 동일여부체크
      if(login_id == mbsp_id) {
        str += '<button type="button" name="btn_review_edit" data-rew_score="' + rew_score + '" class="btn btn-info">수정</button>';
        str += '<button type="button" name="btn_review_del" data-rew_num="' + rew_num + '" class="btn btn-danger">삭제</button>';

        console.log(str);
        return new Handlebars.SafeString(str);
      }

    });

    // 상품후기 수정버튼 클릭
    $("div#review_list").on("click","button[name='btn_review_edit']",function() {
      //평점작업
      let rew_score = $(this).data("rew_score");
      // console.log(rew_score);
      $("#star_rv_score a.rv_score").each(function(index,item) {
        if(index < rew_score){
          $(item).addClass('on');
        }else{
          $(item).removeClass('on');
        }
      });

      // 상품후기 내용
      $("#rew_content").text($(this).parent().parent().find(".rew_content").text());
      // 상품후기 번호
      $("#rew_num").text($(this).parent().parent().find(".rew_num").text());
      // 상품후기 날짜
      $("#rew_regdate").text($(this).parent().parent().find(".rew_regdate").text());

      $("#btn_review_save").hide();
      $("#btn_review_modify").show();
      // 상품후기 수정버튼에 후기번호를 data-rew_num 속성으로 저장
      // $("#btn_review_modify").data("rew_num",$(this).parent().parent().find(".rew_num").text());
      $("#review_modal").modal('show'); // 부트스트랩 4.6버전의 자바스크립트 명령어
      /*
      console.log("번호",$(this).parent().parent().find(".rew_num").text());
      console.log("내용",$(this).parent().parent().find(".rew_content").text());
      console.log("평점",$(this).parent().parent().find(".rew_score").text());
      console.log("날짜",$(this).parent().parent().find(".rew_regdate").text());
      */
    });

    //상품후기 수정하기
    $("#btn_review_modify").on("click",function() {

      let rew_num = $("#rew_num").text();
      let rew_content = $("#rew_content").val();
      //평점
      let rew_score = 0;

      $("p#star_rv_score a.rv_score").each(function(index, item) {
        if($(this).attr("class") == "rv_score on") {
          rew_score += 1;
        }
      });

      let review_data = {rew_num : rew_num , rew_content : rew_content , rew_score : rew_score};

      $.ajax({
        url: '/user/review/modify',
        headers: {
          "Content-Type" : "application/json", "X-HTTP-Method-Override" : "PUT"
        },
        type: 'PUT',
        data: JSON.stringify(review_data), // 데이터 포맷 object -> json으로 변환
        dataType: 'text',
        success: function(result) {
          if(result == 'success') {
            alert("리뷰가 수정되었습니다.");
            $("#review_modal").modal('hide'); // 부트스트랩 4.6버전의 자바스크립트 명령어
            
            // 상품명 목록 불러오는 작업.
            getReviewInfo(url);
          }
        }
      })
    })

    // 상품후기 삭제
    $("div#review_list").on("click",'button[name="btn_review_del"]',function() {
      // console.log("상품후기 삭제");

      if(!confirm("후기를 삭제하시겠습니까?")) return;
      
      let rew_num = $(this).data("rew_num");

      $.ajax({
        url: '/user/review/delete/' + rew_num,
        headers: {
          "Content-Type" : "application/json", "X-HTTP-Method-Override" : "DELETE"
        },
        type: 'delete',
        dataType: 'text',
        success: function(result) {
          if(result == 'success') {
            alert("상품이 삭제되었습니다");
            
            url = `/user/review/list/${productVO.pro_num}/` + review_page;
            getReviewInfo(url);
          }
        }
      })
    })

    // 페이징번호 클릭
    $("div#review_paging").on("click","nav#navigation ul a",function(e) {
      e.preventDefault();
      // console.log("페이지번호");

      review_page = $(this).attr("href"); // 상품후기 선택 페이지번호

      url = `/user/review/list/${productVO.pro_num}/` + review_page;

      getReviewInfo(url); // 스프링에서 상품후기 , 페이지번호 데이터 가져오는 함수

    })

    // 상품후기 저장
    $("#btn_review_save").on("click", function() {


      // 별 평점 값
      let rew_score = 0;
      let rew_content = $("#rew_content").val();

      $("p#star_rv_score a.rv_score").each(function(index, item) {
        if($(this).attr("class") == "rv_score on") {
          rew_score += 1;
        }
      });

      // 별을 선택하지 않았을 경우 체크
      if(rew_score == 0) {
        alert("평점을 선택해 주세요.");
        return;
      }

      // 후기 체크
      if(rew_content == "") {
        alert ("상품 리뷰 내용을 작성 해 주세요");
        return;
      }


      // ajax로 스프링에서 리뷰데이터를 전송하는 작업.
      let review_data = {pro_num : $(this).data("pro_num"), rew_content : rew_content, rew_score : rew_score};

      $.ajax({
        url: '/user/review/new',
        headers: {
          "Content-Type" : "application/json", "X-HTTP-Method-Override" : "POST"
        },
        type: 'post',
        data: JSON.stringify(review_data), // 데이터 포맷 object -> json으로 변환
        dataType: 'text',
        success: function(result) {
          if(result == 'success') {
            alert("상품평이 등록되었습니다.");
            $("#review_modal").modal('hide'); // 부트스트랩 4.6버전의 자바스크립트 명령어
            
            // 상품명 목록 불러오는 작업.
            getReviewInfo(url);


          }
        }
      })

    });
    
    
    
    
  });
  </script>  

  <!-- 상품후기 모델 -->
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
  integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
  crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"
  integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+"
  crossorigin="anonymous"></script>

  <div class="modal fade" id="review_modal" tabindex="-1" aria-labelledby="exampleModalLabel"
    aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">상품후기 작성</h5>
          <b>   </b><span id="rew_num"></span><b>   </b><span id="rew_regdate"></span>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <form>
            <div class="form-group">
              <label for="recipient-name" class="col-form-label">평점</label>
              <p id="star_rv_score">
                <a class="rv_score" href="#">★</a>
                <a class="rv_score" href="#">★</a>
                <a class="rv_score" href="#">★</a>
                <a class="rv_score" href="#">★</a>
                <a class="rv_score" href="#">★</a>
              </p>
            </div>
            <div class="form-group">
              <label for="rew_content" class="col-form-label">상품평</label>
              <textarea class="form-control" id="rew_content" name="rew_content"></textarea>
            </div>
          </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
          <button type="button" id="btn_review_save" class="btn btn-primary" data-pro_num="${productVO.pro_num}" >상품후기저장</button>
          <button type="button" id="btn_review_modify" class="btn btn-primary" data-pro_num="${productVO.pro_num}" >상품후기수정</button>
        </div>
      </div>
    </div>
  </div>

  </body>
</html>
    