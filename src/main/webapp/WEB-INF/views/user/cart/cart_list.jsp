<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!doctype html>
<html lang="ko">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.101.0">
    <title>장바구니</title>

    <!-- Bootstrap core CSS -->
<%@include file="/WEB-INF/views/comm/plugin2.jsp" %>



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
    </style>

   
  </head>
  <body>
    
<%@include file="/WEB-INF/views/comm/header.jsp" %>
<div class="pricing-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
  <p>장바구니</p>
</div>

<div class="container">
  
  <table class="table table-striped">
    <thead>
      <tr>
        <th scope="col"><input type="checkbox" id="checkAll" /></th>
        <th scope="col">상품</th>
        <th scope="col">상품명</th>
        <th scope="col">판매가</th>
        <th scope="col">수량</th>
        <th scope="col">할인(%)</th>
        <th scope="col">합계</th>
        <th scope="col">비고</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach items="${cart_list }" var="cart_list">
        <tr>
          <td><input type="checkbox" name="cart_code" value="${cart_list.cart_code}"/></td>
          <td>
            <img src="/user/cart/imageDisplay?dateFolderName=${cart_list.pro_up_folder }&fileName=s_${cart_list.pro_img }">
          </td>
          <td><a class="move pro_name" href="#" data-bno="${cart_list.pro_num}">${ cart_list.pro_name }</a></td>
          <td><span id="unitPrice">${ cart_list.pro_price }</span></td>
          <td><input type="number" name="cart_amount" value="${cart_list.cart_amount}" style="width: 35px;"> <button type="button" name="btn_cart_amount_change" class="btn btn-success">변경</button></td>
          <td><span id="unitDiscount">${cart_list.pro_discount}%</span></td>
          <td>
            <span class="unitTotalPrice" id="unitTotalPrice">
              ${(cart_list.pro_price - (cart_list.pro_price * cart_list.pro_discount / 100)) * cart_list.cart_amount}
            </span>
          </td>
          <td>
            <button type="button" name="btn_ajax_cart_del" class="btn btn-danger">삭제(ajax사용)</button>
            <button type="button" name="btn_nonAjax_cart_del" class="btn btn-danger">삭제(ajax미사용)</button>
          </td>
        </tr>
      </c:forEach>
    </tbody>
    <tfoot>
      <tr>
        <td colspan="8"><button type="button" id="btn_check_del" class="btn btn-danger">선택삭제</button></td>
      </tr>
      <tr>
        <td colspan="8" style="text-align: right;">
          최종 결제금액 : <span id="cart_total_price">${cart_total_price} </span>
        </td>
      </tr>
      <tr>
        <td colspan="8" style="text-align: center;"><button type="button" id="btn_order" class="btn btn-primary">주문하기</button></td>
      </tr>
    </tfoot>
  </table>


  <%@include file="/WEB-INF/views/comm/footer.jsp" %>
</div>

<%@include file="/WEB-INF/views/comm/plugin.jsp" %>
  <!-- 카테고리 메뉴 자바스크립트 작업소스 -->
  <script src="/js/category_menu.js"></script>
  
  <script>
	$(document).ready(function() {

    // 목록에서 제목행 체크박스 선택
    let isCheck = true;
    $("#checkAll").on("click",function(){
      $("input[name='cart_code']").prop("checked",this.checked);
      isCheck = this.checked;
    });

    // 목록에서 데이터행 체크박스 선택
    $("input[name='cart_code']").on("click",function() {
      // 제목행 체크 상태 변경
      $("#checkAll").prop("checked",this.checked);

      // 데이터 행의 체크박스 상태를 확인해서 제목행 체크상태 변경
      $("input[name='cart_code']").each(function() {
        if(!$(this).is(":checked")) {
          $("#checkAll").prop("checked",false);
        }
      });
    });

    // 선택삭제 버튼 클릭
    $("#btn_check_del").on("click",function() {
      //체크박스 유무 확인
      // console.log("체크확인");
      
      if($("input[name='cart_code']:checked").length == 0) {
        alert("삭제할 물품을 체크해주세요.");
        return;
      }
      
      if(!confirm("선택 상품을 삭제하시겠습니까?")) return;

      let cart_code_arr = []; // 체크된 카트코드 배열

      // 데이터행에서 체크된 체크박스 선택자
      $("input[name='cart_code']:checked").each(function() {
        cart_code_arr.push($(this).val());
      });

      // console.log("카트코드",cart_code_arr);

      $.ajax({
        url: '/user/cart/cart_checked_del', // 체크상품수정 스프링 매핑주소
        type:'post', 
        data:{cart_code_arr: cart_code_arr},
        dataType : 'text',  //스프링에서 받아오는 값의 타입 text ,html ,json,xml 등등
        success: function(result) {
          if(result == 'success') {
            alert("삭제완료");
            location.href = "/user/cart/cart_list";
          } else{
            alert("삭제실패")
          }
        }
      });



    });

    // 장바구니 목록에서 변경클릭시
    $("button[name='btn_cart_amount_change']").on("click",function(){
      let cur_btn_change = $(this);

      let cart_amount = $(this).parent().find("input[name='cart_amount']").val();
      // console.log("수량",cart_amount)
      let cart_code = $(this).parent().parent().find("input[name='cart_code']").val();
      // console.log("장바구니코드",cart_code);
      // console.log("합계",cartItemTotal)

      $.ajax({  
        url : '/user/cart/amount_change',
        type : 'post',
        data : {cart_code : cart_code, cart_amount : cart_amount},
        dataType : 'text',
        beforeSend : function(xhr) {
          xhr.setRequestHeader("AJAX","true");
        },
        success : function(result) {
          if(result == 'success') {
            let unitPrice = cur_btn_change.parent().parent().find("span#unitPrice").text();
            let unitDiscount = cur_btn_change.parent().parent().find("span#unitDiscount").text();

            // 값 파싱
            unitPrice = parseFloat(unitPrice);
            unitDiscount = parseFloat(unitDiscount);
            cart_amount = parseInt(cart_amount, 10);

            // 콘솔 로그 
            // console.log("unitPrice", unitPrice);
            // console.log("unitDiscount", unitDiscount);
            // console.log("cart_amount", cart_amount);

            let unitTotalPrice = cur_btn_change.parent().parent().find("span#unitTotalPrice");
            
            // 계산 및 설정
            unitTotalPrice.text((unitPrice - (unitPrice * unitDiscount / 100)) * cart_amount);
            
            // 전체주문금액
            fn_cart_sumPrice();
          }
        },
        error : function(xhr, status, error) {
          alert(status);
          alert("로그인시간이 만료되었습니다");
          location.href = "/member/login";
        }
      });
    });

    // 장바구니삭제 ajax사용
    $("button[name='btn_ajax_cart_del']").on("click",function() {

      let cart_code = $(this).parent().parent().find("input[name='cart_code']").val();

      // console.log("장바구니코드확인", cart_code);

      let btn_cart_del = $(this); // 선택된 버튼태그의 위치를 참조하기위해

      let userConfirmed = confirm("정말 삭제하시겠습니까?");
      if (userConfirmed) {
        $.ajax({  
          url : '/user/cart/cart_list_del',
          type : 'post',
          data : {cart_code : cart_code},
          dataType : 'text',
          beforeSend : function(xhr) {
          xhr.setRequestHeader("AJAX","true");
          },
          success : function(result) {
            if(result == 'success') {
              alert("삭제되었습니다");

              btn_cart_del.parent().parent().remove();

              fn_cart_sumPrice();
            }
          },
          error : function(xhr, status, error) {
            alert(status);
            alert("로그인시간이 만료되었습니다");
            location.href = "/member/login";
          }
        });
      }
    });

    // 장바구니 삭제 ajax미사용
    $("button[name='btn_nonAjax_cart_del']").on("click",function() {

      if(!confirm("정말 삭제하시겠습니까?")) return;

      let cart_code = $(this).parent().parent().find("input[name='cart_code']").val();

      location.href = "/user/cart/cart_list_del?cart_code=" + cart_code;

    });

    // 주문 정보 페이지
    $("#btn_order").on("click",function() {
      location.href = "/user/order/order_info";
    });


	});

  // 전체 주문금액
  function fn_cart_sumPrice() {
    let sumPrice = 0;
    $(".unitTotalPrice").each(function() {
      sumPrice += Number($(this).text()); // 총합에 더하기
    });
    $("#cart_total_price").text(sumPrice);
    // alert("체크상품이 수정되었습니다.");
  }
  </script>  
  </body>
</html>
    