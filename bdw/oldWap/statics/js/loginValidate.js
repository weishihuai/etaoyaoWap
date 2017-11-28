/**
 * User: xiaochi
 * Date: 12-1-4
 * 登录的验证
 */
$(document).ready(function(){

    /**
     * 输入框获得焦点时，清空内容，字体设为黑色*/
    getFocus  = function(obj,eqmsg){
        if(eqmsg==$(obj).val()){
            $(obj).val("");
            $("#loginId").css("color","black");
        }
    }


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
                    $("#validateCodeField").show();
                    changValidateCode();
                }else{
                    $("#validateCodeField").hide();
                }
            }
        });
    }

    checkNeedValidateCode();
    /**
     * 点击登录时调用验证控件*/
    $("#loginForm").login({
        contextPath:webPath.webRoot
    });

    $("#loginId").change(function(){
        $("#userPsw").val("");
        checkNeedValidateCode();
    });




    /**
     * 监听回车键，回车时登录*/
    $("body").bind('keyup',function(event) {
        if(event.keyCode==13){
            //如果焦点是在登陆账号框并且密码没填则切换到密码输入框
            if(!$("#loginId").val()||$("#loginId").val()=='E-mail、昵称或手机号'){
                $("#loginId").val("");
                $("#loginId").focus();
                return;
            }
            if(!$("#userPsw").val()){
                $("#userPsw").focus();
                return;
            }
            if($("#validateCodeField").css("display")=='block'&&!$("#validateCode").val()){
                $("#validateCode").focus();
                return;
            }
            $('#loginForm').submit();
        }
    });
    /**
     * 输入框重新输入时错误消息隐藏*/
    $("input").keypress(function(){
        $("#alert").hide()
        $("#alert2").hide()
        $("#alert3").hide()
    })
});

/*改变验证码*/
var changValidateCode = function (){
    $("#validateCodeImg").attr("src", webPath.webRoot+"/ValidateCode?" + Math.random());
};