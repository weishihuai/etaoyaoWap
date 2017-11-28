/**
 * Created by lhw on 2016/12/29.
 */
jQuery(function($) {
    $(document).ready( function() {
        // 滚动搜索栏固定
        var divOffsetTop = $(".topToolBar").offset().top;
        $(window).scroll(function(){
            var scrollTop = $(this).scrollTop();
            if(scrollTop > divOffsetTop){
                $(".search-trans-dark").hide();
                $(".search-box").show();
                $(".topToolBar").attr("style", "position:fixed;top:0;");
            }else{
                $(".search-box").hide();
                $(".search-trans-dark").show();
                $(".topToolBar").attr("style", "");
            }
        });

        if (!isEmpty(dataValue.loadLat) && !isEmpty(dataValue.loadLng)) {
            // 定位指定位置
            locatedReceiverAddressByLatLng(dataValue.loadLat, dataValue.loadLng);
        } else if (!isEmpty(dataValue.receiveAddrId)) {
            // 定位到收货地址
            locatedReceiverAddressById(dataValue.receiveAddrId)
        } else {
            // 定位当前位置
            locatedCurrentAddress();
        }

        // 排序
        $(".control-item").click(function(){
            if (!$(this).hasClass("active")) {
                layer.load();
                $(".control-item").removeClass("active");
                $(this).addClass("active");
                var lat = isEmpty($("#location").attr("lat")) ? "" : $("#location").attr("lat");
                var lng = isEmpty($("#location").attr("lng")) ? "" : $("#location").attr("lng");
                var order = isEmpty($(this).attr("order")) ? "" : $(this).attr("order");
                // 如果获取不到定位则跳过
                if (lat == "" || lng == "") {
                    layer.closeAll();
                    return;
                }
                loadOutlet(lat, lng, order);
            }
        });
        // 点击搜索框
        $(".search-action").click(function(){
            var orgIds = "";
            $(".store-list").find(".store").each(function(){
                orgIds += $(this).attr("orgId") + ",";
            });
            if (orgIds != "") {
                orgIds = orgIds.substring(0, orgIds.length - 1);
            }
            window.location.href = dataValue.webRoot + "/wap/citySend/citySearch.ac?orgIds=" + orgIds;
        });

    });
});



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
            console.log("请开启浏览器定位服务");
        }
        var selectAddress = city + addr;
        $("#location").attr("lat",lat);
        $("#location").attr("lng",lng);
        $("#location").attr("title",selectAddress);
        setLocationTxt(selectAddress);
        loadOutlet(lat, lng, "");
    },function(){
        //定位失败
        setLocationTxt("定位失败");
        showError("定位失败");
    });
}

//定位指定的位置
function locatedReceiverAddressByLatLng(lat, lng){
    var data = {
        location: lat + "," + lng,
        key: "IMSBZ-M7ZWU-HCVV7-4FRXE-ESSDS-3OFKL",
        get_poi:0,
        output:"jsonp"
    };
    var url = "http://apis.map.qq.com/ws/geocoder/v1/?";
    $.ajax({
        type:"get",
        url:url,
        data:data,
        dataType:'jsonp',
        jsonp:"callback",
        jsonpCallback:"QQmap",
        success:function(data){
            if ("0" == data.status) {
                // 定位成功
                var address = data.result.address;
                $("#location").attr("lat",lat);
                $("#location").attr("lng",lng);
                $("#location").attr("title",address);
                setLocationTxt(address);
                loadOutlet(lat, lng, "");
            } else {
                setLocationTxt("定位失败");
                showError("定位失败");
            }
        },
        error : function(err){
            setLocationTxt("定位失败");
            showError("定位失败");
        }
    });
}

//定位到收货地址
function locatedReceiverAddressById(receiveAddrId){
    $.ajax({
        type:"post" ,
        url:dataValue.webRoot+"/member/findAddressById.json",
        data:{id:receiveAddrId},
        dataType:"json",
        success:function(data) {
            if (data.success == true) {
                var receiverAddrVo = data.result;
                var displayAddr = receiverAddrVo.addressPath + receiverAddrVo.addr;
                locatedAddressByAddr(displayAddr);
            } else {
                setLocationTxt("定位失败");
                showError("定位失败");
            }
        },
        error : function(err){
            setLocationTxt("定位失败");
            showError("定位失败");
        }
    });
}

// 根据地址定位
function locatedAddressByAddr(addr) {
    var data = {
        address: addr,
        key: "IMSBZ-M7ZWU-HCVV7-4FRXE-ESSDS-3OFKL",
        output:"jsonp"
    };
    var url = "http://apis.map.qq.com/ws/geocoder/v1/?";

    $.ajax({
        type:'get',
        url:url,
        data:data,
        dataType: "jsonp",
        jsonp:"callback",
        jsonpCallback:"QQmap",
        success:function(data){
            if ("0" == data.status && data.result != null) {
                // 定位成功
                var result = data.result;
                var lat = result.location.lat;
                var lng = result.location.lng;
                var address_components = result.address_components;
                var province = address_components.province; // 省
                var city = address_components.city; // 市
                var district = address_components.district; // 区
                var street = address_components.street; // 街道
                var street_number = address_components.street_number; // 门牌
                var address = city + district + street + street_number;
                $("#location").attr("lat", lat);
                $("#location").attr("lng", lng);
                $("#location").attr("title",address);
                setLocationTxt(address);
                loadOutlet(lat, lng, "");
            } else {
                setLocationTxt("定位失败");
                showError("定位失败");
            }
        },
        error : function(err){
            setLocationTxt("定位失败");
            showError("定位失败");
        }
    });
}

function setLocationTxt(address) {
    $("#location").text(address);
    if ($("#location").height() > 48) {
        $(".search-trans-dark").css("margin-top", "-0.5rem");
    } else if ($("#location").height() > 24) {
        $(".search-trans-dark").css("margin-top", "1.0rem");
    } else {
        $(".search-trans-dark").css("margin-top", "2.0rem");
    }
}

function loadOutlet(lat, lng, order){
    $("#shopListDiv").load(dataValue.webRoot+"/wap/citySend/loadOutlet.ac", {lat: lat, lng: lng, order:order}, function(data){
        $("#shopListDiv .store-list").remove();
        $("#shopListDiv").append(data);
        layer.closeAll();
    });
}

// 跳转到店铺
function gotoStore(obj){
    var orgId = $(obj).attr("orgId");
    var isSupportBuy = $(obj).attr("isSupportBuy");
    if (isEmpty(orgId)) {
        return;
    }
    if (isEmpty(isSupportBuy) || 'Y' != isSupportBuy) {
        showError("该店铺不支持购买");
        return;
    }
    window.location.href = dataValue.webRoot + "/wap/citySend/storeIndex.ac?orgId=" + orgId;
}

function isEmpty(val) {
    if (val == undefined || val == null || $.trim(val) == "") {
        return true;
    } else {
        return false;
    }
}