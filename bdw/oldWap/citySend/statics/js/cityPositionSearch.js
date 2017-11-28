/**
 * Created by lhw on 2016/12/29.
 */
jQuery(function($) {
    $(document).ready( function() {
        // 获取当前的地址
        locatedCurrentAddress();

        // 滚动搜索栏固定
        var divOffsetTop = $(".search-box").offset().top;
        $(window).scroll(function(){
            var scrollTop = $(this).scrollTop();
            if(scrollTop > divOffsetTop){
                $(".search-box").attr("style", "position:fixed;top:0;width:100%;padding-right: 9.8rem;z-index:10;");
            }else{
                $(".search-box").attr("style", "padding-right: 9.8rem;");
            }
        });
        // 清除搜索内容
        $(".clear").click(function(){
            $("#searchTxt").val("");
            $("#result").hide();
            $("#search-result").html("");
        });
        // 重新定位
        $("#resetPosition").click(function(){
            locatedCurrentAddress();
        });
        // 选择收货地址
        $(".receiverAddr").click(function(){
            window.location.href = dataValue.webRoot + "/wap/citySend/index.ac?lat=" + $(this).attr("lat") + "&lng=" + $(this).attr("lng") + "&receiveAddrId=" + $(this).attr("receiveAddrId");
        });
        // 选择当前地址
        $("#currentAddress").click(function(){
            var lat = $(this).find("p").attr("lat");
            var lng = $(this).find("p").attr("lng");
            window.location.href = dataValue.webRoot + "/wap/citySend/index.ac?lat=" + lat + "&lng=" + lng;
        });
        // 根据输入关键关键字检索
        $('#searchTxt').bind("propertychange input",function(event){
            $("#search-result").html("");
            var keyword = $(this).val();
            if(isEmpty(keyword)){
                $("#result").hide();
                return;
            }
            $("#result").show();
            search(keyword);
        });
    });
});

//定位当前用户位置
function locatedCurrentAddress(){
    $("#currentAddress p").attr("lat","");
    $("#currentAddress p").attr("lng","");
    $("#currentAddress p").attr("title","");
    $("#currentAddress p").text("正在获取位置信息..");
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
        var selectAddress = city+addr;
        $("#currentAddress p").attr("lat",lat);
        $("#currentAddress p").attr("lng",lng);
        $("#currentAddress p").attr("title",selectAddress);
        $("#currentAddress p").text(selectAddress);
    },function(){
        //定位失败
        $("#currentAddress p").text("定位失败");
        showError("定位失败");
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

// 根据输入关键关键字检索
function search(keyword){
    var mapKey = getMapKey(currentKey);//默认取第一个
    var data = {
        key: mapKey,
        keyword:keyword,
        output:"jsonp"
    };
    var url = "http://apis.map.qq.com/ws/place/v1/suggestion";

    $.ajax({
        type:'get',
        url:url,
        data:data,
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
                search(keyword);
            }else{
                var searchHtml = "";
                if ("0" == result.status && result.data.length > 0) {
                    $.each(result.data, function(i, item){
                        var addr = item.address;
                        var latlng = item.location;
                        addr = addr.replace(item.province, "").replace(item.city, "");
                        searchHtml += '<li class="area-item">';
                        searchHtml += '<a class="searchItem" href="javascript:;" onclick="searchPosition(this)" lat="' + latlng.lat + '" lng="' + latlng.lng + '" addr="' + addr + '">';
                        searchHtml +=   '<h4 class="area-name">' + item.title + '</h4>';
                        searchHtml +=   '<p class="area-detail">' + addr + '</p>';
                        searchHtml += '</a>';
                        searchHtml += '</li>';
                    });
                }
                $("#search-result").html(searchHtml);
            }
        }
    });
}

// 点击查询出来的地址
function searchPosition(val) {
    window.location.href = dataValue.webRoot + "/wap/citySend/index.ac?lat=" + $(val).attr("lat") + "&lng=" + $(val).attr("lng");
}

function isEmpty(val) {
    if (val == undefined || val == null || $.trim(val) == "") {
        return true;
    } else {
        return false;
    }
}