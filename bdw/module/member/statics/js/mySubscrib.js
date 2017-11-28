var subscription = function(idStr){
    $.ajax({
        type:"GET",
        url:dataValue.webRoot+"/member/subscribe.json",
        data:{treeId:idStr},
        dataType:"json",
        success:function(data){
            if(data.success == true){
                alert("订阅信息成功!");
                window.location.reload();
            }
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                alert(result.jsonError.errorText);
            }
        }
    })
};
var unsubscribe = function (idStr){
    $.ajax({
        type:"GET",
        url:dataValue.webRoot+"/member/unsubscribe.json",
        data:{treeId:idStr},
        dataType:"json",
        success:function(data){
            if(data.success == true){
                alert("取消订阅信息成功!");
                window.location.reload();
            }
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                alert(result.jsonError.errorText);
            }
        }
    })
};