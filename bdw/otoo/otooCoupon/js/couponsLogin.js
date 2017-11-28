
$(document).ready(function(){
    loginValidate();
    $(document).keydown(function(event){
        if(event.keyCode == 13){
            $("#login_btn").click();
        }
    });
    $("#login_btn").click(function(){
        var loginId = $("#loginId").val();
        var password = $("#loginPwd").val();
        var code = $("#code").val();
        if(($.trim(loginId) == '') || ($.trim(password) == '') || ($.trim(code) == '')){
            return;
        }
        $.ajax({
            type : "POST",
            url: webPath.webRoot + "/member/otooShopLogin.json",
            dataType : "json",
            data : {loginId : loginId, password : $.md5(password), code : code},
            success : function(data){
                if(data.success == "true"){
                    location.href = webPath.webRoot+"/otoo/otooCoupon/couponsSearch.ac";
                }
            },
            error:  function  (XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    changValidateCode();
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alert(result.errorObject.errorText);
                }
            }
        })
    });
});

/*改变验证码*/
var changValidateCode = function (){
    $("#validateCodeImg").attr("src", webPath.webRoot+"/ValidateCode?" + Math.random());
};
/*登录验证*/
function loginValidate(){
    $("#loginId").blur(function(){
        var loginId =$("#loginId").val();
        loginId = $.trim(loginId);
        if(loginId == ""){
            $(this).css("border","1px solid #ff0000");
            $("#error_login_id").show().html("请输入用户名");
            return;
        }
    });
    $("#loginId").focus(function(){
        $("#error_login_id").css("display","none");
        $(this).css("border","1px solid #ffbdbf");
    });
    $("#loginPwd").blur(function(){
        var loginPwd =$("#loginPwd").val();
        loginPwd = $.trim(loginPwd);
        if(loginPwd == ""){
            $(this).css("border","1px solid #ff0000");
            $("#error_login_pwd").show().html("请输入密码");
            return;
        }
    });
    $("#loginPwd").focus(function(){
        $("#error_login_pwd").css("display","none");
        $(this).css("border","1px solid #ffbdbf");
    });
    $("#code").blur(function(){
        var code =$("#code").val();
        code = $.trim(code);
        if(code == ""){
            $(this).css("border","1px solid #ff0000");
            $("#code_error").show().html("请输入验证码");
            return;
        }
    });
    $("#code").focus(function(){
        $("#code_error").css("display","none");
        $(this).css("border","1px solid #ffbdbf");
    });
}



