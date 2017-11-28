
var addrSelect ;

var feePrice=0.0;




$(document).ready(function(){

    //自提中心
    $(".saveDelivery").each(function () {
        var deliveryLogisticsCompanyId = $(this).find("option:selected").attr('data-company-id');
        //20是表示自提的物流方式
        if (deliveryLogisticsCompanyId == 20 && $('.pickedUpDiv').is(':hidden')) {

            //获取被选中的收货地址:
            var receiveAddrId;
            var selectAddressList = $(".selectAddress");
            selectAddressList.each(function () {
                var strClass = $(this).attr("class");
                var strs = strClass.split(" ");
                var hasClass = $.inArray("cur", strs);
                //如果没有找到，则返回-1
                if (hasClass != -1) {
                    //存在
                    receiveAddrId = $(this).attr('receiveAddrId');
                    //zchtodo 这里要获取用户选择收货地址receiveAddrId,ajax去请求后台,把这个所选地址的对应门店显示出来
                    getPickUpList(receiveAddrId);
                    return false;//退出循环
                }
            });

            return false;//退出循环
        }
    });
    var  couponValue=$(".couponIds").val();
    if(couponValue!="-1"&&couponValue!="0"){
        var isNotUseCoupon = false;
        var orgId =$(".couponIds").attr("orgId");
        var carttype=$(".couponIds").attr("carttype");
        $.ajax({
            type:"POST",
            url:webPath.webRoot+"/member/couponFront/useCoupons.json",
            traditional:true,
            data:{couponIds:eval(couponValue),orgId:orgId,type:carttype},
            dataType: "json",
            success:function(data) {
                if(data.success=="true"){
                    $(".orderTotalAmout"+orgId).html(data.orderTotalAmoutStr);
                    $(".freightAmount"+orgId).html(data.freightAmount);
                    $(".integral"+orgId).html(data.integral);
                    $(".discountAmount"+orgId).html(data.discountAmount);

                    $("#allOrderTotalAmount").html(data.allOrderTotalAmount);
                    $("#allOrderTotalDiscount").html(data.allOrderTotalDiscount);
                    $("#allOrderTotalIntegral").html(data.allOrderTotalIntegral);
                    $("#orderTotalAmount").val(data.allOrderTotalAmount);

                    $("#useCoupons"+orgId).load(webPath.webRoot+"/template/bdw/ajaxload/useCouponsLoad.jsp",{orgId: orgId,carttype:carttype},function(){});
                    $("#userPlatformCoupon"+orgId).load(webPath.webRoot+"/template/bdw/ajaxload/userPlatformCouponsListLoad.jsp",{orgId: orgId,carttype:carttype},function(){if(isNotUseCoupon){$(".coupon").val(0)}});

                    var platformCoupon = $(".userPlatformCoupon");
                    platformCoupon.each(function () {
                        var oId = $(this).attr("orgId");
                        if(oId != orgId && $(this).css("display") != 'none'){
                            $("#userPlatformCoupon"+oId).load(webPath.webRoot+"/template/bdw/ajaxload/platformCanUseCouponsLoad.jsp",{orgId: oId,carttype:carttype},function(){if(isNotUseCoupon){$(".coupon").val(0)}});
                        }

                    });
                }
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    addOrderAlertDialog(result.errorObject.errorText);
                }
            }
        });


    }
    /*使用购物劵*/
    $(".couponIds").change(function(){

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

        //平台不使用购物券
        if(couponIds[0] == '0'){
            $(".cp1" + orgId).trigger('click');
            isNotUseCoupon = true;
            //return;
        }

        $.ajax({
            type:"POST",
            url:webPath.webRoot+"/member/couponFront/useCoupons.json",
            traditional:true,
            data:{couponIds:eval(couponIds),orgId:orgId,type:carttype},
            dataType: "json",
            success:function(data) {
                if(data.success=="true"){
                    $(".orderTotalAmout"+orgId).html(data.orderTotalAmoutStr);
                    $(".freightAmount"+orgId).html(data.freightAmount);
                    $(".integral"+orgId).html(data.integral);
                    $(".discountAmount"+orgId).html(data.discountAmount);

                    $("#allOrderTotalAmount").html(data.allOrderTotalAmount);
                    $("#allOrderTotalDiscount").html(data.allOrderTotalDiscount);
                    $("#allOrderTotalIntegral").html(data.allOrderTotalIntegral);
                    $("#orderTotalAmount").val(data.allOrderTotalAmount);

                    $("#useCoupons"+orgId).load(webPath.webRoot+"/template/bdw/ajaxload/useCouponsLoad.jsp",{orgId: orgId,carttype:carttype},function(){});
                    $("#userPlatformCoupon"+orgId).load(webPath.webRoot+"/template/bdw/ajaxload/userPlatformCouponsListLoad.jsp",{orgId: orgId,carttype:carttype},function(){if(isNotUseCoupon){$(".coupon").val(0)}});

                    var platformCoupon = $(".userPlatformCoupon");
                    platformCoupon.each(function () {
                        var oId = $(this).attr("orgId");
                        if(oId != orgId && $(this).css("display") != 'none'){
                            $("#userPlatformCoupon"+oId).load(webPath.webRoot+"/template/bdw/ajaxload/platformCanUseCouponsLoad.jsp",{orgId: oId,carttype:carttype},function(){if(isNotUseCoupon){$(".coupon").val(0)}});
                        }

                    });
                }
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    addOrderAlertDialog(result.errorObject.errorText);
                }
            }
        });
    });

    $(".cancelUseCoupon").click(function(){
        var couponId = $(this).attr("couponId");

        var orgId =$(this).attr("orgId");
        var carttype=$(this).attr("carttype");
        $.ajax({
            type:"POST",
            url:webPath.webRoot+"/member/couponFront/cancelUseCoupon.json",
            traditional:true,
            data:{couponId:couponId,orgId:orgId,type:carttype},
            dataType: "json",
            success:function(data) {
                if(data.success=="true"){
                    $(".orderTotalAmout"+orgId).html(data.orderTotalAmoutStr);
                    $(".freightAmount"+orgId).html(data.freightAmount);
                    $(".integral"+orgId).html(data.integral);
                    $(".discountAmount"+orgId).html(data.discountAmount);

                    $("#allOrderTotalAmount").html(data.allOrderTotalAmount);
                    $("#allOrderTotalDiscount").html(data.allOrderTotalDiscount);
                    $("#allOrderTotalIntegral").html(data.allOrderTotalIntegral);
                    $("#orderTotalAmount").val(data.allOrderTotalAmount);

                    $("#useCoupons"+orgId).load(webPath.webRoot+"/template/bdw/ajaxload/useCouponsLoad.jsp",{orgId: orgId,carttype:carttype},function(){});
                    $("#userPlatformCoupon"+orgId).load(webPath.webRoot+"/template/bdw/ajaxload/userPlatformCouponsListLoad.jsp",{orgId: orgId,carttype:carttype},function(){});

                    var platformCoupon = $(".userPlatformCoupon");
                    platformCoupon.each(function () {
                        var oId = $(this).attr("orgId");
                        if(oId != orgId && $(this).css("display") != 'none'){
                            $("#userPlatformCoupon"+oId).load(webPath.webRoot+"/template/bdw/ajaxload/platformCanUseCouponsLoad.jsp",{orgId: oId,carttype:carttype},function(){});
                        }

                    });
                }
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    addOrderAlertDialog(result.errorObject.errorText);
                }
            }
        });
    });
    /*使用购物劵*/


    $("#receiverZipcode").hover(function(){
        $("#zipPrompt").hover(function(){
            $(this).show();
        },function(){
            $(this).hide();
        })
    },function(){
        $("#zipPrompt").hide();
    });
    $("#accountBtn").click(function(){
        $(".open01").toggle();
        if($(".open01").is(":visible")==false){
            $("#Icon_plus1").html("(＋)");
        }else{
            $("#Icon_plus1").html("(－)");
        }
    });
    $("#couponBtn").click(function(){
        $(".open02").toggle();
        if($(".open02").is(":visible")==false){
            $("#Icon_plus2").html("(＋)");
        }else{
            $("#Icon_plus2").html("(－)");
        }
    });



    //修改地址
    /*    $(".update_addr").click(function(){
     $(".showAddress").hide();
     $(".updateAddress").show();

     var showAddress_path=$(".showAddress_path").val();
     var paths=showAddress_path.split("-");
     if(paths.length <= 1){
     paths=showAddress_path.split(" ");
     }
     var provinceNm=paths[2];
     var cityNm=paths[3];
     var zoneNm=paths[4];
     addrSelect.ld("api").selected([$.trim(provinceNm),$.trim(cityNm),$.trim(zoneNm)]);
     })*/
    $(".update_delivery").click(function(){
        $(".showDelivery").hide();
        $(".updateDelivery").show();
    });
    $(".update_payway").click(function(){
        $(".showpayway").hide();
        $(".updatepayway").show();
    });
    $(".update_invoice").click(function(){
        $(".showInvoice").hide();
        $(".updateInvoice").show();

        var need = false;
        $(".isNeedInvoice").each(function(){
            if($(this).attr("checked")&&$(this).val()=="Y"){
                need = true;
            }
        });
        if(need){
            var invCont = false;
            $(".invoiceType").each(function(){
                if($(this).attr("checked")&&$(this).val()==0){
                    invCont = true;
                }
            });
            if(invCont){
                setInvContValidator();
            }else{
                setVatInvoiceValidator();
            }
        }

    });


    //加载联动地址栏
    addrSelect= $(".addressSelect").ld(
        {ajaxOptions : {"url" : webPath.webRoot+"/member/addressBook.json"},
            defaultParentId:9,
            style:{"width": 80}
        });
    //选择地址栏
    $(".selectAddres").find("input").click(function(){
        var path=$(this).attr("addressPath");
        $(".showAddress_path").val(path);
        var paths=path.split("-");
        var provinceNm=paths[2];
        var cityNm=paths[3];
        var zoneNm=paths[4];
        var name=$(this).attr("addrname");
        var addrmobile=$(this).attr("addrmobile");
        var addrzip=$(this).attr("addrzip");
        var address=$(this).attr("address");
        var addrtel=$(this).attr("addrtel");
        addrSelect.ld("api").selected([$.trim(provinceNm),$.trim(cityNm),$.trim(zoneNm)]);

        $("#receiverName").val(name);
        $("#receiverAddr").val(address);
        $("#receiverMobile").val(addrmobile);
        $("#receiverZipcode").val(addrzip);
        $("#receiverTel").val(addrtel);

    });
    //删除地址本
    $(".deleteAddr").click(function(){
        var reviceId=$(this).attr("data");
        $.ajax({
            url:webPath.webRoot+"/cart/deleteRevicer.json",
            data:{reviceId:reviceId},
            dataType: "json",
            success:function(data) {
                var reviceId=data.reviceId;
                $(".address"+reviceId).empty();
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    addOrderAlertDialog(result.errorObject.errorText);
                }
            }
        })
    });

    //加载地址表单验证控件
    $.formValidator.initConfig({validatorGroup:"2",theme:'ArrowSolidBox',onError:function(msg){alert(msg)},inIframe:true,ajaxForm:{}});

    //保存配送方式
    $(".saveDelivery").change(function(){

        var deliveryId=$(this).val();
        if(deliveryId==undefined || deliveryId==0){
            addOrderAlertDialog("配送方式未选择");
            //return;
        }

        var carttype=$(this).attr("carttype");
        var orgId=$(this).attr("orgid");
        $.ajax({
            url:webPath.webRoot+"/cart/saveDeliveryRuleId.json",
            data:{type:carttype,deliveryRuleId:deliveryId,orgId:orgId},
            dataType: "json",
            success:function(data) {
                $(".orderTotalAmout"+orgId).html(data.orderTotalAmoutStr);
                $(".freightAmount"+orgId).html(data.freightAmount);
                $(".integral"+orgId).html(data.integral);
                $(".discountAmount"+orgId).html(data.discountAmount);
                $(".shopDiscountMsg"+orgId).html('<a style="text-decoration: none;"><span>店铺优惠：</span>'+data.allDiscountName+'</a>');

                $("#allOrderTotalAmount").html(data.allOrderTotalAmount);
                $("#allOrderTotalDiscount").html(data.allOrderTotalDiscount);
                $("#allOrderTotalIntegral").html(data.allOrderTotalIntegral);
                $("#orderTotalAmount").val(data.allOrderTotalAmount);
                //$("#userPreAmount").load(webPath.webRoot+"/template/bdw/ajaxload/userPreStoreLoad.jsp",{carttype:carttype},function(){});

                //window.location.reload();//选择快递方式不刷新
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    addOrderAlertDialog(result.errorObject.errorText);
                }
            }
        });
        $('input:radio[name="payway"]:checked').each(function(){
            var tmp = $(this)[0];
            tmp.checked = false;
            tmp = null;
        });
    });

    //邮编
    $("#receiverZipcode").click(function(){
        var cityId = $("#cityId").val();
        if(cityId != null && cityId != ""){
            $("#zipPrompt").load(webPath.webRoot+"/shoppingcart/zipCode.ac?cityId="+cityId,null,function(){
                $("#zipPrompt").offset({top:$("#receiverZipcode").position().top+24});
                $("#zipPrompt").show();
            });
        }else{
            $("#zipPrompt").hide();
        }
    });
    $("#ul_zip_prompt").find("li").live('click',function(){
        $("#receiverZipcode").attr("value",$(this).attr("value"));
        $("#zipPrompt").hide();
    });

    //选择支付方式
    $(".selectPayWay").find("input").click(function(){
        var payWayId=$(this).val();
        if(payWayId!=""){
            $("#payWayId").val(payWayId);
            var payNm=$(this).attr("payWayName");
            var payDesc=$(this).attr("payWayDesc");
            $("#payWayValue").attr("payWayName",payNm);
            $("#payWayValue").attr("payWayDesc",payDesc);
        }


    });
    //保存支付方式
    $(".savepayway").click(function(){
//        var payNm= $("#payWayValue").attr("payWayName");
//        var payDesc= $("#payWayValue").attr("payWayDesc");
        var payNm = $('input:radio[name="payway"]:checked').attr("payWayName");
        var payDesc = $('input:radio[name="payway"]:checked').attr("payWayDesc");
        if(payNm=="" || payNm==undefined ){
            addOrderAlertDialog("请选择支付方式");
            return;
        }
        var payWayId=$("#payWayId").val();
        $.ajax({
            url:webPath.webRoot+"/cart/savePayWay.json",
            data:{payWayId:payWayId},
            dataType: "json",
            success:function(data) {
                $(".updatepayway").hide();
                $(".showpayway").show();
                $(".showpayway").find("label").html(payNm);
                $(".showpayway").find(".text").html(payDesc);
                checkPayWay=true;
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alert(result.errorObject.errorText);
                }
            }
        });



    });

    //选择发票
    $(".isNeedInvoice").click(function(){
        var value= $(this).val();
        if(value=="Y"){
            var invCont = false;
            $(".invoiceType").each(function(){
                if($(this).attr("checked")&&$(this).val()==0){
                    invCont = true;
                }
            });
            if(invCont){
                setInvContValidator();
            }else{
                setVatInvoiceValidator();
            }

        }else{
            $(".addInvoice").hide();
        }
    });

    function setInvContValidator(){
        $("#invoiceTitle").formValidator({
            validatorGroup:"2",
            onShow:"请输入发票抬头",
            onFocus:"请输入发票抬头"
        }) .inputValidator({min:1,onError:"发票抬头不能为空" });
        $("#invoiceCont").formValidator({
            validatorGroup:"2",
            onShow:"请选择发票内容",
            onFocus:"请选择发票内容"
        }) .inputValidator({min:1,onError:"发票内容不能为空" });
        $(".addInvoice").show();
        $("#invTitle").show();
        $("#invcont").show();
        $("#vatInvoice").hide();
    }


    function setVatInvoiceValidator(){

        $("#invoiceEntNm").formValidator({
            validatorGroup:"2",
            onShow:"请输入单位名称",
            onFocus:"请输入单位名称"
        }) .inputValidator({min:1,onError:"单位名称不能为空" });

        $("#invoiceTaxPayerNum").formValidator({
            validatorGroup:"2",
            onShow:"请输入纳税人识别号",
            onFocus:"请输入纳税人识别号"
        }) .inputValidator({min:1,onError:"纳税人识别号不能为空" });

        $("#invoiceEntAddr").formValidator({
            validatorGroup:"2",
            onShow:"请输入注册地址",
            onFocus:"请输入注册地址"
        }) .inputValidator({min:1,onError:"注册地址不能为空" });

        $("#invoiceEntTel").formValidator({
            validatorGroup:"2",
            onShow:"请输入注册电话",
            onFocus:"请输入注册电话"
        }) .inputValidator({min:1,onError:"注册电话不能为空" });

        $("#invoiceEntBank").formValidator({
            validatorGroup:"2",
            onShow:"请输入开户银行",
            onFocus:"请输入开户银行"
        }) .inputValidator({min:1,onError:"开户银行不能为空" });

        $("#invoiceBackAccount").formValidator({
            validatorGroup:"2",
            onShow:"请输入银行账户",
            onFocus:"请输入银行账户"
        }) .inputValidator({min:1,onError:"银行账户不能为空" });

        $(".addInvoice").show();
        $("#vatInvoice").show();
        $("#invTitle").hide();
        $("#invcont").hide();
    }
    //切换发票类型
    $(".invoiceType").click(function(){

        if($(this).val()==0){
            setInvContValidator();
        }else{
            setVatInvoiceValidator();
        }

    });

    //保存发票
    $(".saveInvoice").click(function(){
        var isNeedInvoice=$(".isNeedInvoice:checked").val();
        var invoiceType=$(".invoiceType:checked").attr("data");
        var invoiceTypeValue=$(".invoiceType:checked").val();
        var invoiceTitle=$("#invoiceTitle").val();
        var invoiceCont=$("#invoiceCont").val();

        var invoiceEntNm=$("#invoiceEntNm").val();
        var invoiceTaxPayerNum=$("#invoiceTaxPayerNum").val();
        var invoiceEntAddr=$("#invoiceEntAddr").val();
        var invoiceEntTel=$("#invoiceEntTel").val();
        var invoiceEntBank=$("#invoiceEntBank").val();
        var invoiceBackAccount=$("#invoiceBackAccount").val();

        $(".showInvoice").find(".rComple").find("p").html("");

        if(isNeedInvoice=="N"){
            $(".showInvoice").show();
            $(".showInvoice").find("label").html("不需要发票");
            $(".updateInvoice").hide();
        }else{
            if(invoiceTypeValue=="0"){
                if(!invoiceTitle||!invoiceCont){
                    return;
                }
                $(".showInvoice").show();
                $(".IvTitle").show();
                $(".IvDec").hide();
                $(".showInvoice").find("label").html("开具发票");
                $(".showInvoice").find(".IvType").html(invoiceType+"："+invoiceTitle);
                $(".showInvoice").find(".IvTitle").html("发票内容："+invoiceCont);
                $(".updateInvoice").hide();
            }else{
                if(!invoiceEntNm||!invoiceTaxPayerNum||!invoiceEntAddr||!invoiceEntTel||!invoiceEntBank||!invoiceBackAccount){
                    return;
                }
                $(".showInvoice").show();
                $(".IvTitle").hide();
                $(".IvDec").show();
                $(".showInvoice").find("label").html("开具发票");
                $(".showInvoice").find(".IvType").html(invoiceType+"："+invoiceEntNm);
                $(".showInvoice").find(".InvaxPayerNum").html("纳税人识别号："+invoiceTaxPayerNum);
                $(".showInvoice").find(".InvEntAddr").html("注册地址："+invoiceEntAddr);
                $(".showInvoice").find(".InvEntTel").html("注册电话："+invoiceEntTel);
                $(".showInvoice").find(".InvEntBank").html("开户银行："+invoiceEntBank);
                $(".showInvoice").find(".InvBackAccount").html("开户银行："+invoiceBackAccount);
                $(".updateInvoice").hide();

            }
        }

        $.ajax({
            url:webPath.webRoot+"/cart/saveInvoice.json",
            data:{isNeedInvoice:isNeedInvoice,
                invoiceType:invoiceTypeValue,
                invoiceCont:invoiceCont,
                invoiceTitle:invoiceTitle,
                invoiceEntNm:invoiceEntNm,
                invoiceTaxPayerNum:invoiceTaxPayerNum,
                invoiceEntAddr:invoiceEntAddr,
                invoiceEntTel:invoiceEntTel,
                invoiceEntBank:invoiceEntBank,
                invoiceBackAccount:invoiceBackAccount
            },
            dataType: "json",
            success:function(data) {
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    addOrderAlertDialog(result.errorObject.errorText);
                }
            }
        });

    });

    //提交订单
    $(".submitOrder").click(function(){
        var hasCurNum = 0;
        var selectAddressList = $(".selectAddress");
        selectAddressList.each(function(){
            var strClass = $(this).attr("class");
            var strs = strClass.split(" ");
            var hasClass = $.inArray("cur", strs);
            if(hasClass!=-1){
                //存在
            }else{
                hasCurNum += 1;//不存在
            }
        });
        if(selectAddressList.length == hasCurNum){
            //alert("请选择收货地址");
            easyDialog.open({
                container : {
                    header : '提示信息',
                    content : "<div style='font-size: large;font-weight: 700;text-align: center'>请选择收货地址！</div>",
                    yesFn : function(){
                        easyDialog.close();
                        return false;
                    }
                },
                fixed: true,
                lock:false//esc可以关闭弹出层
            });
            return false;
        }
        if(!validatorDelivery()){
            addOrderAlertDialog("配送方式未选择");
            return false;
        }

        if(orderData.productTotal<1){
            addOrderAlertDialog("购物车中没有可购买的商品!");
            return false;
        }

        //设置自提点值
        //先判断是否有订单选了自提
        var flag = false;
        $(".saveDelivery").each(function () {
            var deliveryLogisticsCompanyId = $(this).find("option:selected").attr('data-company-id');
            //20是表示自提的物流方式,如果自提点的DIV是隐藏的,则说明这个收货地址是没有自提点的,这笔订单是不能提交的
            var pickedUpDiv = $(".submitOrder").attr("pickedUpDiv");
            if (deliveryLogisticsCompanyId == 20 && pickedUpDiv == 'N') {
                flag = true;
                return false;//退出循环
            }
        });

        if (flag) {
            addOrderAlertDialog("您收货的所在地区暂无自提点，请重新选择地区或重新选择配送方式");
            return;
        } else {
            var pickedUpRadioValue = $('input[type="radio"][name="pickedUpRadio"]:checked').val();
            if (pickedUpRadioValue != undefined && pickedUpRadioValue != '') {
                $('#pickUpId').val(pickedUpRadioValue);
            }
        }

        setTimeout($("#orderForm").submit(),10)
    });

    $(".topay").click(function(){
        var payAmount=$("#payAmount");
        var payPsw=$("#payPsw");
        var accountId=$("#accountId");
        var carttype=$(this).attr("carttype");
        if($.trim(payAmount.val())=="" || payAmount.val()==null ){
            addOrderAlertDialog("请输入金额");
            return

        }
        var reg=new RegExp("^(([0-9]+\\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\\.[0-9]+)|([0-9]*[1-9][0-9]*))$");
        if(!reg.test(payAmount.val())){
            addOrderAlertDialog("请输入正确的金额！");
            payAmount.val("");
            return
        }
        if($.trim(payPsw.val())=="" || payPsw.val()==null ){
            addOrderAlertDialog("请输入密码");
            return
        }
        $.ajax({
            url:webPath.webRoot+"/cart/addAccount.json",
            data:({moneyAmount:payAmount.val(),password:payPsw.val(),type:carttype}),
            success:function(data){
                addOrderAlertDialog("电子币支付成功，提交订单后，系统会扣除相应的电子币支付金额");
                var accountAmount=data.accountAmount;
                var useAmount=data.useAmount;
                payAmount.val('');
                payPsw.val('');
                $(".accountAmount").html("￥-"+parseFloat(useAmount));
                var leftAm=parseFloat(accountAmount)-parseFloat(useAmount);
                $(".prestore").html("￥"+leftAm);
                var orderTotalAmount=data.orderTotalAmount;
//                var orderTotalAmount= parseFloat(shoppingCart.orderTotalAmount)-parseFloat(useAmount);
                $(".orderAmount").html("￥"+parseFloat(orderTotalAmount+feePrice));
            },
            error:function(XMLHttpRequest, textStatus) {
                payPsw.val('');
                payAmount.val('');
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    //var error = eval("(" + result + ")");
                    alert(result.errorObject.errorText);

                }
            }
        })

    });


    $(".usecoupon").click(function(){
        var couponId=$(this).val();
        var carttype=$(this).attr("carttype");
        if($(this).attr("checked")){
            $.ajax({
                url:webPath.webRoot+"/cart/addCoupon.json",
                data:({couponId:couponId,type:carttype}),

                success:function(data){
                    var totalCouponAmount=data.totalCouponAmount;
                    $(".totalCouponAmount").html("￥-"+parseFloat(totalCouponAmount));
                    var orderTotalAmount=data.orderTotalAmount;
                    $(".orderAmount").html("￥"+parseFloat(feePrice+orderTotalAmount));

                },
                error:function(XMLHttpRequest, textStatus) {
                    if (XMLHttpRequest.status == 500) {
                        var result = eval("(" + XMLHttpRequest.responseText + ")");
                        //var error = eval("(" + result + ")");
                        alert(result.errorObject.errorText);
                        $(this).attr("checked",false)

                    }
                }
            })
        }else{
            $.ajax({
                url:webPath.webRoot+"/cart/removeCoupon.json",
                data:({couponId:couponId,type:carttype}),

                success:function(data){
                    var totalCouponAmount=data.totalCouponAmount;
                    $(".totalCouponAmount").html("￥"+parseFloat(totalCouponAmount));
                    var orderTotalAmount=data.orderTotalAmount;
                    $(".orderAmount").html("￥"+parseFloat(feePrice+orderTotalAmount));

                },
                error:function(XMLHttpRequest, textStatus) {
                    if (XMLHttpRequest.status == 500) {
                        var result = eval("(" + XMLHttpRequest.responseText + ")");
                        //var error = eval("(" + result + ")");
                        alert(result.errorObject.errorText);
                        $(this).attr("checked",false)

                    }
                }
            })

        }
    });

    $(".addNewCoupon").click(function(){
        var carttype=$(this).attr("carttype");
        var couponNum=$("#couponNum");
        var couponPsw=$("#couponPsw");
        if($.trim(couponNum.val())=="" || couponNum.val()==null ){
            alert("请输入卡号");
            return

        }
        if($.trim(couponPsw.val())=="" || couponPsw.val()==null ){
            addOrderAlertDialog("请输入密码");
            return
        }
        $.ajax({
            url:webPath.webRoot+"/cart/addNewCoupon.json",
            data:({couponNum:couponNum.val(),couponPsw:couponPsw.val(),type:carttype}),
            success:function(data){
                couponNum.val('');
                couponPsw.val('');
                var couponVo= data.CouponVo;
                if($("#coupon_"+couponVo.couponId).length==0){
                    $("#couponUl").append('<li><input class="usecoupon" id="coupon_'+couponVo.couponId+'" name="" carttype="'+carttype+'" type="checkbox" onclick="userCoupon($(this))" value="'+couponVo.couponId+'" />'+couponVo.amount+'元购物券（有效期至：'+couponVo.endTime+'）</li>')
                } else if(couponVo.typeCode == '2'){
                    $("#couponUl").append('<li><input class="usecoupon" id="coupon_'+couponVo.couponId+'" name="" carttype="'+carttype+'" type="checkbox" onclick="userCoupon($(this))" value="'+couponVo.couponId+'" />'+couponVo.amount+'元购物券（有效期至：'+couponVo.endTime+'）</li>')
                } else {
                    addOrderAlertDialog("此卷已经录入");
                }
            },
            error:function(XMLHttpRequest, textStatus) {
                couponNum.val('');
                couponPsw.val('');
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    //var error = eval("(" + result + ")");
                    alert(result.errorObject.errorText);

                }
            }
        })
    });

    $(".instalmentSelect").find("input").click(function(){
        var payWayId=$(this).val();
        $(".qishu").hide();
        $("#installment_"+payWayId).show();
        $(".qishu").find("input").attr("checked",false);
        $("#panel_ins_show").html('----')
    });

    $(".qishu").find("input").click(function(){
        var qishu=$(this).val();
        var feeRate=$(this).attr("feeRate");
        $.ajax({
            url:webPath.webRoot+"/cart/calcInstallment.json",
            data:({feeRate:parseFloat(feeRate),qishu:parseFloat(qishu),type:'installment'}),
            success:function(data){
                var price=data.price;
                $("#panel_ins_show").html('        <b style="color:Red">'+price+'</b>元 × <b style="color:Red">'+qishu+'</b>期(月)')
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    //var error = eval("(" + result + ")");
                    alert(result.errorObject.errorText);

                }
            }
        })

    });


    $(".saveInstallment").click(function(){
        var bank=$(".instalmentSelect").find("input:checked");
        var qishu=$(".qishu").find("input:checked");


        if(bank.length==0 || qishu.length==0){
            addOrderAlertDialog("请保存分期付款信息");
            return
        }
        var q=qishu.val();
        var f=qishu.attr("feeRate");
        $.ajax({
            url:webPath.webRoot+"/cart/calcInstallment.json",
            data:({feeRate:parseFloat(f),qishu:parseFloat(q),type:'installment'}),
            success:function(data){
                var price=data.price;
                var s=data.shouxufei;
                var orderTotalAmount=data.orderTotalAmount;
                $(".updatepayway").hide();
                $(".showpayway").show();
                $(".showpayway").find("label").html(bank.attr("payWayNm"));
                $(".showpayway").find(".text").html('      <b style="color:Red">'+price+'</b>元 × <b style="color:Red">'+q+'</b>期(月)');
                $(".shouxufei").html("￥"+s);
                $("#periods").val(q);
                $("#payWayId").val(bank.val());
                $(".orderAmount").html("￥"+orderTotalAmount);
                feePrice=s;
                checkPayWay=true;

            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    //var error = eval("(" + result + ")");
                    addOrderAlertDialog(result.errorObject.errorText);

                }
            }
        })
    });


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
                    //var error = eval("(" + result + ")");
                    alert(result.errorObject.errorText);

                }
            }
        })

    });

    /*弹出层*/
    $("#addAddress").click(function(){
        showMyAddress();
        $("#easyDialogBox").css("margin","-380.5px 0 0 -605px");
        initOrderAddReceiverMap();
    });

    $("#editInvoiceBtn").click(function(){
        showEditInvoice();
    });
    $("#closeEditInvoice").click(function(){
        hideEditInvoice();
    });

    $(".closeMyAddress").click(function(){
        hideMyAddress()
    });

    $(".needInvoice").click(function(){
        disabledEdictInvoice();
    });

    $(".saveInvoice").click(function(){
        saveInvoice();
    });

    $(".closeInvoice").click(function(){
        hideEditInvoice();
    });


    var showMyAddress = function(){
        $('#userAddrForm')[0].reset();
        citylocation.searchLocalCity();
        easyDialog.open({
            container : 'myAddress',
            fixed : true,
            /*        yesFn : btnFn,*/
            noFn : true
        });
    };
    var showEditInvoice = function(){
        easyDialog.open({
            container : 'editInvoice',
            fixed : false,
            /*        yesFn : btnFn,*/
            noFn : true
        });
    };

    var hideMyAddress = function(){
        easyDialog.close();
        $('#userAddrForm')[0].reset();
    };

    var hideEditInvoice = function(){
        easyDialog.close();
        $('#editInvoice')[0].reset();
    };


    var disabledEdictInvoice = function(){
        var needInvoice =$(".needInvoice:checked").val();
        if(needInvoice=='Y'){
            $('#edictInvoiceTitle').removeAttr('disabled')
        }else{
            $('#edictInvoiceTitle').val("");
            $('#edictInvoiceTitle').attr('disabled','disabled')
        }
    };


    var saveInvoice = function(){
        var needInvoice =$(".needInvoice:checked").val();
        var title = $("#edictInvoiceTitle").val();
        var newTilte = title.trim();
        if(undefined != newTilte && null != newTilte && "" != newTilte){
            if(newTilte.length > 64){
                addOrderAlertDialog("发票抬头64字以内");
                return;
            }
        }
        $("#isNeedInvoice").val(needInvoice);
        if(needInvoice=='N'){
            $("#invoiceTitle").val("");
            $("#invoiceCont").html("不需要开具")
        }
        else{
            $("#invoiceTitle").val(newTilte);
            $("#invoiceCont").html("( 发票抬头 - <span style='font-weight: bold;'>"+newTilte+"</span> )");
        }
        hideEditInvoice();
    };

    /*保存新地址*/
    $("#saveAddress").click(function(){
        if($("#receiverZipcode").val()==""){
            setTimeout(function(){ $("#receiverZipcodeTip").empty();},30);
        }
        if($("#receiverTel").val()==""){
            setTimeout(function(){ $("#receiverTelTip").empty();},30);
        }
        $('#userAddrForm').submit();
    });
    //加载地址表单验证控件
    $.formValidator.initConfig({formID:"userAddrForm",theme:'ArrowSolidBox',onError:function(msg){alert(msg)},inIframe:true,ajaxForm:{
        type:"POST",
        dataType : "json",
        url:webPath.webRoot+"/cart/saveReceiver.json?type="+$("#type").val(),
        buttons:$("#saveAddress"),
        async : true,
        error: function(jqXHR, textStatus, errorThrown){alert("服务器没有返回数据，可能服务器忙，请重试"+errorThrown);},
        success : function(data){
            $('#userAddrForm')[0].reset();
            window.location.reload();
//            hideMyAddress();
        }
    }});
    /*新地址验证*/
    $("#receiverName").formValidator({
        onShow:"请输入收货人姓名",
        onFocus:"输入收货人的姓名（中文2~5个字，英文4~10个字母）",
        tipCss:{width:200}
    }) .inputValidator({min:4,max:10,empty:{leftEmpty:false,rightEmpty:false,emptyError:""},onError:"请正确输入您的姓名（中文2~5个字，英文4~10个字母）" });

    $("#zone").formValidator({
        onShow:"请输入收货人所在地",
        onFocus:"请输入收货人所在地"
    }) .inputValidator({min:1,onError:"地区信息不完整！" });


    $("#receiverAddr").formValidator({
        onShow:"请输入收货地址",
        onFocus:"请输入收货地址"})
        .inputValidator({min:1,empty:{leftEmpty:false,rightEmpty:false,emptyError:""},onError:"收货地址不能为空！" })
        .regexValidator({regExp:"notempty",dataType:"enum",onError:""});

    $("#receiverMobile").formValidator({
        onShow:"请输入手机号码"
        ,onFocus:"请输入手机号码",
        tipCss:{width:200},tipID:"receiverMobileTip"}).
        inputValidator({min:11,max:11,onError:"手机号码必须是11位的,请确认"}).
        regexValidator({regExp:"mobile",dataType:"enum",onError:"你输入的手机号码格式不正确"});

    $("#receiverTel").formValidator({empty:true,onShow:"请输入你的联系电话，可以为空哦",
        onFocus:"格式例如：0577-88888888",tipCss:{width:200}}).regexValidator({regExp:"^(([0\\+]\\d{2,3}-)?(0\\d{2,3})-)?(\\d{7,8})(-(\\d{3,}))?$",onError:"你输入的联系电话格式不正确"});

    $("#receiverZipcode").formValidator({
        empty:true,
        onShow:"请输入正确的邮政编码",
        onFocus:"有助于快速确定送货地址"})
        .inputValidator({min:6,max:6,onError:"您输入的邮政编码有误" })
        .regexValidator({regExp:"num",dataType:"enum",onError:"你输入的邮政编码不正确"});
    /*弹出层*/

    /*选择订单收货地址 设置默认地址*/
    $(".selectAddress").click(function(){
        var strClass = $(this).attr("class");
        var strs = strClass.split(" ");
        var hasClass = $.inArray("cur", strs);
        if(hasClass!=-1){
            return false;//存在
        }
        var receiveAddrId = $(this).attr("receiveAddrId");
        var type = $("#type").val();
        var selectAddress = $(this);

        setTimeout(function(){
            selectAddressFun(receiveAddrId,selectAddress,type);
        },500);
    });
});
function userCoupon(coupon){
    var couponId=coupon.val();
    var carttype=coupon.attr("carttype");
    if(coupon.attr("checked")){
        $.ajax({
            url:webPath.webRoot+"/cart/addCoupon.json",
            data:({couponId:couponId,type:carttype}),

            success:function(data){
                var totalCouponAmount=data.totalCouponAmount;
                $(".totalCouponAmount").html("￥-"+parseFloat(totalCouponAmount));
                var orderTotalAmount=data.orderTotalAmount;
                $(".orderAmount").html("￥"+parseFloat(feePrice+orderTotalAmount));

            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    //var error = eval("(" + result + ")");
                    addOrderAlertDialog(result.errorObject.errorText);
                    coupon.attr("checked",false)

                }
            }
        })
    }else{
        $.ajax({
            url:webPath.webRoot+"/cart/removeCoupon.json",
            data:({couponId:couponId,type:carttype}),

            success:function(data){
                var totalCouponAmount=data.totalCouponAmount;
                $(".totalCouponAmount").html("￥"+parseFloat(totalCouponAmount));
                var orderTotalAmount=data.orderTotalAmount;
                $(".orderAmount").html("￥"+parseFloat(feePrice+orderTotalAmount));

            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    //var error = eval("(" + result + ")");
                    addOrderAlertDialog(result.errorObject.errorText);
                    coupon.attr("checked",false)

                }
            }
        })

    }
}
/*选中订单地址*/
var selectAddressFun = function(receiveAddrId,div,type){
    var cartType = type;
    var selectAddress = div;
    $("#zoomloader").show();
    $.ajax({
        url:webPath.webRoot+"/cart/updateReceiver.json",
        data:({type:cartType,receiveAddrId:receiveAddrId,isCod:orderData.isCod}),
        success:function(data){
            if(data.success == "true"){
                $(".selectAddress").removeClass("cur");
                selectAddress.addClass("cur");
                //配送方式处理
                if(data.result == null){
                    setTimeout(function(){
                        $("#zoomloader").hide();
                    },500);
                    return fasle;
                }
                checkInvalidCartItem(eval(data.unSupportDeliveryItemKeys));
                var deliveryRule = eval(data.result);

                for(var i = 0 ; i < deliveryRule.length; i++){
                    var saveDelivery = $(".saveDelivery[orgid="+deliveryRule[i].orgId+"]");
                    if(deliveryRule[i].deliveryRuleVoList.length == 0){
                        saveDelivery.hide();
                        saveDelivery.next(".operationMsg").html("该地区不支持货到付款");
                    }else{
                        saveDelivery.show();
                        saveDelivery.next(".operationMsg").hide();
                        var deliveryRuleVoList = deliveryRule[i].deliveryRuleVoList;
                        saveDelivery.empty();
                        saveDelivery.append('<option value="0">请选择配送方式</option>');
                        for(var drListIndex = 0;drListIndex < deliveryRuleVoList.length;drListIndex++){
                            var drv = deliveryRuleVoList[drListIndex];
                            var valueId = drv.deliveryRule.deliveryRuleId;
                            var valueNm = drv.deliveryRuleNm;
                            saveDelivery.append('<option value="'+valueId+'">'+valueNm+'</option>');
                        }
                    }
                }
                setTimeout(function(){
                    $("#zoomloader").hide();
                },500);
                window.location.reload();
            }
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                //var error = eval("(" + result + ")");
                addOrderAlertDialog(result.errorObject.errorText);
                coupon.attr("checked",false)

            }
        }
    });
};

var checkInvalidCartItem=function(unSupportDeliveryItemKeys){
    if(invalidCartItems.length!=unSupportDeliveryItemKeys.length){
        window.location.reload();
    }
    //相同数量
    var sameCount = 0;
    for(var i=0;i<invalidCartItems.length;i++){
        for(var c=0;c<unSupportDeliveryItemKeys.length;c++){
            if(invalidCartItems[i]==unSupportDeliveryItemKeys[c]){
                sameCount++;
            }
        }
    }

    if(sameCount!=unSupportDeliveryItemKeys.length){
        window.location.reload();
    }
};


/*验证选择配送方式*/
var validatorDelivery = function(){
    var returnBool = true;
    $(".saveDelivery").each(function(){
        if($(this).find("option:selected").val()-0 <= 0){
            returnBool = false;
        }
    });
    return returnBool;
};

function removeTheSign(Obj,tip){
    if($(Obj).val() == ""){
        setTimeout(function(){ $("#"+tip).empty();},30);
    }
}


//查询收货地址相关自提点
var getPickUpList = function (receiveAddrId) {
    if (receiveAddrId != '') {
        $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
        $.ajax({
            type: "POST",
            url: webPath.webRoot + "/pickedup/getPickUpListByZoneId.json",
            data: {
                receiveAddrId: receiveAddrId
            },
            dataType: "json",
            success: function (data) {
                if (data.success == "true") {
                    $.each(data.result, function (i, n) {
                        //默认选中第一个
                        if (i == 0) {
                            $('.pickedUpListDiv').append(
                                '<div class="la_item pickedUpSubDiv">'
                                + '<input type="radio" name="pickedUpRadio" checked="checked" class="pickedUpSubRadio" value="' + n.pickedUpId + '"/>'
                                + '<span class="pickedUpSubSpan">' + n.pickedUpName + '</span>'
                                + '<em style="float: left;" >(' + n.pickedUpAddress + '&nbsp;&nbsp;电话：' + n.pickedUpMobile + ')</em>'
                                + '</div>'
                            );
                        } else {
                            $('.pickedUpListDiv').append(
                                '<div class="la_item pickedUpSubDiv">'
                                + '<input type="radio" name="pickedUpRadio" class="pickedUpSubRadio" value="' + n.pickedUpId + '"/>'
                                + '<span class="pickedUpSubSpan">' + n.pickedUpName + '</span>'
                                + '<em style="float: left;" >(' + n.pickedUpAddress + '&nbsp;&nbsp;电话：' + n.pickedUpMobile + ')</em>'
                                + '</div>'
                            );
                        }
                    });
                    $(".submitOrder").attr("pickedUpDiv","Y");
                    //显示自提点
                } else if (data.success == "false") {
                    $('.pickedUpListDiv').append(
                        '<div class="la_item pickedUpSubDiv">'
                        + '<em style="float: left;color:red;" >(' + '您收货的所在地区暂无自提点，请重新选择地区或重新选择配送方式' + ')</em>'
                        + '</div>'
                    );
                    $(".submitOrder").attr("pickedUpDiv","N");
                }
                $('.pickedUpDiv').show();
            },
            error: function (XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    addOrderAlertDialog(result.errorObject.errorText);
                }
            }
        });
    }
};


//==================地址地图=====================
   function inits() {

       var center = new qq.maps.LatLng(39.916527, 116.397128);
       map = new qq.maps.Map(document.getElementById('addMap'), {
           center: center,
           zoom: 13
       });

       //添加到提示窗
        var info = new qq.maps.InfoWindow({
           map: map
       });

       geocoder = new qq.maps.Geocoder({
           complete: function (result) {
               var latLng = result.detail.location;
               map.setCenter(latLng);
               setLatAndLng(latLng.lng + "", latLng.lat + "");
                marker = new qq.maps.Marker({
                   map: map,
                   position: result.detail.location
               });
           }
       });

//获取城市列表接口设置中心点
       citylocation = new qq.maps.CityService({
           complete: function (result) {
               var latLng = result.detail.latLng;
               map.setCenter(latLng);
               setLatAndLng(latLng.lng + "", latLng.lat + "");
           }
       });
       citylocation.searchLocalCity();

       //绑定单击事件添加参数
       qq.maps.event.addListener(map, 'click', function(event) {
           locatedByLngAndLat (event.latLng.getLng() + "",event.latLng.getLat() + "");
       });

   }

//设置经度纬度
function locatedByLngAndLat(lng, lat) {
    setLatAndLng(lat,lng);
    var center = new qq.maps.LatLng(lat, lng);
    map.setCenter(center);
    if(!marker){
        marker = createMarker(center, map);
    }

}

//创建标记
function createMarker(latLng, map) {
     marker = new qq.maps.Marker({
        position: latLng,
        draggable: true,
        map: map
    });
    marker.setDraggable(true);
    qq.maps.event.addListener(marker, 'dragend', dragCallBack);
    return marker;
}

//调用回调
function dragCallBack() {
    var p = marker.getPosition();
    setLatAndLng(p.lng + "", p.lat + "");
}

//解析地址数据
 window.top.located = function (city, address) {
        geocoder.getLocation(city + address);
};

//设置经度纬度值
function setLatAndLng(lat,lng){
    $("#addrLat").val(lat + "");
    $("#addrLng").val(lng + "");
}

$(function(){
    //地图初始化
    inits();

    //定位
    $("#location").click(function(){
        var city = $("#city").find("option:selected").text();
        var area = $("#zone").find("option:selected").text();
        var address = $("#receiverAddr").val();
        if(city == '请选择' || city == ''){
            addOrderAlertDialog("请选择城市");
            return;
        }

        if(area == '请选择' || area == ''){
            addOrderAlertDialog("请选择区/县");
            return;
        }

        if(address == ''){
            addOrderAlertDialog("请输入街道地址");
            return;
        }

        window.top.located(city,area + address);
    });
});


/*-------------------------新的定位地图地址----------------------------------*/

var orderAddMarker,orderAddMap,orderAddGeocoder = null;
var orderAddLat,orderAddLng = null;

var initOrderAddReceiverMap = function() {
    var center = new qq.maps.LatLng(39.916527, 116.397128);

    orderAddMap = new qq.maps.Map(document.getElementById('addMap'), {
        center: center,
        zoom: 13
    });

    var citylocation = new qq.maps.CityService({
        //设置地图
        map : orderAddMap,
        complete : function(results){
            orderAddMap.setCenter(results.detail.latLng);
            orderAddMarker.setPosition(results.detail.latLng);
        }
    });
    citylocation.searchLocalCity();
    //调用地址解析类
    orderAddGeocoder = new qq.maps.Geocoder({
        complete : function(result){
            orderAddMap.setCenter(result.detail.location);
            orderAddMarker.setPosition(result.detail.location);
            orderAddLat = orderAddMap.getCenter().getLat();
            orderAddLng = orderAddMap.getCenter().getLng();
            $("#addrLat").val(orderAddLat + "");
            $("#addrLng").val(orderAddLng + "");
        },
        error: function(){
            addOrderAlertDialog("出错了，请输入正确的地址!");
        }
    });
    orderAddMarker = new qq.maps.Marker({
        //设置Marker的位置坐标
        position: center,
        //设置显示Marker的地图
        map: orderAddMap,
        //设置Marker被添加到Map上时的动画效果为反复弹跳
        animation: qq.maps.MarkerAnimation.BOUNCE,
        //设置Marker被添加到Map上时的动画效果为从天而降
        //animation:qq.maps.MarkerAnimation.DROP
        //设置Marker被添加到Map上时的动画效果为落下
        //animation:qq.maps.MarkerAnimation.DOWN
        //设置Marker被添加到Map上时的动画效果为升起
        //animation:qq.maps.MarkerAnimation.UP
        draggable: true
    });
    qq.maps.event.addListener(orderAddMarker, 'dragend', function(event) {
        orderAddLat = event.latLng.getLat();
        orderAddLng = event.latLng.getLng();
    });
};

function analyzeOrderAddAddress(){
    var  province=document.getElementById("province");
    var provinceIndex=province.selectedIndex ;             // selectedIndex代表的是你所选中项的index
    var provinceName = province.options[provinceIndex].text;

    var  city=document.getElementById("city");
    var cityIndex=city.selectedIndex ;             // selectedIndex代表的是你所选中项的index
    var cityName = city.options[cityIndex].text;

    var  country=document.getElementById("country");
    var countryIndex=country.selectedIndex ;             // selectedIndex代表的是你所选中项的index
    var countryName = country.options[countryIndex].text;

    var  zone=document.getElementById("zone");
    var zoneIndex=zone.selectedIndex ;             // selectedIndex代表的是你所选中项的index
    var zoneName = zone.options[zoneIndex].text;

    var addr = document.getElementById("receiverAddr").value;
    var selectedNum = 0;
    if(undefined != provinceName && provinceName != "" && provinceName !='请选择'){
        selectedNum+=1;
    }

    if(undefined != cityName && cityName != "" && cityName !='请选择'){
        selectedNum+=1;
    }

    if(undefined != countryName && countryName != "" && countryName !='请选择'){
        selectedNum+=1;
    }

    if(undefined != zoneName && zoneName != "" && zoneName !='请选择'){
        selectedNum+=1;
    }

    if(undefined != addr && addr != ""){
        selectedNum+=1;
    }

    if(selectedNum >= 4){
        var place = cityName + "," + countryName  + ","+ zoneName + ","+ addr;
        //通过getLocation();方法获取位置信息值
        orderAddGeocoder.getLocation(place);
    }
}

//因为用户可能第一次修改选择地址后，对地址进行二次修改，此时不会定位正确的地址;
//省级
function proviceSelected(obj){
    analyzeOrderAddAddress();

}
//市级
function citySelected(obj){
    analyzeOrderAddAddress();
}
//地区
function areaSelected(obj){
    var value = $.trim($(obj).val());
    if(value!=0&&value!=undefined&&value!="请选择"){
        $("#receiverZoneId").val(value);
    }
    analyzeOrderAddAddress();
}



//最普通最常用的alert对话框，默认携带一个确认按钮
var addOrderAlertDialog = function(dialogTxt){
    var dialog = jDialog.alert(dialogTxt);
};
