
$(function(){
    var addrSelect;//加载地区


    /* 新增收货地址 省市区切换 */
    (function(){
        var item_site = $("#item_site");
        var mrt = item_site.find(".mrt");
        var dt = item_site.find(".dt");
        var dd_ul = item_site.find(".dd").find("ul");
        var icon = item_site.find(".icon");

        dt.on("click","li",function(){
            var index = $(this).index();
            $(this).addClass("cur").siblings().removeClass("cur");
            icon.css("left",index*69 +10);
            dd_ul.eq(index).show().siblings().hide();
        });

        dd_ul.on("click","li",function(event){
            var p_index = $(this).parent().index();

            $(this).addClass("cur").siblings().removeClass("cur");
            dt.find("li").eq(p_index+1).addClass("cur").siblings().removeClass("cur");

            if (p_index >= 2) {
                event.stopPropagation();
                mrt.removeClass("mrt-show");
            }
            else {
                dt.find("li").eq(p_index+1).addClass("cur").siblings().removeClass("cur");
                icon.css("left",(p_index+1)*69 +10);
                dd_ul.eq(p_index+1).show().siblings().hide();
            }
            var type = $(this).parent().attr('id');
            var id = $(this).attr('id');
            if(type == "provinceConten"){
                loadCityAddr(id);
            }else if(type == "cityConten"){
                loadZoneAddr(id);
            }else if(type == "zoneConten"){
               var pathName = getPathName();
                $("#zoneId").val(id);
                $("#pathName").text(pathName);
            }
        });

        item_site.on("click",function(event){
            event.stopPropagation();
            mrt.addClass("mrt-show");
        });

        $(document).on("click",function(){
            mrt.removeClass("mrt-show");
        });
    })();
    /*--加载地区 start--*/
    loadProvinceAddr();

    /* 打开/关闭弹窗 */
    (function(){
        $(".shipping-address-btn").on("click",function(){
            $(".layer").show();
        });

        $(".layer .close").on("click",function(){
            $(".layer").hide();
        });
    })();


    /* 收货地址切换 */
    (function(){
        $(".shipping-address .dd").on("click",function(){
            $(this).addClass("dd-cur").siblings().removeClass("dd-cur");
        });

        $(".shipping-address .dd").find("a").on("click",function(event){
            event.stopPropagation();
        });

    })();
});

function showAddressWin(){
    jQuery("#name").attr("value", "");
    jQuery("#mobile").attr("value", "");
    jQuery("#tel").attr("value", "");
    jQuery("#zipcode").attr("value","");
    jQuery("#addr").attr("value","");
    jQuery("#receiveAddrId").attr("value","");
    jQuery("#zoneId").val("");
    jQuery("#cityId").val("");
    jQuery("#provinceId").val("");
    jQuery("#isDefault").attr("data-checked","false");
    $("#addressWin").show();
}

function editAddressWin(id){
    $.ajax({
        type: "post",
        url: webPath.webRoot + "/member/findAddressById.json",
        data:{id:id},
        success: function (data) {
            jQuery("#name").attr("value", data.result.name);
            jQuery("#mobile").attr("value", data.result.mobile);
            jQuery("#tel").attr("value", data.result.tel);
            jQuery("#zipcode").attr("value", data.result.zipcode);
            jQuery("#addr").attr("value", data.result.addr);
            jQuery("#receiveAddrId").attr("value", data.result.receiveAddrId);
            jQuery("#zoneId").val(data.result.zoneId);
            jQuery("#cityId").val(data.result.cityId);
            jQuery("#provinceId").val(data.result.provinceId);
            jQuery("#pathName").text(data.result.pathName);

            if(data.result.isDefault == 'N'){
                jQuery("#isDefault").attr("data-checked",'false');
            }else if(data.result.isDefault == 'Y'){
                jQuery("#isDefault").attr("data-checked",'true');
            }
            loadProvinceAddr();
        },
        error: errorFun
    });
    $("#addressWin").show();
}

//关闭
function closeAddressWin(){
    $("#addressWin").hide();
}

//加载省
function loadProvinceAddr() {
    $.ajax({
        type: "post",
        url: webPath.webRoot + "/member/addressBook.json",
        data:{sysTreeNodeId:9},
        success: function (data) {
            $("#provinceConten").html("");
            var provinceId = $("#provinceId").val();
            $.each(data.result, function (i, item) {
                var isSelect = provinceId == item.sysTreeNodeId?"cur":"";
                $("#provinceConten").append("<li class='"+isSelect+"' id='"+item.sysTreeNodeId+"' ><span>"+item.sysTreeNodeNm+"</span></li>");
            });
            if(provinceId != ""){
                loadCityAddr(provinceId);
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

//加载市
function loadCityAddr(provinceId) {
    $.ajax({
        type: "post",
        url: webPath.webRoot + "/member/addressBook.json",
        data:{sysTreeNodeId:provinceId},
        success: function (data) {
            $("#cityConten").html("");
            var cityId = $("#cityId").val();
            $.each(data.result, function (i, item) {
                var isSelect = cityId == item.sysTreeNodeId?"cur":"";
                $("#cityConten").append("<li class='"+isSelect+"' id='"+item.sysTreeNodeId+"'><span>"+item.sysTreeNodeNm+"</span></li>");
            });
            if(cityId != ""){
                loadZoneAddr(cityId);
            }
        },
        error: errorFun
    });
}

//加载区
function loadZoneAddr(cityId) {
    $.ajax({
        type: "post",
        url: webPath.webRoot + "/member/addressBook.json",
        data:{sysTreeNodeId:cityId},
        success: function (data) {
            $("#zoneConten").html("");
            var zoneId = $("#zoneId").val();
            $.each(data.result, function (i, item) {
                var isSelect = zoneId == item.sysTreeNodeId?"cur":"";
                $("#zoneConten").append("<li class='"+isSelect+"' id='"+item.sysTreeNodeId+"'><span>"+item.sysTreeNodeNm+"</span></li>");
            });
        },
        error: errorFun
    });
}

function getPathName(){
    var province = $("#provinceConten").find(".cur").text();
    var city = $("#cityConten").find(".cur").text();
    var zone = $("#zoneConten").find(".cur").text();
    return province+"/"+city+"/"+zone;
}

//删除收货地址
function btnDel(reciverAddrId) {
    if(confirm("您是否要删除该收货地址?")) {
        $.ajax({
            type: "post",
            url: webPath.webRoot + "/member/deleteUserAddress.json?id=" + reciverAddrId,
            success: function (data) {
                if (data.success == true) {
                    alert("删除地址成功");
                    //清空值
                    jQuery("#name").attr("value", "");
                    jQuery("#mobile").attr("value","");
                    jQuery("#tel").attr("value", "");
                    jQuery("#zipcode").attr("value","");
                    jQuery("#addr").attr("value", "");
                    jQuery("#receiveAddrId").attr("value", "");
                    location.reload();
                } else {
                    alert("删除地址失败，请重试");
                    location.reload();
                }
            },
            error: errorFun
        });
    }
    return false;
}

function  saveOrUpdateAddress() {
        var name = jQuery.trim(jQuery("#name").val());
        var mobile = jQuery.trim(jQuery("#mobile").val());
        var tel = jQuery.trim(jQuery("#tel").val());
        var zipCode = jQuery.trim(jQuery("#zipcode").val());
        var addr = jQuery.trim(jQuery("#addr").val());
        var zoneId = $("#zoneId").val();
        var receiveAddrId = jQuery.trim(jQuery("#receiveAddrId").val());
        var isDefault = $("#isDefault").attr("data-checked");

        if (name == "") {
            alert("请输入收货人姓名");
            return false;
        }

        if(zipCode != ""){
            if(zipCode.length!=6){
                alert("邮政编码是6位数字");
                return false;
            }
            var strT=/^\d+(\.\d+)?$/;
            if(!strT.test(zipCode)){
                alert("邮政编码必须是数字");
                return;
            }
        }

        if(undefined==zoneId||0==zoneId){
            alert("请选择地区");
            return false;
        }

        if (addr == "") {
            alert("地址不能为空");
            return false;
        }


        if(mobile == ""){
            alert("手机号码不能为空");
            return false;
        }
        if(mobile.length != 11){
            alert("手机号长度只能是11位数字");
            return false;
        }
        var strP=/^1[3|4|5|7|8][0-9]{9}$/;
        if(!strP.test(mobile)){
            alert("请输入正确的手机号码");
            return false;
        }

        if(isDefault != "true" && isDefault != "false"){
            alert("请重新选择默认地址");
            return false;
        }

        $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
        $.ajax({
            type:"POST",
            url:webPath.webRoot+"/member/receiverAddress/saveOrUpdate.json",
            data: {name:name,
                addr:addr,
                mobile:mobile,
                zipcode:zipCode,
                tel:tel,
                zoneId :zoneId,
                receiveAddrId:receiveAddrId,
                isDefault:isDefault
            },
            dataType: "json",
            success:function(data) {
                if (data.success == true) {
                    location.reload();
                }
                if(data.success == false){
                    if(data.errorCode == "errors.login.noexist"){
                        alert("您的收货地址已满10个，不能再继续添加!");
                        return false;
                    }
                }
            },
            error:function(XMLHttpRequest, textStatus) {
                alert("服务器异常，请稍后重试!");
            }
        });
}

function errorFun(XMLHttpRequest, textStatus){
    if (XMLHttpRequest.status == 500) {
        var result = eval("(" + XMLHttpRequest.responseText + ")");
        alert(result.errorObject.errorText);
    }
}
