$(document).ready(function(){
    //失去焦点触发
    $("#loginId").blur(function(){
        checkLoginId();
    }).keyup(function () {
        showLoginBtn();
    });

});
var checkRegisterForm = function(openId){
    if(!checkLoginId()){
        return false;
    }
    if($("#registerForm").valid() == false){
        return false;
    }
    var params = $("#registerForm").formToArray();
    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8;";
    $.ajax({
        type:"POST",
        url:webPath.webRoot+"/member/register.json",
        data:params,
        dataType: "json",
        async: false,//同步
        success:function(data) {
            if (data.success == false) {
                if(data.errorCode=="errors.saveUser.duplicateLoginId"){
                    showTips("注册失败:您填写的电子邮箱已被注册!");
                }
                else  if(data.errorCode=="errors.saveUser.duplicateEmail"){
                    showTips("注册失败:邮箱已被他人注册!");
                }
                else{
                    if(data.errorCode=="errors.saveUser.duplicateEmai"){
                        showTip("注册失败:邮箱已被他人注册!");
                    }
                }
            }
            else{
                showTips("注册成功!");
                setTimeout(function () {
                    window.location.href=webPath.webRoot+"/wap/login.ac";
                }, 2000);
            }
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                showTips(result.errorObject.errorText);
            }
        }
    });

};

/**
 * 检查用户名（为空和是否存在）*/
var checkLoginId = function(){
    var bol = false;
    var loginId = $.trim($("#loginId").val());
    if(loginId == ""){
        showTips("请输入手机号!");
        return bol;
    }
    var checkMobile = /^1(\d{10})$/;
    if(!checkMobile.test(loginId)){
        showTips("请输入正确的手机号!");
        return false;
    }

    return bol;
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
    var loginId = $.trim($("#loginId").val());
    var checkMobile = /^1(\d{10})$/;
    if(!checkMobile.test(loginId) || loginId == ""){
        return false;
    }
    return true;
}



//判断是否登陆
function checkIsRegisterAndBand(){

    var mobile = $("#loginId").val();
    // var openId = $("#openId").val();
    if($.trim(mobile) == ""){
        showTips("请输入手机号");
        return false;
    }

    var checkMobile = /^1(\d{10})$/;
    if(!checkMobile.test(mobile)){
        showTips("请输入正确的手机号");
        return false;
    }
    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
    $.ajax({
        type : "POST",
        url : webPath.webRoot + "/member/checkIsRegisterAndBand.json",
        data : {mobile : mobile},
        dataType : "json",
        success : function(data){
            if(data.success == "INDEX"){
                window.location.href=webPath.webRoot+"/wap/index.ac";
            }else if(data.success == "WEIXINREGISTER"){
                window.location.href=webPath.webRoot+"/wap/weixinRegister.ac?loginId="+mobile;
            }else if(data.success == "REBIND"){
                window.location.href=webPath.webRoot+"/wap/weixinRebind.ac?loginId="+mobile;
            }else if(data.success == "PASSWORDBIND"){
                window.location.href=webPath.webRoot+"/wap/passwordBind.ac?loginId="+mobile;
            }
        },

        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                showTips(result.errorObject.errorText);
            }
        }

    });
}

//检查验证码
function checkMobile(){
    var bol = false;
    var mobile = $("#loginId").val();
    var code = $("#code").val();
    if($.trim(code) == ""){
        showTips("请输入验证码");
        return;
    }
    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
    $.ajax({
        url : webPath.webRoot + "/member/checkMobileCode.json",
        type : "post",
        dataType : "json",
        data : {code : code,mobile : mobile},
        async:false,    //设置同步
        success : function(data){
            if(data.success == "true"){
                bol = true;
            }
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                showTips(result.errorObject.errorText);
            }
        }
    });
    return bol;
}

//清除验证码
function setHtml(){
    $("#second").html();
    if(s > 0){
        if(!$("#second").hasClass("count")){
            $("#second").addClass("count");
        }
        $("#second").html("重新发送" + s);
        s--;
    }else{
        clearInterval(sh);
        if($("#second").hasClass("count")){
            $("#second").removeClass("count");
        }
        $("#second").html("重新发送验证码");
        s = 60;
        clearSessionCode();
    }
}

function clearSessionCode(){
    $.ajax({
        url : webPath.webRoot + "/member/clearSessionCode.json",
        type : "post",
        dataType : "json",
        success : function(data){
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                alert(result.errorObject.errorText);
            }
        }
    });
}