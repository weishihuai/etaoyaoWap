function buyerSigned(getTorphyRecodeId){
    confirm("您确认收货了吗？",{onSuccess:function(){
        $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8;";
        $.ajax({
            type:"GET",
            url:dataValue.webRoot+"/frontend/vmall/vgettorphyrecode/buyerSigned.json?getTorphyRecodeId="+getTorphyRecodeId ,
            success:function(data) {
                if (data.success == "true") {
                    setTimeout(function(){
                        window.location.href = dataValue.webRoot+"/wap/module/member/vLogisticsDetail.ac?getTorphyRecodeId="+getTorphyRecodeId+"&time="+new Date().getMilliseconds();
                    },1)
                }
            },
            error:function(XMLHttpRequest, textStatus) {
                alert("确认收货失败！");
            }
        });
    }});
}