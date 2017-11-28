$(function(){
    /*最新中标公告上下滚动*/
    //$('.dowebok').vTicker({
    //    showItems: 5,
    //    pause: 3000
    //});
    $("#toInv").click(function(){
        $("#investment").show();
        $("#zone").val("");
        $("#merchant").val("");
        $("#agentType li").removeClass("cur");
        $("#contactMan").val("");
        $("#contactTel").val("");
        $("#message").val("");
    });

    $("#toClose").click(function(){
        $("#investment").hide();
        $("#zone").val("");
        $("#merchant").val("");
        $("#agentType li").removeClass("cur");
        $("#contactMan").val("");
        $("#contactTel").val("");
        $("#message").val("");
    });

    $("#resetForm").click(function(){
        $("#zone").val("");
        $("#merchant").val("");
        $("#agentType li").removeClass("cur");
        $("#contactMan").val("");
        $("#contactTel").val("");
        $("#message").val("");
    });

    $("#submitInfo").click(function(){
        submitInfo();
    });
});

function submitInfo(){
    var merchantsInfId = $.trim($("#merchantsInfId").val());
    var zone = $.trim($("#zone").val());
    var contactMan = $.trim($("#contactMan").val());
    var contactTel = $.trim($("#contactTel").val());
    var message = $.trim($("#message").val());
    var unitNm = $.trim($("#merchant").val());
    var typeArray = [];

    var checkContactTel = /^1[34578](\d{9})$/;
    var merZone = $.trim($("#merZone").val());
    var zones = zone.replace(/，/g,",");
    var listZones = zones.split(",");
    var listMerZone = merZone.split(",");
    var sameZones = listZones.concat(listMerZone);
    var str = [];
    for(var i = 0; i < sameZones.length; i++){
        ! RegExp(sameZones[i],"g").test(str.join(",")) && (str.push(sameZones[i]));
    }

    $("#agentType li.cur").each(function(){
        var agentType = $(this).find("a").attr("agentType");
        typeArray.push(agentType);
    });

    if(undefined == zone || null == zone || '' == zone){
        breadJDialog("请填写代理区域!",2000,"30px",true);
        return;
    }else if($.trim($("#zone").val()).length > 1024){
        breadJDialog("代理区域过长!",2000,"30px",true);
        return;
    }
    //else if(str.length > listMerZone.length){
    //    breadJDialog("请看清可代理区域!",2000,"30px",true);
    //    return;
    //}

    if(undefined == typeArray || null == typeArray || typeArray.length <= 0){
        breadJDialog("请选择代理类型!",2000,"30px",true);
        return;
    }

    if(undefined == contactMan || null == contactMan || '' == contactMan){
        breadJDialog("请填写联系人姓名!",2000,"30px",true);
        return;
    }else if($.trim($("#contactMan").val()).length > 60){
        breadJDialog("联系人姓名过长!",2000,"30px",true);
        return;
    }

    if(undefined == contactTel || null == contactTel || '' == contactTel){
        breadJDialog("请填写联系电话!",2000,"30px",true);
        return;
    }else if(!checkContactTel.test(contactTel)){
        breadJDialog("请填写有效的手机号!",2000,"30px",true);
        return;
    }

    if(undefined == message || null == message || '' == message){
        breadJDialog("请填写代理简述!",2000,"30px",true);
        return;
    }else if($.trim($("#message").val()).length > 1024){
        breadJDialog("代理简述过长!",2000,"30px",true);
        return;
    }

    var requestUrl = webPath.webRoot + "/agentInfFront/saveAgentInf.json";
    $.ajax({
        type: 'post',
        dataType : "json",
        data:{"merchantsInfId":merchantsInfId,"agentZone":zone,"unitNm":unitNm,"agentChannel":typeArray.toString(),"contactMan":contactMan,"contactTel":contactTel,"message":message},
        url: requestUrl,
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        success: function(data) {
            if(data.success){
                breadJDialog("代理申请提交成功,等待平台审核!",2000,"30px",true);
                $("#investment").hide();
                $("#zone").val("");
                $("#merchant").val("");
                $("#agentType li").removeClass("cur");
                $("#contactMan").val("");
                $("#contactTel").val("");
                $("#message").val("");
            }else{
                breadJDialog("代理申请提交失败，请重新提交!",2000,"30px",true);
            }
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                breadJDialog(result.errorObject.errorText,2000,"30px",true);
            }
        }
    });
}

function selectZsType(count){
    var obj = $(".type" + count);
    if(obj.hasClass("cur")){
        obj.removeClass("cur");
    }else{
        obj.addClass("cur");
    }
}

//没有标题和按钮的提示框
function breadJDialog(content, autoClose, padding, modal){
    var dialog = jDialog.message(content,{
        autoClose : autoClose,    // 3s后自动关闭
        padding : padding,    // 设置内部padding
        modal: modal         // 非模态，即不显示遮罩层
    });
    return dialog;
}
