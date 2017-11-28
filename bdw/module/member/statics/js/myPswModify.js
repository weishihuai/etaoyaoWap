/**
 * Created by IntelliJ IDEA.
 * User: feng_lh
 * Date: 12-4-1
 * Time: 下午2:33
 * To change this template use File | Settings | File Templates.
 */
//初始化  设置密码强度控件  start
$(document).ready(function() {
    var $pwd = $('#new_password');
    $pwd.passwordStrength();
});
//初始化  设置密码强度控件  end

var result = false; //设置结果 默认false
//修改密码 start
function modPsw() {
    var password = $("#password").val();
    var new_password = $("#new_password").val();
    var confirm_Password = $("#confirm_Password").val();
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
                        var callbackDialog = jDialog.alert('修改密码成功!',{
                            type : 'highlight',
                            text : '确定',
                            handler : function(button,callbackDialog) {
                                callbackDialog.close();
                                location.reload();
                            }
                        });
                    }
                },
                error:function(XMLHttpRequest, textStatus) {
                    if (XMLHttpRequest.status == 500) {
                        var result = eval("(" + XMLHttpRequest.responseText + ")");
                        userPswAlertDialog(result.jsonError.errorText);
                    }
                }
            });
}
//修改密码 end

//验证原始密码是否与该用户匹配 start
function checkPassword() {
    var password = $("#password").val();
    if (password == "") {
        fieldValidate("#passwordMsg", "#password_div", "#passwordTips", "请输入当前密码!");
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
                            fieldValidate("#passwordMsg", "#password_div", "#passwordTips", "密码错误!");
                            result = false;
                        } else {
                            fieldValidatePass("#passwordMsg", "#password_div", "#passwordTips", "");
                            result = true;
                        }
                    }
                },
                error:function(XMLHttpRequest, textStatus) {
                    if (XMLHttpRequest.status == 500) {
                        var result = eval("(" + XMLHttpRequest.responseText + ")");
                        userPswAlertDialog(result.jsonError.errorText);
                        result = false;
                    }
                }
            });
    return result;
}
//验证原始密码是否与该用户匹配 end

//验证新密码格式 start
function checkNewPassword() {
    var new_password = $("#new_password");
    var newStr = new_password.val();
    if (newStr == "") {
        fieldValidate("#new_passwordMsg", "#new_password_div", "#new_passwordTips", "新密码不能为空!");
        return false;
    }
    var new_passwordImg = $("#new_passwordImg");
    var new_passwordMsg = $("#new_passwordMsg");

    var checkPsw=/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,20}$/;
    if(!checkPsw.test(newStr)){
        fieldValidate("#new_passwordMsg", "#new_password_div", "#new_passwordTips", "密码必须为8~20位字母和数字组合！");
        return false;
    }
    fieldValidatePass("#new_passwordMsg", "#new_password_div", "#new_passwordTips", "");
    return true;
}
//验证新密码格式 end

//验证确认密码格式 start
function checkConfirmPassword() {
    var confirm_Password = $("#confirm_Password");
    var confirm_PasswordMsg = $("#confirm_PasswordMsg");
    var confirmStr = confirm_Password.val();
    if (confirmStr == "") {
        fieldValidate("#confirm_PasswordMsg", "#confirm_Password_div", "#confirm_PasswordTips", "确认新密码不能为空！");
        return false;
    }
    var confirm_PasswordImg = $("#confirm_PasswordImg");
    var checkPsw=/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,20}$/;
    if(!checkPsw.test(confirmStr)){
        fieldValidate("#confirm_PasswordMsg", "#confirm_Password_div", "#confirm_PasswordTips", "密码必须为8~20位字母和数字组合！");
        return false;
    }else{
        var new_password = $.trim($("#new_password").val());
        if (new_password != confirmStr) {
            fieldValidate("#confirm_PasswordMsg", "#confirm_Password_div", "#confirm_PasswordTips", "确认密码与新密码不一致！");
            return false;
        }
        var new_passwordMsg = $("#new_passwordMsg");
        new_passwordMsg.html("");
        fieldValidatePass("#confirm_PasswordMsg", "#confirm_Password_div", "#confirm_PasswordTips", "");
        return true;
    }
}
//验证新密码格式 end

//弹出消息框 start
function showDialog(msg) {
    alert(msg);
}
//弹出消息框 end
// 验证不通过显示错误提示 start
function fieldValidate(msgId, divId, tipId, str) {
    $(msgId).html(str);
    $(tipId).show();
    $(divId).find(".pass").hide();
}
// 验证不通过显示错误提示 end

// 验证通过显示正确提示 start
function fieldValidatePass(msgId, divId, tipId, str) {
    $(tipId).hide();
    $(divId).find(".pass").show();
}
// 验证通过显示正确提示 end

//最普通最常用的alert对话框，默认携带一个确认按钮
var userPswAlertDialog = function(dialogTxt){
    var dialog = jDialog.alert(dialogTxt);
};
