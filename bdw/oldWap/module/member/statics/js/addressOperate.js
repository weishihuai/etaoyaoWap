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
                //alert(data.result.isDefault);
                if(data.result.isDefault == "Y"){
                    $(".use-always").addClass("cur");
                    $(".use-always").attr("isDefault","Y");
                }
                if(data.result.isDefault == "N"){
                    $(".use-always").removeClass("cur");
                    $(".use-always").attr("isDefault","N");
                }
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
                showError("系统繁忙，请稍后重试!");
                //xyPop({content:'系统繁忙，请稍后重试!',type:'error'});
            }
        });
    });

    $("#detailAddr").bind("input propertychange",function(){
        var proCityArea = $(".addrPathText").html();
        if(undefined == proCityArea || null == proCityArea || "" == proCityArea || (proCityArea.indexOf('请选择'))>-1) {
            proCityArea="";
            showError("请选择省市区");
            return;
        }else{
            proCityArea = proCityArea.replace(" ", "");
        }
        var detailAddress = $.trim($("#detailAddr").val());
        if(undefined != detailAddress && null != detailAddress && "" != detailAddress) {
            detailAddress = detailAddress.replace(" ","");
        }else{
            detailAddress = "";
        }

        if(null == memberGeocoder || undefined == memberGeocoder){
            initMemberMap(memberLat,memberLng);
        }
        memberGeocoder.getLocation(proCityArea+","+detailAddress);
    });

    $("#detailAddr").focus(function(){
        var proCity = $(".addrPathText").html();
        if(undefined == proCity || null == proCity || "" == proCity || (proCity.indexOf('请选择'))>-1){
            showError('请选择地区!');
            $(".addrPath").focus();
            $(".addrPath").click();

        }
    });

    //默认按钮
    $(".use-always").click(function(){
        if($(".use-always").attr("isDefault") == "Y"){
            $(".use-always").removeClass("cur");
            $(".use-always").attr("isDefault","N");
        }
        else {
            $(".use-always").addClass("cur");
            $(".use-always").attr("isDefault","Y");
        }
    });

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
        else if($(this).hasClass("town")){
            $(".zoneArea").css("display","block");
            $(".townArea").css("display","none");
            $(".townList").empty();
        }
    });

    $(".del").click(function(){
        $(".provinceList").empty();
        $(".cityList").empty();
        $(".zoneList").empty();
        $(".townList").empty();
        $(".provinceArea").css("display","none");
        $(".cityArea").css("display","none");
        $(".zoneArea").css("display","none");
        $(".townArea").css("display","none");
    });

    $(".save-btn").click(function() {
        setTimeout(function(){},10000);

        var name = $.trim($(".name").val());
        var phone = $.trim($(".phone").val());
        var proCity = $.trim($(".addrPathText").text());
        var addr = $.trim($(".addr").val());
        var zipcode = $.trim($(".zipcode").val());
        var zoneId = $(".zoneId").val();
        var receiveAddrId = $.trim($(".receiveAddrId").attr("value"));
        var isDefault = $(".use-always").attr("isDefault");
        if(isDefault == "Y"){
            isDefault = true;
        }
        else{
            isDefault = false;
        }

        name = name.replace(/<(script|link|style|iframe)(.|\n)*\/\1>\s*/ig, "");
        name = name.replace(/<.*?>/g, "");
        addr = addr.replace(/<(script|link|style|iframe)(.|\n)*\/\1>\s*/ig, "");
        addr = addr.replace(/<.*?>/g, "");
        phone = phone.replace(/<(script|link|style|iframe)(.|\n)*\/\1>\s*/ig, "");
        phone = phone.replace(/<.*?>/g, "");
        zipcode = zipcode.replace(/<(script|link|style|iframe)(.|\n)*\/\1>\s*/ig, "");
        zipcode = zipcode.replace(/<.*?>/g, "");

        if(name == "" || name == null || addr == "" || addr == null || phone == "" || phone == null){
            showError('请完善所有信息!');
            //xyPop.msg('请完善所有信息!',{time:2,type:"warning"});
            return;
        }

        if(name.length<2||name.length>20){
            showError('收货人姓名的长度为2-20个字!');
            //xyPop.msg('收货人姓名的长度为2-20个字!',{time:2,type:"warning"});
            $(".name").focus();
            return;
        }

        if(phone.length != 11){
            showError('手机号长度只能是11位数字!');
            //xyPop.msg('手机号长度只能是11位数字!',{time:2,type:"warning"});
            $(".phone").focus();
            return;
        }
        else{
            /*var strP=/^13[0-9]{9}|15[0-99][0-9]{8}|18[0-9][0-9]{8}|147[0-9]{8}|177[0-9]{8}|170[0-9]{8}$/;*/
            var strP=/^1[3|4|5|7|8][0-9]{9}$/;
            if(!strP.test(phone)){
                showError('请输入正确的手机号码!');
                //xyPop.msg('请输入正确的手机号码!',{time:2,type:"warning"});
                $(".phone").focus();
                return;
            }
        }

        if(undefined == proCity || null == proCity || "" == proCity || (proCity.indexOf('请选择'))>-1){
            showError('请选择地区!');
            return;
            //xyPop.msg('请选择地区!',{time:2,type:"warning"});
        }

        if(addr.length>125) {
            showError('地址不能大于125个字符!');
            //xyPop.msg('地址不能大于125个字符!',{time:2,type:"warning"});
            $(".addr").focus();
            return;
        }

        //邮政编码非必填
        if(zipcode != ""){
            if (zipcode.length != 6) {
                showError('邮政编码不符合规则!');
                //xyPop.msg('您输入的邮政编码不符合规则!',{time:2,type:"warning"});
                $(".zipcode").focus();
                return;
            } else {
                var strT = /^\d+(\.\d+)?$/;
                if (!strT.test(zipcode)) {
                    showError('邮政编码只能是数字!');
                    //xyPop.msg('邮政编码请输入数字!',{time:2,type:"warning"});
                    $(".zipcode").focus();
                    return;
                }
            }
        }

        var isMap = $(".addrPath").attr("ismaplocated");
        if(isMap == 'true'){
            if(isEmpty(memberLat) || isEmpty(memberLng)){
                showError('定位失败,请重新定位!');
                //xyPop.msg('定位失败,请重新定位!',{time:2,type:"warning"});
                return;
            }
        }

        layer.load();
        var urlData={ name:name,
            addr:addr,
            mobile:phone,
            zoneId:zoneId,
            zipcode:zipcode,
            receiveAddrId:receiveAddrId,
            isDefault:isDefault,
            addrLat:null == memberLat?undefined:memberLat,
            addrLng:null == memberLng?undefined:memberLng,
            city:city,
            district:district
        };

        if(isEmpty(memberLat) || isEmpty(memberLng)){
            //调用地址解析类
            var newGeocoder = new qq.maps.Geocoder({
                complete : function(result){
                    var detail = result.detail;
                    urlData.addrLat = detail.location.getLat();
                    urlData.addrLng = detail.location.getLng();

                    setTimeout(saveAddr(urlData),1000);
                },
                error: function(){
                    layer.closeAll();
                    showError('定位失败,请重新定位!');

                }
            });
            newGeocoder.getLocation(proCity+","+addr);
        } else {
            setTimeout(saveAddr(urlData),1000);
        }
    });
});

function saveAddr(urlData){
    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
    $.ajax({
        type:"POST",
        url:dataValue.webRoot+"/member/receiverAddress/saveOrUpdate.json",
        data: urlData,
        dataType: "json",
        success:function(data) {
            layer.closeAll();
            if (dataValue.fromPath != null && dataValue.fromPath != "") {
                if ("addrSelect" == dataValue.fromPath) {
                    // 来自普通订单提交页
                    window.location.href = dataValue.webRoot+'/wap/shoppingcart/addrSelect.ac?handler=' + dataValue.handler + '&carttype=' + dataValue.carttype + '&isCod=' + dataValue.isCod + '&time='+(new Date()).getTime();
                } else if ("integralAddrSelect" == dataValue.fromPath) {
                    // 来自积分订单提交页
                    window.location.href = dataValue.webRoot+'/wap/shoppingcart/integralAddrSelect.ac?integralProductId=' + dataValue.integralProductId + '&num=' + dataValue.num + '&integralExchangeType=' + dataValue.integralExchangeType + '&time='+(new Date()).getTime();
                } else if ("cityAddrSelect" == dataValue.fromPath) {
                    // 来自同城送订单结算页
                    window.location.href = dataValue.webRoot+'/wap/citySend/cityAddrSelect.ac?orgId=' + dataValue.orgId + '&isCod=' + dataValue.isCod + '&time='+(new Date()).getTime();
                } else if ("cityPositionSearch" == dataValue.fromPath) {
                    // 来自同城送定位搜索页
                    window.location.href = dataValue.webRoot+'/wap/citySend/cityPositionSearch.ac?time='+(new Date()).getTime();
                }else if("exchangeAddrSelect"== dataValue.fromPath){
                    window.location.href = dataValue.webRoot+'/wap/shoppingcart/exchangeAddrSelect.ac?numStr='+dataValue.itemNums+'&orderId='+dataValue.orderId+'&isReturn='+dataValue.isReturn+'&orderItems='+dataValue.orderItems+'&time='+(new Date()).getTime();
                } else {
                    window.location.href = dataValue.webRoot+'/wap/module/member/myAddressBook.ac?time='+(new Date()).getTime();
                }
            } else {
                window.location.href = dataValue.webRoot+'/wap/module/member/myAddressBook.ac?time='+(new Date()).getTime();
            }

        },
        error:function() {
            layer.closeAll();
            showError('系统繁忙，请稍后重试!');
            //xyPop({content:'系统繁忙，请稍后重试!',type:'error'});
        }
    });
}

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
                $(".townList").empty();
                $(".provinceArea").css("display","none");
                $(".cityArea").css("display","none");
                $(".zoneArea").css("display","none");
                $(".townArea").css("display","none");
            }
        },
        error:function() {
            showError('系统繁忙，请稍后重试!');
            //xyPop({content:'系统繁忙，请稍后重试!',type:'error'});
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
                $(".townList").empty();
                $(".provinceArea").css("display","none");
                $(".cityArea").css("display","none");
                $(".zoneArea").css("display","none");
                $(".townArea").css("display","none");
            }
        },
        error:function() {
            showError('系统繁忙，请稍后重试!');
            //xyPop({content:'系统繁忙，请稍后重试!',type:'error'});
        }
    });
    $(".zoneSelected").text($(".citySelected").text() + " " + sysTreeNodeNm);
}

function zoneClick(sysTreeNodeId,sysTreeNodeNm){
    $.ajax({
        url:dataValue.webRoot+'/member/addressBook.json?sysTreeNodeId=' + sysTreeNodeId,
        success:function(data){
            if(data.result.length > 0){
                $.each(data.result,function(i,val){
                    $(".townList").append("<a href=javascript:void(0); class=area-name onclick=townClick(" + sysTreeNodeId + "," + val.sysTreeNodeId + ",'" + val.sysTreeNodeNm + "')>" + val.sysTreeNodeNm + "</a>");
                });
                $(".townArea").css("display","block");
            }
            else{
                //这里处理没有子节点的情况
                $(".addrPathText").text($(".citySelected").text() + " " + sysTreeNodeNm);
                $(".zoneId").val(sysTreeNodeId);
                $(".provinceList").empty();
                $(".cityList").empty();
                $(".zoneList").empty();
                $(".townList").empty();
                $(".provinceArea").css("display","none");
                $(".cityArea").css("display","none");
                $(".zoneArea").css("display","none");
                $(".townArea").css("display","none");
            }
        },
        error:function() {
            showError('系统繁忙，请稍后重试!');
            //xyPop({content:'系统繁忙，请稍后重试!',type:'error'});
        }
    });
    $(".townSelected").text($(".zoneSelected").text() + " " + sysTreeNodeNm);
}

function townClick(last,sysTreeNodeId,sysTreeNodeNm){
    $(".addrPathText").text($(".townSelected").text() + " " + sysTreeNodeNm);
    //$(".addrPath").attr("zoneId",sysTreeNodeId);
    if(sysTreeNodeId > 0){
        $(".zoneId").val(sysTreeNodeId);
    }else{
        $(".zoneId").val(last);
    }
    $(".provinceList").empty();
    $(".cityList").empty();
    $(".zoneList").empty();
    $(".townList").empty();
    $(".provinceArea").css("display","none");
    $(".cityArea").css("display","none");
    $(".zoneArea").css("display","none");
    $(".townArea").css("display","none");
    $(".addrPathText").attr("isMapLocated", "false");
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




/*-----------------------------地图处理--------------start----------------------*/
var addr ='';
var city,district='';
var selectAddress = null;
var memberMarker,memberMap,memberGeocoder = null;
var lastGeocoder = null;
var memberLat,memberLng = null;
var localService = null;
var keyword = null;

$(function(){
    var KEY = "locationHistory";
    var LAT = "wapLat";
    var LNG = "wapLng";
    var ADDR = "wapAddr";
    var LEN = 5;
    var reloateTime = 0;
    var date = new Date();
    var expires = 30*24*3600*1000;
    date.setTime(date.getTime() + expires);

    $("#locatedM").click(function () {
        $("#userAddr").hide();
        $("#locatedAddr").show();
        $("#keywords").val("");
        locatedCurrentAddress();
        $('#result').hide();
        $("#cont").hide();
    });

    $(".action-back").click(function(){
        $("#userAddr").show();
        $("#locatedAddr").hide();
    });

    //取消
    $(".action-cancel").click(function(){
        $("#keywords").val("");
        $('#result').hide();
        $("#cont").hide();
        $("#search-result li").remove();
        //定位到当前位置
        locatedCurrentAddress();
    });

    //根据输入关键关键字检索
    $('#keywords').bind("propertychange input",function(event){
        keyword = $(this).val();
        $('#result').show();
        $("#cont").show();
        if($.trim(keyword) == ""){
            $("#result").hide();
            $("#cont").hide();
            keyword = null;
            return;
        }
        search(keyword);
    });

    $("#search-result li").live('click',function(){
        addr= $(this).attr("addr");
        var lat = $(this).attr("lat");
        var lng = $(this).attr("lng");
        $("#keywords").val(addr);
        $("#detailAddr").val(addr);

        //saveCookie(JSON.stringify({addr:$(this).attr("addr"), lat:lat, lng:lng}));
        //$.cookie(ADDR, addr,{
        //    expires:date,
        //    path:dataValue.webRoot+"/wap"
        //})
        $("#result").hide();
        $("#cont").hide();
        var poi = new qq.maps.LatLng(lat, lng);
        //返回到添加地址页面，同时填充省市区
        lastGeocoder.getAddress(poi);
    });

    $("#nearPanel li").live('click',function(){
        addr = $(this).attr("addr");
        var lat = $(this).attr("lat");
        var lng = $(this).attr("lng");
        //返回到添加地址页面，同时填充省市区
        var poi = new qq.maps.LatLng(lat, lng);
        //返回到添加地址页面，同时填充省市区
        lastGeocoder.getAddress(poi);
    });

    function saveCookie(value){
        var val = $.cookie(KEY);
        if(val){
            var arr = val.split("|");
            if(arr.length >= LEN){
                arr.shift();
                arr[LEN-1] = value
            }else{
                arr[arr.length] = value;
            }
            $.cookie(KEY, arr.join("|"),{
                expires:date,
                path:dataValue.webRoot+"/wap"
            })
        }else{
            $.cookie(KEY, value,{
                expires:date,
                path:dataValue.webRoot+"/wap"
            })
        }
    }

});

//var province,city,district,street = null;//省份,城市,区县,街道


//定位当前用户位置
function locatedCurrentAddress(){
    var geolocation = new qq.maps.Geolocation("IMSBZ-M7ZWU-HCVV7-4FRXE-ESSDS-3OFKL", "myapplication");

    geolocation.getLocation(function(data){
        var lat = data.lat;//纬度
        var lng = data.lng;//经度
        var province = data.province;
        var city = data.city;
        var addr = data.addr;
        if(undefined == addr || addr == ""){
            $("#nearPanel").hide();
            showError("请开启浏览器定位服务");
        }else{
            $("#nearPanel").show();
        }
        initMemberMap(lat, lng);
        selectAddress = province+","+city+","+addr;
        memberGeocoder.getLocation(selectAddress);
        //附近检索
        localService.search(selectAddress);
    },function(){
        //定位失败
        showError('定位失败,请重新定位!');
        //alert("失败");
    });
}

var keyLength = 1;
var currentKey = 0;

function getMapKey(i){
    var qqMapKeyArray = dataValue.qqMapKey;
    if(undefined == qqMapKeyArray || null == qqMapKeyArray || "" == qqMapKeyArray){
        return "3RVBZ-IWI3F-CYBJV-JZK6M-UT2DF-Z6FBO";
    }else{
        var array = qqMapKeyArray.split(",");
        keyLength = array.length;
        return array[i];
    }
}

function search(kw){
    //先清除掉之前的
    //3RVBZ-IWI3F-CYBJV-JZK6M-UT2DF-Z6FBO 专门用于关键字检索,webService
    var mapKey = getMapKey(currentKey);//默认取第一个
    $.ajax({
        type:'GET',
        url:"http://apis.map.qq.com/ws/place/v1/suggestion?region=&key="+mapKey+"&output=jsonp&keyword="+kw,
        dataType: "jsonp",
        jsonp:"callback",
        jsonpCallback:"QQmap",
        success:function(result){
            if(result.status == '121'){
                console.log(mapKey+"每日调用量已达到上限");
                currentKey++;
                if(currentKey>keyLength){
                    console.log("所有的key已达上限,无可调用的可以");
                }
                search(kw);
            }else{
                $("#search-result li").remove();
                var searchHtml = "";
                if(undefined != result.data || null != result.data){
                    $.each(result.data, function(i, item){
                        var addr = item.address;
                        var latlng = item.location;
                        addr = addr.replace(item.province, "").replace(item.city, "");
                        searchHtml +='<a href="javascript:;"><li class="area-item" lat="'+latlng.lat+'" lng="'+latlng.lng+'" addr="'+addr+'"><h4 class="area-name">'+item.title+'</h4><p class="area-detail">'+addr+'</p></li></a>';

                    });
                    $("#search-result").append(searchHtml);
                }
            }
        }
    });
}


function initMemberMap(lat, lng) {
    var center = new qq.maps.LatLng(lat, lng);

    memberMap = new qq.maps.Map(document.getElementById('locationMap'), {
        center: center,
        zoom: 13
    });

    //调用地址解析类
    memberGeocoder = new qq.maps.Geocoder({
        complete : function(result){
            var detail = result.detail;
            memberMap.setCenter(detail.location);
            memberMarker.setPosition(detail.location);
            memberLat = detail.location.getLat();
            memberLng = detail.location.getLng();
            console.log("lat:"+lat);
            console.log("lng+"+lng);
        },
        error: function(){
            showError('定位失败,请重新定位!');
        }
    });

    //调用地址解析类
    lastGeocoder = new qq.maps.Geocoder({
        complete : function(result){
            var detail = result.detail;
            var addrComponent = detail.addressComponents;
            var province = addrComponent.province;//省份
            city = addrComponent.city;//城市
            district = addrComponent.district;//区县
            $("#detailAddr").val(addr.replace(province, "").replace(city, ""));
            if(undefined == province || null == province){
                province = "";
            }else{
                province = province.replace("省","");
            }
            if(undefined == city || null == city){
                city = "";
            }
            if(undefined == district || null == district){
                district = "";
            }

            $(".addrPathText").html(province +" " + city + " "+ district);
            $(".addrPathText").attr("isMapLocated", "true");

            memberLat =detail.location.getLat();
            memberLng = detail.location.getLng();

            $("#userAddr").show();
            $("#locatedAddr").hide();

        },
        error: function(){
            showError('定位失败,请重新定位!');
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
        memberLat = event.latLng.getLat();
        memberLng = event.latLng.getLng();
    });

    //附近检索
    localService = new qq.maps.SearchService({
        //设置搜索页码为1
        pageIndex: 1,
        //设置每页的结果数为5
        pageCapacity: 10,
        //设置动扩大检索区域。默认值true，会自动检索指定城市以外区域。
        autoExtend: true,
        //检索成功的回调函数
        complete: function(results) {
            var html="";
            $("#nearPanel li").remove();
            //设置回调函数参数
            var pois = results.detail.pois;
            for (var i = 0; i < pois.length; i++) {
                var p = pois[i];
                var name = p.name;
                var addr = p.address;
                var latlng = p.latLng;
                //拼接检索面板
                var ac = "";
                var cur = "";
                if(i==0){
                    ac = "active";
                    cur = "<em>[当前]</em>";
                }else{
                    ac = "";
                    cur = "";
                }
                html+='<a href="javascript:;"><li class="area-item '+ac+'" lat="'+latlng.lat+'" lng="'+latlng.lng+'" addr="'+addr+'"><h4 class="area-name">'+cur+name+'</h4><p class="area-detail">'+addr+'</p></li></a>';
            }
            $("#nearPanel").append(html);

        },
        //若服务请求失败，则运行以下函数
        error: function() {
            showError('定位失败,请重新定位!');
            //alert("出错了。");
        }
    });
}
/*-------------------------地图处理-------------------end------------------------*/

function isEmpty(val) {
    if (val == undefined || val == null || $.trim(val) == "") {
        return true;
    } else {
        return false;
    }
}


