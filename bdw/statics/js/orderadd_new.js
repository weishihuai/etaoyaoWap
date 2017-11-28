
$(document).ready(function(){
    /*选择订单收货地址 设置默认地址*/
    $(".selectAddress").click(function(){
        var receiveAddrId = $(this).attr("receiveAddrId");
        var type = webPath.carttype;
        var selectAddress = $(this);
        selectAddressFun(receiveAddrId,selectAddress,type);
    });

    //添加购物券
    $(".coupon-title .link2").on("click",function(){
        $(".layer-binding-coupon").parent().show();
    });
    $(".couponlayer .close").on("click",function(){
        $(this).parents(".couponlayer").hide();
    });

    //保存配送方式
    $(".saveDelivery").change(function(){

        var deliveryId=$(this).val();
        if(deliveryId==undefined || deliveryId==0){
            alert("配送方式未选择");
            return false;
        }

        var carttype=$(this).attr("carttype");
        var orgId=$(this).attr("orgid");
        $.ajax({
            url:webPath.webRoot+"/cart/saveDeliveryRuleId.json",
            data:{type:carttype,deliveryRuleId:deliveryId,orgId:orgId},
            dataType: "json",
            success:function(data) {
                window.location.reload();//选择快递方式不刷新
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alert(result.errorObject.errorText);
                }
            }
        });
    });


    //提交购物券
    $("#bindCoupon").click(function(){
        var cardNum=$("#cardNum");
        var cardPwd=$("#cardPwd");
        if($.trim(cardNum.val())=="" || cardNum.val()==null ){
            alert("请输入购物券编号");
            return false;
        }
        if($.trim(cardPwd.val())=="" || cardPwd.val()==null ){
            alert("请输入购物券密码");
            return false;
        }
        $.ajax({
            url:webPath.webRoot+'/member/bindCoupon.json?time=' + new Date().getTime(),
            data:({cardNum:cardNum.val(),password:cardPwd.val()}),
            type:'post',
            success:function(data){
                cardNum.val('');
                cardPwd.val('');
                alert("绑定成功");
                window.location.reload();
            },
            error:function(XMLHttpRequest, textStatus) {
                cardPwd.val('');
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alert(result.errorObject.errorText);

                }
            }
        })
    });

    //提交订单
    $(".submitOrder").click(function(){
        var isSelectAddress = false;
        var selectAddressList = $(".selectAddress");
        var isNeedInvoice = $("#isNeedInvoice").val();
        selectAddressList.each(function(){
            if($(this).hasClass('dd-cur')){
                isSelectAddress = true;
            }
        });
        if(!isSelectAddress){
            alert("请选择收货地址！");
            return false;
        }
        if(!validatorDelivery()){
            alert("配送方式未选择");
            return false;
        }
        if(isNeedInvoice == "Y"){
            var inputInvoiceTitle = $("#inputInvoiceTitle").val();
            var inputInvoiceTaxPayerNum = $("#inputInvoiceTaxPayerNum").val();
            if($.trim(inputInvoiceTitle) == ""){
                alert("请输入发票抬头");
                return false;
            }
            if($.trim(inputInvoiceTaxPayerNum) == ""){
                alert("请输入发票税号");
                return false;
            }
        }
        setTimeout($("#orderForm").submit(),10)
    });

    /* 收货地址切换 */
    (function(){
        var sp_address_dd = $(".shipping-address .dd");
        var more_address = $(".shipping-address .more-address");
        var onOff = true;

        sp_address_dd.eq(2).nextAll(".dd").hide();

        sp_address_dd.on("click",function(){
            $(this).addClass("dd-cur").siblings().removeClass("dd-cur");
        });

        sp_address_dd.find("a").on("click",function(event){
            event.stopPropagation();
        });

        more_address.on("click", function(){
            if (onOff) {
                $(this).text("收起收货地址").addClass("more-address-c");
                sp_address_dd.stop().slideDown(300);
                onOff = false;
            }
            else {
                $(this).text("更多收货地址").removeClass("more-address-c");
                sp_address_dd.eq(2).nextAll(".dd").slideUp(300);
                onOff = true;
            }
        });

    })();

    $(".remark").blur(function(){
        var remark=  $(this).val();
        var orgId=$(this).attr("orgid");
        var type=$(this).attr("carttype");

        $.ajax({
            url:webPath.webRoot+"/cart/saveRemark.json",
            data:({remark:remark,orgId:orgId,type:type}),
            success:function(data){
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alert(result.errorObject.errorText);
                }
            }
        })
    });
});

var setDefaultAddr = function (obj) {
    var dataCheck = $(obj).attr("data-checked");
    if(dataCheck == 'true'){
        $(obj).attr("data-checked","false");
    }else{
        $(obj).attr("data-checked","true");
    }
};

var couponToggleSelect = function(obj){
    var couponInner = $(obj).parent().siblings(".coupon-inner");
    if(couponInner.is(":hidden")){
        $(obj).css('background-position-y','-21px');
        couponInner.slideDown();
    }else{
        $(obj).css('background-position-y','0px');
        couponInner.slideUp();
    }
};


/*选中订单地址*/
var selectAddressFun = function(receiveAddrId,div,type){
    var cartType = type;
    var receiveAddrId = receiveAddrId;
    $("#zoomloader").show();
    $.ajax({
        url:webPath.webRoot+"/cart/updateReceiver.json",
        data:({type:cartType,receiveAddrId:receiveAddrId,isCod:false}),
        success:function(data){
            if(data.success == "true"){
                window.location.reload();
            }
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                alert(result.errorObject.errorText);
            }
        }
    });
};

function selectiNvoice(nowThis){
    $(".invoice .invoice-cut li").removeClass("cur");
    $(nowThis).addClass("cur");
    var isInvoice  = $(nowThis).attr("invoice");
    if(isInvoice == "Y"){
        $("#isNeedInvoice").val("Y");
        $(".invoiceWin").show();
    }else{
        $("#isNeedInvoice").val("N");
        $(".invoiceWin").hide();
    }
    $(".editInvoiceWin").hide();
}

function saveInvoice(){
    var inputInvoiceTitle = $("#inputInvoiceTitle").val();
    var inputInvoiceTaxPayerNum = $("#inputInvoiceTaxPayerNum").val();
    if($.trim(inputInvoiceTitle) == ""){
        alert("请输入发票抬头");
        return false;
    }
    if($.trim(inputInvoiceTaxPayerNum) == ""){
        alert("请输入发票税号");
        return false;
    }
    $("#textInvoiceTitle").text(inputInvoiceTitle);
    $("#textInvoiceTaxPayerNum").text(inputInvoiceTaxPayerNum);

    $("#invoiceTitle").val(inputInvoiceTitle);
    $("#invoiceTaxPayerNum").val(inputInvoiceTaxPayerNum);
    $(".editInvoiceWin").show();
    $(".invoiceWin").hide();
}



/*验证选择配送方式*/
var validatorDelivery = function(){
    var returnBool = true;
    $(".saveDelivery").each(function(){
        if($(this).find("option:selected").val() == 0){
            returnBool = false;
        }
    });
    return returnBool;
};


function  clickCoupon(nowThis) {
    var couponId = $(nowThis).attr("couponId")
    var orgId = $(nowThis).attr("orgId")
    var isSelect = $(nowThis).attr("data-checked");
    if(isSelect == "true"){
        cancelCoupon(couponId,orgId);
    }else{
        var couponIds = [];
        couponIds[0] = couponId;
        selectCoupon(couponIds,orgId);
    }
}

function selectCoupon(couponIds,orgId){
    var carttype = webPath.carttype;
    $.ajax({
        type:"POST",
        url:webPath.webRoot+"/member/couponFront/useCoupons.json",
        traditional:true,
        data:{couponIds:eval(couponIds),orgId:orgId,type:carttype},
        dataType: "json",
        success:function(data) {
            if(data.success=="true"){
                window.location.reload();
            }
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                alert(result.errorObject.errorText);
            }
        }
    });
}
function cancelCoupon(couponId,orgId){
    var carttype = webPath.carttype;
    $.ajax({
        type:"POST",
        url:webPath.webRoot+"/member/couponFront/cancelUseCoupon.json",
        traditional:true,
        data:{couponId:couponId,orgId:orgId,type:carttype},
        dataType: "json",
        success:function(data) {
            if(data.success=="true"){
                window.location.reload();
            }
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                alert(result.errorObject.errorText);
            }
        }
    });
}
/*使用购物劵*/