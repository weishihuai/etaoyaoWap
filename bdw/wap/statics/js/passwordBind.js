$(document).ready(function(){


    $("#userPsw").blur(function(){
        checkPsw();
    }).keyup(function () {
        showLoginBtn();
        delBtnVisible();
    });


    //密码清除
    $(".del-btn").click(function () {
        $(this).hide();
        $("#userPsw").val("");
        showLoginBtn();
    });
});

//控制重置密码输入框按钮
function delBtnVisible(){
    if($.trim($("#userPsw").val()).length < 1){
        if($(".del-btn").is(":visible")){
            $(".del-btn").hide();
        }
    }else{
        if($(".del-btn").is(":hidden")){
            $(".del-btn").show();
        }
    }
}



/**
 * 检查密码（空、长度和密码强度验证）*/
var checkPsw = function(){
    var userPsw = $("#userPsw").val();
    if(userPsw == ""){
        showTips("请输入密码!");
        return false;
    }
    var checkPsw=/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$/;
    if(!checkPsw.test(userPsw)){
        showTips("密码必须为6~20位字母、数字组合");
        return false;
    }
    return true;
};


function showTips(tips) {
    $("#tipsSpan").text(tips);
    $("#tipsDiv").show();
    setTimeout(function () {
        $("#tipsDiv").hide();
    }, 2000);
}

//控制登录按钮是否可点击
function showLoginBtn(){
    var canShow = isLoginBtnShow();
    if(canShow){
        if($(".login-btn").hasClass("disbale")){
            $(".login-btn").removeClass("disbale");
        }
    }else{
        if(!$(".login-btn").hasClass("disbale")){
            $(".login-btn").addClass("disbale");
        }
    }
}

function isLoginBtnShow(){

    var userPsw = $.trim($("#userPsw").val());
    if(userPsw == ""){
        return false;
    }
    var checkPsw=/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$/;
    if(!checkPsw.test(userPsw)){
        return false;
    }
    return true;
}
function confirmLogin(){
    var loginId = $('#loginId').val();
    if($.trim(loginId) == ""){
        return false;
    }

    var checkCode = /^1(\d{10})$/;
    if(!checkCode.test(loginId)){
        return false;
    }


    var userPsw = $('#userPsw').val();
    if(!checkPsw()){
        return false;
    }




    //非空验证结束
    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
    $.ajax({
        type:"POST",
        url:webPath.webRoot+"/member/weixinBindlogin.json",
        data:{loginId:loginId,userPsw:$.md5(userPsw)},
        dataType: "json",
        success:function(data) {
            if (data.success == false) {
                checkLoginResult(data);
            }
            else{
                window.location.href=webPath.webRoot+"/wap/module/member/index.ac?pIndex=member";
                showTips("登陆成功");
            }
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {



                var obj = JSON.parse(XMLHttpRequest.responseText);

                checkLoginResult(obj.errorObject);
                var result = eval("(" + XMLHttpRequest.responseText + ")");
//                                "{\"errorObject\":{\"errorData\":null,\"errorCode\":\"errors.login.userstat\",\"errorText\":\"用户{0}的状态不正常\"}}"
//                 checkLoginResult(result.errorObject);
//                 changValidateCode();
            }
        }
    });

}
function checkLoginResult(data){
    if (data.errorCode == "errors.login.userstat") {
        showTips("用户已被冻结，请联系客服！");
        $("#loginId").val("");
        $("#loginId").focus();

    }
    else if (data.errorCode == "errors.login.noexist") {
        showTips("该账户名不存在");
        $("#loginId").focus();
        $("#loginId").val("");
        $("#userPsw").val("");
        $("#validateCode").val("");

    }
    else if (data.errorCode == "errors.login.password") {
        showTips("用户名与密码不匹配");
        $("#userPsw").focus();
        $("#userPsw").val("");
        $("#validateCode").val("");

    } else if (data.errorCode == "errors.login.no.remain.time") {
        showTips(data.errorText);
        $("#validateCode").focus();
        $("#validateCode").val("");

    } else if (data.errorCode == "errors.remain.time.login.password") {
        showTips("密码出错" );
        $("#userPsw").focus();
        $("#userPsw").val("");
        $("#validateCode").val("");


    }else  if(data.errorCode=="errors.login.validate"){
        showTips("验证码错误");
        $("#validateCode").focus();
        $("#validateCode").val("");
        $(".jud-error").show();

    }
    else {
        showTips("账户冻结或账户已被删除");
        $("#loginId").val("");
        $("#loginId").focus();

    }
}
