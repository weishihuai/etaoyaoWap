$(function(){
	$(".sp-sort-zh > .dd").height($(window).height());

	/*商品列表展示形式切换*/
	(function(){
		var toggle = $(".list-head .toggle");
		var list_inner = $("#list_inner");
		toggle.on("click", function(){
			if ($(this).attr("data-list") === "true") {
				$(this).addClass("toggle-block").attr("data-list","false");
				list_inner.attr("class", "block-inner clearfix");
			}
			else {
				$(this).removeClass("toggle-block").attr("data-list","true");
				list_inner.attr("class", "list-inner clearfix");
			}
		});
	})();

	/*商品列表排序*/
	(function(){
		var sp_sort_li = $(".sp-sort > li").eq(0);
		var zh_a = $(".sp-sort-zh").find("a");
		sp_sort_li.on("click", function(){
			$(this).find(".dd").toggle();
		});

		zh_a.on("click", function(){
			index = $(this).parent().index();
			zh_a.attr("data-active","false").eq(index).attr("data-active","true");
			if (index === 0) {
				$(".sp-sort-zh").removeClass("high-to-low").find(".dt").html("综合");
			}
			else if (index === 1) {
				$(".sp-sort-zh").removeClass("high-to-low").find(".dt").html("价格");
			}
			else {
				$(".sp-sort-zh").addClass("high-to-low").find(".dt").html("价格");
			}
		});
	})();

	/*筛选*/
	(function(){
		var sp_sort_sx = $(".sp-sort-sx");
		var sx_dt = $(".sp-sort-sx > .dt");
		var sx_dd = $(".sp-sort-sx > .dd");
		var sx_show = sp_sort_sx.find(".sx-show");
		var brand_inner = sp_sort_sx.find(".sx-brand .li-dd-inner");
		var initial_side = sp_sort_sx.find(".initial-side");
		var title_height = sp_sort_sx.find(".li-dd-title").height();
		var arr_top = [];
		var onoff = true;
		var initial_tips = sp_sort_sx.find(".initial-tips");

		sx_dt.on("click", function(){
			$(this).siblings(".dd").show();
			$("html, body").scrollTop(0);
		});

		sx_dd.on("click", function(){
			$(this).hide();
		});

		sp_sort_sx.find(".dd-inner").on("click", function(event){
			event.stopPropagation();
		});

		sx_show.on("click", "a", function(){
			$(this).addClass("cur").siblings().removeClass("cur");
		});

		sp_sort_sx.find(".dd-inner .li-dt").on("click", function(){
			$(this).siblings(".li-dd").show();
		});

		sp_sort_sx.find(".li-dd-title .btn-return").on("click", function(){
			$(this).parent().parent().hide();
		});

		sp_sort_sx.find(".sx-class .class-name").on("click", function(){
			$(this).siblings(".class-item-box").toggle();
		});

		sp_sort_sx.find(".sx-brand").on("click", function(){

			if (onoff === true) {
				arr_top = ["0"];
				for (var i = 1; i < brand_inner.find("li").length; i++) {
					arr_top.push(Math.round(brand_inner.find(".brand-name").eq(i).offset().top - title_height));
				}
				onoff = false;
			}
			else {
				return;
			}
		});

		initial_side.on("click", "span", function(){
			var index = $(this).index();
			brand_inner.parent().animate({scrollTop: arr_top[index] + "px"},0);
		});

		brand_inner.parent().on("scroll", function(){

			for (var i = 0; i < arr_top.length; i++) {
				if (arr_top[1] > $(this).scrollTop()) {
					initial_tips.html(initial_side.find("span").eq(0).html());
					return;
				}
				else if (arr_top[arr_top.length - i] <= $(this).scrollTop()) {
					initial_tips.html(initial_side.find("span").eq(arr_top.length - i).html());
					return;
				}
			}
		});

	})();
});
