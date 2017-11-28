/**
 * Created by admin on 2016/11/14.
 */
$(document).ready(function(){
    //clearSessionCode();
});


var s = 120;
var sh;
//发送验证码
function sendCode(){
    if(s != 120){//修改为120秒倒计时
        return false;
    }
    var mobile = $("#loginId").val();
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
    var mobile = $("#loginId").val();
    var code = $("#code").val();
    if($.trim(code) == ""){
        alert("请输入验证码");
        return;
    }
    $.ajax({
        url : webPath.webRoot + "/member/checkMobileCode.json",
        type : "post",
        dataType : "json",
        data : {code : code,mobile : mobile},
        success : function(data){
            if(data.success == "true"){
                location.href = webPath.webRoot + "/register.ac?mobile=" + mobile + "&code=" + code;
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


//清楚验证码
function setHtml(){
    $("#second").html();
    if(s > 0){
        $("#second").html(s + "秒后重发");
        s--;
    }else{
        clearInterval(sh);
        $("#second").html("重新发送验证码");
        s = 60;
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


