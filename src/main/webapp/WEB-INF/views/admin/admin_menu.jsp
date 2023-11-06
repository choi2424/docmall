<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>DocMall  | Admin</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <link rel="stylesheet" href="/css/stylesheet.css" />
  <%@include file="/WEB-INF/views/admin/include/plugin1.jsp" %>
  <style>
    th{text-align: center;}
  </style>
</head>
<!--
BODY TAG OPTIONS:
=================
Apply one or more of the following classes to get the
desired effect
|---------------------------------------------------------|
| SKINS         | skin-blue                               |
|               | skin-black                              |
|               | skin-purple                             |
|               | skin-yellow                             |
|               | skin-red                                |
|               | skin-green                              |
|---------------------------------------------------------|
|LAYOUT OPTIONS | fixed                                   |
|               | layout-boxed                            |
|               | layout-top-nav                          |
|               | sidebar-collapse                        |
|               | sidebar-mini                            |
|---------------------------------------------------------|
-->
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">

  <!-- Main Header -->
<%@include file="/WEB-INF/views/admin/include/header.jsp" %>
  <!-- Left side column. contains the logo and sidebar -->
<%@include file="/WEB-INF/views/admin/include/nav.jsp" %>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">

    <!-- Main content -->
    <section class="content container-fluid">
      <div id="main_wrap">
        <section>
          <h2>전체 주문통계<a href="" class="btn_small">주문내역 바로가기</a></h2>
          <div class="order_vbx">
            <dl class="od_bx1">
              <dt>전체 주문현황</dt>
              <dd>
                <p class="ddtit">총 주문건수</p>
                <p>26</p>
              </dd>
              <dd class="total">
                <p class="ddtit">총 주문액</p>
                <p>1,710,850</p>
              </dd>
            </dl>
      
            <dl class="od_bx2">
              <dt>주문상태 현황</dt>
              <dd>
                <p class="ddtit">입금대기</p>
                <p>0</p>
              </dd>
              <dd>
                <p class="ddtit">입금완료</p>
                <p>0</p>
              </dd>
              <dd>
                <p class="ddtit">배송준비</p>
                <p>0</p>
              </dd>
              <dd>
                <p class="ddtit">배송중</p>
                <p>0</p>
              </dd>
              <dd>
                <p class="ddtit">배송완료</p>
                <p>1</p>
              </dd>
            </dl>
            <dl class="od_bx2">
              <dt>구매확정/클래임 현황</dt>
              <dd>
                <p class="ddtit">구매미확정</p>
                <p>0</p>
              </dd>
              <dd>
                <p class="ddtit">취소</p>
                <p>25</p>
              </dd>
              <dd>
                <p class="ddtit">환불</p>
                <p>0</p>
              </dd>
              <dd>
                <p class="ddtit">반품</p>
                <p>0</p>
              </dd>
              <dd>
                <p class="ddtit">교환</p>
                <p>0</p>
              </dd>
            </dl>
          </div>
        </section>
      
        <section class="sidx_head01">
          <h2>최근 주문내역<a href="" class="btn_small">주문내역 바로가기</a></h2>
          <table>
          <thead>
          <tr>
            <th scope="col">주문번호</th>
            <th scope="col">주문자명</th>
            <th scope="col">수령자명</th>
            <th scope="col">전화번호</th>
            <th scope="col">결제방법</th>
            <th scope="col">총주문액</th>
            <th scope="col">주문일시</th>
          </tr>
          </thead>
          <tbody>
              <tr class="tr_alignc">
            <td>23043013364001</td>
            <td>관리자</td>
            <td>관리자</td>
            <td>010-0000-0000</td>
            <td>무통장</td>
            <td>36,720</td>
            <td>2023-04-30 13:37 (일)</td>
          </tr>
              <tr class="tr_alignc">
            <td>23020113403890</td>
            <td>관리자</td>
            <td>관리자</td>
            <td>010-0000-0000</td>
            <td>무통장</td>
            <td>23,000</td>
            <td>2023-02-01 13:40 (수)</td>
          </tr>
              <tr class="tr_alignc">
            <td>22111615313936</td>
            <td>세글만</td>
            <td>세글만</td>
            <td>010-3333-3333</td>
            <td>무통장</td>
            <td>60,060</td>
            <td>2022-11-16 15:31 (수)</td>
          </tr>
              <tr class="tr_alignc">
            <td>22063014203387</td>
            <td>관리자</td>
            <td>관리자</td>
            <td>010-0000-0000</td>
            <td>무통장</td>
            <td>218,000</td>
            <td>2022-06-30 14:21 (목)</td>
          </tr>
              <tr class="tr_alignc">
            <td>22063014170424</td>
            <td>관리자</td>
            <td>관리자</td>
            <td>010-0000-0000</td>
            <td>무통장</td>
            <td>218,000</td>
            <td>2022-06-30 14:18 (목)</td>
          </tr>
              </tbody>
          </table>
        </section>
      
        <section class="sidx_head01">
          <h2>최근 회원가입<a href="" class="btn_small">회원관리 바로가기</a></h2>
          <table>
          <thead>
          <tr>
            <th scope="col">이름</th>
            <th scope="col">아이디</th>
            <th scope="col">레벨</th>
            <th scope="col">이메일</th>
            <th scope="col">접속횟수</th>
            <th scope="col">추천인</th>
            <th scope="col">가입일시</th>
          </tr>
          </thead>
          <tbody>
              <tr class="tr_alignc">
            <td>세글만</td>
            <td>tubeweb3</td>
            <td>일반회원</td>
            <td>tubeweb3@gmail.com</td>
            <td>44</td>
            <td>tubeweb1</td>
            <td>2020-10-04 18:05 (일)</td>
          </tr>
              <tr class="tr_alignc">
            <td>두글만</td>
            <td>tubeweb2</td>
            <td>일반회원</td>
            <td>tubeweb2@gmail.com</td>
            <td>629</td>
            <td>admin</td>
            <td>2020-10-04 18:05 (일)</td>
          </tr>
              <tr class="tr_alignc">
            <td>한글만</td>
            <td>tubeweb1</td>
            <td>가맹점</td>
            <td>tubeweb1@gmail.com</td>
            <td>682</td>
            <td>admin</td>
            <td>2020-10-04 18:04 (일)</td>
          </tr>
              </tbody>
          </table>
        </section>
      </div>

    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

  <!-- Main Footer -->
<%@include file="/WEB-INF/views/admin/include/footer.jsp" %> 

  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Create the tabs -->
    <ul class="nav nav-tabs nav-justified control-sidebar-tabs">
      <li class="active"><a href="#control-sidebar-home-tab" data-toggle="tab"><i class="fa fa-home"></i></a></li>
      <li><a href="#control-sidebar-settings-tab" data-toggle="tab"><i class="fa fa-gears"></i></a></li>
    </ul>
    <!-- Tab panes -->
    <div class="tab-content">
      <!-- Home tab content -->
      <div class="tab-pane active" id="control-sidebar-home-tab">
        <h3 class="control-sidebar-heading">Recent Activity</h3>
        <ul class="control-sidebar-menu">
          <li>
            <a href="javascript:;">
              <i class="menu-icon fa fa-birthday-cake bg-red"></i>

              <div class="menu-info">
                <h4 class="control-sidebar-subheading">Langdon's Birthday</h4>

                <p>Will be 23 on April 24th</p>
              </div>
            </a>
          </li>
        </ul>
        <!-- /.control-sidebar-menu -->

        <h3 class="control-sidebar-heading">Tasks Progress</h3>
        <ul class="control-sidebar-menu">
          <li>
            <a href="javascript:;">
              <h4 class="control-sidebar-subheading">
                Custom Template Design
                <span class="pull-right-container">
                    <span class="label label-danger pull-right">70%</span>
                  </span>
              </h4>

              <div class="progress progress-xxs">
                <div class="progress-bar progress-bar-danger" style="width: 70%"></div>
              </div>
            </a>
          </li>
        </ul>
        <!-- /.control-sidebar-menu -->

      </div>
      <!-- /.tab-pane -->
      <!-- Stats tab content -->
      <div class="tab-pane" id="control-sidebar-stats-tab">Stats Tab Content</div>
      <!-- /.tab-pane -->
      <!-- Settings tab content -->
      <div class="tab-pane" id="control-sidebar-settings-tab">
        <form method="post">
          <h3 class="control-sidebar-heading">General Settings</h3>

          <div class="form-group">
            <label class="control-sidebar-subheading">
              Report panel usage
              <input type="checkbox" class="pull-right" checked>
            </label>

            <p>
              Some information about this general settings option
            </p>
          </div>
          <!-- /.form-group -->
        </form>
      </div>
      <!-- /.tab-pane -->
    </div>
  </aside>
  <!-- /.control-sidebar -->
  <!-- Add the sidebar's background. This div must be placed
  immediately after the control sidebar -->
  <div class="control-sidebar-bg"></div>
</div>
<!-- ./wrapper -->

<!-- REQUIRED JS SCRIPTS -->
<%@include file="/WEB-INF/views/admin/include/plugin2.jsp" %>
</body>
</html>