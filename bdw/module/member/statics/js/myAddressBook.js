var addrSelect;//加载地区

//        <%--加载地区 start--%>
function loadAddr() {
    return  $(".addressSelect").ld({ajaxOptions : {"url" : dataValue.webRoot+"/member/addressBook.json"},
        defaultParentId:9,
        style:{"width": 80}
    });
}
//        <%--加载地区 end--%>
//        <%--初始化 设置btnAdd监听 start--%>
$(document).ready(function() {
    $("input").keypress(function(){
        $("#alert").hide();
        $("#alert1").hide();
        $("#alert2").hide();
        $("#alert3").hide();
        $("#alert4").hide();
        $("#alert5").hide()
    });

    $("#name").blur(function(){
        checkConsigneeName();
    });

 /*   $("#zipcode").blur(function(){
        checkZipCode();
    });
*/
    addrSelect = loadAddr();
    jQuery("#btnAdd").click(function() {
        var zoneId;
        var name = jQuery.trim(jQuery("#name").val());
        var mobile = jQuery.trim(jQuery("#mobile").val());
        var tel = jQuery.trim(jQuery("#tel").val());
        var zipCode = jQuery.trim(jQuery("#zipcode").val());
        var addr = jQuery.trim(jQuery("#addr").val());
        var zoneId = $("#zoneId").val();
        var townId = $("#zone").val();
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

        if (name == "" || name == null) {
            alertMsg("请输入收货人姓名","#alert");
            return;
        }else{
            $("alert").hide();
        }
        /*if(name.length<2||name.length>20){
            alertMsg("收货人姓名的长度为2-20个字","#alert");
            return;
        }*/
        if(!checkConsigneeName()){
            return;
        }

        if(undefined != zipCode && null != zipCode && ""!=zipCode){
            var strT=/^\d+(\.\d+)?$/;
            if(zipCode.length!=6){
                alertMsg("邮政编码是6位数字","#alert1");
                return;
            }else if(!strT.test(zipCode)){
                alertMsg("邮政编码必须是数字","#alert1");
                return;
            }else{
                $("alert1").hide();
            }

        }else{
            $("alert1").hide();
        }

        //if(!checkZipCode()){
        //    return;
        //}
        //if (zipCode == "" || zipCode == null) {
        //    alertMsg("邮政编码不能为空","#alert1");
        //    return;
        //}else if(zipCode.length!=6){
        //    alertMsg("您输入的邮政编码不符合规则","#alert1");
        //    return;
        //}else{
        //    var strT=/^\d+(\.\d+)?$/;
        //    if(!strT.test(zipCode)){
        //        alertMsg("请输入数字","#alert1");
        //        return;
        //    }
        //    $("alert1").hide();
        //}
        if ($.trim(townId)=="请选择") {
            alertMsg("请选择地区","#alert2");
            return;
        }else{
            $("#alert2").hide()
        }

        if(undefined==zoneId||0==zoneId){
            alertMsg("请选择地区","#alert2");
            return;
        }else{
            $("#alert2").hide()
        }

        if (addr == "" || addr == null) {
            alertMsg("地址不能为空","#alert3");
            return;
        }else if(addr.length>125){
            alertMsg("请输入小于125个字符","#alert3");
            return;
        }else{
            $("#alert3").hide()
        }


        if(mobile == "" || mobile== null){
            alertMsg("手机号码不能为空","#alert4");
            return;
        }else{
            if(mobile.length != 11){
                alertMsg("手机号长度只能是11位数字","#alert4");
                return;
            }else{
                /*var strP=/^13[0-9]{9}|15[0-99][0-9]{8}|18[0-9][0-9]{8}|147[0-9]{8}|177[0-9]{8}|170[0-9]{8}$/;*/
                var strP=/^1[3|4|5|7|8][0-9]{9}$/;
                if(!strP.test(mobile)){
                    alertMsg("请输入正确的手机号码","#alert4");
                    return;
                }else{
                    $("#alert").hide();
                }
            }
        }


        if(undefined == memberLat1 || null == memberLat1 || ""==memberLat1) {
            breadMemberJDialog("请输入正确的收货地址",1200,"10px",true);
            return;
        }

        if(undefined == memberLng1 || null == memberLng1 || ""==memberLng1) {
            breadMemberJDialog("请输入正确的收货地址",1200,"10px",true);
            return;
        }

        //var strT=/^\d+(\.\d+)?$/;
        //if(tel == "" || tel== null){
        //    if (mobile == "" || mobile == null) {
        //        alertMsg("手机号必填","#alert4");
        //        return;
        //    }else{
        //        $("#alert4").hide()
        //    }
        //}

        //if(mobile == "" || mobile == null){
        //    if (tel == "" || tel == null){
        //        alertMsg("手机号必填","#alert5");
        //        return;
        //    }else if(!strT.test(tel)){
        //        alertMsg("请输入数字","#alert5");
        //        return;
        //    } else if(tel.length>15){
        //        alertMsg("请输入小于15个字符","#alert5");
        //        return;
        //    }else{
        //        $("#alert5").hide()
        //    }
        //}else{
        //    var strP=/^\d+(\.\d+)?$/;
        //    if(!strP.test(mobile)){
        //        alertMsg("请输入数字","#alert4");
        //        return;
        //    }
        //    if(mobile.length != 11){
        //        alertMsg("长度至少是 11","#alert4");
        //        return;
        //    }
        //    if(mobile.length > 11){
        //        alertMsg("您输入的手机长度超出范围","#alert4");
        //        return;
        //    }
        //}
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
                receiveAddrId:receiveAddrId,
                addrLat:memberLat1,
                addrLng:memberLng1
            },
            dataType: "json",
            success:function(data) {
                if (data.success == true) {
                    breadMemberJDialog("添加成功",1200,"10px",true);
                    location.reload();
                    jQuery("#name").attr("value", "");
                    jQuery("#mobile").attr("value", "");
                    jQuery("#tel").attr("value", "");
                    jQuery("#zipcode").attr("value", "");
                    jQuery("#addr").attr("value", "");
                    jQuery("#receiveAddrId").attr("value", "");
                    memberLat1 = null;
                    memberLng1 = null;
                }
                if(data.success == false){
                    if(data.errorCode == "errors.login.noexist"){
                        breadMemberJDialog("您的收货地址已满10个，不能再继续添加!",2000,"30px",true);
                        return false;
                    }
                }
            },
            error:function(XMLHttpRequest, textStatus) {
                breadMemberJDialog("服务器异常，请稍后重试!",2000,"30px",true);
            }
        });
    });
});
//        <%--初始化 设置btnAdd监听 end--%>

//        <%--编辑地址 start--%>
function btnAlt(reciverAddrId) {
    $("#alert").hide();
    $("#alert1").hide();
    $("#alert2").hide();
    $("#alert3").hide();
    $("#alert4").hide();
    $("#alert5").hide();
    var zoneId;
    $.ajax({
        type:"post" ,
        url:dataValue.webRoot+"/member/findAddressById.json",
        data:{id:reciverAddrId},
        dataType:"json",
        success:function(data) {
            jQuery("#name").attr("value", data.result.name);
            jQuery("#mobile").attr("value", data.result.mobile);
            jQuery("#tel").attr("value", data.result.tel);
            jQuery("#zipcode").attr("value", data.result.zipcode);
            jQuery("#addr").attr("value", data.result.addr);
            jQuery("#receiveAddrId").attr("value", data.result.receiveAddrId);
            jQuery("#zoneId").val(data.result.zoneId);
            memberLat = data.result.addrLat;
            memberLng = data.result.addrLng;
            memberLat1 = data.result.addrLat;
            memberLng1 = data.result.addrLng;
            if(!(memberLat || memberLng)){
                breadMemberJDialog("未选定具体位置，请编辑所在位置重新选定",1200,"10px",true);
                initUserMemberAddMap();
            }else{
                initUserMemberMap();
            }
            zoneId = data.result.zoneId;
            setAddrNm(zoneId,data.result.addr);
        }
    });
}

function btnDefault(reciverAddrId) {
    $("#alert").hide();
    $("#alert1").hide();
    $("#alert2").hide();
    $("#alert3").hide();
    $("#alert4").hide();
    $("#alert5").hide();
    $.ajax({
        type:"get",
        url:dataValue.webRoot+"/member/setDefaultReceiveAddr.json?receiveAddrId=" + reciverAddrId ,
        success:function() {
            //只有success才改变样式
            //$(".default").removeClass("cur");
            //obj.addClass("cur");
            window.location.href = dataValue.webRoot+'/module/member/myAddressBook.ac?time='+(new Date()).getTime();
        },
        error:function() {
            alert("服务器出了一点问题，请稍后再进行操作");
        }
    });
}

//        <%--编辑地址 end--%>

//        <%--设置地区名称 start--%>
function setAddrNm(zoneId,address) {
    $.ajax({
        type:"post" ,url:dataValue.webRoot+"/member/zoneNm.json",
        data:{zoneId:zoneId},
        dataType:"json",
        success:function(data) {
            var defaultValue = [data.provinceNm,data.cityNm,data.countryNm,data.zoneNm];
            addrSelect.ld("api").selected(defaultValue);
            var addrPlace = data.cityNm + "," + data.countryNm + "," + data.zoneNm + data. address;
            memberGeocoder.getLocation(addrPlace);

        }
    })
}
//        <%--设置地区名称 end--%>

//        <%--删除地址 start--%>
function btnDel(reciverAddrId) {
    if(confirm("您是否要删除该收货地址?")) {
        $.ajax({
            type: "post",
            url: dataValue.webRoot + "/member/deleteUserAddress.json?id=" + reciverAddrId,
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
            error: function (XMLHttpRequest, textStatus) {
                  if (XMLHttpRequest.status == 500) {
                      var result = eval("(" + XMLHttpRequest.responseText + ")");
                      alert(result.errorObject.errorText);
                  }
              }
        });
    }
    return false;
}
//        <%--删除地址 end--%>

//        <%--提示控制 start--%>
function alertMsg(errorMsg,element){
    $(element).show();
    $(element).html(errorMsg);
}
//        <%--提示控制 end--%>

/*function checkZipCode(){
    var zipCode = jQuery.trim(jQuery("#zipcode").val());
    if (zipCode == "" || zipCode == null) {
        alertMsg("邮政编码不能为空","#alert1");
        return false;
    }else{
        var strT=/^[1-9]{1}(\d+){5}$/;
        if(!strT.test(zipCode)){
            alertMsg("您输入的邮政编码不符合规则","#alert1");
            return false;
        }else{
            $("alert1").hide();
            return true;
        }
    }
}*/

function checkConsigneeName(){
    var name = jQuery.trim(jQuery("#name").val());
    if (name == "" || name == null) {
        alertMsg("请输入收货人姓名","#alert");
        return false;
    }else{
        if(name.length<2||name.length>20){
            alertMsg("收货人姓名的长度为2-20个字","#alert");
            return false;
        }else{
            $("alert").hide();
            return true;
        }
    }
}



//==================地址地图=====================
var memberMarker,memberMap,memberGeocoder = null;
var memberLat,memberLng = null;
var memberLat1,memberLng1 = null;
function initUserMemberMap() {

    var center = new qq.maps.LatLng(memberLat, memberLng);
    memberMap = new qq.maps.Map(document.getElementById('memberMap'), {
        center: center,
        zoom: 13
    });

    memberGeocoder = new qq.maps.Geocoder({
        complete: function (result) {
            memberMap.setCenter(result.detail.location);
            memberMarker.setPosition(result.detail.location);
            memberLat1 = memberMap.getCenter().getLat();
            memberLng1 = memberMap.getCenter().getLng();
        },
        error: function(){
            breadJDialog("出错了，请输入正确的地址!",2000,"30px",true);
        }
    });

    memberMarker = new qq.maps.Marker({
        //设置Marker的位置坐标
        position: center,
        //设置显示Marker的地图
        map: memberMap,
        //设置Marker被添加到Map上时的动画效果为反复弹跳
        animation: qq.maps.MarkerAnimation.BOUNCE,
        //设置Marker被添加到Map上时的动画效果为从天而降
        //animation:qq.maps.MarkerAnimation.DROP
        //设置Marker被添加到Map上时的动画效果为落下
        //animation:qq.maps.MarkerAnimation.DOWN
        //设置Marker被添加到Map上时的动画效果为升起
        //animation:qq.maps.MarkerAnimation.UP
        draggable: true
    });

    //绑定单击事件添加参数
    qq.maps.event.addListener(memberMarker, 'dragend', function(event) {
        memberLat1 = event.latLng.getLat();
        memberLng1 = event.latLng.getLng();
    });

}

var initUserMemberAddMap = function() {
    var center = new qq.maps.LatLng(39.916527, 116.397128);

    memberMap = new qq.maps.Map(document.getElementById('memberMap'), {
        center: center,
        zoom: 13
    });

    var citylocation = new qq.maps.CityService({
        //设置地图
        map : memberMap,
        complete : function(results){
            memberMap.setCenter(results.detail.latLng);
        }
    });
    citylocation.searchLocalCity();
    //调用地址解析类
    memberGeocoder = new qq.maps.Geocoder({
        complete : function(result){
            memberMap.setCenter(result.detail.location);
            memberMarker.setPosition(result.detail.location);
            memberLat1 = memberMap.getCenter().getLat();
            memberLng1 = memberMap.getCenter().getLng();
        },
        error: function(){
            breadJDialog("出错了，请输入正确的地址!",2000,"30px",true);
        }
    });
    memberMarker = new qq.maps.Marker({
        //设置Marker的位置坐标
        position: center,
        //设置显示Marker的地图
        map: memberMap,
        //设置Marker被添加到Map上时的动画效果为反复弹跳
        animation: qq.maps.MarkerAnimation.BOUNCE,
        //设置Marker被添加到Map上时的动画效果为从天而降
        //animation:qq.maps.MarkerAnimation.DROP
        //设置Marker被添加到Map上时的动画效果为落下
        //animation:qq.maps.MarkerAnimation.DOWN
        //设置Marker被添加到Map上时的动画效果为升起
        //animation:qq.maps.MarkerAnimation.UP
        draggable: true
    });
    qq.maps.event.addListener(memberMarker, 'dragend', function(event) {
        memberLat1 = event.latLng.getLat();
        memberLng1 = event.latLng.getLng();
    });

};


$(function(){
    //地图初始化
    initUserMemberAddMap();

    //定位
    //$("#location").click(function(){
    //    var city = $("#city").find("option:selected").text();
    //    var area = $("#zone").find("option:selected").text();
    //    var address = $("#addr").val();
    //    if(city == '请选择' || city == ''){
    //        alert("请选择城市");
    //        return;
    //    }
    //
    //    if(area == '请选择' || area == ''){
    //        alert("请选择区/县");
    //        return;
    //    }
    //
    //    if(address == '' || address == undefined){
    //        alert("请输入街道地址");
    //        return;
    //    }
    //
    //    window.top.located(city,area + address);
    //});
});


function locatedAddr(){
    var  province=document.getElementById("province");
    var provinceIndex=province.selectedIndex ;             // selectedIndex代表的是你所选中项的index
    var provinceName = province.options[provinceIndex].text;

    var  city=document.getElementById("city");
    var cityIndex=city.selectedIndex ;             // selectedIndex代表的是你所选中项的index
    var cityName = city.options[cityIndex].text;

    var  country=document.getElementById("country");
    var countryIndex=country.selectedIndex ;             // selectedIndex代表的是你所选中项的index
    var countryName = country.options[countryIndex].text;

    var  zone=document.getElementById("zone");
    var zoneIndex=zone.selectedIndex ;             // selectedIndex代表的是你所选中项的index
    var zoneName = zone.options[zoneIndex].text;

    var addr = document.getElementById("addr").value;
    var selectedNum = 0;
    if(undefined != provinceName && provinceName != "" && provinceName !='请选择'){
        selectedNum+=1;
    }

    if(undefined != cityName && cityName != "" && cityName !='请选择'){
        selectedNum+=1;
    }

    if(undefined != countryName && countryName != "" && countryName !='请选择'){
        selectedNum+=1;
    }

    if(undefined != zoneName && zoneName != "" && zoneName !='请选择'){
        selectedNum+=1;
    }

    if(undefined != addr && addr != ""){
        selectedNum+=1;
    }

    if(selectedNum >= 4){
        var place = cityName + "," + countryName + "," + zoneName + "," + addr;
        //通过getLocation();方法获取位置信息值
        memberGeocoder.getLocation(place);
    }

}


//因为用户可能第一次修改选择地址后，对地址进行二次修改，此时不会定位正确的地址;
//省级
function proviceSelected(obj){
    locatedAddr();

}
//市级
function citySelected(obj){
    locatedAddr();
}
//地区
function areaSelected(obj){
    var value = $.trim($(obj).val());
    if(value!=0&&value!=undefined&&value!="请选择"){
        $("#zoneId").val(value);
    }
    locatedAddr();
}



//没有标题和按钮的提示框
function breadMemberJDialog(content, autoClose, padding, modal){
    var dialog = jDialog.message(content,{
        autoClose : autoClose,    // 3s(3000)后自动关闭
        padding : padding,    // 设置内部padding
        modal: modal         // 非模态，即不显示遮罩层
    });
    return dialog;
}
