/**
 * Created by lhw on 2016/12/26.
 */


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

        //window.location.href = dataValue.webRoot + "/wap/citysend/index.ac?lat=" + lat + "&lng="+lng+"&addr="+addr;
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

var addr ='';
var selectAddress = null;
var memberMarker,memberMap,memberGeocoder = null;
var lastGeocoder = null;
var memberLat,memberLng = null;
var localService = null;
var keyword = null;

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
            console.log("请开启浏览器定位服务");
        }
        initMemberMap(lat, lng);
        selectAddress = province+","+city+","+addr;
        memberGeocoder.getLocation("广州市广东软件园彩频路");
        //附近检索
        localService.search("广东软件园彩频路");
    },function(){
        //定位失败
        //alert("失败");
    });
}

function search(kw){
    //先清除掉之前的
    //3RVBZ-IWI3F-CYBJV-JZK6M-UT2DF-Z6FBO 专门用于关键字检索,webService
    $.ajax({
        type:'GET',
        url:"http://apis.map.qq.com/ws/place/v1/suggestion?region=&key=3RVBZ-IWI3F-CYBJV-JZK6M-UT2DF-Z6FBO&output=jsonp&keyword="+kw,
        dataType: "jsonp",
        jsonp:"callback",
        jsonpCallback:"QQmap",
        success:function(result){
            $("#search-result li").remove();
            var searchHtml = "";
            if(undefined != result.data || null != result.data){
                $.each(result.data, function(i, item){
                    var addr = item.address;
                    var latlng = item.location;
                    addr = addr.replace(item.province, "").replace(item.city, "");
                    searchHtml +='<li class="area-item" lat="'+latlng.lat+'" lng="'+latlng.lng+'" addr="'+addr+'"><h4 class="area-name">'+item.title+'</h4><p class="area-detail">'+addr+'</p></li>';

                });
                $("#search-result").append(searchHtml);
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
        },
        error: function(){

        }
    });

    //调用地址解析类
    lastGeocoder = new qq.maps.Geocoder({
        complete : function(result){
            var detail = result.detail;
            var addrComponent = detail.addressComponents;
            var province = addrComponent.province;//省份
            var city = addrComponent.city;//城市
            var district = addrComponent.district;//区县
            $("#detailAddr").val(addr.replace(province, "").replace(city, ""));
            if(undefined == province || null == province){
                province = "";
            }else{
                province = province.replace("省","");
            }
            if(undefined == city || null == province){
                city = "";
            }
            if(undefined == district || null == district){
                district = "";
            }

            $(".addrPathText").html(province +" " + city + " "+ district);

            $("#userAddr").show();
            $("#locatedAddr").hide();

            $("")
        },
        error: function(){

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
                html+='<li class="area-item '+ac+'" lat="'+latlng.lat+'" lng="'+latlng.lng+'" addr="'+addr+'"><h4 class="area-name">'+cur+name+'</h4><p class="area-detail">'+addr+'</p></li>';
            }
            $("#nearPanel").append(html);

        },
        //若服务请求失败，则运行以下函数
        error: function() {
            //alert("出错了。");
        }
    });
}