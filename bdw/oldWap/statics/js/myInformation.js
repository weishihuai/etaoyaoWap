var result = false; //设置结果 默认false

function modUserInfo() {
    var mobile = $.trim($("#mobile").val());
    var email = $.trim($("#email").val());
    if (!checkMobile()) {
        return false;
    }
    if (!checkUserEmail()) {
        return false;
    }
    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
    $.ajax({
        type:"POST",
        url:dataValue.webRoot+"/member/updateFrontUser.json",
        data:{userMobile:mobile,userEmail:email},
        dataType: "json",
        success:function(data){
            if(data.success == true){
                location.href=dataValue.webRoot+"/wap/module/member/index.ac";
            }
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                $("#emailTip").removeClass("sr-only");
                $("#emailTip").text("服务器异常，请稍后重试。");
            }
        }
    });
}

// 验证邮箱填写格式 start
function checkUserMailValidate(){
    var userEmail = $("#email").val();
    var reMail= /^[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?$/;
    if(userEmail == "" || undefined == userEmail){
        $("#emailTip").removeClass("sr-only");
        $("#emailTip").text("请输入电子邮箱");
        return false;
    }
    if(userEmail != "" && !reMail.test(userEmail)){
        $("#emailTip").removeClass("sr-only");
        $("#emailTip").text("请输入有效的E_mail!");
        return false;
    }
    if(!checkUserEmail(userEmail)){
        return false;
    }
    $("#emailTip").addClass("sr-only");
    $("#emailTip").text("");
    return true;
}
// 验证邮箱填写格式 end

// 验证是否存在填写的邮箱 start
function checkUserEmail(userEmail){
    var bol = false;
    var email=dataValue.email;
    if(userEmail==email){
        $("#emailTip").addClass("sr-only");
        $("#emailTip").text("");
        bol=true;
    }else{
        $.ajax({
            type:"GET",
            url:dataValue.webRoot+"/member/checkUserEmail.json",
            data:{email:userEmail},
            async: false,//同步
            success:function(data) {
                if(data.success == true){
                    $("#emailTip").addClass("sr-only");
                    $("#emailTip").text("");
                    bol = true;
                }
                else{
                    if(data.errorCode=="errors.saveUser.duplicateEmail"){
                        $("#emailTip").removeClass("sr-only");
                        $("#emailTip").text("邮箱已经存在");
                        bol = false;
                    }
                }
            },
            error:function(data){
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    $("#emailTip").removeClass("sr-only");
                    $("#emailTip").text(result.jsonError.errorText);
                    bol =  false;
                }
            }
        });
    }
    return bol;
}
// 验证是否存在填写的邮箱 end

// 验证手机的格式是否正确 start
function checkMobile(){
    var mobile = $("#mobile").val();
    if (mobile == "" || mobile == null) {
        $("#mobileTip").removeClass("sr-only");
        $("#mobileTip").text("手机号码不能为空!");
        return false;
    }
    if(mobile != "" && mobile != null && mobile.length != 11){
        $("#mobileTip").removeClass("sr-only");
        $("#mobileTip").text("请输入11位的的手机号码!");
        return false;
    }
    if(mobile != "" && mobile != null && !mobile.replace(/[^a-z0-9]/i)){
        $("#mobileTip").removeClass("sr-only");
        $("#mobileTip").text("请输入正确的手机号码");
        return false;
    }
    $("#passwordTip").addClass("sr-only");
    $("#passwordTip").text("");
    result = true;
    if(!checkMobilePhone()){//手机号码唯一验证
        return false;
    }
    return true;
}
// 验证是否存在该手机 start
function checkMobilePhone(){
    var mobile = $.trim($("#mobile").val());
    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
    $.ajax({
        type:"POST",
        url:dataValue.webRoot+"/member/checkUserMobileNotNull.json",
        data:{userMobile:mobile},
        dataType: "json",
        async: false,//同步
        success:function(data) {
            if (data.success == true) {
                $("#mobileTip").addClass("sr-only");
                $("#mobileTip").text("");
                bol =  true;
            }
            else{
                $("#mobileTip").removeClass("sr-only");
                $("#mobileTip").text("该手机号码已被使用，请重新输入!");
                bol = false;
            }
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                $("#mobileTip").removeClass("sr-only");
                $("#mobileTip").text("服务器异常，请稍后重试!");
                bol = false;
            }
        }
    });
    return bol;
}
// 验证是否存在该手机 end