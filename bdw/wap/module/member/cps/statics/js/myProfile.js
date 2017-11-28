$(function(){
    //点击联系人、联系手机
    $('.entry-layer').click(function(){
        var type = $(this).attr('type');

        if(type=='name'){//联系人
            $('.layer').find('h2').text('修改联系人');
        }else{//联系手机
            $('.layer').find('h2').text('修改联系手机');
        }

        $('#inputInfo').val($.trim($(this).find('.val').text()));
        $('.layer').find('.btn').attr('href', 'javascript:layerSure("' + type + '");');
        $('.layer').find('.btn').css('background-color', '#ff6b00');
        $('#layerBg').show();
        $('.layer').show();
    });

    $('.inputInfoDel').click(function(){
        $('#inputInfo').val('');
        $('#inputInfo').val($.trim($('#inputInfo').val()));
        $('.layer').find('.btn').css('pointer-events','none');
        $('.layer').find('.btn').css('background-color', '#D3D3D3');
    });

    $('.validateCodeDel').click(function(){
        $('#validateCode').val('');
    });

    $('#layerBg').click(function(){
        $('.layer').find('.btn').css('pointer-events','none');
        $('.layer').find('.btn').css('background-color', '#ff6b00');
        $('#layerBg').hide();
        $('.layer').hide();
    });

    $('.clear').click(function(){
        $(this).next().val('');
    });

    $('#inputInfo').keyup(function(){
        if(isEmpty($('#inputInfo').val())){
            $('.layer').find('.btn').css('pointer-events','none');
            $('.layer').find('.btn').css('background-color', '#D3D3D3');
        }else{
            $('.layer').find('.btn').css('pointer-events','auto');
            $('.layer').find('.btn').css('background-color', '#ff6b00');
        }
    });


});

//修改联系人、联系手机
function layerSure(type){
    if(type=='name') {//联系人
        var name = $('#inputInfo').val().trim();
        if(isEmpty(name)){
            alert('请输入联系人');
            return;
        }

        $('#nameHide').val(name);
        $('#nameSpan').text(name);
    }else {//联系手机
        var mobile = $('#inputInfo').val().trim();
        if(isEmpty(mobile)){
            alert('请输入联系手机');
            return;
        }

        var reg = /^\d{11}$/;
        if(!reg.test(mobile)){
            alert('请输入正确的手机号');
            return;
        }

        $('#mobileHide').val(mobile);
        $('#mobileSpan').text(mobile);
    }

    upateCpsMemberInfo();
    $('#layerBg').hide();
    $('.layer').hide();
}

//进入修改银行卡信息页面
function gotoMyBankProfile(){
    $('#infoForm').attr('action', webParams.webRoot + '/wap/module/member/cps/myBankProfile.ac');
    $('#infoForm').submit();
}

//进入修改支付宝信息页面
function gotoMyAlipayProfile(){
    $('#infoForm').attr('action', webParams.webRoot + '/wap/module/member/cps/myAlipayProfile.ac');
    $('#infoForm').submit();
}

var leftSeconds = 120;//倒计时时间120秒
//获取验证码
function getValidateCode(obj) {
    $.ajax({
        type: "POST",
        url: webParams.webRoot + "/member/sendValidateCode.json",
        data:{},
        success: function (data) {
            if(data.success == "true"){
                countDown(leftSeconds, $(obj));
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

//倒计时
function countDown(leftTime, obj) {
    obj.hide();
    var countObj = obj.parent().find(".count-down");
    countObj.show();
    countObj.html("等待" + leftTime +"秒");
    sh = setInterval(function () {
        leftTime -= 1;
        if (leftTime <= 0) {
            countObj.hide();
            obj.show();
            clearInterval(sh);
        } else {
            countObj.html("等待" + leftTime +"秒");
        }
    }, 1000);
}

//判空
function isEmpty(obj){
    obj = $.trim(obj);

    if(obj==undefined || obj==null || obj==''){
        return true;
    }else{
        return false;
    }
}

//修改银行卡
function upateBankInfo(){
    var bankOfDeposit = $('#bankOfDeposit').val().trim();
    if(isEmpty(bankOfDeposit)){
        alert('请选择银行');
        return;
    }
    $('#bankOfDepositHide').val(bankOfDeposit);

    var bankInf = $('#bankInf').val().trim();
    if(isEmpty(bankInf)){
        alert('请填写支行信息');
        $('#bankInf').val('');
        return;
    }
    $('#bankInfHide').val(bankInf);

    if(bankInf.length>128){
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
    $('#bankOpenManNameHide').val(bankOpenManName);

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
    $('#bankAccountHide').val(bankAccount);

    var validateCode = $('#validateCode').val().trim();
    if(isEmpty(validateCode)){
        alert("请输入验证码");
        return;
    }
    $('#validateCodeHide').val(validateCode);

    upateCpsMemberInfo();
}

//修改支付宝信息
function upateAlipayInfo(){
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
    $('#alipayOpenManNameHide').val(alipayOpenManName);

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
    $('#alipayAccountHide').val(alipayAccount);

    var validateCode = $('#validateCode').val().trim();
    if(isEmpty(validateCode)){
        alert("请输入验证码");
        return;
    }
    $('#validateCodeHide').val(validateCode);

    upateCpsMemberInfo();
}

//更新cps会员信息
function upateCpsMemberInfo(){
    $.ajax({
        type: "POST",
        url: webParams.webRoot + "/promoteMember/updateCpsMemberInfo.json",
        data: $('#infoForm').serialize(),
        async: false,//同步
        success: function (data) {
            if (data.success == 'true') {
                // showSuccess("修改成功");
                setTimeout(function () {
                    window.location.href = webParams.webRoot + "/wap/module/member/cps/myProfile.ac";
                }, 1200)
            } else {
                // alert("修改失败，请刷新后重试！");
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
