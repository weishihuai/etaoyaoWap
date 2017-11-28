$(function(){

	/*发票toggle*/
	(function(){
		var dt = $(".invoice-info-inner .dt");
		var dd_item = $(".invoice-info-inner .dd-item");
		dd_item.eq(0).show();
		$(".invoice-toggle").on("click","a", function(){
			var index = $(this).index();
			$(this).addClass("cur").siblings().removeClass("cur");
			if (index === 1) {
				$(".invoice-info-inner").show();
				onoff = false;
			}
			else {
				$(".invoice-info-inner").hide();
				onoff = true;
			}
		});
		dt.on("click", "p", function(){
			var index = $(this).index();
			$(this).find(".checkbox").addClass("checkbox-active").parent().siblings().find(".checkbox").removeClass("checkbox-active");
			dd_item.eq(index).show().siblings().hide();
		});
	})();
});