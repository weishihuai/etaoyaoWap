/**
 * Created by IntelliJ IDEA.
 * User: feng_lh
 * Date: 12-4-1
 * Time: 下午2:11
 * To change this template use File | Settings | File Templates.
 */
// 验证填写内容是否存在空数据 start
function validatorRegisterNull(){
    if(!checkUserMailValidate()){//邮箱验证
        return false;
    }
    return true;
}
// 验证填写内容是否存在空数据 end

// 验证邮箱填写格式 start
function checkUserMailValidate(){
    var userEmail = $("#userEmail").val();
    /*if(userEmail == ""){
        fieldValidate("#emailMsg","#email_div","#emailTips","请输入邮箱!");
        return false;
    }*/
    var reMail= /^[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?$/;
    if(userEmail != "" && !reMail.test(userEmail)){
        fieldValidate("#emailMsg","#email_div","#emailTips","请输入有效的E_mail!");
        return false;
    }
    if(!checkUserEmail(userEmail)){
        return false;
    }
    fieldValidatePass("#emailMsg","#email_div","#emailTips","");
    return true;
}
// 验证邮箱填写格式 end

// 验证手机的格式是否正确 start
function checkMobile(){
    var mobile = $("#mobile").val();
    if (mobile == "" || mobile == null) {
        fieldValidate("#mobileMsg","#mobile_div","#mobileTips","手机号码不能为空!");
        return false;
    }
    if(mobile != "" && mobile != null && mobile.length != 11){
        fieldValidate("#mobileMsg","#mobile_div","#mobileTips","请输入正确的手机号码!");
        return false;
    }
    if(mobile != "" && mobile != null && !mobile.replace(/[^a-z0-9]/i)){
        fieldValidate("#mobileMsg","#mobile_div","#mobileTips","请输入正确的手机号码!");
        return false;
    }
    fieldValidatePass("#mobileMsg","#mobile_div","#mobileTips","");
    if(!checkMobilePhone()){//手机号码唯一验证
        return false;
    }
    return true;
}
// 验证手机的格式是否正确 end

// 验证是否存在填写的邮箱 start
function checkUserEmail(userEmail){
    var bol = false;
    var email=dataValue.email;
    if(userEmail==email){
        fieldValidatePass("#emailMsg","#email_div","#emailTips","");
        bol=true;
    }else{
        $.ajax({
                    type:"GET",
                    url:dataValue.webRoot+"/member/checkUserEmail.json",
                    data:{email:userEmail},
                    async: false,//同步
                    success:function(data) {
                        if(data.success == true){
                            fieldValidatePass("#emailMsg","#email_div","#emailTips","");
                            bol = true;
                        }
                        else{
                            if(data.errorCode=="errors.saveUser.duplicateEmail"){
                                fieldValidate("#emailMsg","#email_div","#emailTips","注册失败:邮箱已被他人注册!");
                                bol = false;
                            }
                        }
                    },
                    error:function(data){
                        if (XMLHttpRequest.status == 500) {
                            var result = eval("(" + XMLHttpRequest.responseText + ")");
                            alert(result.jsonError.errorText);
                            bol =  false;
                        }
                    }
                });
    }
    return bol;
}
// 验证是否存在填写的邮箱 end

// 验证是否存在该手机 start
function checkMobilePhone(){
    var mobile = $("#mobile").val();
    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
    $.ajax({
                type:"POST",
                url:dataValue.webRoot+"/member/checkUserMobileNotNull.json",
                data:{userMobile:mobile},
                dataType: "json",
                async: false,//同步
                success:function(data) {
                    if (data.success == true) {
                        //用户名可用
                        fieldValidatePass("#mobileMsg","#mobile_div","#mobileTips","");
                        bol =  true;
                    }
                    else{
                        fieldValidate("#mobileMsg","#mobile_div","#mobileTips","该手机号码已被使用，请重新输入!");
                        bol = false;
                    }
                },
                error:function(XMLHttpRequest, textStatus) {
                    if (XMLHttpRequest.status == 500) {
                        userInformationAlertDialog("服务器异常，请稍后重试。");
                        bol = false;
                    }
                }
            });
    return bol;
}
// 验证是否存在该手机 end

// 验证是否存在该用户名 start
function checkUserName(){
    var name = $("#userName").val();
    if (name == "" || name == null) {
        fieldValidate("#userNameMsg","#userName_div","#userNameTips","真实姓名不能为空!");
        return false;
    }
    fieldValidatePass("#userNameMsg","#userName_div","#userNameTips","");
    return true;
}
// 验证是否存在该用户名 end

// 验证不通过显示错误提示 start
function fieldValidate(msgId,divId,tipId,str){
    $(msgId).html(str);
    $(tipId).show();
    $(divId).find(".pass").hide();
}
// 验证不通过显示错误提示 end

// 验证通过显示正确提示 start
function fieldValidatePass(msgId,divId,tipId,str){
    $(tipId).hide();
    $(divId).find(".pass").show();
}
// 验证通过显示正确提示 start

// 保存设置 start
function saveUserInfo(){
    if(!checkUserMailValidate()){
        return false;
    }
    if(!checkMobile()){
        return false;
    }
    if(!checkUserName()){
        return false;
    }
    var params = $("#infoForm").formToArray();
    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
    $.ajax({
                type:"POST",
                url:dataValue.webRoot+"/member/updateFrontUser.json",
                data:params,
                dataType: "json",
                success:function(data){
                    if(data.success == false){
                        userInformationAlertDialog("保存个人资料失败");
                        if(fromOtoo == 1){
                            history.go(-1);
                        }
                    }else{
                        breadJDialog("保存个人资料成功!",1000,"10px",true);
                    }
                },
                error:function(XMLHttpRequest, textStatus) {
                    if (XMLHttpRequest.status == 500) {
                        userInformationAlertDialog("服务器异常，请稍后重试。")
                    }
                }
            });
    /*if(fromPayment == 1){
        history.go(-1);
    }*/
}
// 保存设置 end

//最普通最常用的alert对话框，默认携带一个确认按钮
var userInformationAlertDialog = function(dialogTxt){
    var dialog = jDialog.alert(dialogTxt);
};

//没有标题和按钮的提示框
function breadJDialog(content, autoClose, padding, modal){
    var dialog = jDialog.message(content,{
        autoClose : autoClose,    // 3s(3000)后自动关闭
        padding : padding,    // 设置内部padding
        modal: modal         // 非模态，即不显示遮罩层
    });
    return dialog;
}
