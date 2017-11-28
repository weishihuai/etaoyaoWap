$(function(){

	/* 导航菜单栏切换 */
	(function(){
		var category = $(".category");
		var item = category.find(".item");
		var item_sub = category.find(".item-sub");

		item.on("mouseenter",function(){
			var index = $(this).index();
			$(this).addClass("item-cur").siblings().removeClass("item-cur");
			item_sub.eq(index).show().siblings().hide();
		});
		category.on("mouseleave",function(){
			item.removeClass("item-cur");
			item_sub.hide();
		});
	})();


	/* 轮播图 */
	(function(){
		var slider_list = $(".slider-list");
		var slider_indicator = $(".slider-indicator");
		var slider_prev = $(".slider-control-prev");
		var slider_next = $(".slider-control-next");
		var count = slider_list.find("li").length-1;
		var num = 0;
		var timer = null;

		slider_list.find("li").eq(0).show().siblings().hide();

		timer = setInterval(function(){
			++num > count ? num=0 : num ;
			picfade();
		},2500);

		slider_indicator.on("click","span",function(){
			num = $(this).index();
			picfade();
		});

		slider_prev.on("click",function(){
			--num < 0 ? num=count : num ;
			picfade();
		});

		slider_next.on("click",function(){
			++num > count ? num=0 : num ;
			picfade();
		});

		$(".slider-cont").on({
			"mouseover": function(){
				clearInterval(timer);
			},
			"mouseout": function(){
				timer = setInterval(function(){
					++num > count ? num=0 : num ;
					picfade();
					
				},2500);
			}
		});

		function picfade(){
			slider_list.find("li").eq(num).stop(true,true).fadeIn(1000).siblings().fadeOut(500);
			slider_indicator.find("span").eq(num).addClass("cur").siblings().removeClass("cur");
		}
	})();

	/* 限时特价 - 倒计时 */
	(function(){
		var recommend = $(".recommend");
		var time_box = recommend.find(".time-box");
		var span_item =  time_box.find("span");
		var endDate = $("#promotion1").attr("endDate");
        if(endDate == undefined || endDate == null || endDate == ''){
            return ;
        }
		endDate = endDate.replace(new RegExp("-","gm"),"/");
		var iNew = new Date(endDate);
		var s = 0, m = 0, h = 0, d = 0, seckill_timer = null;

		seckill_timer = setInterval(function(){
			var iNow = new Date();
			var t = Math.floor((iNew - iNow)/1000);
			s = toTwo(t%60);
			m = toTwo(parseInt(t / 60 % 60, 10));
			h = toTwo(parseInt(t / 60 / 60 % 24 , 10));
			d = Math.floor(t/86400);

			if (s < 0) {
				recommend.parent().html("");

				clearInterval(seckill_timer);
			}
			span_item.eq(0).text(d).end().eq(1).text(h).end().eq(2).text(m).end().eq(3).text(s);
		},1000);

		function toTwo(n){
			return n < 10 && n > -1 ? '0' + n : '' + n;
		}
	})();

	/* 限时特价 - 列表切换 */
	(function(){
		var oUl = $(".in-time-goods");
		var aLi = oUl.find("li");
		var aLi_w = aLi.eq(0).width();
		var btn_prev =  $(".goods-box .slider-control-prev");
		var btn_next =  $(".goods-box .slider-control-next");
		var num = 0;

		btn_prev.on("click",function(){
			if (num <= 0){
				return;
			}
			else {
				num --;
			}
			oUl.animate({
				"left" : -num*aLi_w 
			},200);
			console.log(num);
		});

		btn_next.on("click",function(){
			if (num > aLi.length - 6){
				return;
			}
			else {
				num ++;
			}
			oUl.animate({
				"left" : -num*aLi_w 
			},200);
		});
	})();

	/* 本周热销 - 列表切换 */
	(function(){
		var aA = $(".rt-dd > .dd-control > a");
		var rt_dd_w = $(".rt-dd").width();
		aA.on("click",function(){
			var index = $(this).index();
			$(this).addClass("cur").siblings().removeClass("cur").end().parent().siblings('.editDiv').find(".dd-cont").animate({"left": -rt_dd_w*index});
		});
	})();

	/*人气店铺 - 商品展开与收缩*/
	(function(){
		var item = $(".popular-shops .item");
		var mc = $(".popular-shops .mc");
		item.on("mouseenter",function(){
			$(this).stop().removeClass("cur").animate({
				"width":708
			}).siblings().stop().animate({
				"width":119
			}).addClass("cur");
		});

		mc.on("mouseleave",function(){
			item.stop().animate({
				"width":237
			}).removeClass("cur");
		});

	})();

	//图片预加载：只要img标签中有data-original属性的都需要预加载
	$("img.lazy").lazyload(
		{
			effect: "fadeIn",
			failure_limit : 5,
			threshold : 200
		}
	);

});
