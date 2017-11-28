/**
 * 校验帐号
 */
function checkLoginId(){
    var loginId = $("#loginId").val();
    if (loginId == "") {
        popover("loginId","bottom","","帐号不能为空！");
        return false;
    }
    return true;
}

/**
 * 校验密码
 */
function checkUserPsw(){
    var userPsw = $("#userPsw").val();
    if (userPsw == "") {
        popover("userPsw","bottom","","密码不能为空！");
        return false;
    }
    return true;
}

/**
 * 校验验证码
 */
function CheckValidateCode(){
    var validateCode = $("#validateCode").val();
    if(validateCode == ""){
        popover("validateCode","bottom","","密码不能为空！");
        return false;
    }
    if(validateCode.length!=4){
        popover("validateCode","bottom","","请输入4位验证码！");
        return false;
    }
    return true;
}
///**
// * 校验用户是否存在
// */
//function isExistUserLoginId(){
//    $.ajax({
//        type:"POST",
//        url:webPath.webRoot+"/member/isExistLoginId.json",
//        data:{loginId:$("#loginId").val()},
//        dataType:"json",
//        success:function(data) {
//            if(data.success == true){
//                return true;
//            }else{
//                popover("loginId","bottom","","帐号不存在！");
//                return false;
//            }
//        },
//        error:function(data){
//            if (XMLHttpRequest.status == 500) {
//                var result = eval("(" + XMLHttpRequest.responseText + ")");
//                alert(result.jsonError.errorText);
//                return false;
//            }
//        }
//    });
//}

function updateUser(){
    if(!checkLoginId()){
        return false;
    }
    if(!checkUserPsw()){
        return false;
    }
    if(!CheckValidateCode()){
        return false;
    }

    var loginId= $("#loginId").val();   //帐号
    var userPsw=$("#userPsw").val();      //密码
    var  validateCode=$("#validateCode").val(); //验证码
    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8;";
    $.ajax({
        url:webPath.webRoot+"/frontend/vmall/SysUser/boundSysUser.json",
        data:{loginId:loginId,userPsw:$.md5(userPsw),validateCode:validateCode},
        dataType:"json",
        type:"GET" ,
        success:function(data) {
            if(data.success == 'true'){
                window.location = webPath.webRoot+"/wap/module/member/myAccount.ac";
            }
        } ,
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                var errorText=result.errorObject.errorText;
                alert(errorText);
                changValidateCode();
            }
        }
    });
}

/*改变验证码*/
var changValidateCode = function (){
    $("#validateCodeImg").attr("src", webPath.webRoot+"/ValidateCode?" + Math.random());
};