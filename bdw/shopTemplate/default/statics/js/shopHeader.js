$(function () {
    $.ajaxSetup({cache: false });
    $("#buycart-main").load(Top_Path.webRoot+"/ajaxload/cartSideBar.ac");
    showLoginId();//获取用户名

    $(".sideBarUserClose").click(function () {
        $(this).parent().parent().parent().css("display", "none");
    });
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
            $("#collect-main").hide();
            $("#buycart-main").hide();
            $("#feedback-main").hide();
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
            var index = $(this).index();
            var dd_mbar = $(this).parent().parent().find(".dd-mbar");
            $(this).addClass("active").siblings().removeClass("active").siblings(".icon-b").css("margin-left", "0px");
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

    showLoginId();//获取用户名

    $(".tab").click(function () {
        $(this).siblings(".item_popup").toggle();
        $(this).siblings(".item_popup2").toggle();
    });

    /*搜索*/
    $("#searchFields").focus(function () {
        var searchFields = $(this).val();
        if ("请输入搜索关键字" == searchFields) {
            $(this).val("");
        }
    });

    $(".searchAction").click(function () {
        var rel = $(this).attr("rel");
        var fields = $("#searchFields").val();
        if (fields == null || fields == "" || "请输入搜索关键字" == fields) {
            alertDialogInShop("请输入搜索关键字");
        } else {
            if ("global" == rel) {
                $("#searchForm").submit();
            }else{
                var searchFields = $("#searchFields").val();
                $("#searchFields2").val(searchFields);
                $("#shopId").val(paramData1.shopId);
                $("#searchShopForm").submit();
            }

        }
    });

    /*搜索*/
    $("#keyword").focus(function () {
        var searchFields = $(this).val();
        if ("请输入搜索关键字" == searchFields) {
            $(this).val("");
        }
    });

    $(".keywordSearch").click(function () {
        var reg = new RegExp("\d{1,9}(\.\d{0,2}|)");
        var keyword = $("#keyword").val();
        var minPrice = $("#minPrice").val();
        var maxPrice = $("#maxPrice").val();
        if (keyword == null || minPrice == null || maxPrice == null || keyword == "" || minPrice == "" || maxPrice == "") {
            alertDialogInShop("请完善搜索条件!");
            return;
        }
        if (reg.test(minPrice)||reg.test(maxPrice)) {
            alertDialogInShop("请输入正确的价格!");
            return;
        }
        if ( parseFloat(minPrice)>parseFloat(maxPrice)) {
            alertDialogInShop("价格区间应从小到大!");
            return;
        }
        $("#searchShopFormLeft").submit();
    });


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
});

var collectCount1=paramData1.shopCollectCount;
/*收藏店铺*/
function CollectShop(obj){
    if (obj == '' || obj == undefined) {
        return;
    }
    $.get(paramData1.webRoot + "/member/collectionShop.json?shopId=" + obj, function (data) {
        if (data.success == false) {
            if (data.errorCode == "errors.login.noexist") {
                showUserLoginLayerInShop();

            }
            //if (data.errorCode == "errors.collection.has") {
            //    $(".shopCollectLayer .showTip .succe h3").html("您已经收藏了此店铺！");
            //    easyDialog.open({
            //        container: 'shopCollectLayer',
            //        fixed: true
            //    });
            //    //$(".shopCollectLayer").show();
            //
            //}
        } else if (data.success == true) {
            var collectCount;
            if (paramData1.shopCollectCount == '' || paramData1.shopCollectCount == undefined) {
                collectCount = 1
            } else {
                if(data.isCancel == true){
                    $("#shopCollect").removeClass("cur");
                    collectCount1 = parseInt(collectCount1) - 1;
                    $("#shopCollectCount").html(collectCount1);
                    $(".shopCollectLayer .showTip .succe h3").html("店铺已取消收藏！");
                    easyDialog.open({
                        container: 'shopCollectLayer',
                        fixed: true
                    });
                } else{
                    $("#shopCollect").addClass("cur");
                    collectCount1 = parseInt(collectCount1) + 1;
                    $("#shopCollectCount").html(collectCount1);
                    $(".shopCollectLayer .showTip .succe h3").html("店铺已成功收藏！");
                    easyDialog.open({
                        container: 'shopCollectLayer',
                        fixed: true
                    });
                }
            }
            //$("#shopCollectCount").html(collectCount);
            //$("#shopCollect").addClass("cur");
            //$("#shopCollectLayer .showTip .succe h3").html("店铺已成功收藏！");
            //
            ////$(".shopCollectLayer").show();

        }
    });
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
                alertDialogInShop(result.errorObject.errorText);
            }
        }
    });
};


//登录提示框
function showUserLoginLayerInShop(){
    var dialog = jDialog.confirm('您还没有登录',{
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

function closeShopLayer(){
    easyDialog.close();
}


//最普通最常用的alert对话框，默认携带一个确认按钮
var alertDialogInShop = function(dialogTxt){
    var dialog = jDialog.alert(dialogTxt);
};
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