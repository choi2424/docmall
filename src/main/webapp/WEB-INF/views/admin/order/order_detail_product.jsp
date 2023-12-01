<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>

  /* Important part */
  .modal-content{
  overflow-y: initial !important
  }
  .modal-body{
  height: 250px;
  overflow-y: auto;
  }
  
  </style>
</head>
<body>
	
	<table class="table table-sm">
          <caption style="display: table-caption; text-align: center; color: red; font-weight: bold;">[주문상세정보]</caption>
          <thead>
            <tr>
              <th scope="col">주문번호</th>
              <th scope="col">상품코드</th>
              <th scope="col">상품이미지</th>
              <th scope="col">상품명</th>
              <th scope="col">주문수량</th>
              <th scope="col">주문금액</th>
              <th scope="col">비고</th>
            </tr>
          </thead>
          <tbody>
          	<c:forEach items="${orderProductList }" var="orderProductVO">
              <tr>
                <th scope="row">${orderProductVO.orderDetailVO.ord_code }</th>
                <td>${orderProductVO.productVO.pro_num }</td>
                <td><img src="/admin/order/imageDisplay?dateFolderName=${orderProductVO.productVO.pro_up_folder }&fileName=${orderProductVO.productVO.pro_img }"></td>
                <td class="td_pro_name">${orderProductVO.productVO.pro_name}</td>
                <td>${orderProductVO.orderDetailVO.dt_amount}</td>
                <td>${orderProductVO.productVO.pro_price * orderProductVO.orderDetailVO.dt_amount}</td>
                <td><button type="button" name="btn_order_delete" class="btn btn-danger" data-ord_code="${orderProductVO.orderDetailVO.ord_code }" data-pro_num="${orderProductVO.productVO.pro_num }">삭제</button></td>
              </tr>
          	</c:forEach>
          </tbody>
        </table>
        <form id="actionForm" action="" method="get">
          <input type="hidden" name="pageNum" id="pageNum" value="${pageMaker.cri.pageNum}" />
          <input type="hidden" name="amount"  id="amount" value="${pageMaker.cri.amount}" />
          <input type="hidden" name="type" id="type" value="${pageMaker.cri.type}" />
          <input type="hidden" name="keyword" id="keyword" value="${pageMaker.cri.keyword}" />
        </form>
</body>
<script>
  $(document).ready(function() {
    
    let actionForm = $("#actionForm");

    $("button[name='btn_order_delete']").on("click",function() {
      
      // console.log("개별삭제");
      
      let ord_code = $(this).data('ord_code');
      let pro_num = $(this).data('pro_num');
      let pro_name = $(this).parent().parent().find($(".td_pro_name")).text();

      if(!confirm(pro_name + "를(을)정말 삭제하시겠습니까?")) return;
// console.log("주문번호",ord_code);
// console.log("상품번호",pro_num);

// <input type="hidden" name="ord_code" value="">
actionForm.append('<input type="hidden" name="ord_code" value="'+ ord_code +'" />');
actionForm.append('<input type="hidden" name="pro_num" value="'+ pro_num +'" />');

actionForm.attr("method","get");
actionForm.attr("action","/admin/order/order_product_delete");
actionForm.submit();


});
  });

</script>
</html>