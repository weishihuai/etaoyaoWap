/**
 * Created by Arthur Tsang on 2014/12/25 0025.
 */

$(document).ready(function(){

    $(".moreBtn").click(function () {
        if ($(this).attr("data-onoff") == "true") {
            $(this).html("收起<em></em>")
                .attr("data-onoff","false")
                .find("em")
                .css("transform","rotate(180deg)")
                .end();
            $(this).parent().find(".dd").css("height","auto");

        }
        else {
            $(this).html("更多<em></em>")
                .attr("data-onoff","true")
                .find("em")
                .css("transform","rotate(0deg)")
                .end();
            $(this).parent().find(".dd").css("height","30px");
        }});


    /* 筛选类目 */
    (function(){
        var screen_class = $(".screen-class");
        var more_btn = screen_class.find(".more-btn");
        var brand_letter = screen_class.find(".brand-letter");
        var dd_li = screen_class.find(".brand-letter-dd li");
        var multiselect_btn = screen_class.find(".multiselect-btn");
        var cancel = screen_class.find(".cancel");

       /* more_btn.on("click", function(){
            if ($(this).attr("data-onoff") == "true") {
                $(this).html("收起<em></em>")
                    .attr("data-onoff","false")
                    .find("em")
                    .css("transform","rotate(180deg)")
                    .end()
                    .siblings(".brand-letter")
                    .show()
                    .siblings(".brand-letter-dd")
                    .css({"height": 110,"overflow-y": "auto"});
            }
            else {
                $(this).html("更多<em></em>")
                    .attr("data-onoff","true")
                    .find("em")
                    .css("transform","rotate(0deg)")
                    .end()
                    .siblings(".brand-letter")
                    .hide()
                    .siblings(".brand-letter-dd")
                    .css({"height": 56,"overflow-y": "hidden"});

                brand_letter.find("li").eq(0).addClass("cur").siblings().removeClass("cur");
                dd_li.show();
            }

        });*/

        brand_letter.on("mouseenter", "li", function(){
            var Initial = $(this).attr("data-initial");

            $(this).addClass("cur").siblings().removeClass("cur");

            if (Initial == "0") {
                dd_li.show();
            }
            else {
                dd_li.each(function(index,ele){
                    if ($(this).attr("data-initial") == Initial) {
                        $(this).show();
                    }
                    else {
                        $(this).hide();
                    }
                });
            }
        });

        //面包屑多选
        multiselect_btn.click(function () {
            $(this).parent().find(".dd").css("height","auto");
            $(this).hide().siblings(".footer-btn-box").show().siblings(".dd").find(".checkbox-box").show();
            $(this).parent().parent().toggleClass("cur");
            var div = $(this).parent().parent();
            if(div.hasClass("cur")){
                $(this).parent().find(".single").hide();
                $(this).parent().find(".multiple").show();
            }else{
                $(this).parent().find(".single").show();
                $(this).parent().find(".multiple").hide();
            }
        });

        cancel.on("click",function(){
            $(this).parent().parent().find(".dd").css("height","30px");
            $(this).parent().hide().siblings(".multiselect-btn").show().siblings(".dd").find(".checkbox-box").hide();
            var div = $(this).parent().parent();
            div.removeClass("multiple");
            div.find(".single").show();
            div.find(".multiple").hide();
            $(this).parent().parent().parent().removeClass("cur");
        });

    })();


    /* 商品排序 - 搜索框状态切换 */
    (function(){

        var search_inner = $(".product-sort .search-inner");
        var Input = search_inner.find("input");
        Input.on({
            "focus": function(){
                search_inner.removeClass("search-inner2");
            }
            ,
            "blur": function(){
                setTimeout(function(){
                    search_inner.addClass("search-inner2");
                },150);
            }
        });
        search_inner.find(".cancel").on("click",function(){
            Input.val("");
        });

    })();

    $(".collect-btn").click(function () {
        var _this = $(this);
        var productId = _this.attr("productId");
        if (productId == '' || productId == undefined) {
            return;
        }
        $.get(webPath.webRoot + "/member/collectionProduct.json?productId=" + productId, function (data) {

            if (data.success == false) {
                if (data.errorCode == "errors.login.noexist") {
                    showPrdDetailUserLogin();
                }

            } else if (data.success == true) {
                if(data.isCancel == true){
                    _this.removeClass("collect-btn-hove");
                } else{
                    _this.addClass("collect-btn-hove");

                }

            }
        });
    });

    $("#confirmBtn").click(function () {
        var value = $("#searchKeyword").val();
        if ($.trim(value) == "") {
            showErrorWin("请输入搜索关键字");
            return false;
        }
        setTimeout(function () {
            window.location.href = paramData.webRoot + "/productlist.html?" +
                "&category=" + paramData.category +
                "&q=" + paramData.q +
                "&isInStore="+ paramData.isInStore +
                "&keyword=" + value;
        }, 1);
    });

    /* 商品排序 - 价格输入框|搜索框 状态切换 */
    (function(){

        Toggle_status($(".product-sort .price-range-inner"),"price-range-inner2");
        Toggle_status($(".product-sort .search-inner"),"search-inner2");

        function Toggle_status(Node,Class){
            Node.on("click",function(event){
                event.stopPropagation();
            });
            var Input = Node.find("input");

            Input.on({
                "focus": function(){
                    Node.removeClass(Class);
                }
            });

            $(document).on("click",function(){
                Node.addClass(Class);
            });

            Node.find(".empty").on("click",function(){
                Input.val("");
            });

            Node.find(".cancel").on("click",function(){
                Node.addClass(Class);
            });
        }

    })();


    $("#isInStore").click(function () {
        var value = $(this).find("em").attr("data-checked");
        if(value != "true"){
            value = "Y"
        }else {
            value = "N"
        };
            setTimeout(function () {
                window.location.href = paramData.webRoot + "/productlist.html?" +
                    "&category=" + paramData.category +
                    "&q=" + paramData.q +
                    "&isInStore="+ value +
                    "&keyword=" + paramData.keyword;
            }, 1);

    });
    $(".multiSelect").click(function () {
        var a = $(this);
        var em = $(this).parent().find("em");
        if(a.hasClass("cur")){
            a.removeClass("cur");
            em.attr("data-checked","");
        }else{
            a.addClass("cur");
            em.attr("data-checked","true");
        }
    });


    $(".productCur").mouseover(function(){
        $(this).addClass("cur");
    });
    $(".productCur").mouseout(function(){
        $(this).removeClass("cur");
    });

    clearAbove();
    if(paramData.startPrice !=null && paramData.startPrice !=""&& paramData.startPrice !="NaN"){
        $("#minSearchPrice").val(paramData.startPrice);
    }
    if(paramData.endPrice !=null && paramData.endPrice !="" && paramData.endPrice !="NaN"){
        $("#maxSearchPrice").val(paramData.endPrice);
    }

    //显示商品价格筛选框
    $("#selectPrice").hover(function () {
        $("#xz_btn").show();
    }, function () {
        $("#xz_btn").hide();
    });
    //显示商品价格筛选框



    $(".prdNumber").change(function () {
        var value = $(this).val();
        var reg = new RegExp("^[1-9]\\d*$");
        if (!reg.test(value)) {
            $(this).val(1);
            return;
        }
        $(this).parent().parent().find('.addCartBtn').attr('num',value);
    });

    /*上一页和下一页事件 start*/
    $("#pageUp").click(function () {
        //checkPage();
        if (paramData.page == 1) {
            alert("当前已是第一页");
            return;
        }
        var page = parseInt(paramData.page) - 1;
        window.location.href=paramData.webRoot+"/productlist.ac?category="+paramData.category+"&q="+paramData.q+"&keyword="+paramData.keyword+"&order="+paramData.order+"&page="+page;
    });

    $("#pageDown").click(function () {
        //checkPage();
        if (paramData.page == paramData.totalCount) {
            alert("当前已是最后一页");
            return;
        }
        var page = parseInt(paramData.page) + 1;
        window.location.href=paramData.webRoot+"/productlist.ac?category="+paramData.category+"&q="+paramData.q+  "&isInStore="+ paramData.isInStore +"&keyword="+paramData.keyword+"&order="+paramData.order+"&page="+page
    });
    /*上一页和下一页事件 end*/

    /*加入购物车 start*/
    $(".addCartBtn").click(function () {
        var addbtn = $(this);
        var skuId = $(this).attr("skuid");
        var num = $(this).attr("num");
        var carttype = $(this).attr("carttype");
        var handler = $(this).attr("handler");
        var isNormal = $(this).attr("isNormal");
        var srcUrl = $(this).attr("srcUrl");

        if(skuId==""){
            alert("请选择商品规格");
            return;
        }
        if(num==""){
            alert("请填写购买数量");
            return;
        }
        var numCheck=/^[0-9]*$/;
        if(!numCheck.test(num)){
            alert("请填写数字");
            return;
        }
        $.ajax({
            url: paramData.webRoot + "/cart/add.json",
            data: {type: carttype, objectId: skuId, quantity: num, handler: handler},
            dataType: "json",
            success: function (data) {
                if (data.success == "true") {
                    var shoppingcart = data.shoppingCartVo;
                    var allCartNum = data.allCartNum;
                    /*alert(allCartNum);*/
                    var cartNum = allCartNum;
                    var allProductAmount = data.allProductTotalAmount;
                    /* for (var i = 0; i < shoppingcart.items.length; i++) {
                     cartNum = cartNum + shoppingcart.items[i].quantity;
                     }*/
                    var cartLayer;
                    var showId;
                    if(isNormal == "Y"){
                        cartLayer = $("#addToBuyListLayer");
                        showId = 'addToBuyListLayer';
                    }else {
                        cartLayer = $("#addToBuyCarLayer");
                        showId = 'addToBuyCarLayer';
                    }
                    if(carttype == "normal"){
                        $("#buycart-main").load(Top_Path.webRoot+"/ajaxload/cartSideBar.ac",function () {
                            $("#normalSidebar").load(Top_Path.webRoot+"/ajaxload/normalcartSideBar.ac",function(){cartBarReadyFn("#normalSidebar")})
                        });
                    }else {
                        $("#buycart-main").load(Top_Path.webRoot+"/ajaxload/cartSideBar.ac",function () {
                            loadRightCartSideBar();
                        });
                    }
                    moveBoxToCart(".sku"+skuId ,srcUrl);
                    cartLayer.find(".cartnum").html(allCartNum);
                    $("#top_myCart_cartNum").html(allCartNum);
                    cartLayer.find(".cartprice").html(allProductAmount);
                    $("#top_myCart_cartNum2").html(cartNum);
                    $("#cartTotalPrice").html(allProductAmount);

                    /*easyDialog.open({
                        container: showId,
                        fixed: false
                    });*/
                } else {
                    var dialog = jDialog.confirm('您还没有登录',{
                        type : 'highlight',
                        text : '登录',
                        handler : function(button,dialog) {
                            dialog.close();
                            window.location.href = paramData.webRoot + "/login.ac";
                        }
                    },{
                        type : 'normal',
                        text : '取消',
                        handler : function(button,dialog) {
                           dialog.close();
                        }

                    });
                }
            },
            error: function (XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alert(result.errorObject.errorText);
                }
            }
        });

    });
    /*加入购物车 end*/

});

function adapt(Obj){
    var img = new Image();
    img.src = $(Obj).attr("src");
    var imgHeight = img.height;
    if(imgHeight < 200){
        var temp = (200-imgHeight)/2;
        $(Obj).css("margin-top",temp+"px");
    }
}
function addProductNm(Obj){
    var prd_num_object = $(Obj).parents(".n_box").find('.prdNumber');
    var number = parseInt(prd_num_object.val());
    number = number + 1;
    prd_num_object.val(number);
    $(Obj).parents(".b_info").find('.addCartBtn').attr("num",number);
}

function minusProductNm(Obj) {
    var prd_num_object = $(Obj).parents(".n_box").find('.prdNumber');
    var number = parseInt(prd_num_object.val());
    if (number <= 1) {
        prd_num_object.val(1);
        $(Obj).parents(".b_info").find('.addCartBtn').attr("num",number);
    } else {
        number = number - 1;
        prd_num_object.val(number);
        $(Obj).parents(".b_info").find('.addCartBtn').attr("num",number);
    }
}

//清空商品的cookie
function clearHistoryProductsCookie(){
    $.get(paramData.webRoot+"/member/clearProductsCookie.json",function(data){
        window.location.reload();
    });
}
function chageSortByPrice(obj) {
    var sort = paramData.sort;
    if(sort==null||sort=="up"||sort=="") {
        window.location.href = paramData.webRoot+"/productlist.ac?category="+paramData.category+"&q="+paramData.q+  "&isInStore="+ paramData.isInStore +"&keyword="+paramData.keyword+"&order=minPrice,desc"+"&page="+paramData.page+"&sort=down"+"&startPrice="+paramData.startPrice+"&endPrice="+paramData.endPrice;
    } else {
        window.location.href =paramData.webRoot+"/productlist.ac?category="+paramData.category+"&q="+paramData.q+  "&isInStore="+ paramData.isInStore +"&keyword="+paramData.keyword+"&order=minPrice,asc"+"&page="+paramData.page+"&sort=up"+"&startPrice="+paramData.startPrice+"&endPrice="+paramData.endPrice;
    }
}

function chageSortBySaleVolumn(obj) {
    var sort = paramData.sort;
    if(sort==null||sort=="up"||sort=="") {
        window.location.href = paramData.webRoot+"/productlist.ac?category="+paramData.category+"&q="+paramData.q+  "&isInStore="+ paramData.isInStore +"&keyword="+paramData.keyword+"&order=salesVolume,desc"+"&page="+paramData.page+"&sort=down"+"&startPrice="+paramData.startPrice+"&endPrice="+paramData.endPrice;
    } else {
        window.location.href =paramData.webRoot+"/productlist.ac?category="+paramData.category+"&q="+paramData.q+  "&isInStore="+ paramData.isInStore +"&keyword="+paramData.keyword+"&order=salesVolume,asc"+"&page="+paramData.page+"&sort=up"+"&startPrice="+paramData.startPrice+"&endPrice="+paramData.endPrice;
    }
}

function chageSortByPrice2(obj) {
    var sort = paramData.sort;
    if(sort==null||sort=="up"||sort=="") {
        window.location.href = paramData.webRoot+"/productlist.ac?q="+paramData.q+"&keyword="+paramData.keyword+  "&isInStore="+ paramData.isInStore +"&order=minPrice,desc"+"&page="+paramData.page+"&sort=down"+"&startPrice="+paramData.startPrice+"&endPrice="+paramData.endPrice;
    } else {
        window.location.href =paramData.webRoot+"/productlist.ac?q="+paramData.q+"&keyword="+paramData.keyword+  "&isInStore="+ paramData.isInStore +"&order=minPrice,asc"+"&page="+paramData.page+"&sort=up"+"&startPrice="+paramData.startPrice+"&endPrice="+paramData.endPrice;
    }
}

function showBelow(){
    $("#xz_btn").show();
}

function clearAbove(){
    $("#minSearchPrice").val("");
    $("#maxSearchPrice").val("");
}

function makeSureThePriceRange(){
    var reg = /^[0-9]*$/;
    var minPrice = $("#minSearchPrice").val();
    var maxPrice = $("#maxSearchPrice").val();
    if((minPrice == null || minPrice == "") && (maxPrice == null || maxPrice == "")){
        window.location.href =paramData.webRoot+"/productlist.ac?category="+paramData.category+"&q="+paramData.q+  "&isInStore="+ paramData.isInStore +"&keyword="+paramData.keyword+"&order="+paramData.order+"&page="+paramData.page+"&sort="+paramData.sort;
        return;
    }
    if(!reg.test(minPrice) || !reg.test(maxPrice)){
        alert("请输入大于等于0的整数！");
    }
    if((minPrice == null || minPrice == "") && (maxPrice != null && maxPrice != "")){
        window.location.href =paramData.webRoot+"/productlist.ac?category="+paramData.category+"&q="+paramData.q+  "&isInStore="+ paramData.isInStore +"&keyword="+paramData.keyword+"&order="+paramData.order+"&page="+paramData.page+"&sort="+paramData.sort+"&startPrice='"+"&endPrice="+maxPrice;
    }
    if((minPrice != null && minPrice != "") && (maxPrice == null || maxPrice == "")){
        window.location.href =paramData.webRoot+"/productlist.ac?category="+paramData.category+"&q="+paramData.q+  "&isInStore="+ paramData.isInStore +"&keyword="+paramData.keyword+"&order="+paramData.order+"&page="+paramData.page+"&sort="+paramData.sort+"&startPrice="+minPrice+"&endPrice='";
    }
    var min = parseInt(minPrice);
    var max = parseInt(maxPrice);
    if(max < min){
        var temp = max;
        max = min;
        min =temp;
    }
    window.location.href =paramData.webRoot+"/productlist.ac?category="+paramData.category+"&isInStore="+ paramData.isInStore +"&q="+paramData.q+"&keyword="+paramData.keyword+"&order="+paramData.order+"&page="+paramData.page+"&sort="+paramData.sort+"&startPrice="+min+"&endPrice="+max;
}

function makeSureThePriceRange2(){
    var reg = /^[0-9]*$/;
    var minPrice = $("#minSearchPrice").val();
    var maxPrice = $("#maxSearchPrice").val();
    if((minPrice == null || minPrice == "") && (maxPrice == null || maxPrice == "")){
        window.location.href =paramData.webRoot+"/productlist.ac?q="+paramData.q+"&keyword="+paramData.keyword+  "&isInStore="+ paramData.isInStore +"&order="+paramData.order+"&page="+paramData.page+"&sort="+paramData.sort;
        return;
    }
    if(!reg.test(minPrice) || !reg.test(maxPrice)){
        alert("请输入大于等于0的整数！");
    }
    if((minPrice == null || minPrice == "") && (maxPrice != null && maxPrice != "")){
        window.location.href =paramData.webRoot+"/productlist.ac?q="+paramData.q+"&keyword="+paramData.keyword+  "&isInStore="+ paramData.isInStore +"&order="+paramData.order+"&page="+paramData.page+"&sort="+paramData.sort+"&startPrice='"+"&endPrice="+maxPrice;
    }
    if((minPrice != null && minPrice != "") && (maxPrice == null || maxPrice == "")){
        window.location.href =paramData.webRoot+"/productlist.ac?q="+paramData.q+"&keyword="+paramData.keyword+  "&isInStore="+ paramData.isInStore +"&order="+paramData.order+"&page="+paramData.page+"&sort="+paramData.sort+"&startPrice="+minPrice+"&endPrice='";
    }
    var min = parseInt(minPrice);
    var max = parseInt(maxPrice);
    if(max < min){
        var temp = max;
        max = min;
        min =temp;
    }
    window.location.href =paramData.webRoot+"/productlist.ac?q="+paramData.q+"&keyword="+paramData.keyword+"&order="+paramData.order+"&page="+paramData.page+"&sort="+paramData.sort+"&startPrice="+min+"&endPrice="+max;
}

function checkTheValue(Obj){
    var num = $(Obj).val();
    var reg = /^[0-9]*$/;

    if(!reg.test(num) ){
        setTimeout(function(){ $(Obj).val("");},300);
    }
    if( num.length > 6){
        var temp = num.substring(0,6);
        $(Obj).val(temp);
    }
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





function multipleConfirm(obj){
    var str = "";
    var field = $(obj).parent().parent().find(".dd").find(".cur").attr("field");
    $(obj).parent().parent().find(".dd").find(".cur").each(function(){
        str += $(this).attr("title")+",";
    });
    if (str.length > 0) {
        str = str.substring(0, str.length - 1);
    }

    var q = paramData.q;
    if (q != "") {
        var isAdd = false;
        var obj = q.split(";");
        for (var i = 0; i < obj.length; i++) {
            var subObj = obj[i].split(":");
            if(field==subObj[0]){
                m.put(subObj[0], str);
                isAdd = true;
            }
        }
        if(!isAdd){
            q = q+";"+field+":"+str;
        }
    }else{
        q = field+":"+str;
    }

    window.location.href = paramData.webRoot + "/productlist.ac?category=" + paramData.category + "&q=" + q + "&keyword=" + paramData.keyword +   "&isInStore="+ paramData.isInStore + "&order=" + paramData.order ;

}
