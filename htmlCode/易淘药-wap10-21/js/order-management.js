$(function(){
	/* 搜索框显示/隐藏 */
	(function(){
		var m_top = $(".m-top");
		var search1_box = $(".search1-box");
		m_top.find(".search1").on("touchend", function(){
			m_top.hide();
			search1_box.fadeIn(200);
		});
		search1_box.on("touchend", function(){
			m_top.fadeIn(200);
			search1_box.fadeOut(200);
		});
		search1_box.find("input").on("touchend", function(event){
			event.stopPropagation();
		});
	})();

	/* 订单类型切换 */
	(function(){
		var xiala_box = $(".m-top .xiala-box");
		var dt = xiala_box.find(".dt");
		var dd = xiala_box.find(".dd");
		var onoff = true;

		xiala_box.on("touchend", function(){
			fn1();
		});
		dd.find(".dd-inner").on("touchend", function(event){
			event.stopPropagation();
		});

		function fn1() {
			if (onoff) {
				dt.addClass("dt-s").siblings(".dd").stop().fadeIn(200);
				onoff = false;
			}
			else {
				dt.removeClass("dt-s").siblings(".dd").stop().fadeOut(200);
				onoff = true;
			}
		}
	})();

	/* 订单状态切换 */
	(function(){
		var order_class_toggle = $(".order-class-toggle");
		var dd = order_class_toggle.find(".dd");
		var onoff = true;

		order_class_toggle.on("touchend", function(){
			fn2();
		});
		dd.find(".dd-inner").on("touchend", function(event){
			event.stopPropagation();
		});

		function fn2() {
			if (onoff) {
				order_class_toggle.find(".icon-xiala").addClass("icon-xiala-s").siblings(".dd").stop().fadeIn(200);
				onoff = false;
			}
			else {
				order_class_toggle.find(".icon-xiala").removeClass("icon-xiala-s").siblings(".dd").stop().fadeOut(200);
				onoff = true;
			}
		}
	})();
});