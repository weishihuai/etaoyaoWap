$(function(){
    var fetchPswSet = {imgErrorSrc:webPath.webRoot+'/template/bdw/statics/images/register_ico01.gif',
        errorBackground:'none repeat scroll 0 0 #fff'};
    $.imallTipSettings(fetchPswSet);
    $("body").bind('keyup',function(event) {
        if(event.keyCode==13){
            checkUserMsg();
        }
    });
    //失去焦点触发
    $("#loginId").blur(function(){
        checnLoginId();
    });
    $("#userMobile").blur(function(){
        checkUserMobile();
    });
    $("#validateCode").blur(function(){
        checkValidateCode();
    });
    $("#userPsw").blur(function(){
        checkPsw();
    });
    $("#checkPassword").blur(function(){
        cheCkcheckPsw();
    });
    $("#fetchSubmit").click(function(){
        if(!checkUserMobile()){
            checkUserMobile();
            return;
        }
        //验证通过
        if(checkMsgBeforeFetchPsw()){
            //验证登录帐号和手机号是否对应的
            checkUserMsg();
        }
    });

    ////修改密码
    $("#fetchPassword").click(function(){
        if(!checkPsw()){
            checkPsw();
            return;
        }
        if(!cheCkcheckPsw()){
            cheCkcheckPsw();
            return;
        }
        if($("#fetchPswForm").valid() == false){
            return;
        }
        var params = $("#fetchPswForm").formToArray();
        $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8;";
        $.ajax({
            type:"POST",
            url:webPath.webRoot+"/member/updateUserPsw.json",
            data:params,
            dataType: "json",
            async: false,//同步
            success:function(data) {
                if (data.success == "true") {
                    window.location.href=webPath.webRoot+"/fetchPsw/restPswSuccess.ac";
                }
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alert(result.errorObject.errorText);
                }else{
                    alert("修改密码失败!");

                }
            }
        });
    });

});

//检查密码（空、长度和密码强度验证）
var checkPsw = function(){
    var userPsw = $("#userPsw").val();
    if(userPsw == ""){
        showTip("#userPswTip","请输入密码!");
        return false;
    }
    //if(userPsw.length < 6 || userPsw.length > 16){
    //    showTip("#userPswTip","密码为6-16位数字、字母或者符号，建议混合使用!");
    //    return false;
    //}

    var checkPsw=/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,20}$/;
    if(!checkPsw.test(userPsw)){
        showTip("#userPswTip","密码必须为8~20位字母和数字组合!");
        return false;
    }
    showSuccess("#userPswTip");
    return true;
};
//检查重复密码（长度和密码一致验证）
var cheCkcheckPsw = function(){
    var checkPassword = $("#checkPassword").val();
    if(checkPassword == ""){
        showTip("#checkPasswordTip","请再次输入密码!");
        return false;
    }
    //if(checkPassword.length < 6 || checkPassword.length > 16){
    //    showTip("#checkPasswordTip","确认密码为6-16位数字、字母或者符号，建议混合使用!");
    //    return false;
    //}
    var checkPsw=/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,20}$/;
    if(!checkPsw.test(checkPassword)){
        showTip("#checkPasswordTip","密码必须为8~20位字母和数字组合!");
        return false;
    }
    if(!checkPasswordValidate()){/*确认密码长度及一致验证*/
        return false;
    }
    showSuccess("#checkPasswordTip");
    return true;
};
// 密码和重复密码一致性验证
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
/*改变验证码*/
var changValidateCode = function(){
    $("#validateCodeImg").attr("src", webPath.webRoot+"/ValidateCode?" + Math.random());
};

/*验证验证码必填*/
var checkValidateCode = function(){
    var validateCode = $("#validateCode").val();
    if(validateCode == ""){
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

//验证
var checkUserMsg= function(){
    var userMobile = $.trim($("#userMobile").val());
    var messageCode = $.trim($("#messageCode").val());
    $.ajax({
        type:"GET",
        url:webPath.webRoot+"/member/checkUserMsg.json",
        data:{"userMobile":userMobile,"messageCode":messageCode},
        dataType: "json",
        async: false,//同步
        success:function(data) {
            if (data.success == "true") {
                // 隐藏手机号码栏和验证码栏
                $(".mobileRegClass").hide();
                $(".boxConfirm").hide();
                $(".boxDiv").show();
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

//基本信息是否填写
var checkMsgBeforeFetchPsw= function(){

    if (!checkUserMobile()) {
        checkUserMobile();
        return false;
    }

    if ($.trim($("#messageCode").val()) == '') {
        alert("请输入您的短信验证码");
        $("#messageCode").focus();
        return false;
    }
    if($("#fetchPswForm").valid() == false){
        return false;
    }else{
        return true;
    }
};

//检查登录帐号是否存在
var checnLoginId = function(){
    var bol = false;
    var loginId = $.trim($("#loginId").val());
    console.log(loginId);
    if(loginId == ""){
        showTip("#loginIdTip","请输入登录帐号!");
        return bol;
    }
    $.ajaxSettings['contentType'] = "application/json; charset=utf-8;";
    $.ajax({
        type:"POST",
        url:webPath.webRoot+"/member/isExistLoginId.json?loginId="+loginId,
        dataType: "json",
        async: false,//同步
        success:function(data) {
            if (data.success == false) {
                showTip("#loginIdTip","用户名不存在!");
                bol = false;
            }else{
                showSuccess("#loginIdTip");
                bol = true;
            }
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                alert(result.errorObject.errorText);
                bol=false;
            }
        }
    });
    return bol;
};

var checkMobile= /^1(3|4|5|7|8)\d{9}$/;
//检查手机号是否已经注册
function checkUserMobile(){
    var bol = false;
    var userMobile = $("#userMobile").val();

    if(userMobile == ""){
        showTip("#mobileTip","请输入手机号!");
        return false;
    }
    if(!checkMobile.test(userMobile)){
        showTip("#mobileTip","请输入正确的手机号!");
        return false;
    }
    $.ajaxSettings['contentType'] = "application/json; charset=utf-8;";
    $.ajax({
        type:"GET",
        url:webPath.webRoot+"/member/isExistMobile.json",
        data:{mobile:userMobile},
        async: false,//同步
        success:function(data) {
            if(data.success == false){
                showTip("#mobileTip","该手机号尚未注册!");
                $('#sendValidateNumBtn').attr("disabled", true);
                bol = false;
            }else{
                $('#sendValidateNumBtn').attr("disabled", false);
                showSuccess("#mobileTip");
                bol = true;
            }
        },
        error:function(data){
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                alert(result.errorObject.errorText);
                bol=false;
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


/*发送短信验证码 start*/
var leftSeconds = 120;//倒计时时间120秒
var intervalId;//倒数时间对象
var sendValidateCount = 1;//点击发送次数控制
var sendValidateSwitch = false;//取消订单发送短信开关
var btnObj;//这个对象是必须声明的
var sendValidateNum = function (thisBtn) {
    var moblieValue = $('#userMobile').val();
    if ($.trim(moblieValue) == '') {
        alert("请先输入您的手机号码");
        $('#userMobile').focus();
        return;
    }
    if (!(checkMobile.test($.trim(moblieValue)))) {
        alert("请先输入正确手机号码");
        $('#userMobile').focus();
        return;
    }

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
    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
    $.ajax({
        type: "POST",
        url: webPath.webRoot + "/bdwController/sendValidateNumByFetchPsw.json",
        data: {
            mobileNum: moblieValue
        },
        async:false,
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
                    //changValidateCode();
                    $('#sendValidateNumBtn').attr("disabled", false);//设置按钮可用
                    return;
                }
                alert(result.errorObject.errorText);
                //changValidateCode();
            }

        }
    });
};
/*发送短信验证码 end*/
