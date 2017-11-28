<!DOCTYPE html>
<html>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head lang="en">
    <meta charset="utf-8">
    <title>门店地图</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.6.1.min.js"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery.cookie.js"></script>
    <script type="text/javascript" src="https://3gimg.qq.com/lightmap/components/geolocation/geolocation.min.js"></script>
    <script charset="utf-8" src="http://map.qq.com/api/js?v=2.exp"></script>
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/outlettemplate/default/statics/css/store-map.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript">
        $(function () {
            var POSITION_COOKIE = "POSITION_COOKIE";
            var position = eval("("+ unescape($.cookie(POSITION_COOKIE) +")"));
            if (!position){
                var geolocation = new qq.maps.Geolocation("IMSBZ-M7ZWU-HCVV7-4FRXE-ESSDS-3OFKL", "imall");
                geolocation.getLocation(function (po) {
                    position = {lat: po.lat, lng: po.lng, addr: po.addr};
                    $.cookie(POSITION_COOKIE, escape(JSON.stringify(position)));
                    }, function () {
                    alert("获取当前位置失败，请检查是否开启定位");
                }, {timeout: 5000, failTipFlag: true});
            }
            $(".addr").html("送至：" + position.addr);
            var map = new qq.maps.Map(document.getElementById("container"), {
                center: new qq.maps.LatLng(position.lat, position.lng),      // 地图的中心地理坐标。
                zoom: 13                                                 // 地图的中心地理坐标。
            });
            var infoArr = [];
            $.ajax({
                url: "${webRoot}/shop/sysShopInfFront/queryNearByShop.json",
                data:{lat: position.lat, lng: position.lng},
                dataType: "json",
                success:function(data) {
                    var icon = new qq.maps.MarkerImage("${webRoot}/template/bdw/wap/outlettemplate/default/statics/images/002mendian@2x.png");
                    for (var i = 0; i < data.result.length; i++){
                        (function (n) {
                            var temp = data.result[n];
                            var pt = new qq.maps.LatLng(temp.outletLat, temp.outletLng);
                            var marker = new qq.maps.Marker({
                                position: pt,
                                animation:qq.maps.MarkerAnimation.DROP,
                                map: map
                            });
                            marker.setIcon(icon);
                            var info = new qq.maps.InfoWindow({});
                            infoArr.push(info);
                            //获取标记的点击事件
                            qq.maps.event.addListener(marker, 'click', function() {
                                for (var j = 0; j < infoArr.length; j++){
                                    infoArr[j].setMap(null);
                                }
                                info.setMap(map);
                                info.open();
                                var distance = (temp.distance/1000).toFixed(2);
                                info.setContent('<div class="map-box"> <a href="${webRoot}/wap/outlettemplate/default/outletIndex.ac?shopId='+ temp.shopInfId +'">'+ temp.shopNm +'</a> <span>距离'+ distance +'km</span> </div>');
                                info.setPosition(marker.getPosition());
                            });
                        })(i);
                    }
                },
                error:function(XMLHttpRequest, textStatus) {
                    if (XMLHttpRequest.status == 500) {
                        var result = eval("(" + XMLHttpRequest.responseText + ")");
                        alert(result.errorObject.errorText);
                    }
                }
            });
        })
    </script>
</head>

<body>
<div class="map-top">
    <a href="${webRoot}/wap/outlettemplate/default/addrSelect.ac?from=map" class="addr">送至：</a>
    <a href="${webRoot}/wap/outlettemplate/default/nearByShopList.ac" class="map-list"></a>
</div>
<div class="map-main">
    <div id="container" style="width: 100%; height: 100%;"></div>
</div>

</body>
</html>
