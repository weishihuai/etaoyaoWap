/**
 * Created by IntelliJ IDEA.
 * User: lzp
 * Date: 11-7-12
 * Time: 下午7:05
 * 登录验证插件
 */
(function($){
    $.fn.login=function(settings){
        var defaultSettings={
            loginIdWin:{
                id:"loginIdWin",
                alert:{
                    emptyAlert:"请输入用户名！"
                }

            },
            userPswWin:{
                id:"userPswWin",
                alert:{
                    emptyAlert:"请输入密码！"
                }

            },
            validateCode:{
                id:"validateCode",
                alert:{
                    emptyAlert:"请输入验证码！"
                }

            },
            contextPath:"",
            url:"/member/loginValidateCode.json"

        };
        settings = $.extend(true,defaultSettings,settings);
        return this.each(function(){
            $(this).bind("submit",function(){
                return checkLoginForm(settings)
            })

        });
        function checkLoginForm(settings){
            var loginIdWin = $("#"+settings.loginIdWin.id);
            var userPswWin = $("#"+settings.userPswWin.id);
            var validateCode = $("#"+settings.validateCode.id);
            if(loginIdWin.val() == ""){
                $("#alert").show();
                $("#alerttext").html(settings.loginIdWin.alert.emptyAlert);

                return false;
            }
            if(userPswWin.val() == ""){
                $("#alert2").show();
                $("#alerttext1").html(settings.userPswWin.alert.emptyAlert);
                return false;
            }
            if($("#validateCodeField").css("display")=='block'&&!$("#validateCode").val()){
                if(validateCode.val() == ""){
                    $("#alert3").show();
                    $("#alerttext2").html(settings.validateCode.alert.emptyAlert);
                    return false;
                }
             }
            confirmLogin(loginIdWin,userPswWin,validateCode);
            return false;
        }
        function confirmLogin(loginIdWin,userPswWin,validateCode){
            //非空验证结束
            //var params = $("#loginForm").formToArray();
            $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
            $.ajax({
                        type:"POST",
                        url:settings.contextPath+settings.url,
                        data:{loginId:loginIdWin.val(),userPsw:$.md5(userPswWin.val()),validateCode:validateCode.val()},
                        dataType: "json",
                        success:function(data) {
                            if (data.success == false) {
                                checkLoginResult(data);
                            }
                            else{
                                $("#discuzLogin").html(data.loginScript);
                                if(data.redirectUrl=="redirect:/"){
                                    location.href = settings.contextPath+"/" ;
                                }
                                else if(data.redirectUrl==null){
                                   location.href =settings.contextPath+"/index.ac" ;
                                }else{
                                    setTimeout(function(){
                                        location.href = data.redirectUrl
                                    },3);
                                }
                            }
                        },
                        error:function(XMLHttpRequest, textStatus) {
                            if (XMLHttpRequest.status == 500) {
                                var result = eval("(" + XMLHttpRequest.responseText + ")");
//                                "{\"errorObject\":{\"errorData\":null,\"errorCode\":\"errors.login.userstat\",\"errorText\":\"用户{0}的状态不正常\"}}"
                                checkLoginResult(result.errorObject);
                                changValidateCode();
                            }
                        }
                    });

        }

        function checkLoginResult(data){
            if (data.errorCode == "errors.login.userstat") {
                $("#alert").show();
                $("#alerttext").html("<span style='color: #ff6b00'>用户已被冻结，请联系客服！<span>");
                $("#loginIdWin").val("");
                $("#loginIdWin").focus();
                checkNeedValidateCode();
            }
           else if (data.errorCode == "errors.login.noexist") {
                $("#alert").show();
                $("#alerttext").html("<span style='color: #ff6b00'>该账户名不存在<span>");
                $("#loginIdWin").focus();
                $("#loginIdWin").val("");
                $("#validateCode").val("");
                checkNeedValidateCode();
            }
            else if (data.errorCode == "errors.login.password") {
                $("#alert2").show();
                $("#alerttext1").html("<span style='color: #ff6b00'>用户名与密码不匹配<span>");
                $("#userPswWin").focus();
                $("#userPswWin").val("");
                $("#validateCode").val("");
                checkNeedValidateCode();
            } else if (data.errorCode == "errors.login.no.remain.time") {
                $("#alert2").show();
                //$("#alerttext1").html("<span style='color: red'>"+"您今天密码出错次数为 " + data.errorArg + "次，已被系统屏蔽"+"<span>")
                $("#alerttext1").html("<span style='color: #ff6b00'>"+data.errorText+"<span>");
                $("#validateCode").focus();
                $("#validateCode").val("");
                checkNeedValidateCode();
            } else if (data.errorCode == "errors.remain.time.login.password") {
                $("#alert2").show();
                $("#alerttext1").html("<span style='color: #ff6b00'>"+"密码出错，您今天还有 " + data.errorText + "次重新输入的机会"+"<span>");
                $("#userPswWin").focus();
                $("#userPswWin").val("");
                $("#validateCode").val("");
                checkNeedValidateCode();

            }else  if(data.errorCode=="errors.login.validate"){
                $("#alert3").show();
                $("#alerttext2").html("<span style='color: #ff6b00'>验证码错误<span>");
                $("#validateCode").focus();
                $("#validateCode").val("");
                checkNeedValidateCode();
            }
            else {
                $("#alert").show();
                $("#alerttext").html("<span style='color: #ff6b00'>账户冻结或账户已被删除<span>");
                $("#loginIdWin").val("");
                $("#loginIdWin").focus();
                checkNeedValidateCode();
            }
        }
        function showDialog(text,buttons){
            $("#tiptext").html(text);
            $("#tip").dialog({
                        buttons:buttons
                    });

        }
    };
})(jQuery);
