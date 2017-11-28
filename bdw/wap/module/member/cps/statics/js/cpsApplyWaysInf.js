var $btnBlockHref= $(".btn-block").attr("href");

$(function(){
    //输入框内容清除
    $('.clear').click(function () {
        var next = $(this).next();
        if (next != undefined) {
            next.val("");
        }
    });
});
//提交银行信息
function submitBink(){
    var bankName = $('#bankName').val().trim();
    if(isEmpty(bankName)){
        alert('请选择银行');
        return;
    }

    var bankInfo = $('#bankInfo').val().trim();
    if(isEmpty(bankInfo)){
        alert('请填写支行信息');
        $('#bankInfo').val('');
        return;
    }

    if(bankInfo.length>128){
        alert('支行信息超过64个字符');
        return;
    }

    var bankOpenManName = $('#bankOpenManName').val().trim();
    if(isEmpty(bankOpenManName)){
        alert("请填写开户人姓名");
        $('#bankOpenManName').val('');
        return;
    }

    if(bankOpenManName.length<2 || bankOpenManName.length>10){
        alert("开户人姓名长度为2~10字符");
        return;
    }

    var bankAccount = $('#bankAccount').val().trim();
    if(isEmpty(bankAccount)){
        alert("请填写正确的银行卡账号");
        $('#bankAccount').val('');
        return;
    }

    var reg = /^(\d{16}|\d{19})$/;
    if(!reg.test(bankAccount)){
        alert("请填写正确的银行卡账号");
        return;
    }
    var requestUrl = webParams.webRoot + "/promoteMember/bindPayWay.json";
    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8;";
    $.ajax({
        type: "POST",
        url: requestUrl,
        data: {
            withdrawalWayCode: '0',
            bankInf:$.trim($("#bankInfo").val()),
            bankAccount:$.trim($("#bankAccount").val()),
            bankOpenManName:$.trim($("#bankOpenManName").val()),
            bankOfDeposit:$.trim( $('#bankName').val())
        },
        dataType: "json",
        async: false,//同步
        success: function (data) {
            if (data.success == false) {
                alert('操作失败，请稍后再试');
            } else {
                alert('绑定成功');
                setTimeout(function () {
                    //跳转到审核中的页面
                    location.href = webParams.webRoot + "/wap/module/member/cps/myPromoteRegisterThirdStep.ac";
                }, 1000)
            }
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                alert(result.errorObject.errorText);
                $(".btn-block").attr("href",$btnBlockHref);
            }
        }
    });
}

//提交支付宝信息
function submitAlipay(){
    var alipayOpenManName = $('#alipayOpenManName').val().trim();
    if(isEmpty(alipayOpenManName)){
        alert("请填写真实姓名");
        $('#alipayOpenManName').val('');
        return;
    }

    if(alipayOpenManName.length<2 || alipayOpenManName.length>5){
        alert("真实姓名长度为2~5字符");
        return;
    }

    var alipayAccount = $('#alipayAccount').val().trim();
    if(isEmpty(alipayAccount)){
        alert("请填写支付账号");
        $('#alipayAccount').val('');
        return;
    }

    if(alipayAccount.length>32){
        alert("支付账号长度超过32字符");
        return;
    }
    $(".btn-block").attr("href",'javascript:volid(0);');
    var requestUrl = webParams.webRoot + "/promoteMember/bindPayWay.json";
    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8;";
    $.ajax({
        type: "POST",
        url: requestUrl,
        data: {
            withdrawalWayCode: '1',
            alipayAccount:$.trim($("#alipayAccount").val()),
            alipayOpenManName:$.trim($("#alipayOpenManName").val())
        },
        dataType: "json",
        async: false,//同步
        success: function (data) {
            if (data.success == false) {
                alert('操作失败，请稍后再试');
            } else {
                alert('绑定成功');
                setTimeout(function () {
                    //跳转到审核中的页面
                    location.href = webParams.webRoot + "/wap/module/member/cps/cpsApplyWays.ac";
                }, 1000)
            }
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                alert(result.errorObject.errorText);
                $(".btn-block").attr("href",$btnBlockHref);
            }
        }
    });
}

//判空
function isEmpty(text){
    text = $.trim(text);
    if(text==undefined || text==null || text==""){
        return true;
    }else{
        return false;
    }
}