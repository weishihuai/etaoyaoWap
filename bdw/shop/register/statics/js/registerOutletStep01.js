var viewed = false;
$(document).ready(function () {
    $("#checkS").removeAttr("checked");

    var loginId=getByLocalStorage('outletRegisterData.userInf.loginId');
    // var userPsw=getByLocalStorage('outletRegisterData.userInf.userPsw');
    var mobile =getByLocalStorage('outletRegisterData.userInf.userMobile');
    var email = getByLocalStorage('outletRegisterData.userInf.userEmail');

    $("#registerLoginId").val(loginId == null ? '' : loginId);
    //$("#userPsw").val(userPsw == null ? '' : userPsw);
    $("#mobile").val(mobile == null ? '' : mobile);
    $("#email").val(email == null ? '' : email);

    $("#registerLoginId").blur(function () {
        checnLoginId();
    });
    $("#userPsw").blur(function () {
        checkPsw();
    });
    $("#checkPassword").blur(function () {
        cheCkcheckPsw();
    });
    $("#mobile").blur(function () {
        checkMobile();
    });
    $("#email").blur(function () {
        checkEmail();
    });
    $("#checkS").click(function(){
        if(!viewed) {
            $(this).removeAttr("checked");
            showErrorWin("请先查看服务协议!");
        }
    });
    $(".btnConfirm").click(function() {
        $('.registerProvisions').hide();
    });


    if(webPath.countDown == "yes"){
        //获取验证码倒计时
        var leftTime = $.cookie('leftTimeCookie');
        if (leftTime != null && leftTime != 0) {
            countDown($("#sendValidateCode"), leftTime);
        }
    }
});


function countDown (showTime, leftTime) {
    var date = new Date();
    showTime.html(leftTime + "s重新获取");
    showTime.attr("disabled","true");
    sh = setInterval(function () {
        if (leftTime <= 1) {
            clearInterval(sh);
            showTime.html("发送手机验证码");
            showTime.removeAttr("disabled");
            $.cookie('leftTimeCookie', '', {
                expires: -1,
                path: webPath.webRoot
            });
        } else {
            leftTime -= 1;
            date = new Date();
            date.setTime(date.getTime() + leftTime * 1000);
            $.cookie('leftTimeCookie', leftTime, {
                expires: date,
                path: webPath.webRoot
            });
            showTime.html(leftTime + "s重新获取");
        }
    }, 1000);
}

//检查用户名（为空和是否存在）
var checnLoginId = function () {
    var bol = false;
    var loginId = $.trim($("#registerLoginId").val());
    if (loginId == "") {
        showTip("#registerLoginIdTip", "请输入用户名!");
        return bol;
    }
    if (loginId.length < 4 || loginId.length > 20) {
        showTip("#registerLoginIdTip", "用户名长度在4-20个字符之间，请重新输入!");
        return bol;
    }
    //测试登录名重复
    $.ajax({
        type: "POST",
        url: webPath.webRoot + "/member/isExistLoginId.json?loginId=" + loginId,
        async: false,//同步
        success: function (data) {
            if (data.success == false) {
                showSuccess("#registerLoginIdTip");
                bol = true;
            }
            else {
                showTip("#registerLoginIdTip", "该用户已被使用!");
                bol = false;
            }
        },
        error:errorFun
    });
    return bol;
};

//检查密码（空、长度和密码强度验证）
var checkPsw = function () {
    var userPsw = $("#userPsw").val();
    if (userPsw == "") {
        showTip("#userPswTip", "请输入密码!");
        return false;
    }
    //var reg=/^(([a-zA-Z]+[0-9]+)|([0-9]+[a-zA-Z]+))[a-zA-Z0-9][^\<\>]*$/;
    var reg= /^(?![A-Za-z]+$)(?![0-9]+$)(?![\x21-\x2F\x3A-\x40\x5B-\x60\x7B-\x7E]+$)[\x21-\x3b\x3d\x3f-\x7e][^\<\>]{7,}$/
    if (userPsw.length < 8 || userPsw.length > 16) {
        showTip("#userPswTip", "密码为长度8-16位字符");
        return false;
    }
    if(!reg.test(userPsw)){
        showTip("#userPswTip", "使用字母、数字和符号两种及以上组合");
        return false;
    }
    showSuccess("#userPswTip");
    return true;
};

// 检查重复密码（长度和密码一致验证）
var cheCkcheckPsw = function () {
    var checkPassword = $("#checkPassword").val();
    if (checkPassword == "") {
        showTip("#checkPasswordTip", "请再次输入密码!");
        return false;
    }
    if (checkPassword.length < 8 || checkPassword.length > 16) {
        showTip("#checkPasswordTip", "确认密码为长度8-16位字符");
        return false;
    }
    if (!checkPasswordValidate()) {/*确认密码长度及一致验证*/
        return false;
    }
    showSuccess("#checkPasswordTip");
    return true;
};

//密码和重复密码一致性验证
var checkPasswordValidate = function () {

    var userPsw = $("#userPsw").val();
    var checkPassword = $("#checkPassword").val();
    if (userPsw != checkPassword) {
        showTip("#checkPasswordTip", "两次输入密码不一致，请重新输入!");
        return false;
    } else {
        showSuccess("#checkPasswordTip");
    }
    return true;
};


//检查验证码
var checkValidateCode = function () {
    var validateCode = $.trim($("#validateCode").val());
    if (validateCode == "") {
        showTip("#validateCodeTip", "验证码不能为空!");
        return false;
    }
    if (validateCode.length != 6 ) {
        showTip("#validateCodeTip", "验证码长度为6位，请重新输入!");
        return false;
    }
    if(verifyValidateCode(validateCode)){
        showSuccess("#checkPasswordTip");
    }else {
        return false;
    }
    return true;
};

var checkShopStep01 = function () {

    if (!checnLoginId()) {             //用户账号验证
        return false;
    }
    if (!checkPsw()) {                 //密码验证
        return false;
    }
    if (!checkMobile()) {             //检查申请人手机
        return false;
    }
    if (!checkEmail()) {             //检查申请人邮箱
        return false;
    }
    if (!checkValidateCode()) {         //验证码验证
        return false;
    }

    var loginId = $.trim($("#registerLoginId").val());
    var userPsw = $.trim($("#userPsw").val());
    var mobile = $.trim($("#mobile").val());
    var email = $.trim($("#email").val());
    var validateCode = $.trim($("#validateCode").val());
    var userPswMd5 = $.md5(userPsw);

    putToLocalStorage('outletRegisterData.userInf.loginId', loginId);
    putToLocalStorage('outletRegisterData.userInf.userPsw', userPswMd5);
    putToLocalStorage('outletRegisterData.userInf.userMobile', mobile);
    putToLocalStorage('outletRegisterData.userInf.userEmail', email);

    location.href = webPath.webRoot+"/shop/register/registerOutletStep02.ac"
};


//检查申请人手机
var checkMobile = function () {
    var mobile = $.trim($("#mobile").val());
    var strP = /1[0-9]{10}/;
    if (mobile == "") {
        showTip("#mobileTip", "请输入手机!");
        return false;
    }
    if (mobile.length < 11) {
        showTip("#mobileTip", "手机不能少于11位!");
        return false;
    }
    if (!strP.test(mobile)) {
        showTip("#mobileTip", "请输入正确的手机号!");
        return false;
    }
    if (!checkUserMobile(mobile)) {
        return false;
    }
    showSuccess("#mobileTip");
    return true;
};

/*检查手机是否已被注册*/
function checkUserMobile(userMobile) {
    var bol = false;
    $.ajax({
        type: "POST",
        url: webPath.webRoot + "/shop/sysShopInfFront/checkMobile.json",
        data: {mobile: userMobile},
        async: false,//同步
        success: function (data) {
            if (data.success == "true") {
                showSuccess("#mobileTip");
                bol = true;
            }
            else {
                showTip("#mobileTip", "手机已被使用!");
                bol = false;
            }
        },
        error: errorFun
    });
    return bol;
}

//检查申请人邮箱
var checkEmail = function () {
    var theEmail = $.trim($("#email").val());
    if (email == "") {
        showTip("#emailTip", "请输入邮箱!");
        return false;
    }
    var reMail = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/;
    if (!reMail.test(theEmail)) {
        showTip("#emailTip", "邮箱地址不正确，请重新输入!");
        return false;
    }
    if (!checkUserEmail(theEmail)) {
        return false;
    }
    showSuccess("#emailTip");
    return true;
};

/*检查邮箱是否已被注册*/
function checkUserEmail(theEmail) {
    var bol = false;
    $.ajax({
        type: "POST",
        url: webPath.webRoot + "/shop/sysShopInfFront/checkEmail.json",
        data: {email:theEmail},
        async: false,//同步
        success: function (data) {
            if (data.success == "true") {
                showSuccess("#emailTip");
                bol = true;
            }
            else {
                showTip("#emailTip", "邮箱已被使用!");
                bol = false;
            }
        },
        error: errorFun
    });
    return bol;
}



function showRegisterProvisions(){
    $(".registerProvisions").show();
}

function errorFun(XMLHttpRequest, textStatus) {
    if (XMLHttpRequest.status == 500) {
        var result = eval("(" + XMLHttpRequest.responseText + ")");
        showErrorWin(result.errorObject.errorText);
    }
}

//验证验证码是否正确
var verifyValidateCode= function(validateCode){
    var isValidate = false;
    $.ajax({
        type:"POST",
        url:webPath.webRoot+"/member/checkMobileCode.json",
        data:{code:validateCode, mobile :  $.trim($("#mobile").val())},
        async: false,//同步
        success:function(data){
            if (data.success == "false") {
                if(data.errorCode=="验证码错误"){
                    showTip("#validateCodeTip", "验证码错误!");
                }else if(data.errorCode=="验证码过期"){
                    showTip("#validateCodeTip", "验证码已过期!");
                }
            }else {
                showSuccess("#validateCodeTip");
                isValidate = true;
            }
        },
        error: errorFun
    });
    return isValidate;
};

function sendValidateCode(){
    if (!checkMobile()) {             //检查申请人手机
        return false;
    }
    $.ajax({
        type:"POST",
        url:webPath.webRoot+"/member/sendMobileCode.json",
        data:{mobile :  $.trim($("#mobile").val())},
        async: false,//同步
        success:function(data){
            if(data.success == "true"){
                countDown($("#sendValidateCode"), (webPath.smsSeconds ? webPath.smsSeconds:120));
            }else if (data.success == "false") {
                if(data.errorCode=="noSendAgain"){
                    showErrorWin("验证码已发送，请稍后再试！");
                    return false;
                }
            }
        },
        error: errorFun
    });
}