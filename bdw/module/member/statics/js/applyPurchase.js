var addrSelect;//加载地区
$(document).ready(function () {
    addrSelect = loadAddr();
    setAddrNm(webPath.receiverZoneId);
    $("#btnAdd").click(function () {
        if ($("input[name='num']").val() == null || $("input[name='num']").val() == '') {
            applyPurchaseAlertDialog("请选择退换货数量!");
            return;
        }
        $("#purchaseForm").submit();
    });
    $.formValidator.initConfig({
        theme: "ArrowSolidBox", formID: "purchaseForm",
        onSuccess: function () {
            ajaxReturnOrder()
        }, onError: function () {
            applyPurchaseAlertDialog("您还有信息未完善!");
        }
    });
    /* $(":adio[name='typeCode']").cliValidator({tipID:"typeCodeTip",onShow:"请选择处理方式",onFocus:"请选择处理方式",onCorrect:"输入正确",defaultValue:["1"]})
     .inputValidator({min:1,max:1,onError:"请选择处理方式"});*/
    $("#remark").formValidator({onShow: "请输入问题备注", onFocus: "请输入问题备注",leftTrim:true,rightTrim:true})
        .inputValidator({min: 5, max: 255,onError: "请输入字符长度5~255的问题备注"});
    $("#receiverAddr").formValidator({onShow: "请完善收货地址", onFocus: "请完善收货地址",leftTrim:true,rightTrim:true})
        .functionValidator({
            fun: function (val) {
                checkAddress();
            }
        });
    $("#receiverName").formValidator({onShow: "请输入联系人", onFocus: "请输入联系人",leftTrim:true,rightTrim:true})
        .inputValidator({min: 2, max: 24, onError: "请输入字符长度2~24位的联系人信息"});
    $("#receiverMobile").formValidator({onShow: "请输入手机号码", onFocus: "请输入手机号码",leftTrim:true,rightTrim:true})
        .inputValidator({regExp: "num", min: 11, max: 11, onError: "请输入数字长度11位的联系人信息"});

    //2015-04-03,改为非必须
    //$("#photoFileId").formValidator({onShow:"请选择JPG图片文件上传",onFocus:"请选择JPG图片文件上传"}).inputValidator({min:11,onError:"请选择JPG图片文件上传"});
    /*$(":radio[name='typeCode']").click(function(){
     if($(this).val() == '0'){
     $("#addr_div").hide();
     $("#receiverAddr").attr("disabled",true).unFormValidator(true); //解除校验
     }else{
     $("#addr_div").show();
     $("#receiverAddr").attr("disabled",false).unFormValidator(false);//恢复校验
     }
     });*/
    var options = {
        dataType: 'html',
        success: function (responseText, statusText, xhr, $form) {
            try {
                var result = eval("(" + responseText + ")");
                if (result.success == "false") {
                    applyPurchaseAlertDialog("您提交的图片格式不正确");

                } else if (result.success == "true") {
                    $("#photoFileId").attr("value", $.trim(result.fileId));
                    $("#upload_pic").attr("src", $.trim(result.url));
                    $("#tip").dialog('close');

                }
            } catch (err) {
                applyPurchaseAlertDialog("您上传的图片不符合规格,请上传.jpg格式文件");
            }
        }
    };
    $('#upload').submit(function () {
        $(this).ajaxSubmit(options);
        return false;
    });
    $("#upLoad_btn").click(function () {
        $("#tip").dialog({
            buttons: {
                '确定': function () {
                    $("#upload").submit();
                },
                '取消': function () {
                    $("#tip").dialog('close');
                }
            }
        });
    });
});
var changeItemNum = function (div, returnedNum) {
    var orderItemId = div.substring(0,div.indexOf("_"));
    var trDiv = $("#"+orderItemId+"_div");
    var comprdId = trDiv.attr("combinedProductId");
    var comprdNum = trDiv.attr("combinedProductItemNum");
    var numInput = $("#" + div);
    var changeNum = numInput.val();
    if (/[^\d]/.test(changeNum)) {
        applyPurchaseAlertDialog("请输入整数");
        numInput.val(returnedNum);
        if(null!=comprdId && undefined !=comprdId){
            $(".orderItem").each(function(){
                var itemComPrdId = $(this).attr("combinedProductId");
                var numInput = $(this).find(".return_num");
                if(itemComPrdId == comprdId){
                    var canReturnNum  = numInput.attr("canReturnNum");
                    numInput.val(canReturnNum);
                }
            });
        }
        return;
    } else if (parseInt(changeNum) <= 0) {
        applyPurchaseAlertDialog("退换货数量数量不能小于或等于0");
        numInput.val(returnedNum);
        if(null!=comprdId && undefined !=comprdId){
            $(".orderItem").each(function(){
                var itemComPrdId = $(this).attr("combinedProductId");
                var numInput = $(this).find(".return_num");
                if(itemComPrdId == comprdId){
                    var canReturnNum  = numInput.attr("canReturnNum");
                    numInput.val(canReturnNum);
                }
            });
        }
        return;
    } else if (parseInt(changeNum) > parseInt(returnedNum)) {
        applyPurchaseAlertDialog("退换货数量大于下单数量");
        numInput.val(returnedNum);
        if(null!=comprdId && undefined !=comprdId){
            $(".orderItem").each(function(){
                var itemComPrdId = $(this).attr("combinedProductId");
                var numInput = $(this).find(".return_num");
                if(itemComPrdId == comprdId){
                    var canReturnNum  = numInput.attr("canReturnNum");
                    numInput.val(canReturnNum);
                }
            });
        }
        return;
    }

    if(isReturn == true){
        var currentNum  = numInput.val();
        if(null != comprdId && undefined != comprdId) {
            if(changeNum%comprdNum!=0){
                $(".orderItem").each(function(){
                    var itemComPrdId = $(this).attr("combinedProductId");
                    var numInput = $(this).find(".return_num");
                    if(itemComPrdId == comprdId){
                        var canReturnNum  = numInput.attr("canReturnNum");
                        numInput.val(canReturnNum);
                    }
                });
            }else {
                var mulNum = changeNum/comprdNum;
                $(".orderItem").each(function () {
                    var itemComPrdId = $(this).attr("combinedProductId");
                    var numInput = $(this).find(".return_num");
                    if(itemComPrdId == comprdId) {
                        var itemComPrdNum = $(this).attr("combinedProductItemNum");
                        numInput.val(itemComPrdNum*mulNum);
                    }
                });
            }
        }
    }
};
var ajaxReturnOrder = function () {
    var value = getValue();
    $.ajaxSettings['contentType'] = "application/json; charset=utf-8;";
    $.ajax({
        type: "POST",
        url: webPath.webRoot + "/afterSale/add.json",
        data: _ObjectToJSON("post", value),
        async: false,
        success: function (data) {
            if (data.errorCode === "errors.comment.notOrder") {
                applyPurchaseAlertDialog("您的订单尚未完成，请完成后再申请！");
                return;
            }
            if (data.success === 'true') {
                goToUrl(webPath.webRoot + "/module/member/returnedPurchase.ac");
            }
        },
        error:function (result) {
            var data = eval("("+result.responseText+")");
            alert(data.errorObject.errorText);
        }
    });
};
var getValue = function () {
    var items = [];
    var i = 0;
    $(".orderItem").each(function (i) {
        items[i] = {
            orderItemId: $(this).find("input[name=orderItemId]").val(),
            quantity: $(this).find("input[name=num]").val(),
            combinedProductId: $(this).attr("combinedProductId")
        };
        i++;
    });

    var tyoeCode = $("input[name = typeCode]").val();
    if (tyoeCode == '0') {
        return {
            orderId: webPath.orderId,
            name:$("#receiverName").val(),
            tel: $("#receiverMobile").val(),
            descr: $("#remark").val(),
            typeCode: $("input[name=typeCode]").val(),
            receiverAddr: $("#province").find('option:selected').text() + $("#city").find('option:selected').text() + $("#zone").find('option:selected').text() + $("#receiverAddr").val(),
            photoFileId: $("#photoFileId").val(),
            orderItems: items
        }
    } else {
        return {
            orderId: webPath.orderId,
            name:$("#receiverName").val(),
            tel: $("#receiverMobile").val(),
            descr: $("#remark").val(),
            typeCode: $("input[name=typeCode]").val(),
            photoFileId: $("#photoFileId").val(), orderItems: items
        }
    }
};
var checkAddress = function () {
    if ($("#province").val() == "" || $("#city").val() == "" || $("#zone").val() == "" || $("#receiverAddr").val() == "") {
        $("#addrTipCorrect").hide();
        $("#addrTipError").show();
        return false;
    } else {
        $("#addrTipError").hide();
        $("#addrTipCorrect").show();
        return false;
    }
};
var setAddrNm = function (zoneId) {
    if (zoneId != null && zoneId != '') {
        $.ajax({
            type: "post", url: webPath.webRoot + "/member/zoneNm.json",
            data: {zoneId: zoneId},
            dataType: "json",
            success: function (data) {
                var defaultValue = [data.provinceNm, data.cityNm, data.zoneNm];
                addrSelect.ld("api").selected(defaultValue)
            }
        });
    }
};
var loadAddr = function () {
    return $(".addressSelect").ld({
        ajaxOptions: {"url": webPath.webRoot + "/member/addressBook.json"},
        defaultParentId: 9
    });
};
var removeOrderItem = function (orderItemId) {
    var comPrdId = $("#" + orderItemId).attr("combinedProductId");
    $("#" + orderItemId).remove();
    if(null != comPrdId && undefined != comPrdId) {
        $(".orderItem").each(function () {
            if ($(this).attr("combinedProductId") == comPrdId) {
                $(this).remove();
            }
        });
    }
    if ($(".orderItem").length <= 0) {
        goToUrl(webPath.webRoot + "/module/member/selectPurchaseByOrderId.ac?orderId="+webPath.orderId);
        //goToUrl(webPath.webRoot + "/module/member/selectPurchase.ac");
//                window.location.href = webPath.webRoot+"/module/member/selectPurchase.ac";
    }
};


//最普通最常用的alert对话框，默认携带一个确认按钮
var applyPurchaseAlertDialog = function(dialogTxt){
    var dialog = jDialog.alert(dialogTxt);
};


