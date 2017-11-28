$(document).ready(function(){
    $("body").bind('keyup',function(event) {
        if(event.keyCode==13){
            authCheckUserForm();
        }
    });

    $.validator.setDefaults({
        submitHandler: function(form) { form.submit(); }
    });

    jQuery.validator.addMethod("stringCheck",function(value,element){
        return this.optional(element) || /^[\u0391-\uFFE5\w]+$/.test(value);
    },"含有非法字符");

    $("#checkForm").validate({
        rules:{
            name:{
                required:true,
                stringCheck:true,
                minsize:2
            }
        },
        messages:{
            realName:{
                required: "请输入真实姓名!",
                stringCheck:"真实姓名含有非法字符!",
                minsize :jQuery.validator.format("真实姓名在2~20个字之间!")
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
});

var authCheckUserForm = function(){
    if(!checkUserRealName()){
        return false;
    }

    if(!checkUserIdCardValidate()){
        return false;
    }

    if(!checkUserMobileValidate()){
        return false;
    }

    if(!checkValidateCode()){//验证码验证
        return false;
    }

    if($("#checkForm").valid() == false){
        return false;
    }
    var params = $("#checkForm").formToArray();

    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8;";
    $.ajax({
        type:"GET",
        url:webPath.webRoot+"/member/checkUser.json",
        data:params,
        dataType: "json",
        async: false,//同步
        success:function(data) {
            if (data.success == "true") {
                alert("验证成功!");
                //base64加密
                $.base64.utf8encode = true;//设置转码字符
                var realName = $.trim($("#realName").val());
                var idCard = $.trim($("#idCard").val());
                var userMobile = $.trim($("#userMobile").val());
                var concatStr = data.erpUserId+"&"+realName+"&"+idCard+"&"+userMobile+"&"+data.userSex;
                var fid = $.base64.encode(concatStr);
                window.location.href = webPath.webRoot+"/userInfo.ac?code="+fid;
            }
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                alert(result.errorObject.errorText);
                changValidateCode();
            }
        }
    });
    return;
};

//检查真实姓名
var checkUserRealName = function(){
    var realName = $("#realName").val();
    if($.isBlank(realName)){
        showTip("#realNameTip","请输入真实姓名!");
        return false;
    }
    if(realName.length < 2 || realName.length > 20){
        showTip("#realNameTip","真实姓名在2~20个字之间!");
        return false;
    }
    showSuccess("#realNameTip");
    return true;
}

//检查身份证号码
var checkUserIdCardValidate = function(){
    var idCard = $("#idCard").val();
    if($.isBlank(idCard)){
        showTip("#idCardTip","请输入身份证号码!");
        return false;
    }
    var reCard = /^[1-9](\d{1,19})[0-9xX]$/
    if(!reCard.test(idCard)){
        showTip("#idCardTip","请输入有效的身份证号码!");
        return false;
    }
    showSuccess("#idCardTip");
    return true;
}

//手机检查
var checkUserMobileValidate = function(){
    var userMobile = $("#userMobile").val();
    if($.isBlank(userMobile)){
        showTip("#mobileTip","请输入手机号!");
        return false;
    }
    var reMobile = /^\d{7,12}$/;
    if(!reMobile.test(userMobile)){
        showTip("#mobileTip","请输入有效的手机号!");
        return false;
    }
    showSuccess("#mobileTip");
    webPath.mobileFlag = true;
    return true;
};

//校验验证码
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


//改变验证码
var changValidateCode = function (){
    $("#validateCodeImg").attr("src", webPath.webRoot+"/ValidateCode?" + Math.random());
};

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

//判断字符是否为空
(function($){
    $.isBlank = function(obj){
        return(!obj || $.trim(obj) === "");
    };
})(jQuery);

