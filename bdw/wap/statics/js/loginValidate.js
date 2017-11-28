$(document).ready(function() {


    checkNeedValidateCode  = function(){
        if(!$("#loginId").val()){
            return;
        }
        $.ajax({
            type:"GET",
            url:webPath.webRoot+"/member/needValidateCode.json",
            data:{loginId:$("#loginId").val()},
            dataType: "json",
            success:function(data) {
                if(data.needValidateCode){
                    //需要展示验证码
                    $("#validateCodeField").show();
                    changValidateCode();
                }else{
                    $("#validateCodeField").hide();
                }
            }
        });
    };

    checkNeedValidateCode();

    /**
     * 点击登录时调用验证控件*/
    $("#loginForm").login({
        contextPath:webPath.webRoot
    });

    $("#loginId").change(function(){
        $("#userPsw").val("");
        checkNeedValidateCode();
        showLoginBtn();
    });

    $("input").keyup(function(){
        showLoginBtn();
    });

    $("#userPsw").keyup(function () {
        showLoginBtn();
    });

    $("#validateCode").keyup(function () {
        showLoginBtn();
    });

    $("#cancel-psw").click(function () {
        $("#userPsw").val("");
        showLoginBtn();
    });

    $("#cancel-validateCode").click(function () {
        $("#validateCode").val("");
        showLoginBtn();
    });

    /**
     * 输入框重新输入时错误消息隐藏*/
    $("#validateCode").keypress(function(){
        $(".jud-error").hide();;
    })
});

//控制登录按钮是否可点击
function showLoginBtn(){
    var loginId =  $.trim($("#loginId").val());
    var userPsw = $.trim($("#userPsw").val());
    var loginBtnVisible = true;
    if(!checkValidateCode()){
        loginBtnVisible = false;
    }
    if(!loginId){
        loginBtnVisible = false;
    }
    if(!userPsw){
        loginBtnVisible = false;
    }
    if(loginBtnVisible){
        if($(".login-btn").hasClass("disbale")){
            $(".login-btn").removeClass("disbale");
        }
    }else{
        if(!$(".login-btn").hasClass("disbale")){
            $(".login-btn").addClass("disbale");
        }
    }
}

function checkValidateCode(){
    var validateCodeVisible = $("#validateCodeField").is(":visible");
    if(validateCodeVisible){
        var validateCode = $.trim($("#validateCode").val());
        if(validateCode == ''){
            return false;
        }
    }
    return true;
}

/*改变验证码*/
var changValidateCode = function (){
    $("#validateCodeImg").attr("src", webPath.webRoot+"/ValidateCode?" + Math.random());
};

/*提示窗口*/
function showTips(tips) {
    $("#tipsSpan").text(tips);
    $("#tipsDiv").show();
    setTimeout(function () {
        $("#tipsDiv").hide();
    }, 2000);
}