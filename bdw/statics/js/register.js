$(document).ready(function(){
    $("body").bind('keyup',function(event) {
        if(event.keyCode==13){
            checkRegisterForm();
        }
    });
    var $pwd = $("#registerForm").find('#userPsw');
    //var checkPsw=/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,20}$/;
    $pwd.passwordStrength();
    $.validator.setDefaults({
        submitHandler: function(form) { form.submit(); }
    });
    jQuery.validator.addMethod("stringCheck",function(value,element){
        return this.optional(element) || /^[\u0391-\uFFE5\w]+$/.test(value);
    },"含有非法字符");
    jQuery.validator.addMethod("pswStringCheck",function(value,element){
        return this.optional(element) || /^(?![A-Z]+$)(?![a-z]+$)(?!\d+$)(?![\W_]+$)\S{6,16}$/.test(value);
    },"密码必须为6~16位字母和数字或者符号组合！");
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
                pswStringCheck:true,
                minlength:8
            },
            checkPassword:{
                required: true,
                pswStringCheck:true,
                minlength:8,
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
                pswStringCheck:"密码必须为6~16位字母和数字组合！",
                minlength:jQuery.validator.format("密码必须为6~16位字母和数字或者符号组合！")
            },
            checkPassword:{
                required: "请输入确认密码!",
                pswStringCheck:"确认密码必须为6~16位字母和数字组合！",
                minlength:jQuery.validator.format("确认密码必须为6~16位字母和数字或者符号组合！"),
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
    $("#registerForm").find("#loginId").blur(function(){
        checnLoginId();
    });
    $("#registerForm").find("#userPsw").blur(function(){
        checkPsw();
    });
    $("#registerForm").find("#checkPassword").blur(function(){
        cheCkcheckPsw();
    });
    $("#registerForm").find("#userAgreement").click(function(){
        var userAgreement =$("#userAgreement").html();
        var article= $("#content").html();
        easyDialog.open({
            container : {
                header : userAgreement,
                content : article,
                yesFn : function(){return true}
            },
            fixed: true,
            //lock:false,
        });
        $("#easyDialogWrapper").css("margin","-170px");
        $(".easyDialog_content").css("width","800px");
        $(".easyDialog_content").css("height","auto");
        $(".easyDialog_content").css("overflow","auto");
        $(".easyDialog_text").css("width","770px");
        $(".easyDialog_text").css("height","400px");
        $(".easyDialog_text").css("overflow","auto");
        $(".easyDialog_footer").css("margin-top","10px");
        $(".easyDialog_footer").css("margin-right","10px")
    });

    $("#unRelease").click(function(){
        easyDialog.open({
            container : {
                header : "提示",
                content : "该用户服务协议未发布！",
                yesFn : function(){return true}
            },
            fixed: true
        });
    })
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
    if(!checkMobile()){
        return false;
    }
    //if(!checkUserMailValidate()){//邮箱验证
    //    return false;
    //}

    //if(!checkValidateCode()){//验证码验证
    //    return false;
    //}
    if(!pitchOn()){//同意协议
        return false;
    }
    //2015年12月11日 会员注册去除手机验证
    /*//手机号正确性和唯一性判断
    if (!checkUserMobileValidate()) {
        return false;
    }

    if ($.trim($("#messageCode").val()) == '') {
        alert("请输入您的短信验证码");
        $("#messageCode").focus();
        return false;
    }*/

    if($("#registerForm").valid() == false){
        return false;
    }
    var params = $("#registerForm").formToArray();
    params[5]={name:'userPsw',value:$.md5(params[5].value)};
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
                    //showTip("#loginIdTip","注册失败:注册失败:您填写的电子邮箱已被注册，您是否忘记密码？点击 <a href="+webPath.webRoot+"/fetchPsw/fetchPsw.ac>找回密码</a>");
                    showTip("#loginIdTip","注册失败:注册失败:您填写的电子邮箱已被注册");

                }
                else  if(data.errorCode=="errors.saveUser.duplicateEmail"){
                    showTip("#emailTip","注册失败:邮箱已被他人注册!");

                }
                else{
                    if(data.errorCode=="errors.saveUser.duplicateEmai"){
                        showTip("#emailTip","注册失败:邮箱已被他人注册!");

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

};
/**
 * 检查用户名（为空和是否存在）*/
var checnLoginId = function(){
    var bol = false;
    var loginId = $.trim($("#registerForm").find("#loginId").val());
    if(undefined == loginId || null == loginId || loginId == ""){
        showTip("#loginIdTip","请输入手机号!");
        return bol;
    }
    /*if(loginId.length < 2 || loginId.length > 20){
        showTip("#loginIdTip","会员名称在2~20个字之间!");
        return bol;
    }*/
    var checkMobile = /^1[3|4|5|7|8]\d{9}$/;
    if(!checkMobile.test(loginId)){
        showTip("#loginIdTip","请输入正确的手机号!");
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
                /*if(data.errorCode=="errors.login.noexist"){*/
                /*手机号可用*/
                showSuccess("#loginIdTip");
                bol = true;
                /*   }*/
            }
            else{
                showTip("#loginIdTip","手机号已注册!");
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
    var userPsw = $("#registerForm").find("#userPsw").val();
    if(userPsw == ""){
        showTip("#userPswTip","请输入密码!");
        return false;
    }
    if(userPsw.length < 6|| userPsw.length > 16){
        showTip("#userPswTip","密码必须为6~16位字母和数字或者符号组合！");
        return false;
    }
    if(!/^(?![A-Z]+$)(?![a-z]+$)(?!\d+$)(?![\W_]+$)\S{6,16}$/.test(userPsw)){
        showTip("#userPswTip","密码必须为6~16位字母和数字或者符号组合！");
        return false;
    }
    showSuccess("#userPswTip");
    return true;
};
/**
 * 检查重复密码（长度和密码一致验证）*/
var cheCkcheckPsw = function(){
    var checkPassword = $("#registerForm").find("#checkPassword").val();
    if(checkPassword == ""){
        showTip("#checkPasswordTip","请再次输入密码!");
        return false;
    }
    if(checkPassword.length < 6 || checkPassword.length > 16){
        showTip("#checkPasswordTip","确认密码必须为6~16位字母和数字组合！");
        return false;
    }
    /*if(!/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,20}$/.test(userPsw)){
        showTip("#checkPasswordTip","密码必须为8~20位字母和数字组合！");
        return false;
    }*/
    if(!checkPasswordValidate()){/*确认密码长度及一致验证*/
        return false;
    }
    showSuccess("#checkPasswordTip");
    return true;
};
/**
 * 密码和重复密码一致性验证*/
var checkPasswordValidate = function(){

    var userPsw = $("#registerForm").find("#userPsw").val();
    var checkPassword = $("#registerForm").find("#checkPassword").val();
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
        alert("请阅读，并同意该协议");
        return false;
    }
    return true;
};
/**
 * 邮箱检查（空和邮箱合法性、是否存在验证）*/
var checkUserMailValidate = function(){
    var userEmail = $("#userEmail").val();
    /*if(userEmail == ""){
        showTip("#emailTip","请输入邮箱!");
        return false;
    }*/
    var reMail=/^[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?$/;
    if(userEmail != "" && !reMail.test(userEmail)){
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
    var userEmail = $("#validateCode").val();
    if(userEmail == ""){
        showTip("#checkValidateCodeTip","请输入验证码!");
        return false;
    }
    if(userEmail.length<4){
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


//======================================================

//手机检查
var checkUserMobileValidate = function(){
    var userMobile = $("#registerForm").find("#loginId").val();
    if(userMobile == ""){
        showTip("#mobileTip","请输入手机号!");
        return false;
    }
    var reMobile = /^1(\d{10})$/;
    if(!reMobile.test(userMobile)){
        showTip("#mobileTip","请输入有效的手机号!");
        return false;
    }
    if(!checkUserMobile(userMobile)){
        return false;
    }
    showSuccess("#mobileTip");
    webPath.mobileFlag = true;
    return true;
};


//检查手机号是否已经存在 start
function checkUserMobile(userMobile){
    var bol = false;
    $.ajax({
        type:"GET",
        url:webPath.webRoot+"/member/isExistMobile.json",
        data:{mobile:userMobile},
        async: false,//同步
        success:function(data) {
            if(data.success == false){
                showSuccess("#mobileTip");
                bol = true;
            }
            else{
                showTip("#mobileTip","该手机号已被注册，您如果忘记密码可联系管理员进行修改");
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
//检查手机号是否已经存在 end



/*发送短信验证码 start*/
/*var leftSeconds = 120;//倒计时时间120秒
var intervalId;//倒数时间对象
var sendValidateCount = 1;//点击发送次数控制
var sendValidateSwitch = false;//取消订单发送短信开关
var btnObj;//这个对象是必须声明的
var sendValidateNum = function (thisBtn) {
    //必须填写验证码,并且匹配正确
    //if(!checkValidateCode()){//验证码验证
    //    return false;
    //}
    var moblieValue = $('#loginId').val();
    alert(moblieValue);
    if ($.trim(moblieValue) == '') {
        alert("请先输入您的手机号码");
        $('#loginId').focus();
        return;
    }

    //if (!webPath.mobileFlag) {
    //    alert("请输入可注册的手机号码");
    //    $('#userMobile').focus();
    //    return;
    //}

    btnObj = thisBtn;
    //发送短信
    sendValidateSwitch = true;//用于取消订单开关判断
    $('#sendValidateNumBtn').attr("disabled", true);//设置按钮不可用
    sendValidateJSON();
};


var countDown = function () {//倒计时方法
    if (leftSeconds <= 0) {
        $('#sendValidateNumBtn').val("发送验证码"); //当时间<=0的时候改变按钮的value
        $('#sendValidateNumBtn').attr("disabled", false);//如果时间<=0的时候按钮可用
        clearInterval(intervalId); //取消由 setInterval() 设置的 timeout
        leftSeconds = 120;
        return;
    }

    leftSeconds--;
    $('#sendValidateNumBtn').val("等待" + leftSeconds + "秒");
};

//发送验证码
var sendValidateJSON = function () {
    var moblieValue = $('#userMobile').val();
    moblieValue = $.trim(moblieValue);
    var checkCode = $.trim($("#validateCode").val());
    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
    $.ajax({
        type: "POST",
        url: webPath.webRoot + "/bdwController/sendValidateNum.json",
        data: {
            mobileNum: moblieValue,validatorCode:checkCode
        },
        dataType: "json",
        success: function (data) {
            if (data.success == "true") {
                //发送成功
                //禁用按钮,开始倒数
                $('#sendValidateNumBtn').attr("disabled", true);//设置按钮不可用
                intervalId = setInterval("countDown()", 1000);//调用倒计时的方法
            } else if (data.success == "false") {
                //当第一次发送失败的时候,不进行倒数,而是变成"重新发送",当点击"重新发送"的时候,还发送失败就开始进行倒数
                sendValidateCount++;
                $('#sendValidateNumBtn').attr("disabled", false);//设置按钮可用
                $('#sendValidateNumBtn').attr("value", "重新发送");
                if (sendValidateCount > 2) {
                    sendValidateCount = 1;
                    $('#sendValidateNumBtn').attr("disabled", true);//设置按钮不可用
                    intervalId = setInterval("countDown()", 1000);//调用倒计时的方法
                }
            }
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                if(result.errorObject.errorText == "验证码错误"){
                    alert(result.errorObject.errorText);
                    changValidateCode();
                    $('#sendValidateNumBtn').attr("disabled", false);//设置按钮可用
                    return;
                }
                alert(result.errorObject.errorText);
                changValidateCode();
            }

        }
    });
};*/
/*发送短信验证码 end*/

/** 短信相关 **/
var s = 120;
var sh;
//发送验证码
function sendCode(){
    if(s != 120){//修改为120秒倒计时
        return false;
    }
    var mobile = $("#registerForm").find("#loginId").val();
    if($.trim(mobile) == ""){
        alert("请输入手机号");
        return false;
    }

    var checkMobile = /^1[3|4|5|7|8]\d{9}$/;
    if(!checkMobile.test(mobile)){
        alert("请输入正确的手机号");
        return false;
    }
    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
    $.ajax({
        type : "POST",
        url : webPath.webRoot + "/member/sendMobileCode.json",
        data : {mobile : mobile},
        dataType : "json",
        async:false,
        success : function(data){
            if(data.success == "true"){
                sh = setInterval("setHtml()",1000);
            }
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                alert(result.errorObject.errorText);
            }
        }

    });
}

//检查验证码
function checkMobile(){
    var bol = false;
    var mobile = $("#registerForm").find("#loginId").val();
    var code = $("#code").val();
    if($.trim(code) == ""){
        alert("请输入验证码");
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
                //location.href = webPath.webRoot + "/register.ac?mobile=" + mobile + "&code=" + code;
            }
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                alert(result.errorObject.errorText);
            }
        }

    });
    return bol;
}


//清楚验证码
function setHtml(){
    $("#second").html();
    if(s > 0){
        $("#second").html(s + "秒后重发");
        s--;
    }else{
        clearInterval(sh);
        $("#second").html("重新发送验证码");
        s = 120;
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

