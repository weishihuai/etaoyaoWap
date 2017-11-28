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
            $("#loginIdWin").css("color","black");
        }
    }



    checkNeedValidateCode();
    /**
     * 点击登录时调用验证控件*/
    $("#loginFormWin").login({
                contextPath:webPath.webRoot
            });

    $("#loginIdWin").change(function(){
        $("#userPswWin").val("");
        checkNeedValidateCode();
    });


    /**
     * 输入框重新输入时错误消息隐藏*/
    $("input").keypress(function(){
        $("#alert").hide()
        $("#alert2").hide()
        $("#alert3").hide()
    })
});
