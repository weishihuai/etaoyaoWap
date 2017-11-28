$(function(){
    var fetchPswSet = {imgErrorSrc:webPath.webRoot+'/template/bdw/statics/images/register_ico01.gif',
        errorBackground:'none repeat scroll 0 0 #fff'};
    $.imallTipSettings(fetchPswSet);
    /*密码找回*/
    $("#email").blur(function(){
        checkUserEmail($(this));
    });
    $("#code").blur(function(){
        checkCode($(this));
    });
    $("#fetchSubmit").click(function(){
        if(!checkUserEmail($("#email"))){
            return;
        }
        if(!checkCode($("#code"))){
            return;
        }
        sendEmail($("#email").val(),$("#code").val());
    });
    /*密码找回*/
    /*重置密码*/
    var $pwd = $('#resetPsw');
    $pwd.passwordStrength();
    $("#resetPsw").blur(function(){
        checkPsw($("#resetPsw"));
    });
    $("#confirmPsw").blur(function(){
        checkPsw($("#confirmPsw"));
    });
    $("#resetSubmit").click(function(){
        if(!checkPsw($("#resetPsw"))){
            return;
        }
        if(!checkPsw($("#confirmPsw"))){
            return;
        }
        if(!checkConfigPassword($("#resetPsw"),$("#confirmPsw"))){
            return;
        }
        resetPsw($.trim($("#resetPsw").val()));
    });
    /*重置密码*/
});
var checkPsw = function(pswObj){
    var userPsw = $.trim(pswObj.val());
    if(userPsw == ""){
        pswObj.imallValidTip("error","请输入密码!");
        return false;
    }
    //if(userPsw.length < 6 || userPsw.length > 16){
    //    pswObj.imallValidTip("error","密码为6-16位数字、字母或者符号，建议混合使用!");
    //    return false;
    //}
    var checkPsw=/^[a-zA-Z0-9]{8,20}$/;
    if(!checkPsw.test(userPsw)){
        pswObj.imallValidTip("error","密码为8-20位数字或字母加数字，建议混合使用!");
        return false;
    }
    pswObj.imallValidTip("success","");
    return true;
};
var checkConfigPassword = function(pswObj,confirmPswObj){
    var resetPsw = $.trim(pswObj.val());
    var confirmPsw = $.trim(confirmPswObj.val());
    if(resetPsw != confirmPsw){
        confirmPswObj.imallValidTip("error","确认密码与重置密码不一致!");
        return false;
    }
    return true;
};
/*改变验证码*/
var changValidateCode = function(){
    $("#validateCodeImg").attr("src", webPath.webRoot+"/ValidateCode?" + Math.random());
};
/*验证邮箱必填*/
var checkUserEmail = function(emailObj){
    var userEmail = $.trim(emailObj.val());
    if(userEmail == ""){
        $("#email").imallValidTip("error","请填写你的E-mail地址!");
        return false;
    }
    var reMail=/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/;
    if(!reMail.test(userEmail)){
        $("#email").imallValidTip("error","请输入有效的E_mail!");
        return false;
    }
    $("#email").imallValidTip("success","");
    return true;
};
/*验证验证码必填*/
var checkCode = function(codeObj){
    var codeStr = $.trim(codeObj.val());
    if(codeStr == ''){
        codeObj.imallValidTip("error","请输入验证码");
        return false;
    }else{
        codeObj.imallValidTip("success",'');
        return true;
    }
};
/*发邮件*/
var sendEmail = function (userEmail,validateCode){
    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
    $.ajax({
        type:"POST",url:webPath.webRoot+"/member/sendEmail.ac",
        data:{validateCode:validateCode,userEmail:userEmail},
        dataType:"json",
        success:function(data){
            if (data.success == false) {
                if(data.errorCode=="errors.login.validate"){
                    $("#code").imallValidTip("error","验证码输入错误!");
                    changValidateCode();
                    return false;
                }else if(data.errorCode=="noSendAgain"){
                    alert('您刚已经发送了一次邮件！');
                    return false;
                }else if(data.errorCode=="notOpenEmail"){
                    alert('系统未开启找回密码功能，请与客服联系！');
                    return false;
                }else {
                    $("#email").imallValidTip("error","邮箱未注册!");
                    return false;
                }
            }else{
                window.location=webPath.webRoot+"/fetchPsw/fetchPswSuccess.ac?email="+userEmail
            }
        },
        error:function(XMLHttpRequest, textStatus) {
            alert("找回密码失败!");
            return false;
        }
    });
};
/*修改密码*/
var resetPsw = function(password){
    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
    $.ajax({
        type:"GET",
        url:webPath.webRoot+"/member/setNewPassword.json",
        data:{newPassword:$.md5(password),userId:webPath.userId,validateInfCode:webPath.validateInfCode},
        success:function(data){
            if(data.success == true){
                setTimeout(function() {window.location=webPath.webRoot+"/fetchPsw/restPswSuccess.ac"}, 3000);
            }
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                alert(result.errorObject.errorText);
            }
        }
    });
};
