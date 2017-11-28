<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head lang="en">
    <meta charset="utf-8">
    <title>选择收货地址</title>
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="telephone=no,email=no" name="format-detection">
    <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js"></script>
    <script type="text/javascript" src="https://3gimg.qq.com/lightmap/components/geolocation/geolocation.min.js"></script>
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/outlettemplate/default/statics/css/sp-address.css" type="text/css" rel="stylesheet" />
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.6.1.min.js"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery.cookie.js"></script>
    <script type="text/javascript">
        $(function () {
            var POSITION_COOKIE = "POSITION_COOKIE";
            var geolocation = new qq.maps.Geolocation("IMSBZ-M7ZWU-HCVV7-4FRXE-ESSDS-3OFKL", "imall");
            var position = eval("("+ unescape($.cookie(POSITION_COOKIE) +")"));
            if(!position){
                $(".re-location").trigger("click");
            }else {
                $("#cur-addr").html(position.addr);
            }
            $(".re-location").click(function () {
                geolocation.getLocation(function (position) {
                    $("#cur-addr").html(position.addr);
                    $.cookie(POSITION_COOKIE, escape(JSON.stringify({lat: position.lat, lng: position.lng, addr: position.addr})));
                    afterAddrSelect();
                }, function () {
                    alert("获取当前位置失败，请检查是否开启定位");
                }, {timeout: 5000, failTipFlag: true});
            });

            $("#addrs li").click(function () {
                var lat = $(this).attr("data-lat");
                var lng = $(this).attr("data-lng");
                var addr = $(this).attr("data-addr");
                $.cookie(POSITION_COOKIE, escape(JSON.stringify({lat: lat, lng: lng, addr: addr})));
                afterAddrSelect();
            });

            function afterAddrSelect() {
                if("${param.from}" == "map"){
                    window.location.href = "${webRoot}/wap/outlettemplate/default/nearByShopMap.ac";
                }else {
                    window.location.href = "${webRoot}/wap/outlettemplate/default/nearByShopList.ac?";
                }
            }
        });
    </script>
</head>
<c:set var="loginUser" value="${sdk:getLoginUser()}"/>
<c:set var="addrs" value="${loginUser.addr}"/>

<body>
<div class="m-top">
    <a class="back" href="javascript:history.go(-1)"></a>
    <div class="toggle-box">选择收货地址</div>
    <a href="${webRoot}/wap/module/member/addrAdd.ac?redirectUrl=${webRoot}/wap/outlettemplate/default/addrSelect.ac?from=${param.from}" class="rt-btn">新增地址</a>
</div>

<div class="addr-main">
    <%--<div class="addr-serch"><a href="##" class="search-btn">请输入地址</a></div>--%>
    <div class="mc">
        <div class="item">
            <h5>当前地址</h5>
            <ul>
                <li class="present">
                    <p id="cur-addr"></p>
                    <a href="javascript:;" class="re-location">重新定位</a>
                </li>
            </ul>
        </div>
        <div class="item">
            <h5>收货地址</h5>
            <ul id="addrs">
                <c:forEach items="${addrs}" var="addr">
                    <li data-lat="${addr.lat}" data-lng="${addr.lng}" data-addr="${addr.addressStr}">
                        <p>${fn:replace(addr.addressPath, '中国', '')}${addr.addressStr}</p>
                        <span>${addr.name}</span>
                        <span>${addr.mobile}</span>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>
</div>
</body>
</html>
