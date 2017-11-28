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
    if(userEmail == ""){
        fieldValidate("#emailMsg","#email_div","#emailTips","请输入邮箱!");
        return false;
    }
    var reMail=/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/;
    if(!reMail.test(userEmail)){
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
    if(mobile.length != 11){
        fieldValidate("#mobileMsg","#mobile_div","#mobileTips","请输入正确的手机号码!");
        return false;
    }
    if(!mobile.replace(/[^a-z0-9]/i)) {
        fieldValidate("#mobileMsg","#mobile_div","#mobileTips","请输入正确的手机号码!");
        return false;
    }
    if(!checkMobilePhone()){//手机号码唯一验证
        return false;
    }
    fieldValidatePass("#mobileMsg","#mobile_div","#mobileTips","");
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
                url:dataValue.webRoot+"/member/checkUserMobileNoinOwn.json",
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
                        alert("服务器异常，请稍后重试。")
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
                        alert("保存个人资料失败");
                    }else{
                        alert("保存个人资料成功");
                        window.location.href=dataValue.webRoot+"/index.ac";
                    }
                },
                error:function(XMLHttpRequest, textStatus) {
                    if (XMLHttpRequest.status == 500) {
                        alert("服务器异常，请稍后重试。")
                    }
                }
            });
}
// 保存设置 end