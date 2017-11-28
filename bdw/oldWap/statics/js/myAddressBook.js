var addrSelect;//加载地区

//        <%--加载地区 start--%>
function loadAddr() {
    return  $(".addressSelect").ld({ajaxOptions : {"url" : dataValue.webRoot+"/member/addressBook.json"},
        defaultParentId:9,
        style:{"width": "100%"}
    });
}
/**
 *订单详情中返回
 */
function detailBack(){
    if(change){
        change= false;
        // window.location.href='javascript:history.go(-1);' ;
        window.location.href=dataValue.webRoot+'/wap/module/member/myAddressBook.ac';
    }else{
        window.location.href='javascript:history.go(-1);' ;
    }
}
//        <%--加载地区 end--%>
//        <%--初始化 设置btnAdd监听 start--%>
$(document).ready(function() {
    addrSelect = loadAddr();
    if(receiveAddrId){
        btnAlt(receiveAddrId);
    }
    $("input").keypress(function(){
        $("#alert").hide()
    });
    jQuery("#btnAdd").click(function() {
        var name = jQuery.trim(jQuery("#name").val());
        var mobile = jQuery.trim(jQuery("#mobile").val());
        var tel = jQuery.trim(jQuery("#tel").val());
        var zipCode = jQuery.trim(jQuery("#zipcode").val());
        var addr = jQuery.trim(jQuery("#addr").val());
        var zoneId = $("#zone").val();
        var receiveAddrId = jQuery.trim(jQuery("#receiveAddrId").val());

        name = name.replace(/<(script|link|style|iframe)(.|\n)*\/\1>\s*/ig, "");
        name = name.replace(/<.*?>/g, "");
        addr = addr.replace(/<(script|link|style|iframe)(.|\n)*\/\1>\s*/ig, "");
        addr = addr.replace(/<.*?>/g, "");
        mobile = mobile.replace(/<(script|link|style|iframe)(.|\n)*\/\1>\s*/ig, "");
        mobile = mobile.replace(/<.*?>/g, "");
        tel = tel.replace(/<(script|link|style|iframe)(.|\n)*\/\1>\s*/ig, "");
        tel = tel.replace(/<.*?>/g, "");
        zipCode = zipCode.replace(/<(script|link|style|iframe)(.|\n)*\/\1>\s*/ig, "");
        zipCode = zipCode.replace(/<.*?>/g, "");

        //收货人验证
        if (name == "" || name == null) {
            alertMsg("请输入收货人姓名","#alert");
            return;
        }else{
            $("alert").hide();
        }
        if(name.length<2||name.length>20){
            alertMsg("收货人姓名的长度为2-20个字","#alert");
            return;
        }
        /*if (zipCode == "" || zipCode == null) {
             //alertMsg("请填写邮政编码,方便配送","#alert")
             // return;
        }if((zipCode != "" && zipCode.length!=6) || (zipCode == null && zipCode.length!=6)){
            alertMsg("您输入的邮政编码不符合规则","#alert");
            return;
        }*/
        /*else{
            var strT=/^\d+(\.\d+)?$/;
            if(!strT.test(zipCode)){
                alertMsg("请输入数字","#alert")
                return;
            }
            $("alert").hide();
        }*/
        if ($.trim(zoneId)=="请选择") {
            alertMsg("请选择地区","#alert");
            return;
        }else{
            $("#alert2").hide()
        }

        if (addr == "" || addr == null) {
            alertMsg("地址不能为空","#alert");
            return;
        }else if(addr.length>125){
            alertMsg("地址不能大于125个字符","#alert");
            return;
        }else{
            $("#alert3").hide()
        }

        //if(tel == "" || tel== null){
        //    if (mobile == "" || mobile == null) {
        //        alertMsg("手机号码不能为空","#alert")
        //        return;
        //    }else{
        //        $("#alert4").hide()
        //    }
        //}


        if(mobile == "" || mobile== null){
            alertMsg("手机号码不能为空","#alert");
            return;
        }else{
            if(mobile.length != 11){
                alertMsg("手机号长度只能是11位数字","#alert");
                return;
            }else{
                var strP=/^13[0-9]{9}|15[0-99][0-9]{8}|18[0-9][0-9]{8}|147[0-9]{8}|177[0-9]{8}|170[0-9]{8}$/;
                if(!strP.test(mobile)){
                    alertMsg("请输入正确的手机号码","#alert");
                    return;
                }else{
                    $("#alert").hide();
                }
            }
        }
//            var params = $("#newAddrForm").formToArray();
        $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
        $.ajax({
            type:"POST",
            url:dataValue.webRoot+"/member/receiverAddress/saveOrUpdate.json",
            data: {name:name,
                addr:addr,
                mobile:mobile,
                zipcode:zipCode,
                tel:tel,
                zoneId :zoneId,
                receiveAddrId:receiveAddrId
            },
            dataType: "json",
            success:function(data) {
                window.location.href = dataValue.webRoot+'/wap/module/member/myAddressBook.ac?time='+(new Date()).getTime();
            },
            error:function(XMLHttpRequest, textStatus) {
                $("#success").removeClass("sr-only");
                $("#success").text("服务器异常，请稍后重试!");
            }
        });

    });
});
//        <%--初始化 设置btnAdd监听 end--%>

//        <%--编辑地址 start--%>
function btnAlt(reciverAddrId) {
    var zoneId;
    $.ajax({
        type:"post" ,
        url:dataValue.webRoot+"/member/findAddressById.json",
        data:{id:reciverAddrId},
        dataType:"json",
        success:function(data) {
            jQuery("#name").attr("value", data.result.name);
            jQuery("#name").attr("placeholder", "");
            jQuery("#mobile").attr("value", data.result.mobile);
            jQuery("#tel").attr("value", data.result.tel);
            jQuery("#zipcode").attr("value", data.result.zipcode);
            jQuery("#addr").attr("value", data.result.addr);
            jQuery("#addr").attr("placeholder", "");
            jQuery("#receiveAddrId").attr("value", data.result.receiveAddrId);
            zoneId = data.result.zoneId;
            setAddrNm(zoneId);
        }
    });

}
//        <%--编辑地址 end--%>

//        <%--设置地区名称 start--%>
function setAddrNm(zoneId) {
    $.ajax({
        type:"post" ,url:dataValue.webRoot+"/member/zoneNm.json",
        data:{zoneId:zoneId},
        dataType:"json",
        success:function(data) {
            var defaultValue = [data.provinceNm,data.cityNm,data.zoneNm];
            addrSelect.ld("api").selected(defaultValue);
           /* return false;*/
        }
    })
}
//        <%--设置地区名称 end--%>

//        <%--删除地址 start--%>
function btnDel(reciverAddrId) {

    confirm("您确认要删除此收货地址吗？",{onSuccess:function(){
        $.ajax({
            type:"post" ,
            url:dataValue.webRoot+"/member/deleteUserAddress.json?id=" + reciverAddrId ,
            success:function() {
                window.location.href = dataValue.webRoot+'/wap/module/member/myAddressBook.ac?time='+(new Date()).getTime();
            }
        });
    }})
}
//        <%--删除地址 end--%>

//        <%--提示控制 start--%>
function alertMsg(errorMsg,element){
    $(element).show();
    $(element).html(errorMsg);
}
//        <%--提示控制 end--%>