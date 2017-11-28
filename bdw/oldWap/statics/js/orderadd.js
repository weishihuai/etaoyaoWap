/**
 * Created with IntelliJ IDEA.
 * User: lxd
 * Date: 13-11-28
 * Time: 下午4:43
 * To change this template use File | Settings | File Templates.
 */
var collapse = true;
var isNeedInvoice =false;
$(document).ready(function(){

    /*if(typeof(allProductsPrice) != "undefined"){
        //return;
        $("#allProductsPrice").html("¥"+allProductsPrice);
    }*/

    /*var radio = $("input[name='needInvoice']:checked").val();
    if(radio=="N"){
        $(".title-text").hide();
        isNeedInvoice = false;
    }else{
        $(".title-text").show();
        isNeedInvoice = true;
    }*/

    /*var invoiceButton = $("#needInvoice").val();
    if(invoiceButton=="N"){
        $(".title-text").css("display","none");
        isNeedInvoice = false;
    }else{
        $(".title-text").css("display","block");
        isNeedInvoice = true;
    }*/

    /*使用购物劵*/
    /*$(".coupon").change(function(){

        var isNotUseCoupon = false;

        var couponIds = $(this).val();
        if(couponIds==null || couponIds.isArray && couponIds.length==0){
            return;
        }

        if(couponIds.length==1 && couponIds[0] == -1){
            return;
        }

        var orgId =$(this).attr("orgId");
        var carttype=$(this).attr("carttype");

        //不使用购物券
        if(couponIds[0] == '0'){
            couponIds[0] == '0';
            var isNotUseCoupon = true;
        }
        $.ajax({
            type:"POST",
            url:webPath.webRoot+"/cart/useCoupon.json",
            data:{couponIds:eval(couponIds),orgId:orgId,type:carttype},
            dataType: "json",
            success:function(data) {
                if(data.success=="true"){
                    $(".orderTotalAmout"+orgId).html(data.orderTotalAmoutStr);
                    $(".freightAmount"+orgId).html(data.freightAmount);
                    $(".discountAmount"+orgId).html(data.discountAmount);
                    $("#allOrderTotalAmount").html(data.allOrderTotalAmount);
                    $("#totalPrice").html(data.allOrderTotalAmount);
                    $("#freightTotalAmount").html(data.freightAmount);
                    $("#allDiscount").html(data.discountAmount);

                    $("#useCoupons"+orgId).load(webPath.webRoot+"/template/bdw/wap/ajaxload/useCouponsLoad.jsp",{orgId: orgId,carttype:carttype},function(){});
                    $("#userPlatformCoupon"+orgId).load(webPath.webRoot+"/template/bdw/wap/ajaxload/userPlatformCouponsListLoad.jsp",{orgId: orgId,carttype:carttype},function(){if(isNotUseCoupon){$(".coupon").val(0)}});
                    var platformCoupon = $(".userPlatformCoupon");
                    platformCoupon.each(function () {
                        var oId = $(this).attr("orgId");
                        if(oId != orgId && $(this).css("display") != 'none'){
                            $("#userPlatformCoupon"+oId).load(webPath.webRoot+"/template/bdw/wap/ajaxload/platformCanUseCouponsLoad.jsp",{orgId: oId,carttype:carttype},function(){if(isNotUseCoupon){$(".coupon").val(0)}});
                        }

                    });
                }
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    executeError(result.errorObject.errorText);
                }
            }
        });
    });*/

    $(".selectAddr").click(function(){
        window.location.href=webPath.webRoot+'/wap/shoppingcart/addrSelect.ac?handler='+webPath.handler+'&carttype='+webPath.carttype+"&isCod="+orderData.isCod+"&time="+(new Date()).getTime();
    });

    /*选择收货地址*/
    $(".addrRow").click(function(){
        //$(".slectItem").removeClass("glyphicon-ok");
        var receiveAddrId=$(this).attr("receiveAddrId");
        selectAddressFun(receiveAddrId);
    });

    /*$(".clear-msg").click(function(){
        if($(this).val()=='备注内容'){
            $(this).val('');
            //$(this).attr("style", "color:#000;");
        }
    });*/

    /*$(".invoice-radio").change(function(){
        var radioVal = $("input[name='needInvoice']:checked").val();
        if(radioVal=="N"){
            $(".title-text").hide();
            $("#isNeedInvoice").val("N");
            isNeedInvoice = false;
        }else{
            isNeedInvoice = true;
            $("#isNeedInvoice").val("Y");
            $(".title-text").show();
        }
    });*/

    $(".invoiceIcon").click(function(){
        var invoiceValue = $("#isNeedInvoice").val();
        if(invoiceValue=="N"){
            isNeedInvoice = true;
            $("#needInvoice").val("Y");
            $("#isNeedInvoice").val("Y");
            $(".title-text").css("display","block");
        }else{
            isNeedInvoice = false;
            $("#needInvoice").val("N");
            $("#isNeedInvoice").val("N");
            $(".title-text").css("display","none");
        }
    });

    /*$("#invoice-title").click(function(){
        if($(this).val().trim()=='请输入抬头内容'){
            $(this).val('');
            //$(this).attr('style', 'color:#000;');
        }
    });*/

    $(".clear-msg").blur(function(){
        var remark=  $(this).val();
        var orgId=$(this).attr("orgid");
        var type=$(this).attr("carttype");
        if($(this).val()=='备注内容'||$(this).val()=='')
            return;
        $.ajax({
            url:webPath.webRoot+"/cart/saveRemark.json",
            data:({remark:remark,orgId:orgId,type:type}),
            success:function(data){
                //alert("ssss");
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    //alert(result.errorObject.errorText);
                    breadDialog(result.errorObject.errorText,"alert",1000,false);

                }
            }
        })
    });

    $(".selectCoupon").click(function(){
        var shoppingIndex = $(this).attr("shoppingIndex");
        $("#saveCoupon"+shoppingIndex).css("display","block");
    });

    $(".confirmCoupon").click(function(){
        var shoppingIndex = $(this).attr("shoppingIndex");
        $("#saveCoupon"+shoppingIndex).css("display","none");
        var radioStr = "input[name='coupon" + shoppingIndex + "']:checked";
        if($(radioStr).val() != undefined){
            if($(radioStr).parent(".checkbox").attr("couponId") != "0"){
                var couponAmount = $(radioStr).parent(".checkbox").attr("couponAmount");
                var couponNm = $(radioStr).parent(".checkbox").attr("couponNm");
                $("#selectCoupon"+shoppingIndex).html("优惠"+couponAmount+"元");
            }
            else{
                $("#selectCoupon"+shoppingIndex).html("不使用购物券");
            }
        }
    });

    $(".confirmCoupon").trigger("click");

    /*使用购物劵*/
    $(".saveCoupon").change(function(){
        var shoppingIndex = $(this).attr("shoppingIndex");
        var radioStr = "input[name='coupon" + shoppingIndex + "']:checked";
        var couponId = $(radioStr).parent(".checkbox").attr("couponId");

        /*if(couponId==undefined || couponId==0){
            breadDialog("未选择购物券","alert",1000,false);
            //return;
        }*/

        var orgId =$(this).attr("orgId");
        var carttype=$(this).attr("carttype");

        //不使用购物券
        /*if(couponId == '0'){
            couponId[0] == '0';
            var isNotUseCoupon = true;
        }*/

        //var aaa = parseInt(couponId);
        //var aaa = new Array(couponId);
        //alert(couponIds instanceof Array);
        var couponIds = [];
        couponIds.push(couponId);
        //couponIds = JSON.stringify(aaa);


        $.ajax({
            type:"POST",
            url:webPath.webRoot+"/cart/useCoupon.json",
            data:{couponIds:couponIds,orgId:orgId,type:carttype},
            dataType: "json",
            traditional:true,
            async:false,

            success:function(data) {
                //alert("success");
                if(data.success=="true"){
                    $(".orderTotalAmout"+orgId).html(data.orderTotalAmoutStr);
                    $(".freightAmount"+orgId).html(data.freightAmount);
                    $(".discountAmount"+orgId).html(data.discountAmount);
                    $("#allOrderTotalAmount").html(data.allOrderTotalAmount);
                    $("#totalPrice").html(data.allOrderTotalAmount);
                    /* 选择购物券的时候不用修改邮费的显示 */
                    $("#freightTotalAmount").html(data.freightTotalAmount);
                    $("#allDiscount").html(data.allOrderTotalDiscountAbs);
                    //alert(data.allOrderTotalDiscountAbs);
                    if(data.allOrderTotalDiscountAbs == '0.0'){
                        $(".allDiscound").css("display","none");
                    }
                    else{
                        $(".allDiscound").css("display","block");
                    }
                    if(data.isAlreadyUse == "true"){
                        var couponStr = "input[name='coupon" + shoppingIndex + "']";
                        $(couponStr).removeAttr("checked");
                        breadDialog("此购物券已经被别的订单使用","alert",1500,false);
                    }
                }
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    //executeError(result.errorObject.errorText);
                }
            }
        });
    });

    $(".selectDeliverWay").click(function(){
        $("#moreDeliverWays").css("display","block");
        $(".moreDeliverWay").css("display","none");

        var shoppingIndex = $(this).attr("shoppingIndex");
        $("#saveDelivery"+shoppingIndex).css("display","block");
    });
    $("#moreDeliverWays").click(function(){
        $("#moreDeliverWays").css("display","none");
        $(".moreDeliverWay").css("display","block");
    });

    $(".confirmDeliver").click(function(){
        var shoppingIndex = $(this).attr("shoppingIndex");
        $("#saveDelivery"+shoppingIndex).css("display","none");
        var radioStr = "input[name='express" + shoppingIndex + "']:checked";
        if($(radioStr).val() != undefined){
            var deliverWay = $(radioStr).parent(".checkbox").attr("deliverWay");
            deliverWay = deliverWay.toString();
            /*if(deliverWay.length > 13){
                deliverWay = deliverWay.toString().substring(0,12) + "···";
            }*/
            $("#selectDeliverWay"+shoppingIndex).html(deliverWay);
        }
    });

    $(".confirmDeliver").trigger("click");

    //保存配送方式
    $(".saveDelivery").change(function(){
        var shoppingIndex = $(this).attr("shoppingIndex");
        var radioStr = "input[name='express" + shoppingIndex + "']:checked";
        var deliveryId = $(radioStr).parent(".checkbox").attr("deliverWayId");
        //alert(deliveryId);
        if(deliveryId==undefined || deliveryId==0){
            breadDialog("配送方式未选择","alert",1000,false);
            //return;
        }
        var carttype=$(this).attr("carttype");
        var orgId=$(this).attr("orgid");
        $.ajax({
            url:webPath.webRoot+"/cart/saveDeliveryRuleId.json",
            data:{type:carttype,deliveryRuleId:deliveryId,orgId:orgId},
            dataType: "json",
            async:false,

            success:function(data) {
                $(".discountAmount"+orgId).html(data.discountAmount);
                $(".orderTotalAmout"+orgId).html(data.orderTotalAmoutStr);
                $(".freightAmount"+orgId).html(data.freightAmount);
                $("#allOrderTotalAmount").html(data.allOrderTotalAmount);
                $("#totalPrice").html(data.allOrderTotalAmount);
                $("#freightTotalAmount").html(data.freightTotalAmount);
                $("#allDiscount").html(data.allOrderTotalDiscountAbs);
                if(data.allOrderTotalDiscountAbs == '0.0'){
                    $(".allDiscound").css("display","none");
                }
                else{
                    $(".allDiscound").css("display","block");
                }
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    //alert(result.errorObject.errorText);
                    breadDialog(result.errorObject.errorText,"alert",1000,false);
                }
            }
        });
        /*$('input:radio[name="payway"]:checked').each(function(){
            var tmp = $(this)[0];
            tmp.checked = false;
            tmp = null;
        });*/
    });

    /*提交订单*/
    $(".submitOrder").click(function(){

        var isReceiver = $("#isReceiver").val();
        if(isReceiver == "false"){
            //alert("请检查您的收货地址!");
            breadDialog("请检查您的收货地址!","alert",1000,false);
            return false;
        }
        if(!validatorDelivery()){
            //alert("配送方式未选择");
            breadDialog("配送方式未选择","alert",1000,false);
            return false;
        }
        /*if(isNeedInvoice && $("#invoice-title").val()==''){
            //alert("请填写发票台头！");
            breadDialog("请填写发票台头！","alert",1000,false);
            return false;
        }*/
        if(isNeedInvoice){
            if($("#invoice-title").val()==''){
                breadDialog("请填写发票台头！","alert",1000,false);
                return;
            }
            else{
                $("#invoiceTitle").val($("#invoice-title").val());
            }
        }

        if(orderData.productTotal<1){
            //alert("购物车中没有可购买的商品!");
            breadDialog("购物车中没有可购买的商品!","alert",1000,false);
            return false;
        }

        setTimeout($("#orderForm").submit(),10);

    });

    /*function collapse(thatCollapse){
        if(!thatCollapse.find(".glyphicon-chevron-down").is(":hidden")){
            thatCollapse.find(".glyphicon-chevron-down").hide();
            thatCollapse.find(".glyphicon-chevron-up").show();
        }else{
            thatCollapse.find(".glyphicon-chevron-down").show();
            thatCollapse.find(".glyphicon-chevron-up").hide();
        }
    }*/

    /* 隐藏/显示商店商品的功能 */
    /*$(".shops").click(function(){
        var shop =  $(this).parent().find(".shop");
        if(shop.hasClass("collapse")){
            shop.collapse('show');
        }else{
            shop.collapse('hide');
        }
        collapse($(this));
    });*/

});

var selectAddressFun = function(receiveAddrId){
    var isCod = false;
    if ('Y' == orderData.isCod) {
        isCod = true;
    }
    $.ajax({
        url:webPath.webRoot+"/cart/updateReceiver.json",
        data:({type:webPath.carttype,receiveAddrId:receiveAddrId,isCod:isCod}),
        success:function(data){
            if(data.success == "true"){
                window.location.reload();
            }
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                //alert(result.errorObject.errorText);
                breadDialog(result.errorObject.errorText,"alert",1000,false);
            }
        }
    });
};

/*验证选择配送方式*/
var validatorDelivery = function(){
    var returnBool = true;
    //alert($(".saveDelivery").length);
    $(".saveDelivery").each(function(){
        /*if($(this).find("option:selected").val()-0 <= 0){
            returnBool = false;
        }*/
        var shoppingIndex = $(this).attr("shoppingIndex");
        var radioStr = "input[name='express" + shoppingIndex + "']:checked";
        var deliveryId = $(radioStr).parent(".checkbox").attr("deliverWayId");
        if(deliveryId==undefined || deliveryId==0){
            breadDialog("配送方式未选择","alert",1000,false);
            returnBool = false;
        }
    });
    return returnBool;
};
