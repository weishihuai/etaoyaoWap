$(function(){
    //如果是编辑地址，要先把相对应的值填进各个文本框
    if($(".receiveAddrId").attr("value") != null && $(".receiveAddrId").attr("value") != ''){
        var receiveAddrId = $(".receiveAddrId").attr("value");
        $.ajax({
            type:"post" ,
            url:dataValue.webRoot+"/member/findAddressById.json",
            data:{id:receiveAddrId},
            dataType:"json",
            success:function(data) {
                $(".name").attr("value", data.result.name);
                $(".name").attr("placeholder", "");
                $(".phone").attr("value", data.result.mobile);
                $(".phone").attr("placeholder", "");
                $(".addr").attr("value", data.result.addr);
                $(".addr").attr("placeholder", "");
                $(".zipcode").attr("value", data.result.zipcode);
                $(".zipcode").attr("placeholder", "");
                $(".zoneId").val(data.result.zoneId);
                $(".receiveAddrId").val(data.result.receiveAddrId);
                setAddrNm(data.result.zoneId);
                /*if(data.result.isDefault == "Y"){
                    $(".use-always").addClass("cur");
                    $(".use-always").attr("isDefault","Y");
                }
                if(data.result.isDefault == "N"){
                    $(".use-always").removeClass("cur");
                    $(".use-always").attr("isDefault","N");
                }*/
            }
        });
    }

    $(".clearName").click(function(){
        $(".name").attr("value","");
    });

    $(".clearPhone").click(function(){
        $(".phone").attr("value","");
    });

    $(".clearAddr").click(function(){
        $(".addr").attr("value","");
    });

    $(".clearZip").click(function(){
        $(".zipcode").attr("value","");
    });

    //点击选择"请选择省，市，区"触发
    $(".addrPath").click(function(){
        $.ajax({
            url:dataValue.webRoot+'/member/addressBook.json?sysTreeNodeId=9',
            success:function(data){
                $.each(data.result,function(i,val){
                    //$(".provinceList").append("<a href='javascript:;' class='area-name' sysTreeNodeId=" + val.sysTreeNodeId + ">" + val.sysTreeNodeNm + "<span></span></a>");
                    $(".provinceList").append("<a id=" + val.sysTreeNodeId + " href=javascript:void(0); class=area-name onclick=provinceClick(" + val.sysTreeNodeId + ",'" + val.sysTreeNodeNm + "')>" + val.sysTreeNodeNm + "</a>");
                });
                $(".provinceArea").css("display","block");
            },
            error:function() {
                xyPop({content:'系统繁忙，请稍后重试!',type:'error'});
            }
        });
    });

    //默认按钮
    /*$(".use-always").click(function(){
        if($(".use-always").attr("isDefault") == "Y"){
            $(".use-always").removeClass("cur");
            $(".use-always").attr("isDefault","N");
        }
        else {
            $(".use-always").addClass("cur");
            $(".use-always").attr("isDefault","Y");
        }
    });*/

    $(".back").click(function(){
        if($(this).hasClass("province")){
            $(".provinceArea").css("display","none");
            $(".provinceList").empty();
        }
        else if($(this).hasClass("city")){
            $(".provinceArea").css("display","block");
            $(".cityArea").css("display","none");
            $(".cityList").empty();
        }
        else if($(this).hasClass("zone")){
            $(".cityArea").css("display","block");
            $(".zoneArea").css("display","none");
            $(".zoneList").empty();
        }
    });

    $(".del").click(function(){
        $(".provinceList").empty();
        $(".cityList").empty();
        $(".zoneList").empty();
        $(".provinceArea").css("display","none");
        $(".cityArea").css("display","none");
        $(".zoneArea").css("display","none");
    });

    $(".save-btn").click(function() {
        var name = $.trim($(".name").val());
        var phone = $.trim($(".phone").val());
        var addr = $.trim($(".addr").val());
        var zipcode = $.trim($(".zipcode").val());
        var zoneId = $(".zoneId").val();
        var receiveAddrId = $.trim($(".receiveAddrId").attr("value"));
        /*var isDefault = $(".use-always").attr("isDefault");
        if(isDefault == "Y"){
            isDefault = true;
        }
        else{
            isDefault = false;
        }*/

        name = name.replace(/<(script|link|style|iframe)(.|\n)*\/\1>\s*/ig, "");
        name = name.replace(/<.*?>/g, "");
        addr = addr.replace(/<(script|link|style|iframe)(.|\n)*\/\1>\s*/ig, "");
        addr = addr.replace(/<.*?>/g, "");
        phone = phone.replace(/<(script|link|style|iframe)(.|\n)*\/\1>\s*/ig, "");
        phone = phone.replace(/<.*?>/g, "");
        zipcode = zipcode.replace(/<(script|link|style|iframe)(.|\n)*\/\1>\s*/ig, "");
        zipcode = zipcode.replace(/<.*?>/g, "");

        if(name == "" || name == null || addr == "" || addr == null || phone == "" || phone == null){
            xyPop.msg('请完善所有信息!',{type:'warning',time:2});
            return;
        }

        if(name.length<2||name.length>20){
            xyPop.msg('收货人姓名的长度为2-20个字!',{type:'warning',time:2});
            $(".name").focus();
            return;
        }

        if(phone.length != 11){
            xyPop.msg('手机号长度只能是11位数字!',{type:'warning',time:2});
            $(".phone").focus();
            return;
        }
        else{
            var strP=/^13[0-9]{9}|15[0-99][0-9]{8}|18[0-9][0-9]{8}|147[0-9]{8}|177[0-9]{8}|170[0-9]{8}$/;
            if(!strP.test(phone)){
                xyPop.msg('请输入正确的手机号码!',{type:'warning',time:2});
                $(".phone").focus();
                return;
            }
        }

        if(addr.length>125) {
            xyPop.msg('地址不能大于125个字符!',{type:'warning',time:2});
            $(".addr").focus();
            return;
        }

        //邮政编码非必填
        if(zipcode != ""){
            if (zipcode.length != 6) {
                xyPop.msg('您输入的邮政编码不符合规则!',{type:'warning',time:2});
                $(".zipcode").focus();
                return;
            } else {
                var strT = /^\d+(\.\d+)?$/;
                if (!strT.test(zipcode)) {
                    xyPop.msg('邮政编码请输入数字!',{type:'warning',time:2});
                    $(".zipcode").focus();
                    return;
                }
            }
        }

        if(zoneId == "" || zoneId == null){
            xyPop.msg('请选择地区!',{type:'warning',time:2});
        }

        $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
        $.ajax({
            type:"POST",
            url:dataValue.webRoot+"/member/receiverAddress/saveOrUpdate.json",
            data: { name:name,
                    addr:addr,
                    mobile:phone,
                    zipcode:zipcode,
                    zoneId:zoneId,
                    receiveAddrId:receiveAddrId
                    //isDefault:isDefault
            },
            dataType: "json",
            success:function(data) {
                //window.location.href = dataValue.webRoot+'/wap/module/member/myAddressBook.ac?time='+(new Date()).getTime();
                window.location.href=dataValue.webRoot+"/wap/shoppingcart/addrSelect.ac?handler="+dataValue.handler+"&carttype="+dataValue.carttype;
            },
            error:function() {
                xyPop({content:'系统繁忙，请稍后重试!',type:'error'});
            }
        });
    });
});

function provinceClick(sysTreeNodeId,sysTreeNodeNm){
    //$(".area-name").removeClass("cur");
    //$("$"+sysTreeNodeId).addClass("cur");
    $.ajax({
        url:dataValue.webRoot+'/member/addressBook.json?sysTreeNodeId=' + sysTreeNodeId,
        success:function(data){
            if(data.result.length){
                $.each(data.result, function (i, val) {
                    $(".cityList").append("<a href=javascript:void(0); class=area-name onclick=cityClick(" + val.sysTreeNodeId + ",'" + val.sysTreeNodeNm + "')>" + val.sysTreeNodeNm + "</a>");
                });
                $(".cityArea").css("display", "block");
            }
            else{
                //这里处理没有子节点的情况
                $(".addrPathText").text(sysTreeNodeNm);
                $(".zoneId").val(sysTreeNodeId);
                $(".provinceList").empty();
                $(".cityList").empty();
                $(".zoneList").empty();
                $(".provinceArea").css("display","none");
                $(".cityArea").css("display","none");
                $(".zoneArea").css("display","none");
            }
        },
        error:function() {
            xyPop({content:'系统繁忙，请稍后重试!',type:'error'});
        }
    });
    $(".citySelected").text(sysTreeNodeNm);
}

function cityClick(sysTreeNodeId,sysTreeNodeNm){
    $.ajax({
        url:dataValue.webRoot+'/member/addressBook.json?sysTreeNodeId=' + sysTreeNodeId,
        success:function(data){
            if(data.result.length > 0){
                $.each(data.result,function(i,val){
                    $(".zoneList").append("<a href=javascript:void(0); class=area-name onclick=zoneClick(" + val.sysTreeNodeId + ",'" + val.sysTreeNodeNm + "')>" + val.sysTreeNodeNm + "</a>");
                });
                $(".zoneArea").css("display","block");
            }
            else{
                //这里处理没有子节点的情况
                $(".addrPathText").text($(".citySelected").text() + " " + sysTreeNodeNm);
                $(".zoneId").val(sysTreeNodeId);
                $(".provinceList").empty();
                $(".cityList").empty();
                $(".zoneList").empty();
                $(".provinceArea").css("display","none");
                $(".cityArea").css("display","none");
                $(".zoneArea").css("display","none");
            }
        },
        error:function() {
            xyPop({content:'系统繁忙，请稍后重试!',type:'error'});
        }
    });
    $(".zoneSelected").text($(".citySelected").text() + " " + sysTreeNodeNm);
}

function zoneClick(sysTreeNodeId,sysTreeNodeNm){
    $(".addrPathText").text($(".zoneSelected").text() + " " + sysTreeNodeNm);
    //$(".addrPath").attr("zoneId",sysTreeNodeId);
    $(".zoneId").val(sysTreeNodeId);
    $(".provinceList").empty();
    $(".cityList").empty();
    $(".zoneList").empty();
    $(".provinceArea").css("display","none");
    $(".cityArea").css("display","none");
    $(".zoneArea").css("display","none");
}

function setAddrNm(zoneId) {
    $.ajax({
        type:"post" ,url:dataValue.webRoot+"/member/zoneNm.json",
        data:{zoneId:zoneId},
        dataType:"json",
        success:function(data) {
            var defaultValue = data.provinceNm + " " + data.cityNm + " " + data.zoneNm;
            $(".addrPathText").text(defaultValue);
            $(".zoneId").val(zoneId);
        }
    })
}




