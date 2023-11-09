<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 
<div id="category_menu">
	<ul class="nav justify-content-center">
		<c:forEach items="${firstCategoryList }" var="category">
			<li class="nav-item ">
				<a class="nav-link active" href="#" data-cg_code="${category.cg_code }">${category.cg_name }</a>
			</li>
		</c:forEach>
	</ul>
</div>
-->
<div id="category_menu" style="text-align: center;">
	<c:forEach items="${firstCategoryList }" var="category">
		<span style="text-align: center; display: inline-block; margin-right: 50px; vertical-align: top;">
			<a class="nav-link active" href="#" data-cg_code="${category.cg_code }">${category.cg_name }</a>
		</span>
	</c:forEach>
</div>