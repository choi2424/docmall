$(document).ready(function() {
		
	// 1차카테고리 마우스오버
	$("div#category_menu a").on("mouseover",function(e) {
		e.preventDefault() // a태그의 링크기능을 제거하는 기능
		// console.log("1차 카테고리 오버");
		let sel_first_category = $(this);
		let cg_code = $(this).data("cg_code");

		// console.log("1차 카테고리 코드" + cg_code);

		let url = "/category/secondCategory/" + cg_code;
		$.getJSON(url, function (category) {

			// console.log(category);
			let str = '<ul class="treeview-menu" id="second_category" style="display:block; list-style:none; text-align: center;">';
			for (let i = 0; i < category.length; i++) {
				str += '<li class="nav-item">';
				str += '<a class="nav-link active" href="#" data-cg_code="' + category[i].cg_code + '">' + category[i].cg_name + '</a>';
				str += "</li>";
			}
			str += "</ul>";

			// console.log(str);
			$(".treeview-menu").remove();
			sel_first_category.after(str);
		});
	});
	
	$("div#category_menu span").on("mouseleave", function (e) {
		e.preventDefault() // a태그의 링크기능을 제거하는 기능
		$(".treeview-menu").remove();
	});
	
	// 2차카테고리 선택 
	/*
	$("동적태그 참조선택자").on("이벤트명", "동적태그를 참조하는 선택자", function() {
	
	})
	*/
	$("div#category_menu").on("click", "ul#second_category", function() {
		console.log("2차 카테고리 작업");
	});
});