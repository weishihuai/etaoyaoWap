$(function () {

    $(".item").click(function () {
        $(this).addClass("cur").siblings().removeClass("cur");
        var sexCode = $(this).attr("rel");
        $("#userSexCode").val(sexCode);
        updateUserSexCode();
    });
});

/**
 * 修改用户性别
 */
function updateUserSexCode(){
    var userSexCode = $("#userSexCode").val();
    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";

    $.ajax({
        type:"POST",
        url:dataValue.webRoot+"/member/updateFrontUser.json",
        data:{userSexCode:userSexCode},
        dataType: "json",
        success:function(data){
            if(data.success == false){
                showTips("修改性别失败");
            }else{
                showTips("修改性别成功");
                setTimeout(function(){
                    window.location.href = dataValue.webRoot+"/wap/module/member/myInformation.ac&time=" + new Date().getTime();
                },1500);
            }
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                showTips("服务器异常，请稍后重试。")
            }
        }
    });
}

/*自定义弹出框*/
function showTips(tips) {
    $("#tipsSpan").text(tips);
    $("#tipsDiv").show();
    setTimeout(function () {
        $("#tipsDiv").hide();
    }, 1000);
}