$(function(){
	(function(){
		var promotion = $(".dt-main .promotion");
		var more = promotion.find(".more");
		var promotion_p = promotion.find("p");
		var onoff = true;
		var Height = 0;
		for (var i = 0; i < promotion_p.length; i++) {
			Height += promotion_p.eq(i).height();
		}
		more.on("click", function(){
			if (onoff) {
				promotion.stop().animate({
					"height": Height
				});
				onoff = false;
			}
			else {
				promotion.stop().animate({
					"height": "1.09375rem"
				});
				onoff = true;
			}
		});
	})();
});