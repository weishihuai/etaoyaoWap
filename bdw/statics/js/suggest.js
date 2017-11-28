/*改变验证码*/
var changValidateCode = function (){
    $("#validateCodeImg").attr("src", "/ValidateCode?" + Math.random());
};
$(document).ready(function(){
    $.formValidator.initConfig({theme:"ArrowSolidBox",formID:"form1",
        onError:function(msg){},inIframe:true,
        ajaxForm:{
            dataType:"json",url:webPath.webRoot+"/member/addSuggest.json",type :"POST",
            buttons:$("#suggestBtn"),
            error: function(jqXHR, textStatus, errorThrown){
                if(textStatus == "error"){
                    try{
                        var result = eval("("+jqXHR.responseText+")");
                        alert(result.errorObject.errorText);
                    }catch(err) {
                        alert(alert("服务器没有返回数据，可能服务器忙，请重试"+errorThrown));
                        return;
                    }
                }
            },
            success : function(data){
                if(data.errorCode == "errors.login.noexist"){
                    if(confirm("您尚未登陆，请登陆!")){
                        window.location.href=webPath.webRoot+"/login.ac";
                    }
                    return;
                }
                if(data.errorCode == "errors.login.validate"){
                    alert("您输入的验证码错误!");
                    return;
                }
                if(data.success == true){
                    window.location.href=webPath.webRoot+"/suggestSuccess.ac";
                    return;
                }
            }
        }
    });
    $("#complainCont").formValidator({
        onShow:"请输入您的描述",
        onFocus:"描述至少要输入10个汉字或20个字符"
    }).inputValidator({min:10,max:255,onError:"您输入的描述长度不正确,请确认"});

    $("#memberTel").formValidator({
        onShow:"请输入您的手机号码",
        onFocus:"请输入您的手机号码"
    }).inputValidator({min:11,max:11,onError:"你输入的手机号码长度不正确,请确认"})
        .regexValidator({regExp:"mobile",dataType:"enum",onError:"你输入的手机号码格式不正确"});
    $("#validateCode").formValidator({
        onShow:"请输入验证码",
        onFocus:"请输入验证码"
    }).inputValidator({min:4,max:4,onError:"您输入验证码长度不正确,请确认"});
});