$(document).ready(function(){

    $(".agree").click(function () {
        $(this).toggleClass("selected");
        showLoginBtn();
    });

    //失去焦点触发
    $("#loginId").blur(function(){
        checkLoginId();
    }).keyup(function () {
        showLoginBtn();
    });
    $("#userPsw").blur(function(){
        checkPsw();
    }).keyup(function () {
        showLoginBtn();
        delBtnVisible();
    });
    $("#code").blur(function(){
        checkValidateCode();
    }).keyup(function () {
        showLoginBtn();
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

var checkRegisterForm = function(){
    if(!checkLoginId()){
        return false;
    }
    if(!checkPsw()){
        return false;
    }
    if(!checkMobile()){
        return false;
    }
    if(!$(".agree").hasClass("selected")){
        return false;
    }
    if($("#registerForm").valid() == false){
        return false;
    }
    var params = $("#registerForm").formToArray();
    params[2]={name:'userPsw',value:$.md5(params[2].value)};
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
    //测试登录名重复
    $.ajaxSettings['contentType'] = "application/json; charset=utf-8;";
    $.ajax({
        type:"POST",
        url:webPath.webRoot+"/member/isExistLoginId.json?loginId="+loginId,
        dataType: "json",
        async: false,//同步
        success:function(data) {
            if (data.success == false) {
                bol = true;
                //发送验证码按钮可点击
                var second = $("#second");
                if(second.hasClass("count")){
                    second.removeClass("count");
                    second.css("pointer-events","");
                }
            }
            else{
                showTips("用户名已被他人注册!");
                bol = false;
                //发送验证码按钮不可点击
                var second = $("#second");
                if(!second.hasClass("count")){
                    second.addClass("count");
                    second.css("pointer-events","none");
                }
            }
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                showTips(result.jsonError.errorText);
                bol = false;
            }
        }
    });
    return bol;
};
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
var checkValidateCode = function(){
    var code = $("#code").val();
    if(code == ""){
        showTips("请输入验证码!");
        return false;
    }
    if(code.length<6){
        showTips("请输入有效验证码!");
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
    var agreeSelect = $(".agree").hasClass("selected");
    var userPsw = $.trim($("#userPsw").val());
    var loginId = $.trim($("#loginId").val());
    var code = $.trim($("#code").val());
    if(loginId == ""){
        return false;
    }

    var checkMobile = /^1(\d{10})$/;
    if(!checkMobile.test(loginId)){
        return false;
    }

    if(userPsw == ""){
        return false;
    }
    var checkPsw=/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$/;
    if(!checkPsw.test(userPsw)){
        return false;
    }
    if(code == ""){
        return false;
    }
    if(code.length<6){
        return false;
    }
    if(!agreeSelect){
        return false;
    }
    return true;
}


/** 短信相关 **/
var s = 120;
var sh;
//发送验证码
function sendCode(){
    if(s != 120){//修改为120秒倒计时
        return false;
    }
    var mobile = $("#loginId").val();
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
        url : webPath.webRoot + "/member/sendMobileCode.json",
        data : {mobile : mobile},
        dataType : "json",
        success : function(data){
            if(data.success == "true"){
                sh = setInterval("setHtml()",1000);
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