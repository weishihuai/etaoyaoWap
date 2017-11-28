$(function () {

	$(".disComment").click(function(){
		$("#toggleTab a").removeClass("cur");
		$(".comment").addClass("cur");

	});

	/*最近浏览-置顶*/
	var recentlyH = $("#topMenu").offset().top;
	var recentlyW = $("#topMenu").offset().left;

	/*商家位置等-导航条置顶*/
	var navH = $("#toggleTab").offset().top;
	var subNav_scroll = function(target){
		$("#toggleTab a").removeClass("cur");
		target.addClass("cur");

	};
	//点击选中
	$("#toggleTab a").click(function(){
		$("#toggleTab a").removeClass("cur");
		subNav_scroll($(this));

	});

	$(window).scroll(function(){

		//获取滚动条的滑动距离
		var scroH = $(this).scrollTop()+5;

		//最近浏览
		if(scroH>=recentlyH){
			$("#topMenu").css({"position":"fixed","top":0,"left":recentlyW});
		}else if(scroH<recentlyH){
			$("#topMenu").css({"position":"static"});
		}

		//商家位置等-导航条
		var address = $("#address").offset().top + $("#address").height();
		var buy = $("#buy").offset().top + $("#buy").height();
		var prodt = $("#productDetail").offset().top + $("#productDetail").height();
		var shop = $("#introduce").offset().top + $(".shopName").height() + $(".productDescr").height();
		var comment = $("#comment").offset().top + $("#comment").height();
		var footerTop = $(".footer").offset().top;
		if ( scroH>= navH){
			$("#toggleTab").css({"position":"fixed","top":0});
			if(scroH < address){
				subNav_scroll($(".address"));
			}else if(scroH >= address && scroH < buy){
				subNav_scroll($(".buy"));
			}else if(scroH > buy && scroH < prodt){
				subNav_scroll($(".productDetail"));
			}else if(scroH > prodt && scroH < shop){
				subNav_scroll($(".introduce"));
			}else if(scroH > shop && scroH < footerTop){
				subNav_scroll($(".comment"));
			}
		}else{
			$("#toggleTab").css({"position":"static"});
		}
	});

	//鼠标放在商品小图上自动显示大图
	$("#mycarousel").find("a").hover(function () {
		$("#mycarousel a").removeClass("cur");
		$(this).addClass("cur");
		$(this).click();
	}, function () {

	});

	//鼠标放在商品小图上自动显示大图
	$(".productImgClass").click(function () {
		var imgUrl = $(this).attr("bigImgData");
		$("#bigsrc").attr("src", imgUrl);
	});

	//购买按钮事件
	$("#buyBtn").click(function () {

		if (webPath.userId == '' || webPath.userId == undefined) {
			var unLogin = layer.alert('您尚未登陆，请登陆!',3,function(){
				layer.close(unLogin);
				goToUrl(webPath.webRoot + "/login.ac");
			});
		}
		else if(webPath.userMobile == '' || webPath.userMobile == undefined){
			var noMobile = layer.alert('您尚未绑定手机号，请先绑定手机号!',3,function(){
				layer.close(noMobile);
				goToUrl(webPath.webRoot + "/module/member/myInformation.ac?fromOtoo=1");
			});
		}
		else {
			var otooQuantity = $(".prd_num").val();
			goToUrl(webPath.webRoot + "/otoo/otooorderadd.ac?otooProductId=" + webPath.productId + "&otooQuantity=" + otooQuantity);
		}
	});


	$("#showFullBaiduMapBtn").click(function () {
		normalDiv = $.layer({
			shade: [0.5, '#000', true],//0.5：遮罩透明度，'#000'：遮罩颜色，true：是否遮罩（否：false）
			type: 1,//0：信息框（默认），1：页面层，2：iframe层，3：加载层，4：tips层。
			area: ['auto', 'auto'],//显示区域控制,前面参数是宽,后面是高,(area: ['600px', '360px'])
			shadeClose: true,//当鼠标点击遮罩层外,true关闭遮罩层
			title: false,//不显示默认标题栏
			closeBtn: true,//是否显示关闭按钮
			offset: ['10%', '15%'],//弹出框与浏览器边框的距离(offset=偏移量),里面可以写30px,也可以写auto,也可以不写,也可以写百分比
			fix: true,//弹出层是否可以跟随
			border: [10, 0.3, '#000', true],//10：边框大小，0.3：边框透明度，'#000'：边框颜色，true：是否显示边框（否：false）。不显示边框则设置border:[0]
			fadeIn: 300,//以渐渐显示的方式弹出,单位是毫秒
			page: {dom: '#allmapFullDiv'}
		});
	});

	//购买数量增加事件
	$(".prd_addNum").click(function () {
		var productNum = $(".prd_num");
		var value = productNum.val();
		var num = parseInt(value) + 1;
		productNum.val(num);
	});

	//购买数量减少事件
	$(".prd_subNum").click(function () {
		var productNum = $(".prd_num");
		var value = productNum.val();
		var num = parseInt(value) - 1;
		if (num == 0) {
			return;
		}
		productNum.val(num);
	});

    //购买数量输入框，输入
    $(".prd_num").change(function () {
        var value = $(this).val();
        var reg = new RegExp("^[1-9]\\d*$");
        if (!reg.test(value)) {
            $(this).val(1);

        }
    });


});

var collectLayer;
//清空商品的cookie
function clearHistoryProductsCookie(){
	$.get(webPath.webRoot+"/member/clearProductsCookie.json",function(data){
		window.location.reload();
	});
}

//收藏O2O商品
function collectOtooProduct(){
	if (webPath.productId == '' || webPath.productId == undefined) {
	 	return;
	}
	 $.get(webPath.webRoot + "/member/collectionOtooProduct.json?otooProductId=" + webPath.productId, function (data) {
	 	if (data.success == false) {
	 		if (data.errorCode == "errors.login.noexist") {
				var unLogin = layer.alert('您尚未登陆，请登陆!',3,function(){
					layer.close(unLogin);
					goToUrl(webPath.webRoot + "/login.ac");

				});
	 			return;
	 		}
	 		if (data.errorCode == "errors.collection.has") {
				collectProductLayer("您已经收藏了此商品！");

	 		}
	 	} else if (data.success == true) {
			collectProductLayer("商品已成功收藏！");

		}
	 });
}
/*O2O商品弹出层*/
function collectProductLayer(message) {
	collectLayer = $.layer({
		type: 1,
		area: ['auto', 'auto'],
		title: false,
		move: false,
		border: [1],
		offset: ['300px', '600px'],//纵坐标、横坐标
		shadeClose: false,
		page: {dom: '#collectProduct'},
		bgcolor: "none"
	});
	$(".AddTomyLikeLayer .showTip .succe h3").html(message);
	return collectLayer;
}

//关闭所有层
function hideLayer() {
	layer.closeAll();
}



