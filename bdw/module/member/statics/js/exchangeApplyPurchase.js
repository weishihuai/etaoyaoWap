var addrSelect;//加载地区
$(document).ready(function () {
    addrSelect = loadAddr();
    setAddrNm(webPath.receiverZoneId);
    $("#hh_btnAdd").click(function () {
        if ($("input[name='num']").val() == null || $("input[name='num']").val() == '') {
            alert("请选择退换货数量!");
            return;
        }
        $("#hh_purchaseForm").submit();
    });
    $.formValidator.initConfig({
        theme: "ArrowSolidBox", formID: "hh_purchaseForm",
        onSuccess: function () {
            exchangeOrder()
        }, onError: function () {
            alert("您还有信息未完善")
        }
    });
    /* $(":adio[name='typeCode']").cliValidator({tipID:"typeCodeTip",onShow:"请选择处理方式",onFocus:"请选择处理方式",onCorrect:"输入正确",defaultValue:["1"]})
     .inputValidator({min:1,max:1,onError:"请选择处理方式"});*/
    $("#hh_remark").formValidator({onShow: "请输入问题备注", onFocus: "请输入问题备注",leftTrim:true,rightTrim:true})
        .inputValidator({min: 5, max: 255, onError: "请输入字符长度5~255的问题备注"});
    $("#hh_receiverAddr").formValidator({onShow: "请完善收货地址", onFocus: "请完善收货地址",leftTrim:true,rightTrim:true})
        .functionValidator({
            fun: function (val) {
                checkAddress();
            }
        });
    $("#hh_receiverName").formValidator({onShow: "请输入联系人", onFocus: "请输入联系人",leftTrim:true,rightTrim:true})
        .inputValidator({min: 2, max: 24, onError: "请输入字符长度2~24位的联系人信息"});
    $("#hh_receiverMobile").formValidator({onShow: "请输入手机号码", onFocus: "请输入手机号码",leftTrim:true,rightTrim:true})
        .inputValidator({regExp: "num", min: 11, max: 11, onError: "请输入数字长度11位的联系人信息"});

    //2015-04-03,改为非必须
    //$("#hh_photoFileId").formValidator({onShow:"请选择JPG图片文件上传",onFocus:"请选择JPG图片文件上传"}).inputValidator({min:11,onError:"请选择JPG图片文件上传"});
    /*$(":radio[name='typeCode']").click(function(){
     if($(this).val() == '0'){
     $("#hh_addr_div").hide();
     $("#hh_receiverAddr").attr("disabled",true).unFormValidator(true); //解除校验
     }else{
     $("#hh_addr_div").show();
     $("#hh_receiverAddr").attr("disabled",false).unFormValidator(false);//恢复校验
     }
     });*/
    var options = {
        dataType: 'html',
        success: function (responseText, statusText, xhr, $form) {
            try {
                var result = eval("(" + responseText + ")");
                if (result.success == "false") {
                    alert("您提交的图片格式不正确");

                } else if (result.success == "true") {
                    $("#hh_photoFileId").attr("value", $.trim(result.fileId));
                    $("#hh_upload_pic").attr("src", $.trim(result.url));
                    $("#hh_tip").dialog('close');

                }
            } catch (err) {
                alert("您上传的图片不符合规格,请上传.jpg格式文件");
            }
        }
    };
    $('#hh_upload').submit(function () {
        $(this).ajaxSubmit(options);
        return false;
    });
    $("#hh_upLoad_btn").click(function () {
        $("#hh_tip").dialog({
            buttons: {
                '确定': function () {
                    $("#hh_upload").submit();
                },
                '取消': function () {
                    $("#hh_tip").dialog('close');
                }
            }
        });
    });
});
var changeItemNum = function (div, returnedNum) {
    var numInput = $("#" + div);
    var changeNum = numInput.val();
    if (/[^\d]/.test(changeNum)) {
        alert("请输入整数");
        numInput.val(returnedNum);
    } else if (parseInt(changeNum) <= 0) {
        alert("退换货数量数量不能小于或等于0");
        numInput.val(returnedNum);
    } else if (parseInt(changeNum) > parseInt(returnedNum)) {
        alert("退换货数量大于下单数量");
        numInput.val(returnedNum);
    }
};
var exchangeOrder = function () {
    var value = getValue();
    $.ajaxSettings['contentType'] = "application/json; charset=utf-8;";
    $.ajax({
        type: "POST",
        url: webPath.webRoot + "/afterSale/add.json",
        data: _ObjectToJSON("post", value),
        async: false,
        success: function (data) {
            if (data.errorCode === "errors.comment.notOrder") {
                alert("您的订单尚未完成，请完成后再申请！");
                return;
            }
            if (data.success === 'true') {
                goToUrl(webPath.webRoot + "/module/member/exchangePurchase.ac");
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
            quantity: $(this).find("input[name=num]").val()
        };
        i++;
    });

    var tyoeCode = $("input[name = typeCode]").val();
    if (tyoeCode == '0') {
        return {
            orderId: webPath.orderId,
            name:$("#hh_receiverName").val(),
            tel: $("#hh_receiverMobile").val(),
            descr: $("#hh_remark").val(),
            typeCode: $("input[name=typeCode]").val(),
            receiverAddr: $("#hh_province").find('option:selected').text() + $("#hh_city").find('option:selected').text() + $("#hh_zone").find('option:selected').text() + $("#hh_receiverAddr").val(),
            photoFileId: $("#hh_photoFileId").val(),
            orderItems: items
        }
    } else {
        return {
            orderId: webPath.orderId,
            name:$("#hh_receiverName").val(),
            tel: $("#hh_receiverMobile").val(),
            descr: $("#hh_remark").val(),
            typeCode: $("input[name=typeCode]").val(),
            photoFileId: $("#hh_photoFileId").val(),
            orderItems: items
        }
    }
};
var checkAddress = function () {
    if ($("#hh_province").val() == "" || $("#hh_city").val() == "" || $("#hh_zone").val() == "" || $("#hh_receiverAddr").val() == "") {
        $("#hh_addrTipCorrect").hide();
        $("#hh_addrTipError").show();
        return false;
    } else {
        $("#hh_addrTipError").hide();
        $("#hh_addrTipCorrect").show();
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
                var defaultValue = [data.provinceNm, data.cityNm, data.countryNm];
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
    $("#" + orderItemId).remove();
    if ($(".orderItem").length <= 0) {
        goToUrl(webPath.webRoot + "/module/member/selectPurchase.ac");
//                window.location.href = webPath.webRoot+"/module/member/selectPurchase.ac";
    }
};
