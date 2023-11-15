<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!doctype html>
<html lang="ko">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.101.0">
    <title>DocMall 비밀번호 찾기</title>

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

<div class="container">
  <div class="text-center">
    <div class="box box-primary">
      <div class="box-header with-border">
      <h3 class="box-title">비밀번호 찾기</h3>
      </div>
      
      <form role="form" id="change_pwForm" method="post" action="/member/change_password">
      <div class="box-body">
        <div class="form-group row">
          <label for="mbsp_password" class="col-2">비밀번호</label>
          <div class="col-10">
            <input type="password" class="form-control" name="mbsp_password" id="mbsp_password" placeholder="비밀번호 입력">
          </div>
        </div>
        <div class="form-group row">
          <label for="mbsp_password2" class="col-2">비밀번호 확인</label>
          <div class="col-10">
            <input type="password" class="form-control" id="mbsp_password2" placeholder="비밀번호 확인">
          </div>
        </div>
      </div>
      
      <div class="box-footer">
      <button type="button" id="btn_change_pw" class="btn btn-primary">비밀번호 변경</button>
      </div>
      </form>
      </div>
  </div>
  
 <%@include file="/WEB-INF/views/comm/footer.jsp" %> 

  <%@include file="/WEB-INF/views/comm/plugin.jsp" %>

<script>
  // jquery.slim.min.js 파일에 jquery 명령어가 정의되어 있음
  // 별칭 : $ -> jQuery()함수
  // read() 이벤트 메서드 : 브라우저가 html태그를 모두 읽고난 후에 동작하는 이벤트 특징.
  // 자바스크립트 이벤트 등록 :  https://www.w3schools.com/js/js_htmldom_eventlistener.asp
  let msg = "${msg}";
  // 아이디 비밀번호 확인
  if(msg != "") {
        alert(msg);
  }

  $(document).ready(() => {

    let change_pwForm = $("#change_pwForm");// form 태그 참조 <form role="form" id="loginForm" method="post" action="">
    let isConfirmAuth = false; // 이메일 중복체크 사용유무 확인

    
    
    // 확인버튼 클릭
    $("#btn_change_pw").click(()=>{

      // 이름 입력검사
      if($("#mbsp_password").val() =="") {
        alert("비밀번호를 입력해주세요");
        $("#mbsp_password").focus();
        return;
      }


      if($("#mbsp_password").val() !== $("#mbsp_password2").val()) {
        alert("비밀번호가 일치하지않습니다");
        return;
      }
      // 폼 전송작업
      alert("비밀번호 변경 성공");
      change_pwForm.submit();
    });
  });

  </script>
  </body>
</html>
    