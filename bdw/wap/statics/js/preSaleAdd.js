function consultationChange() {
    var value = $.trim($("#consultCont").val());
    if(value.length>255){
        $("#consultCont").val(value.substring(0, 255));
        $("#consultContLength").text("255/255");
    }else{
        $("#consultCont").val(value);
        $("#consultContLength").text(value.length + "/255");
    }

    if(isEmpty(value)){
        $("#submitBtn").addClass("disable");
    }else {
        $("#submitBtn").removeClass("disable");
    }
}

function isEmpty(value) {
    if(value==undefined || value==null || value.length==0){
        return true;
    }else{
        return false
    }
}

function submitConsultCont() {
    if($("#submitBtn").attr("class")=="disable"){
        return;
    }else{
        $("#submitBtn").addClass("disable");
    }

    var value = $.trim($("#consultCont").val());
    if(isEmpty(value)){
        $("#consultCont").val(value);
        $("#tips").text("描述不能为空");
        $("#tips").show();
        $("#submitBtn").removeClass("disable");
        setTimeout(function () {
            $("#tips").hide();
        }, 1000);
        return;
    }

    if(value.length>255){
        $("#tips").text("描述字符请在255字内");
        $("#tips").show();
        $("#submitBtn").removeClass("disable");
        setTimeout(function () {
            $("#tips").hide();
        }, 1000);
        return;
    }

    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
    $.ajax({
        type:"POST",
        url:webPath.webRoot + "/frontend/comment/addConsultCont.json",
        data:{productId: webPath.productId, consultCont:value},
        dataType:"json",
        async: false,//同步
        success:function(data){
            if(data.success == false){
                $("#tips").text("提交失败");
                $("#tips").show();
                $("#submitBtn").removeClass("disable");
                setTimeout(function () {
                    $("#tips").hide();
                }, 1000);
            }else if(data.success == true){
                location.href = webPath.webRoot + '/wap/presale/preSaleList.ac?productId=' + webPath.productId;
            }
        },
        error:function(data){
            $("#tips").text("提交失败");
            $("#tips").show();
            $("#submitBtn").removeClass("disable");
            setTimeout(function () {
                $("#tips").hide();
            }, 1000);
        }
    });
}