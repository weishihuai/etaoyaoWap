
$(function () {

    $(".btn-box a.del").click(function () {
        var reciverAddrId = $(this).attr("data-id");
        if (window.confirm("确认删除吗？")){
            $.ajax({
                type: "POST",
                url: webPath.webRoot + "/member/deleteUserAddress.json?id=" + reciverAddrId,
                success: function (data) {
                    if (data.success == true) {
                        window.location.reload();
                    } else {
                        alert("删除地址失败，请重试");
                    }
                },
                error: function (XMLHttpRequest, textStatus) {
                    if (XMLHttpRequest.status == 500) {
                        var result = eval("(" + XMLHttpRequest.responseText + ")");
                        alert(result.errorObject.errorText);
                    }
                }
            });
        }
    });

    var url = document.referrer;
    if(!(url.indexOf("addrAdd.ac")>-1||url.indexOf("addrManage.ac")>-1||url.indexOf("wap/login.ac")>-1)){
        document.cookie="LS_BACK_URL="+url;
    }
    $(".btn-box .checkbox").click(function () {
        if($(this).hasClass("checkbox-active")){
            return false;
        }
        var receiverAddrId = $(this).attr("data-id");
        $.ajax({
            url: webPath.webRoot+"/member/setDefaultReceiveAddr.json?receiveAddrId=" + receiverAddrId ,
            success:function() {
                $(".checkbox-active").removeClass("checkbox-active");
                $('em:[data-id='+receiverAddrId+']').addClass("checkbox-active");
            },
            error: function (XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alert(result.errorObject.errorText);
                }
            }
        });
    });
});


function back(){
    var cookies = document.cookie.split(";")||[];
    var backUrl = "";
    for(var i=0;i<cookies.length;i++){
        var arr = cookies[i].split("BACK_URL=");
        if(arr.length == 2){
            if(arr[0].indexOf("LS") != -1){
                backUrl = arr[1];
                break;
            }
        }
    }
    if(backUrl==""){
        window.location.href=webPath.webRoot+"/wap/index.ac";
        return;
    }
    window.location.href = backUrl;
}