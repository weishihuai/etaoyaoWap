$(function(){
	/* 图片切换 */
	(function(){
		
		var preview = $(".product-preview");
		var preview_stage = preview.find(".preview-stage");
		var preview_bar = preview.find(".preview-bar");

		preview_bar.on("click","li",function(){
			var index = $(this).index();
			$(this).addClass("active").siblings().removeClass("active");
			preview_stage.find("li").eq(index).show().siblings().hide();
		});
	})();

	/* 商品-menu 切换 */
	(function(){
		var minute_menu = $(".minute-menu");
		var minute_cont = minute_menu.siblings(".minute-cont");
		var client_w = document.body.clientWidth;
		var btn_cart = $(".main-content .btn-cart");
		var show_h = minute_menu.offset().top + 1;

		minute_menu.on("click","li",function(){
			var index = $(this).index();
			$(this).addClass("active").siblings().removeClass("active");
			minute_cont.hide().eq(index).show();
			if ($(document).scrollTop() >= show_h) {
				$(document).scrollTop(show_h);
			}
			var rel = $(this).attr("rel");
			if ("2" == rel) {
				loadPage();
			}
		});


		if (client_w > 1190) {
			btn_cart.css("left",(client_w-1190)/2 + 1190 - 191);
		}
		else {
			btn_cart.css({
				"position":"absolute",
				"right":"2px",
				"top":"20px"
			});
		}
		$(window).scroll(function(){
			var TOP = $(document).scrollTop();
			if (TOP >= show_h) {
				minute_menu.addClass("minute-menu-fixed");
				minute_cont.css("margin-top",51);
				btn_cart.show();
			}
			else {
				minute_menu.removeClass("minute-menu-fixed");
				minute_cont.css("margin-top",0);
				btn_cart.hide();
			}
		});
	})();

	/* 限时特价 - 倒计时 */
	(function(){
		var time_box = $(".time-box");
		var span_item =  time_box.find("span");
		var endDate = $(".time-box").attr("endDate");
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
				clearInterval(seckill_timer);
			}
			span_item.eq(0).text(d).end().eq(1).text(h).end().eq(2).text(m).end().eq(3).text(s);
		},1000);
		function toTwo(n){
			return n < 10 && n > -1 ? '0' + n : '' + n;
		}
	})();

	//商品详细页促销活动
	//更多的点击事件
	$(".more-rule").click(function(){
		$(".i_layer").css("height","auto");
		$(".hidden-rule").css("display","");
		$(".more-rule").css("display","none");
	});

	//隐藏的点击事件
	$(".hidden-rule").click(function(){
		$(".i_layer").css("height","80px");
		$(".hidden-rule").css("display","none");
		$(".more-rule").css("display","");
	});

	//购买数量减少事件
	$(".prd_subNum").click(function () {
		var productNum = $(".amount-inp");
		var value = productNum.val();
		var num = parseInt(value) - 1;
		if (num == 0) {
			return;
		}else if(num <= 1){
			$(".prd_subNum").addClass("disabled");
		}
		productNum.val(num);
		$(".addcart").attr("num", num);
		$(".addGoCar").attr("num", num);
	});

	//购买数量输入框
	$(".amount-inp").change(function () {
		var value = $(this).val();
		var reg = new RegExp("^[1-9]\\d*$");
		if (!reg.test(value)) {
			$(this).val(1);
			$(".addcart").attr("num", 1);
			$(".addGoCar").attr("num", 1);
			return;
		}
		$(".addcart").attr("num", value);
		$(".addGoCar").attr("num", value);
	});

	//购买数量增加事件
	$(".prd_addNum").click(function () {
		var productNum = $(".amount-inp");
		var value = productNum.val();
		var num = parseInt(value) + 1;
		productNum.val(num);
		if (num > 1) {
			$(".prd_subNum").removeClass("disabled");
		}
		$(".addcart").attr("num", value);
		$(".addGoCar").attr("num", value);
	});

	var collectCount = webPath.productCollectCount;
	//收藏商品
	$("#AddTomyLikeBtn").click(function () {
		if (webPath.productId == '' || webPath.productId == undefined) {
			return;
		}
		$.get(webPath.webRoot + "/member/collectionProduct.json?productId=" + webPath.productId, function (data) {

			if (data.success == false) {
				if (data.errorCode == "errors.login.noexist") {
					showPrdDetailUserLogin();
				}
			} else if (data.success == true) {
				if (webPath.productCollectCount == '' || webPath.productCollectCount == undefined) {
					collectCount = 1
				}
				if(data.isCancel == true){

					$("#AddTomyLikeBtn").find('i:first-child').removeClass("icon-collect-active");
					$("#AddTomyLikeBtn").find('i:first-child').addClass("icon-collect");
					collectCount = parseInt(collectCount) - 1;
					$("#productCollectCount").html(collectCount);
					$(".AddTomyLikeLayer .showTip .succe h3").html("商品已取消收藏！");
					$(".AddTomyLikeLayer").show();
				} else{
					$("#AddTomyLikeBtn").find('i:first-child').removeClass("icon-collect");
					$("#AddTomyLikeBtn").find('i:first-child').addClass("icon-collect-active");
					collectCount = parseInt(collectCount) + 1;
					$("#productCollectCount").html(collectCount);
					$(".AddTomyLikeLayer .showTip .succe h3").html("商品已成功收藏！");
					$(".AddTomyLikeLayer").show();
				}
			}
		});
	});

	//发表评价跳转到订单列表,从列表进入评价入口
	$("#isAllowComment").click(function(){
		window.location.href = webPath.webRoot + 'module/member/orderList.ac?pitchOnRow=11';
	});

	$("#consultCont").keyup(function () {
		$("#consultContLength").text($(this).val().length+"/300");
	});

});


var collectCount2=webPath.shopCollectCount;
function CollectShop(obj){
    if (obj == '' || obj == undefined) {
        return;
    }
    $.get(webPath.webRoot + "/member/coll" +
        "ectionShop.json?shopId=" + obj, function (data) {
        if (data.success == false) {
            if (data.errorCode == "errors.login.noexist") {
                if (confirm("您尚未登陆，请登陆!")) {
                    goToUrl(webPath.webRoot + "/login.ac");
                }
            }
        } else if (data.success == true) {
            if (webPath.shopCollectCount == '' || webPath.shopCollectCount == undefined) {
                collectCount2 = 1
            } else {
                if(data.isCancel == true){
                    collectCount2 = parseInt(collectCount2)- 1 ;
                    $("#shopCollectCount").html(collectCount2);
                    $(".AddShopTomyLikeLayer .showTip .succe h3").html("店铺已取消收藏！");
                    $(".AddShopTomyLikeLayer").show();
                } else{
                    collectCount2 = parseInt(collectCount2)+ 1;
                    $("#shopCollectCount").html(collectCount2);
                    $(".AddShopTomyLikeLayer .showTip .succe h3").html("店铺已成功收藏！");
                    $(".AddShopTomyLikeLayer").show();
					$("#collectState").text("已收藏");
					$("#collectState").removeAttr("onclick");
                }
            }
        }
    });
}

/*点击 累积评价 展开评价模块*/
function goComment(){
	$(".minute-menu li").removeClass("active");
	$("#relComment").addClass("active");
    $(".minute-menu").siblings(".minute-cont").hide().eq(1).show();;
	$("html,body").animate({scrollTop: $(".minute-menu").offset().top}, 300);
    loadPage();
}

//清空商品的cookie
var clearHistoryProductsCookie = function () {
    $.get(webPath.webRoot + "/member/clearProductsCookie.json", function (data) {
        setTimeout(function () {
            window.location.reload();
        }, 2)
    });
};

function goToPage(obj){
	var page = $(".inputPage").val();
	 if(parseInt(page) > parseInt($(obj).attr("lastPage"))){
		 return ;
	 }
	 $(".comment-list").load(webPath.webRoot + "/template/bdw/module/common/includeProductComment.jsp", {
	 page: page,
	 id: productId
	 }, function () {

	 });
}

function loadPage() {
	$(".comment-list").load(webPath.webRoot + "/template/bdw/module/common/includeProductComment.jsp", {id: productId}, function () {
	});
}

//异步分页
function syncPage(page, productId) {
	$(".comment-list").load(webPath.webRoot + "/template/bdw/module/common/includeProductComment.jsp", {
		page: page,
		id: productId
	}, function () {

	});
}

/* 图片切换 */
function preview(obj) {
    $(obj).parent().parent().addClass("active").siblings().removeClass("active");
}

function loadCategoryById(categoryId) {
    if (categoryId == '' || categoryId == undefined) {
        categoryId = 1;
    }
    window.location.href=webPath.webRoot +"/productlist-"+categoryId+".html";
}



//登录提示框
function showPrdDetailUserLogin(){
	var dialog = jDialog.confirm('您还没有登录',{
		type : 'highlight',
		text : '登录',
		handler : function(button,dialog) {
			dialog.close();
			window.location.href = webPath.webRoot + "/login.ac";
		}
	},{
		type : 'normal',
		text : '取消',
		handler : function(button,dialog) {
			dialog.close();
		}
	});
	return dialog;
}


//登录提示框
function showPrdCommentUserLogin(){
    var dialog = jDialog.confirm('您还没有登录',{
        type : 'highlight',
        text : '登录',
        handler : function(button,dialog) {
            dialog.close();
            window.location.href = webPath.webRoot + "/login.ac";
        }
    },{
        type : 'normal',
        text : '取消',
        handler : function(button,dialog) {
            dialog.close();
        }
    });
    return dialog;
}

