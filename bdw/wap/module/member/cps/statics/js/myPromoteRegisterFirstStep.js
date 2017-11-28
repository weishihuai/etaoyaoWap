$(function(){
    //输入框内容清除
    $('.clear').click(function () {
        var next = $(this).next();
        if (next != undefined) {
            next.val("");
        }
    });

    var approveStat = $('#approveStat').val().trim();
    if(!isEmpty(approveStat)){
        if(approveStat==unApprove){//未处理
            //跳转到审核中的页面
            location.href = webPath.webRoot + "/wap/module/member/cps/myPromoteRegisterThirdStep.ac";
        }else if(approveStat==passApprove){//已通过
            location.href = webPath.webRoot + "/wap/module/member/cps/cpsIndex.ac";
        }else{//已拒绝
            $('#sysMsg').show();
        }
    }
});

//关闭消息框
function hideMeg(){
    $('#sysMsg').hide();
}

//进入注册第二步页面
function gotoSecondStep(){
    var userName = $('#userName').val().trim();
    if(isEmpty(userName)){
        alert('请输入联系人');
        return;
    }

    var userPhone = $('#userPhone').val().trim();
    if(isEmpty(userPhone)){
        alert('请输入联系手机');
        return;
    }

    var reg = /^\d{11}$/;
    if(!reg.test(userPhone)){
        alert('请输入正确的手机号');
        return;
    }

    $('#userNameHidden').val(userName);
    $('#userPhoneHidden').val(userPhone);
    $('#gotoSecondStepForm').submit();
}

//判空
function isEmpty(text){
    text = $.trim(text);
    if(text==undefined || text==null || text==""){
        return true;
    }else{
        return false;
    }
}