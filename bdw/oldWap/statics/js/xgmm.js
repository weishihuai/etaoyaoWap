var result = false; //设置结果 默认false

function modPsw() {
    var password = $("#password").val();
    var new_password = $("#new_password").val();
    var confirm_Password = $("#confirm_password").val();
    if (!checkPassword()) {
        return false;
    }
    if (!checkNewPassword()) {
        return false;
    }
    if (!checkConfirmPassword()) {
        return false;
    }
    $.ajax({
        type:"POST",
        url:dataValue.webRoot+"/member/modPassword.json",
        data:{userPsw:$.md5(new_password)},
        dataType: "json",
        success:function(data) {
            if (data.success == "true") {
                location.href=dataValue.webRoot+"/wap/module/member/xgmm_cg.ac";
            }
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                showDialog(result.jsonError.errorText);
            }
        }
    });
}

function checkPassword() {
    var password = $("#password").val();
    if (password == "") {
        $("#passwordTip").removeClass("sr-only");
        $("#passwordTip").text("请输入当前密码");
        return false;
    }
    $.ajax({
        type:"POST",
        url:dataValue.webRoot+"/member/checkPassword.json",
        data:{userPsw:$.md5(password)},
        dataType: "json",
        success:function(data) {
            if (data.success == "true") {
                if (data.errorCode == "errors.login.password") {
                    $("#passwordTip").removeClass("sr-only");
                    $("#passwordTip").text("密码错误");
                    result = false;
                } else {
                    $("#passwordTip").addClass("sr-only");
                    $("#passwordTip").text("");
                    result = true;
                }
            }
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                showDialog(result.jsonError.errorText);
                result = false;
            }
        }
    });
    $("#passwordTip").addClass("sr-only");
    return result;
}

//验证新密码格式 start
function checkNewPassword() {
    var new_password = $("#new_password");
    var newStr = new_password.val();
    if (newStr == "") {
        $("#new_passwordTip").removeClass("sr-only");
        $("#new_passwordTip").text("新密码不能为空");
        return false;
    }
    if (newStr.length >= 6 && newStr.length <= 16) {
        var confirmStr = $("#confirm_password").val();
        if (confirmStr != "") {
            if (newStr != confirmStr) {
                $("#new_passwordTip").removeClass("sr-only");
                $("#new_passwordTip").text("确认密码与新密码不一致");
                return false;
            }
        }
        $("#new_passwordTip").addClass("sr-only");
        $("#new_passwordTip").text("");
        return true;
    } else {
        $("#new_passwordTip").removeClass("sr-only");
        $("#new_passwordTip").text("密码在6-16个字符内!");
        return false;
    }
    $("#new_passwordTip").addClass("sr-only");
    return true;
}
//验证新密码格式 end

//验证新密码格式 start
function checkConfirmPassword() {
    var confirm_Password = $("#confirm_password");
    var confirmStr = confirm_Password.val();
    if (confirmStr == "") {
        $("#confirm_passwordTip").removeClass("sr-only");
        $("#confirm_passwordTip").text("新密码不能为空");
        return false;
    }
    if (confirmStr.length >= 6 && confirmStr.length <= 16) {
        var new_password = $("#new_password").val();
        if(new_password == confirmStr){
            $("#confirm_passwordTip").addClass("sr-only");
            $("#confirm_passwordTip").text("");
            return true;
        }else{
            $("#confirm_passwordTip").removeClass("sr-only");
            $("#confirm_passwordTip").text("确认密码与新密码不一致");
            return false;
        }
    } else {
        $("#confirm_passwordTip").removeClass("sr-only");
        $("#confirm_passwordTip").text("密码在6-16个字符内!");
        return false;
    }
    $("#confirm_passwordTip").addClass("sr-only");
    return true;
}
//验证新密码格式 end