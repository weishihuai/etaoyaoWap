$(function(){

    //失去焦点触发
    $("#userMobile").blur(function(){
        checkUserMobile();
    }).keyup(function () {
        showLoginBtn();
    });
    $("#messageCode").blur(function(){
        checkValidateCode();
    }).keyup(function () {
        showLoginBtn();
    });
    $("#userPsw").blur(function(){
        checkPsw();
    }).keyup(function () {
        showLoginBtn();
    });
    //密码清除
    $(".del-btn").click(function () {
        $("#userPsw").val("");
        showLoginBtn();
    });

    //修改密码
    $("#fetchPassword").click(function(){
        if(!checkPsw()){
            return;
        }
        if($("#findPswForm").valid() == false){
            return;
        }
        var params = $("#findPswForm").formToArray();
        $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8;";
        $.ajax({
            type:"POST",
            url:webPath.webRoot+"/member/updateUserPsw.json",
            data:params,
            dataType: "json",
            async: false,//同步
            success:function(data) {
                if (data.success == "true") {
                    showTips("重置密码成功!");
                    setTimeout(function () {
                        window.location.href=webPath.webRoot+"/wap/login.ac";
                    }, 2000);
                }
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    showTips(result.errorObject.errorText);
                }else{
                    showTips("修改密码失败!");
                }
            }
        });
    });
});

//检查手机号是否已经注册
function checkUserMobile(){
    var bol = false;
    var userMobile = $("#userMobile").val();
    if(userMobile == ""){
        showTips("请输入手机号!");
        return false;
    }
    var reMobile = /^1(\d{10})$/;
    if(!reMobile.test(userMobile)){
        showTips("请输入有效的手机号!");
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
                showTips("该手机号尚未注册!");
                bol = false;
            }else{
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

//检查密码（空、长度和密码强度验证）
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

/*验证验证码必填*/
var checkValidateCode = function(){
    var validateCode = $("#messageCode").val();
    if(validateCode == ""){
        showTips("请输入验证码!");
        return false;
    }
    if(validateCode.length<6){
        showTips("请输入有效验证码!");
        return false;
    }
    return true;
};

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
    var userMobile = $.trim($("#userMobile").val());
    var messageCode = $.trim($("#messageCode").val());
    if(userMobile == ""){
        return false;
    }

    var checkMobile = /^1(\d{10})$/;
    if(!checkMobile.test(userMobile)){
        return false;
    }

    if(userPsw == ""){
        return false;
    }
    var checkPsw=/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$/;
    if(!checkPsw.test(userPsw)){
        return false;
    }
    if(messageCode == ""){
        return false;
    }
    if(messageCode.length<6 || messageCode.length>6){
        return false;
    }
    return true;
}

function showTips(tips) {
    $("#tipsSpan").text(tips);
    $("#tipsDiv").show();
    setTimeout(function () {
        $("#tipsDiv").hide();
    }, 2000);
}

/*发送短信验证码 start*/
var leftSeconds = 120;//倒计时时间120秒
var intervalId;//倒数时间对象
var sendValidateCount = 1;//点击发送次数控制
var sendValidateSwitch = false;//取消订单发送短信开关
var btnObj;//这个对象是必须声明的
var sendValidateNum = function (thisBtn) {
    if(leftSeconds != 120){//修改为120秒倒计时
        return false;
    }
    if(!checkUserMobile()){
        return ;
    }

    btnObj = thisBtn;
    //发送短信
    sendValidateSwitch = true;//用于取消订单开关判断
    $('#second').addClass("count");//设置按钮不可用

    sendValidateJSON();
};


var countDown = function () {//倒计时方法
    if (leftSeconds <= 0) {
        $('.send').val("发送验证码"); //当时间<=0的时候改变按钮的value
        $('.send').removeClass("count");//如果时间<=0的时候按钮可用
        clearInterval(intervalId); //取消由 setInterval() 设置的 timeout
        leftSeconds = 120;
        return;
    }

    leftSeconds--;
    $('#second').text("等待" + leftSeconds + "秒");
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
        dataType: "json",
        async: false,//同步
        success: function (data) {
            if (data.success == "true") {
                //发送成功
                //禁用按钮,开始倒数
                $('.send').addClass("count");//设置按钮不可用
                intervalId = setInterval("countDown()", 1000);//调用倒计时的方法
            } else if (data.success == "false") {
                //当第一次发送失败的时候,不进行倒数,而是变成"重新发送",当点击"重新发送"的时候,还发送失败就开始进行倒数
                sendValidateCount++;
                $('.send').removeClass("count");//设置按钮可用
                $('.send').attr("value", "重新发送");
                if (sendValidateCount > 2) {
                    sendValidateCount = 1;
                    $('.send').addClass("count")//设置按钮不可用
                    intervalId = setInterval("countDown()", 1000);//调用倒计时的方法
                }
            }
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                if(result.errorObject.errorText == "验证码错误"){
                    showTips(result.errorObject.errorText);
                    $('.send').attr("disabled", false);//设置按钮可用
                    return;
                }
                showTips(result.errorObject.errorText);
            }

        }
    });
};
/*发送短信验证码 end*/