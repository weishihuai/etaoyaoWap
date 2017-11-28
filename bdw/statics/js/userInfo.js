$(document).ready(function(){
    $("body").bind('keyup',function(event) {
        if(event.keyCode==13){
            checkRegisterForm();
        }
    });
    var $pwd = $('#userPsw');
    $pwd.passwordStrength();
    $.validator.setDefaults({
        submitHandler: function(form) { form.submit(); }
    });
    jQuery.validator.addMethod("stringCheck",function(value,element){
        return this.optional(element) || /^[\u0391-\uFFE5\w]+$/.test(value);
    },"含有非法字符");
    jQuery.validator.addMethod("loginIdCheck",function(value,element){
        return checnLoginId();
    },"");
    $("#userAddrForm").validate({
        rules:{
            name:{
                required:true,
                stringCheck:true,
                minlength:3
            },
            userPsw:{
                required: true,
                minlength:6
            },
            checkPassword:{
                required: true,
                minlength:6,
                equalTo: "#userPsw"
            },
            userEmail:{
                required: true,
                email:true
            }
        },
        messages:{
            loginId:{
                required: "请输入用户帐号!",
                stringCheck:"用户帐号含有非法字符!",
                minlength:jQuery.validator.format("会员名称在2~20个字之间!")
            },
            userPsw:{
                required: "请输入密码!",
                minlength:jQuery.validator.format("密码为6-16位数字、字母或者符号，建议混合使用!")
            },
            checkPassword:{
                required: "请输入确认密码!",
                minlength:jQuery.validator.format("确认密码为6-16位数字、字母或者符号，建议混合使用!"),
                equalTo: "两次输入密码不一致，请再次输入密码!"
            },
            userEmail:{
                required: "请输入E_mail!",
                email:"请输入有效的E_mail!"
            }
        }
        ,errorPlacement: function(error, element) {
            var tips = element.parent().parent().children(".tips");
            tips.find("span").html(error.text());
            tips.show();
        }
        ,success: function(label, element) {
            element.parent().parent().children(".tips").hide();
            element.parent().parent().children(".pass").show();
        }
    });
    //失去焦点触发
    $("#loginId").blur(function(){
        checnLoginId();
    });
    $("#userPsw").blur(function(){
        checkPsw();
    });
    $("#checkPassword").blur(function(){
        cheCkcheckPsw();
    });
});
var checkRegisterForm = function(){
    if(!checnLoginId()){
        return false;
    }
    if(!checkPsw()){
        return false;
    }
    if(!cheCkcheckPsw()){
        return false;
    }
    if(!checkUserMailValidate()){//邮箱验证
        return false;
    }

    if(!checkValidateCode()){//验证码验证
        return false;
    }
    if(!pitchOn()){//同意协议
        return false;
    }

    if($("#registerForm").valid() == false){
        return false;
    }
    var params = $("#registerForm").formToArray();

    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8;";
    $.ajax({
        type:"POST",
        url:webPath.webRoot+"/member/completeRegister.json",
        data:params,
        dataType: "json",
        async: false,//同步
        success:function(data) {
            if (data.success == false) {
                if(data.errorCode=="errors.saveUser.duplicateLoginId"){
                    showTip("#loginIdTip","注册失败:您填写的电子邮箱已被注册");
                    return;
                }
                else  if(data.errorCode=="errors.saveUser.duplicateEmail"){
                    showTip("#emailTip","注册失败:邮箱已被他人注册!");
                    return;
                }
                else{
                    if(data.errorCode=="errors.saveUser.duplicateEmai"){
                        showTip("#emailTip","注册失败:邮箱已被他人注册!");
                        return;
                    }
                }
            }
            else{
                setTimeout(function(){
                    window.location.href=webPath.webRoot+"/registerSuccess.ac";
                },1)

            }
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                if(result.errorObject.errorText=="输入验证码不正确"){
                    alert(result.errorObject.errorText);
                    changValidateCode();
                    return;
                }
                alert(result.errorObject.errorText);
                alert(result.jsonError.errorText);
                changValidateCode();
            }
        }
    });
    return;
};
/**
 * 检查用户名（为空和是否存在）*/
var checnLoginId = function(){
    var bol = false;
    var loginId = $.trim($("#loginId").val());
    if($.isBlank(loginId)){
        showTip("#loginIdTip","请输入用户帐号!");
        return bol;
    }
    if(loginId.length < 2 || loginId.length > 20){
        showTip("#loginIdTip","会员名称在2~20个字之间!");
        return bol;
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
                /*if(data.errorCode=="errors.login.noexist"){*/
                /*用户名可用*/
                showSuccess("#loginIdTip");
                bol = true;
                /*   }*/
            }
            else{
                showTip("#loginIdTip","用户名已被他人注册!");
                bol = false;
            }
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                alert(result.jsonError.errorText);
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
    if($.isBlank(userPsw)){
        showTip("#userPswTip","请输入密码!");
        return false;
    }
    if(userPsw.length < 6 || userPsw.length > 16){
        showTip("#userPswTip","密码为6-16位数字、字母或者符号，建议混合使用!");
        return false;
    }
    showSuccess("#userPswTip");
    return true;
};
/**
 * 检查重复密码（长度和密码一致验证）*/
var cheCkcheckPsw = function(){
    var checkPassword = $("#checkPassword").val();
    if($.isBlank(checkPassword)){
        showTip("#checkPasswordTip","请再次输入密码!");
        return false;
    }
    if(checkPassword.length < 6 || checkPassword.length > 16){
        showTip("#checkPasswordTip","确认密码为6-16位数字、字母或者符号，建议混合使用!");
        return false;
    }
    if(!checkPasswordValidate()){/*确认密码长度及一致验证*/
        return false;
    }
    showSuccess("#checkPasswordTip");
    return true;
};
/**
 * 密码和重复密码一致性验证*/
var checkPasswordValidate = function(){

    var userPsw = $("#userPsw").val();
    var checkPassword = $("#checkPassword").val();
    if(userPsw != checkPassword){
        showTip("#checkPasswordTip","两次输入密码不一致，请再次输入密码!");
        return false;
    }else{
        showSuccess("#checkPasswordTip");
    }
    return true;
};
/**
 * 同意协议才能注册
 * @returns {boolean}
 */
var pitchOn = function(){
    var tongYi = document.getElementById("tongYi");
    if(tongYi.checked==false){
        alert("请阅读，并同意该协议")
        return false;
    }
    return true;
}
/**
 * 邮箱检查（空和邮箱合法性、是否存在验证）*/
var checkUserMailValidate = function(){
    var userEmail = $("#userEmail").val();
    if($.isBlank(userEmail)){
        showTip("#emailTip","请输入邮箱!");
        return false;
    }
    var reMail=/^[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?$/;
    if(!reMail.test(userEmail)){
        showTip("#emailTip","请输入有效的E_mail!");
        return false;
    }
    if(!checkUserEmail(userEmail)){
        return false;
    }
    showSuccess("#showTip");
    return true;
};
var checkValidateCode = function(){
    var validateCode = $("#validateCode").val();
    if($.isBlank(validateCode)){
        showTip("#checkValidateCodeTip","请输入验证码!");
        return false;
    }
    if(validateCode.length<4){
        showTip("#checkValidateCodeTip","请输入4位验证码!");
        return false;
    }
    $("#checkValidateCodeTip").hide();
    return true;
};
/**
 * 检查邮箱是否已被注册*/
function checkUserEmail(userEmail){
    var bol = false;
    $.ajax({
        type:"GET",
        url:webPath.webRoot+"/member/isExistEmail.json",
        data:{email:userEmail},
        async: false,//同步
        success:function(data) {
            if(data.success == false){
                showSuccess("#emailTip");
                bol = true;
            }
            else{
                showTip("#emailTip","注册失败:您填写的电子邮箱已被注册，您是否忘记密码？点击 <a href="+webPath.webRoot+"/fetchPsw/fetchPsw.ac>找回密码</a>");
                bol = false;
            }
        },
        error:function(data){
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                alert(result.jsonError.errorText);
                bol =  false;
            }
        }
    });
    return bol;
}
var showTip = function(tipId,errorText){
    var tips = $(tipId);
    tips.parent().children(".pass").hide();
    tips.find("span").html(errorText);
    tips.show();
};
var showSuccess = function(tipId){
    $(tipId).hide();
    $(tipId).parent().children(".pass").show();
};
/*改变验证码*/
var changValidateCode = function (){
    $("#validateCodeImg").attr("src", webPath.webRoot+"/ValidateCode?" + Math.random());
};

//判断字符是否为空
(function($){
    $.isBlank = function(obj){
        return(!obj || $.trim(obj) === "");
    };
})(jQuery);