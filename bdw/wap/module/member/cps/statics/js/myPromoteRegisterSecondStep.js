var wayCode = '1';
$(function(){
    //输入框内容清除
    $('.clear').click(function () {
        var next = $(this).next();
        if (next != undefined) {
            next.val("");
        }
    });

    //切换银行卡信息
   /* $('.tab-nav li').click(function(){
        var id = $(this).attr('id');
        if(id=="bankCard"){//切换到银行卡
            $('#alipay').removeClass('active');
            $('#bankCard').addClass('active');
            $('.div-bank-card').show();
            $('.div-alipay').hide();
            wayCode = '0';
        }else{//切换到支付宝
            $('#bankCard').removeClass('active');
            $('#alipay').addClass('active');
            $('.div-bank-card').hide();
            $('.div-alipay').show();
            wayCode = '1';
        }
    });*/

    //协议
    $('.deal-toggle').click(function(){
        $('#promoteRuleDiv').show();
    });

    $(".layer-bg .close-btn").click(function(){
        $(".layer-bg").hide();
    });

    if(!isEmpty(withdrawalWayCode)){
      /*  if(withdrawalWayCode=='0'){//银行卡
            $('#alipay').removeClass('active');
            $('#bankCard').addClass('active');
            $('.div-bank-card').show();
            $('.div-alipay').hide();
            wayCode = '0';
        }else{//支付宝
            $('#bankCard').removeClass('active');
            $('#alipay').addClass('active');
            $('.div-bank-card').hide();
            $('.div-alipay').show();
            wayCode = '1';
         }*/
        $('#alipay').addClass('active');
        wayCode = '1';
    }
});

//提交注册信息
function submitRegisterInfo(){
    var type =  $(".tab-nav li[class='active']").attr('id');
    if(type=="bankCard") {//银行卡
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
    }else {//支付宝
        var alipayOpenManName = $('#alipayOpenManName').val().trim();
        if(isEmpty(alipayOpenManName)){
            alert("请填写真实姓名");
            $('#alipayOpenManName').val('');
            return;
        }

        if(alipayOpenManName.length<2 || alipayOpenManName.length>10){
            alert("真实姓名长度为2~10字符");
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
    }

    var requestUrl = null;
    if(isEmpty(approveStat)){//第一次申请
        requestUrl = webPath.webRoot + "/promoteMember/becomeAPromoteMember.json";
    }else{//重新提交
        requestUrl = webPath.webRoot + "/promoteMember/reApplyForPromoteMember.json";
    }

    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8;";
    $.ajax({
        type: "POST",
        url: requestUrl,
        data: {
            promoteMemberId:memberId,
            name: userName,
            mobile: userPhone,
            withdrawalWayCode: wayCode,
            bankInf:$.trim($("#bankInfo").val()),
            bankAccount:$.trim($("#bankAccount").val()),
            bankOpenManName:$.trim($("#bankOpenManName").val()),
            alipayAccount:$.trim($("#alipayAccount").val()),
            alipayOpenManName:$.trim($("#alipayOpenManName").val()),
            bankOfDeposit:$.trim( $('#bankName').val())
        },
        dataType: "json",
        async: false,//同步
        success: function (data) {
            if (data.success == false) {
                alert('操作失败，请稍后再试');
            } else {
                setTimeout(function () {
                    //跳转到审核中的页面
                    location.href = webPath.webRoot + "/wap/module/member/cps/myPromoteRegisterThirdStep.ac";
                }, 1)
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

//推广联盟协议
function agreement(obj, nextBtn){
    if($(obj).is(':checked')){//同意协议
        $('.' + nextBtn).css('background-color', '#2fbdc8');
        $('.' + nextBtn).attr('href', 'javascript:submitRegisterInfo();');
    }else{//不同意协议
        $('.' + nextBtn).css('background-color', '#D3D3D3');
        $('.' + nextBtn).attr('href', 'javascript:void(0);');
    }
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