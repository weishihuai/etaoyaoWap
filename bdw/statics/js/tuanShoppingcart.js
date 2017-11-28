
$(document).ready(function() {

    //参团时判断用户是否登录
/*
    $("#addGroup").click(function () {

    });
*/

    //添加团购商品
    $("#addGroupCart").click(function () {
        var isLogin = "N";
        $.ajax({
            url: webPath.webRoot + "/cart/canTuan.json",
            type: 'POST',
            async: false,//同步
            success: function (data) {
                if (data.success == "true") {
                    isLogin = "Y";
                } else {
                    layer.confirm('您还没有登录，请先登录!', function () {
                        window.location.href = webPath.webRoot + "/login.ac";
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
        if ( isLogin != "N") {
            var skuId = $(this).attr("skuid");
            var num = $("#num").val();
            var carttype = $(this).attr("carttype");
            var handler = $(this).attr("handler");
            var remainStock = $(this).attr("remainStock");

            if (parseInt(num) == 0) {
                alert("请输入正确的数量");
                $("#num").val(1);
                return;
            }

            if (remainStock == 0) {
                alert("购买的商品库存不足，请重新选择数量");
                return;
            }

          /*  if ($(".specSelect").size() != selectSpecValues.length) {
                alert("请选择商品规格");
                return;
            }*/

            if (remainStock == '' || remainStock == undefined) {
                //单规格商品的时候
                var remainStockValue = $("#remainStock").val();
                if (parseInt(num) > parseInt(remainStockValue)) {
                    alert("购买的商品库存不足，请重新选择数量");
                    return;
                }
            } else {
                //多规格商品的时候
                if (parseInt(num) > parseInt(remainStock)) {
                    alert("购买的商品库存不足，请重新选择数量");
                    return;
                }
            }

            if (skuId == "") {
                alert("请选择商品规格");
                return;
            }
            if (num == "") {
                alert("请填写购买数量");
                return;
            }
            var numCheck = /^[0-9]*$/;
            if (!numCheck.test(num)) {
                alert("请填写数字");
                return;
            }
            $.ajax({
                url: webPath.webRoot + "/cart/tuanAdd.json",
                data: {type: carttype, objectId: skuId, quantity: num, handler: handler},
                dataType: "json",
                success: function (data) {
                    if (data.success == "true") {
                        var shoppingcart = data.shoppingCartVo;
                        var cartNum = 0;
                        for (var i = 0; i < shoppingcart.items.length; i++) {
                            cartNum = cartNum + shoppingcart.items[i].quantity;
                        }
                        var cartLayer = $(".addTobuyCarLayer");
                        cartLayer.find(".cartnum").html(data.allCartNum);
                        $("#top_myCart_cartNum").html(data.allCartNum);
                        cartLayer.find(".cartprice").html(data.allProductTotalAmount);
                        $("#top_myCart_cartNum2").html(cartNum);
                        $("#cartTotalPrice").html(shoppingcart.productDiscountAmount);
                        $("#tuanbox").hide();
                        //直接跳转到提交订单页面
                        window.location.href = webPath.webRoot + "/shoppingcart/orderadd.ac?handler=groupBuy&carttype=groupBuy&isCod=N";
                    }
                },
                error: function (XMLHttpRequest, textStatus) {
                    if (XMLHttpRequest.status == 500) {
                        var result = eval("(" + XMLHttpRequest.responseText + ")");
                        alert(result.errorObject.errorText);
                    }
                }
            });
        }
    });

    //数量改变
    $("#num").change(function(){
        //每次操作先清空错误日志
        $(".msg").html("");
        var stockNum = $("#stockNum").val();
        if(undefined != stockNum || "" != stockNum || null != stockNum || null != parseInt(stockNum)){
            var num = $("#num");
            var quantity = num.val();
            var numCheck = /^[0-9]*$/;
            if (!numCheck.test(quantity)) {
                //alert("请输入数字");
                $(".msg").html("请输入数字");
                num.val(1);
                return;
            }
            //如果库存大于1,并且购买数量没有超过库存
            if(parseInt(stockNum) > 0 && parseInt(quantity) < parseInt(stockNum)){
                $(".groupPrd_addNum").removeClass("lock");
            }
            //如果库存大于1,并且购买数量等于库存
            if(parseInt(stockNum) > 1 &&parseInt(quantity) == parseInt(stockNum)){
                $(".groupPrd_addNum").addClass("lock");
                $(".groupPrd_subNum").removeClass("lock");
            }
            if(quantity <= 0){
                num.val(1);
                $(".groupPrd_subNum").addClass("lock");
                $(".msg").html("数量不能小于0");
                //alert("数量不能小于0");
                return;
            }
            if(parseInt(quantity) > parseInt(stockNum)){
                num.val(stockNum);
                $(".groupPrd_addNum").addClass("lock");
                $(".msg").html("商品数量不足");
                //alert("该商品数量不足");

            }


        }
    });
    //数量减少
    $(".groupPrd_subNum").click(function(){
        //每次操作先清空错误日志
        $(".msg").html("");
        var stockNum = $("#stockNum").val();
        if(undefined != stockNum || "" != stockNum || null != stockNum || null != parseInt(stockNum)){
            if(stockNum == 0){
                $(".groupPrd_subNum").addClass("lock");
                $(".groupPrd_addNum").addClass("lock");
                $(".msg").html("该商品数量不足");
                //alert("该商品数量不足");
                return;
            }
            var num = $("#num");
            var quantity = $("#num").val();
            if (quantity == 1) {
                $(this).addClass("lock");
                return;
            }
            var newQuantity = parseInt(quantity) - 1;
            if(newQuantity == 1){
                $(this).addClass("lock");
                num.val(1);
                return;
            }if(parseInt(newQuantity) < parseInt(stockNum)){
                $(".groupPrd_addNum").removeClass("lock");
            }
            num.val(newQuantity);

        }
    });
    //数量添加
    $(".groupPrd_addNum").click(function(){
        //每次操作先清空错误日志
        $(".msg").html("");
        var stockNum = $("#stockNum").val();
        if(undefined != stockNum || "" != stockNum || null != stockNum || null != parseInt(stockNum)){
            if(parseInt(stockNum) == 0){
                $(".groupPrd_subNum").addClass("lock");
                $(".groupPrd_addNum").addClass("lock");
                $(".msg").html("该商品数量不足");
                //alert("该商品数量不足");
                return;
            }
            var num = $("#num");
            var quantity = $("#num").val();
            if (parseInt(quantity) > parseInt(stockNum)) {
                $(".groupPrd_subNum").removeClass("lock");
                $(".groupPrd_addNum").addClass("lock");
                num.val(stockNum);
                $(".msg").html("该商品数量不足");
                //alert("该商品数量不足");
                return;
            }
            var newQuantity = parseInt(quantity) + 1;
            if (newQuantity > parseInt(stockNum)) {
                $(".groupPrd_subNum").removeClass("lock");
                $(".groupPrd_addNum").addClass("lock");
                num.val(stockNum);
                $(".msg").html("该商品数量不足");
                //alert("该商品数量不足");
                return;
            }if (newQuantity == parseInt(stockNum)) {
                $(".groupPrd_subNum").removeClass("lock");
                $(".groupPrd_addNum").addClass("lock");
                num.val(stockNum);
                return;
            }
            if(parseInt(newQuantity) < parseInt(stockNum)){
                $(".groupPrd_subNum").removeClass("lock");
            }
            num.val(newQuantity);
        }
    });

});

