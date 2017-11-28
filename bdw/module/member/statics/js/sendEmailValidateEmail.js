$(function(){
    $("#sendEmailValidateEmail").click(function(){
        $.ajax({type:"POST",url:webPath.webRoot+"/member/sendEmailValidateEmail.ac",
                success:function(data){
                    if(data.success == false){
                        if(data.errorCode == "noSendAgain"){
                            alert("邮件已发送,可能因为网络原因延缓,请检查邮箱!");
                            return false;
                        }
                        else if(data.errorCode == "message"){
                            alert("你的账号还没绑定邮箱，请先绑定邮箱!");
                            return false;
                        }
                        alert("验证邮件未发送!");
                        return false;
                    }else{
                        alert("验证邮件已发送!");
                        return false;
                    }
                },
                error:function(XMLHttpRequest, textStatus){
                    alert("服务器太忙了,请稍后再试.");
                }
            });
    });
});