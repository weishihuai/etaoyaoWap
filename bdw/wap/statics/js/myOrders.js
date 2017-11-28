var countDown ;
var promotionTypeCode = webPath.promotionTypeCode;

$(function(){

	$("#order-panel").infinitescroll({
		navSelector: "#page-nav",     //页面分页元素--成功后自动隐藏
		nextSelector: "#page-nav a",
		itemSelector: ".order-list" ,
		animate: true,
		loading: {
			finishedMsg: '无更多数据'
		},
		extraScrollPx: 50,
        maxPage: webPath.lastPageNumber
	});

    //移动到当前活动Tab
    moveToActivate(webPath.orderStatus);

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

        $("#iconXiaLa").click(function () {
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

	$(".countDown").each(function() {
		fresh($(this));
	});

	countDown=setInterval(function(){
		$(".countDown").each(function() {
			fresh($(this));
		});
	},1000);

	/* 搜索框显示/隐藏 START*/
	$(".search1").click(function () {
		 $(".m-top").fadeOut(200);
		 $(".search1-box").fadeIn(200);
	});

	$("body").click(function (e) {
		if($(e.target).is(".search1-box")){
			$(".search1-box").fadeOut(200);
			$(".m-top").fadeIn(200);
		}
	});
	/* 搜索框显示/隐藏 END */

	var slider = $(".order-m-main .swiper-wrapper .swiper-slide");
    var dd_inner = $(".order-m-main .dd .dd-inner");
	slider.find("a").click(function () {
        $(this).addClass("cur");
        $(this).parent().siblings().find("a").removeClass("cur");

		if (dd_inner.parent().is(":visible")) {
            dd_inner.parent().css("display","none");
		}

        var rel = $(this).attr("rel");
        dd_inner.find("li").each(function () {
            if ($(this).attr("rel") == rel) {
                $(this).addClass("cur").siblings().removeClass("cur");
            }
        });
        var searchField = $("#searchField");
        var searchValue = $.trim(searchField.val());
        if("商品名称/商品编号/订单编号" == searchValue){
            searchField.attr("value",'');
        }
        reLoadOrderList(rel,searchValue,promotionTypeCode);
    });

    dd_inner.find("li").click(function () {
        var toggleMenu = $("#iconXiaLa");
        var rel = $(this).attr("rel");
        var index = $(this).index();
        slider.find("a").each(function () {
            var swipperWrapper = $(".swiper-wrapper");
            if ($(this).attr("rel") == rel) {
                var margin_r = parseInt(swipperWrapper.find("li").eq(0).css("marginRight"));
                var arr_w = 0;
                swipperWrapper.find("li").eq(index);
                for (var i = 0; i < index; i++) {
                    arr_w += (swipperWrapper.find("li").eq(i).width() + margin_r);
                }
                if (arr_w > $(window).width() - margin_r){
                    arr_w = arr_w - $(window).width() + margin_r * 3;
                    swipperWrapper.css("transform", "translate3d(-"+arr_w + "px, 0px, 0px)");
                } else {
                    swipperWrapper.css("transform", "translate3d(0px, 0px, 0px)");
                }
                $(this).addClass("cur");
                $(this).parent().siblings().find("a").removeClass("cur");
            }
        });
        $(this).addClass("cur").siblings().removeClass("cur");
        toggleMenu.parent().find(".dd").css("display", "none");
        $(".m-top").css("display","block");
        toggleMenu.removeClass("icon-xiala-s");
        var searchField = $("#searchField");
        var searchValue = $.trim(searchField.val());
        if('商品名称/商品编号/订单编号' == searchValue){
            searchField.attr("value",'');
        }
        reLoadOrderList($(this).attr("rel"),searchValue,promotionTypeCode);
    });
});

// 提醒发货
function remindOrder(obj,orderId){
	var $mythis = $(obj);
	if(confirm("您确认要提醒发货吗？")) {
		$.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8;";
		$.ajax({
			type:"GET",
			url:webPath.webRoot+"/order/remindOrder.json?orderId="+orderId ,
			success:function(data) {
				if (data.success == "true") {
					$mythis.replaceWith('<a class="zhifu-btn3" href="javascript:;">已提醒发货</a>');
				}
			},
			error:function(XMLHttpRequest, textStatus) {
				alert("提醒发货失败！");
			}
		});
	}
}

/*
 * 确认收货
 * */
function buyerSigned(orderId){
	if(confirm("您确认收货了吗？")){
		$.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8;";
		$.ajax({
			type:"GET",
			url:webPath.webRoot+"/order/buyerSigned.json?orderId="+orderId ,
			success:function(data) {
				if (data.success == "true") {
					setTimeout(function(){
						window.location.reload();
					},2000)
				}
			},
			error:function(XMLHttpRequest, textStatus) {
				alert("确认收货失败！");
			}
		});
	}
	return false;
}

/**
 * 查询订单
 **/
function searchOrder(){
	$(".search1-box").css("display","none");
	$(".m-top").css("display","block");
	var searchField = $.trim($("#searchField").val());
	if(searchField=='商品名称/商品编号/订单编号'){
		$("#searchField").attr("value",'');
	}

	var selectStatus;

	$("#selectStatus li").each(function () {
		if($(this).hasClass("cur")){
			selectStatus = $(this).attr("rel");
			return false;
		}
	});
	if(selectStatus == undefined || selectStatus =='' || selectStatus == null){
		selectStatus=10;
	}
    reLoadOrderList(selectStatus,searchField,promotionTypeCode);
}

function fresh(t){
	var RemainTime = t.attr("lastPayTime");
    if(RemainTime == undefined || RemainTime == null || RemainTime == ''){
        clearInterval(countDown);
        return false;
    }
	var orderId = t.attr("orderId");
	var endtimeStr = RemainTime.replace(/-/g,"/");
	var endtime=new Date(endtimeStr);
	var nowtime = new Date();
	var leftsecond=parseInt((endtime.getTime()-nowtime.getTime())/1000);
	if(leftsecond<=0){
		clearInterval(countDown);
		window.location.reload();
	}else{
		d=toTwo(parseInt(leftsecond/3600/24));
		h=toTwo(parseInt((leftsecond/3600)%24));
		m=toTwo(parseInt((leftsecond/60)%60));
		s=toTwo(parseInt(leftsecond%60));
		$("#orderId"+orderId).html("立即支付<span>"+h + ":"+ m +":" + s+"</span>");
	}
	function toTwo(n){
		return n < 10 && n > -1 ? '0' + n : '' + n;
	}
}

/*
 * 取消订单
 * */
function cancelOrder(orderId){
	if(confirm("您确认要取消此订单么?")) {
		$.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8;";
		$.ajax({
			type: "GET",
			url: webPath.webRoot + "/order/cancel.json?orderId=" + orderId,
			success: function (data) {
				if (data.success == "true") {
					setTimeout(function () {
						window.location.reload();
					}, 1)
				}
			},
			error: function (XMLHttpRequest, textStatus) {
				alert("取消订单失败！");
			}
		});
	}
	return false;
}

//移动到选中的菜单
function moveToActivate(orderStatus){
    var swipper_slider = $(".order-m-main .swiper-wrapper .swiper-slide");
    var index = 0;
    swipper_slider.find("a").each(function (ind) {
        if ($(this).attr("rel") == orderStatus){
            index = ind
        }
    });
    swipper_slider.find("a").each(function () {
        var swipperWrapper = $(".swiper-wrapper");
        if ($(this).attr("rel") == orderStatus) {
            var margin_r = parseInt(swipperWrapper.find("li").eq(0).css("marginRight"));
            var arr_w = 0;
            swipperWrapper.find("li").eq(index);
            for (var i = 0; i < index; i++) {
                arr_w += (swipperWrapper.find("li").eq(i).width() + margin_r);
            }
            if (arr_w > $(window).width() - margin_r){
                arr_w = arr_w - $(window).width() + margin_r * 3;
                swipperWrapper.css("transform", "translate3d(-"+arr_w + "px, 0px, 0px)");
            } else {
                swipperWrapper.css("transform", "translate3d(0px, 0px, 0px)");
            }
            $(this).addClass("cur");
            $(this).parent().siblings().find("a").removeClass("cur");
        }
    });
}

/**
 * 重新加载订单列表
 * @param orderStatus 订单状态
 * @param searchField 订单搜索关键字
 * @param promotionTypeCode 订单类型
 */
function reLoadOrderList(orderStatus,searchField,promotionTypeCode) {
	if (!isNotEmpty(searchField) && !isNotEmpty(promotionTypeCode)) {
        window.location.href = webPath.webRoot + "/wap/module/member/myOrders.ac?status="+orderStatus;
	} else if (isNotEmpty(searchField) && !isNotEmpty(promotionTypeCode)) {
        window.location.href = webPath.webRoot + "/wap/module/member/myOrders.ac?status="+orderStatus+"&searchField="+searchField;
	} else if (!isNotEmpty(searchField) && isNotEmpty(promotionTypeCode)) {
        window.location.href = webPath.webRoot + "/wap/module/member/myOrders.ac?status="+orderStatus+"&promotionTypeCode="+promotionTypeCode;
	} else {
        window.location.href = webPath.webRoot + "/wap/module/member/myOrders.ac?status="+orderStatus+"&searchField="+searchField+"&promotionTypeCode="+promotionTypeCode;
	}
}

/**
 * 判断对象是否为空
 * @param text
 * @returns {boolean}
 */
function isNotEmpty(text){
    text = $.trim(text);
	return undefined != text && null != text && "" != text;
}