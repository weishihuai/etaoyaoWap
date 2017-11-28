(function ($) {
	$(document).ready(function () {
		$.ajaxSetup({cache: false });
		$("#buycart-main").load(Top_Path.webRoot+"/ajaxload/cartSideBar.ac");
		showLoginId();//获取用户名

		/* 侧边栏 */
		(function(){

			var sidebar = $(".sidebar");
			var sidebar_dt = sidebar.find(".dt");
			var sidebar_dd = sidebar.find(".dd");
			var sidebar_icon_lx = sidebar.find(".icon-lx");
			var sidebar_back = sidebar.find(".sidebar-back");


			$(".sidebar .title").live("click",function(){
				$("#buycart-main").hide();
				$("#feedback-main").hide();
				$("#buycart-feedback").hide();
				$("#collect-main").hide();
				$("#sidebar-cart").removeClass("cur").attr("data-onoff", "true");
				$("#sidebar-collect").removeClass("cur").attr("data-onoff", "true");
				$("#sidebar-feedback").removeClass("cur").attr("data-onoff", "true");
			});

			$("#sidebar-user").click(function(){
				$("#buycart-main").hide();
				$("#feedback-main").hide();
				$("#collect-main").hide();
				$("#buycart-feedback").hide();
				if($(this).attr("isLogin") == "N"){
					$('.login-fixed').css("display","block");
				}
				if ($(this).attr("data-onoff") == "true" && $(this).attr("isLogin") == "Y" ) {
					sidebar_dd.hide();
					sidebar_icon_lx.hide();
					sidebar_dt.removeClass("cur").attr("data-onoff", "true");
					$(this).addClass("cur").siblings(".dd").show().siblings(".icon-lx").show().end().end().attr("data-onoff", "false");
				}
				else {
					$(this).removeClass("cur").siblings(".dd").hide().siblings(".icon-lx").hide().end().end().attr("data-onoff", "true");
				}
			});

			$("#sidebar-cart").click(function(){
				if($(this).attr("isLogin") == "N"){
					$('.login-fixed').css("display","block");
					return;
				}
				$("#buycart-main").show();
				$("#collect-main").hide();
				$("#feedback-main").hide();
				sidebar_dd.hide();
				sidebar_icon_lx.hide();
				var _this = $(this);
				$("#buycart-main").load(Top_Path.webRoot+"/ajaxload/cartSideBar.ac",function(){
					if (_this.attr("data-onoff") == "true" ) {
						sidebar_dt.removeClass("cur").attr("data-onoff", "true");
						_this.addClass("cur");
						_this.attr("data-onoff", "false");
						$("#normalSidebar").load(Top_Path.webRoot+"/ajaxload/normalcartSideBar.ac",function () {
							cartBarReadyFn("#normalSidebar");
						});
						/*$("#drugSidebar").load(Top_Path.webRoot+"/ajaxload/drugCartSideBar.ac");*/
					} else {
						$("#buycart-main").hide();
						_this.removeClass("cur").attr("data-onoff", "true");
					}
				});


			 });

			$("#sidebar-collect").click(function(){
				if($(this).attr("isLogin") == "N"){
					$('.login-fixed').css("display","block");
					return;
				}
				$("#feedback-main").hide();
				$("#buycart-main").hide();
				$("#collect-main").show();
				sidebar_dd.hide();
				sidebar_icon_lx.hide();
				var _this = $(this);
				$("#collect-main").load(Top_Path.webRoot+"/ajaxload/collectSideBar.ac",function(){
					if (_this.attr("data-onoff") == "true" ) {
						sidebar_dt.removeClass("cur").attr("data-onoff", "true");
						_this.addClass("cur");
						_this.attr("data-onoff", "false");
					} else {
						$("#collect-main").hide();
						_this.removeClass("cur").attr("data-onoff", "true");
					}
				});
			});

			$("#sidebar-feedback").click(function(){
				if($(this).attr("isLogin") == "N"){
					$('.login-fixed').css("display","block");
					return;
				}
				$("#buycart-main").hide();
				$("#collect-main").hide();
				$("#feedback-main").show();
				sidebar_dd.hide();
				sidebar_icon_lx.hide();
				var _this = $(this);
				$("#feedback-main").load(Top_Path.webRoot+"/ajaxload/feedbackSideBar.ac",function(){
					if (_this.attr("data-onoff") == "true" ) {
						sidebar_dt.removeClass("cur").attr("data-onoff", "true");
						_this.addClass("cur");
						_this.attr("data-onoff", "false");
					} else {
						$("#feedback-main").hide();
						_this.removeClass("cur").attr("data-onoff", "true");
					}
				});
			});

			$(".cart-reservation > p").live("click",function(){
				var index = $(this).index();

				var dd_mbar = $(this).parent().parent().find(".dd-mbar");
				$(this).addClass("active").siblings().removeClass("active").siblings(".icon-b").css("margin-left", "0px");
				$(this).addClass("active").siblings().removeClass("active").siblings(".icon-b").css("left", index*140 + "px");
				dd_mbar.stop().hide().eq(index).show();
				if(index != 1){
					$("#buycart-main").load(Top_Path.webRoot+"/ajaxload/cartSideBar.ac",function () {
						$("#normalSidebar").load(Top_Path.webRoot+"/ajaxload/normalcartSideBar.ac",function(){cartBarReadyFn("#normalSidebar")})
					});
				}else {
					$("#buycart-main").load(Top_Path.webRoot+"/ajaxload/cartSideBar.ac",function () {
						loadRightCartSideBar();
					});
				}


			});

			$(".merchandise-shop > p").live("click",function(){
				$(this).addClass("active").siblings().removeClass("active").siblings(".icon-b").css("margin-left", "0px");
				var index = $(this).index();
				var dd_mbar = $(this).parent().parent().find(".dd-mbar");
				$(this).addClass("active").siblings().removeClass("active").siblings(".icon-b").css("left", index*140 + "px");
				dd_mbar.stop().hide().eq(index).show();
			});

			$(".ly-jy-ts > p").live("click",function(){
				var index = $(this).index();
				var dd_mbar = $(this).parent().parent().find(".dd-mbar");
				$(this).addClass("active").siblings().removeClass("active").siblings(".icon-b").css("left", index*92 + "px");
				dd_mbar.stop().hide().eq(index).show();
			});

			sidebar_back.live("click",function(){
				$("html,body").stop().animate({"scrollTop": 0}, 300, "swing", function(){
					sidebar_back.find(".dt").removeClass("cur");
				});
			});
		})();




		if (Top_Path.topParam == "index" || Top_Path.topParam == "list" || Top_Path.topParam == "detail"|| Top_Path.topParam == "channel") {
			if (window.screen.width < 1200) {
				$("body").removeClass("q");
			} else {
			}
		} else {
			$("body").addClass("q");
		}

		if(Top_Path.topParam != "index"){
			$(".dc-inner").hide();
		}

		var searchField = top_searchField;
		$(".shop_s").click(function () {
			$(".shop_s").removeClass("cur");
			$(this).addClass("cur");
			if ($(this).attr("id") == "product") {
				$("#productSearch").show();
				$("#shopSearch").hide();
			}
			if ($(this).attr("id") == "shop") {
				$("#shopSearch").show();
				$("#productSearch").hide();
			}
		});
		if (searchField != "" && searchField != null) {
			$(".shop_s").removeClass("cur");
			$("#shop").addClass("cur");
			$("#productSearch").hide();
			$("#shopSearch").show();
		}


		var keyword = Top_Path.keyword;
		if (keyword != null) {
			$("#searchFields").attr("value", keyword);
		}

		$(".myAcunnt").hover(function () {
			$(this).addClass("cur");
			$(this).find(".item_popup").show();
		}, function () {
			$(this).removeClass("cur");
			$(this).find(".item_popup").hide();
		});


		$(".wechatQr").hover(function () {
			$(this).addClass("cur2");
			$(this).find(".item_popup2").show();
		}, function () {
			$(this).removeClass("cur2");
			$(this).find(".item_popup2").hide();
		});

		$(".buy-car").hover(function () {
			$("#Car_info").show();
			$(".buy-car").addClass("cur2");
		}, function () {
			$("#Car_info").hide();
			$(".buy-car").removeClass("cur2");
		});

		if("channel"==Top_Path.topParam){
			$(".ch_all").bgiframe();
			$(".ch_popup").bgiframe();
		}else{
			$(".category").bgiframe();
			$(".dc-inner").bgiframe();
		}


		$(".icondt").find(".icon").each(function () {
			var src = $(this).find("img").attr("src");
			if (src.split("/upload/")[1] == "") {
				$(this).hide();
			}
		});


		$("#myAccount").hover(function () {
			$(this).find(".in").children("a").addClass("cur");
			$(this).find(".myCop").show();

		}, function () {
			$(this).find(".in").children("a").removeClass("cur");
			$(this).find(".myCop").hide();
		});

		$("#myService").hover(function () {
			$(this).find(".in").children("a").addClass("cur");
			$(this).find(".myCop").show();

		}, function () {
			$(this).find(".in").children("a").removeClass("cur");
			$(this).find(".myCop").hide();
		});
		$("#myCart").hover(function () {
			var showlist = $(this).find(".showlist");
			showlist.load(Top_Path.webRoot + "/template/bdw/module/common/cartlayer.jsp?time=" + new Date().getTime(), function () {
				showlist.show();
			});

		}, function () {
			$(this).find(".showlist").hide();
		});
		$(".putArea").find("a").click(function () {
			var searchFields = document.getElementById("searchFields");
			if (searchFields.value == null || searchFields.value == "" || searchFields.value == "请输入关键字") {
				alertDialog("请输入搜索关键字");
				return false;

			}
			var searchForm = document.getElementById("searchForm");
			setTimeout(function () {
				searchForm.submit();
			}, 1);
			return true;
		});

		$(".category").hover(function () {
			$(this).find(".dc-inner").show();
			$(this).find(".dc-inner").find(".p_item").hover(function () {
				$(this).addClass("cur2").show();
				$(this).children(".tem_popup").show();
			}, function () {
				$(this).removeClass("cur2");
				$(this).children(".tem_popup").hide();
			});
		}, function () {
			var rel = $(this).attr("rel");
			if (rel == "index") {
				return true;
			} else {
				$(this).find(".dc-inner").hide();
			}
		});

		//频道页导航
		$(".ch_all").hover(function () {
			$(this).find(".ch_popup").show();
			$(this).find(".ch_popup").find(".p_item").hover(function () {
				$(this).addClass("cur2").show();
				$(this).children(".tem_popup").show();
			}, function () {
				$(this).removeClass("cur2");
				$(this).children(".tem_popup").hide();
			});
		}, function () {

		});

		$(".tal_Acunnt").hover(function () {
			$(".Acunnt_info").show();
			$(".Acunnt_info").hover(function () {
				$(this).show();
			}, function () {
				$(this).hide();
			})
		}, function () {
			$(".Acunnt_info").hide();
		});
		/*    $(".tal_Car").hover(function(){
		 $(".Car_info").show();
		 $(".Car_info").hover(function(){
		 $(this).show();
		 },function(){
		 $(this).hide();
		 })
		 },function(){
		 $(".Car_info").hide();
		 })*/

        if("shop"==Top_Path.topParam){
            if(Top_Path.keyword == null || $.trim(Top_Path.keyword) == undefined || $.trim(Top_Path.keyword) == ""){
            }else{
                $("#searchProductForm").css("display", "none");
                $("#searchShopForm").css("display", "block");
            }
        }

        $("#search-product").click(function () {
            $(".search-sel").children("span:first-child").text($(this).text());
            $("#searchProductForm").css("display", "block");
            $("#searchShopForm").css("display", "none");
        });

        $("#search-shop").click(function () {
            $(".search-sel").children("span:first-child").text($(this).text());
            $("#searchProductForm").css("display", "none");
            $("#searchShopForm").css("display", "block");
        });

		$(".sideBarUserClose").click(function () {
			$(this).parent().parent().parent().css("display", "none");
		});

        /* 导航菜单栏切换 */
        (function(){
            var category = $(".category");
            var item = category.find(".item");
            var item_sub = category.find(".item-sub");

			item.mouseenter(function () {
				var index = $(this).index();
				$(this).addClass("item-cur").siblings().removeClass("item-cur");
				item_sub.eq(index).show().siblings().hide();
			});

			category.mouseleave(function(){
				item.removeClass("item-cur");
				item_sub.hide();
			});
        })();
	});
})(jQuery);


function cartBarReadyFn(obj) {
	var selectItemNum = 0;
	$(obj).find(".updateSelect").each(function(){
		if($(this).attr("data-checked") =="true"){
			selectItemNum += 1;
		}
	});
	if($(obj).find(".updateSelect").length == selectItemNum){
		$(obj).find(".selectAll").attr("data-checked","true");
	}
	$(obj).find(".checkPro").each(function(){
		var oldSelect = "true";
        $(this).parent().parent().parent().find(".updateSelect").each(function () {
			var select = $(this).attr("data-checked");
			if(select == "false"){
				oldSelect = "false";
			}
		});
		$(this).attr("data-checked",oldSelect);
	});
}

//清空商品的cookie
var clearHistoryCookie = function (divId) {
	$.get(Top_Path.webRoot + "/member/clearProductsCookie.json", function (data) {
		$(divId).html("<ul>暂无浏览商品记录</ul>");
	});
};

function showScreen(showScreen, removeScreen) {
	$(showScreen).show();
	$(removeScreen).hide();
}

function toSearchSubmit() {
	setTimeout(function () {
		$("#searchForm").submit();
	}, 1)
}
function toFocus() {
	if($("#searchFields").val()=="请输入搜索关键字"){
		$("#searchFields").attr("value","");
	}
	$("#searchFields").attr("value", $("#searchFields").val());
}

function toShopSearchSubmit() {
	var searchFieldshop = $("#searchFieldshop").val();
	if (searchFieldshop == null || $.trim(searchFieldshop) == "" || $.trim(searchFieldshop) == "请输入搜索关键字") {
		alertDialog("请输入搜索关键字");
		return false;
	}
	setTimeout(function () {
		$("#searchShopForm").submit();
	}, 1)
}

function productSearchSubmit() {
	var searchFields = $("#searchFields").val();
	if (searchFields == null || $.trim(searchFields) == "" || $.trim(searchFields) == "请输入搜索关键字") {
		alertDialog("请输入搜索关键字");
		return false;
	}
	setTimeout(function () {
		$("#searchProductForm").submit();
	}, 1);
	return true;
}

//商品搜索在结果页面的时候保持输入框的内容为搜索关键字
function prdSearchAction() {
	var prdVal = $("#searchShopFields").val();
	$("#searchFields").val(prdVal);
}

//店铺搜索在结果页面的时候保持输入框的内容为搜索关键字
function shopSearchAction() {
	var shopVal = $("#searchFields").val();
	$("#searchShopFields").val(shopVal);
}

//获取用户名
var showLoginId = function () {
	var exitUrl = Top_Path.webUrl + "/member/exit.ac?sysUserId=";
    var timestamp = Date.parse(new Date());
    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
    $.ajax({
        type: "GET",
		url: Top_Path.webRoot+"/pickedup/showLoginId.json?cdntime="+timestamp,
        data: {},
        dataType: "json",
        success: function (data) {
            if (data.success == "true") {
                //alert("成功");
                $('#showUserId').html(
                    '您好，<a href="'+Top_Path.webUrl+'/module/member/index.ac">'+data.login_id+'</a>，欢迎来到'+Top_Path.webName+'[<a href="'+exitUrl+data.user_id+'" title="退出">退出</a>]'
                );
            } else if (data.success == "false") {
                //alert("失败");
                $('#showUserId').html(
                    '您好，欢迎来到'+Top_Path.webName+'！[<a class="cur" href="'+Top_Path.webUrl+'/login.ac" title="登录">登录</a>] [<a class="color" href="'+Top_Path.webUrl+'/register.ac" title="免费注册">免费注册</a>]'
                );
            }
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                alert(result.errorObject.errorText);
            }
        }
    });
};

function searchMenu(categoryId){
	window.open( Top_Path.webRoot + "/productlist-"+categoryId+".html");
}
//-----------------------------------------------------------亚中-----------------------------------------------------
$(function(){
//会员中心
	$("#member_item").hover(function () {
		$(this).addClass("cur");
	}, function () {
		$(this).removeClass("cur");
	});
	//客户服务
	$("#service").hover(function () {
		$(this).addClass("cur");
	}, function () {
		$(this).removeClass("cur");
	});
	//头部二维码1
	$("#top_code").hover(function () {
		$(this).addClass("cur");
		$(this).find(".ewm-box").show();
	}, function () {
		$(this).removeClass("cur");
		$(this).find(".ewm-box").hide();
	});

	//头部二维码2
	$("#top_code2").hover(function () {
		$(this).addClass("cur");
		$(this).find(".ewm-box").show();
	}, function () {
		$(this).removeClass("cur");
		$(this).find(".ewm-box").hide();
	});

	//商品分类
	$(".dc-inner").find(".show").hover(
		function(){
			$(this).find(".dropdown-layer").show();
		},
		function(){
			$(this).find(".dropdown-layer").hide();
		}
	);
});


//没有标题和按钮的提示框
function breadJDialog(content, autoClose, padding, modal){
	var dialog = jDialog.message(content,{
		autoClose : autoClose,    // 3s(3000)后自动关闭
		padding : padding,    // 设置内部padding
		modal: modal         // 非模态，即不显示遮罩层
	});
	return dialog;
}

//登录提示框
function showNetUserLoginLayer(){
	var dialog = jDialog.confirm('<span style="margin-left: 10px">您还没有登录!</span>',{
		type : 'highlight',
		text : '登录',
		handler : function(button,dialog) {
			dialog.close();
			window.location.href = Top_Path.webRoot + "/login.ac";
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

//最普通最常用的alert对话框，默认携带一个确认按钮
var alertDialog = function(dialogTxt){
	var dialog = jDialog.alert(dialogTxt);
};

// 设置窗口对其，方法返回dialog对象本身
//dialog = dialog.middle();


function loadCartSideBar(callBackFun) {
	$.ajaxSetup({cache: false });
	setTimeout(function () {
		$("#normalSidebar").load(Top_Path.webRoot+"/ajaxload/cartSideBar.ac",function (response,status) {
			if (callBackFun){
				callBackFun();
			}
		});
	},0)
}


function loadRightCartSideBar(){

	$("#normalSidebar").hide();
	$("#drugSidebar").show();
	$("#drugSidebar").load(Top_Path.webRoot+"/ajaxload/drugCartSideBar.ac",function(){cartBarReadyFn("#drugSidebar")});
	var _obj = $(".cart-reservation > p")[1];
	$(_obj).addClass("active").siblings().removeClass("active").siblings(".icon-b").css("margin-left", 140 + "px");
}

function messageSidebar(obj) {
    if($(obj).attr("isLogin") == "N"){
        $('.login-fixed').css("display","block");
        return;
    }
    window.location.href =Top_Path.webRoot+"/module/member/mySystemMsg.ac?pitchOnRow=7";
}

var moveBoxToCart = function(obj, ico) {
//加入购物车效果
    if (null != ico || undefined != ico) {
        //首页商品悬浮窗 加入进货单
        $("body").after('<div id="floatOrder" class="pay" style="z-index: 999;border:2px solid #ff6b00; border-radius: 3px;"><img src="' + ico + '" alt="进货" /></div>');
    } else if(null != imgpathData.defaultImage || undefined != imgpathData.defaultImage){
        //商品详情 加入进货单
        $("body").after('<div id="floatOrder" class="pay" style="z-index: 999;border:2px solid #ff6b00; border-radius: 3px;"><img src="' + imgpathData.defaultImage + '" alt="进货" /></div>');
    }else{
        $("body").after('<div id="floatOrder" class="pay"><a class="index_addcart" skuid="6" num="3" carttype="normal" handler="sku" href="javascript:;">进货</a></div>');
    }
    var myBox = $("#floatOrder");
    var divTop = $(obj).offset().top;
    var divLeft = $(obj).offset().left;
    var divWidth = $(obj).width();
    myBox.css({
        "position": "absolute",
        "z-index": "9999",
        "left": divLeft + divWidth/2 + "px",
        "top": divTop + "px"
    });
    myBox.animate({
            "left": ($(".sidebar-cart").offset().left - $(".sidebar-cart").width() ) + "px",
            "top": $(".sidebar-cart").offset().top + 15+ "px",
            "width": "60px",
            "height": "30px"
        },
        600,
        function() {
            myBox.animate({
                "left": $(".sidebar-cart").offset().left + "px",
                "top": $(".sidebar-cart").offset().top + 15 + "px",
                "width": "50px",
                "height": "25px"
            },600).fadeTo(0, 0.1).remove();
        });
};
