function updateSysUser(){
        var userEmail= $("#userEmail").val();   //绑定邮箱
        var userMobile=$("#userMobile").val();      //手机号码
        var userId=$("#userId").val();

        if(userEmail.trim("")==null||!(/^\w+([-\.]\w+)*@\w+([\.-]\w+)*\.\w{2,4}$/.test(userEmail.trim("")))||userEmail.trim.length>32){
            popover("userEmail","bottom","","邮箱输入有误");
            return false;
        }
        if(userMobile.trim("")==''||isNaN(userMobile)||userMobile.trim("").length>24||!(/^1[3|4|5|8][0-9]\d{8,8}$/.test(userMobile.trim("")))){
            popover("userMobile","bottom","","手机号码输入不正确");
            return false;
        }
        $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8;";
        $.ajax({
            url:dataValue.webRoot+"/frontend/vmall/SysUser/updateSysUser.json",
            data:{userId:userId,userEmail:userEmail,userMobile:userMobile},
            dataType:"json",
            type:"GET" ,
            success:function(data) {
                lcokBox("温馨提示","保存数据成功，2秒后自动跳转！");
                setTimeout("window.location = dataValue.webRoot+'/wap/module/member/myAccount.ac';",2000)
            } ,
            error:function(XMLHttpRequest, textStatus) {
                alert("服务器异常，请稍后重试。")
            }
        });
}

