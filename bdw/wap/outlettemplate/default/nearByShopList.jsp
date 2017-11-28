<html>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/wap/fastShow.jsp" %>
<head lang="en">
    <meta charset="utf-8">
    <title>附近门店</title>
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="telephone=no,email=no" name="format-detection">
    <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js"></script>
    <script type="text/javascript" src="https://3gimg.qq.com/lightmap/components/geolocation/geolocation.min.js"></script>
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/outlettemplate/default/statics/css/store-list.css" type="text/css" rel="stylesheet" />

    <link href="${webRoot}/template/bdw/wap/statics/css/fastShow.css" type="text/css" rel="stylesheet" />

</head>
<body>
<div class="list-main">
    <div class="list-head">
        <div class="list-head-m">
            <a href="${webRoot}/wap/outlettemplate/default/addrSelect.ac?from=list" class="addr">送至：</a>
            <a href="${webRoot}/wap/outlettemplate/default/nearByShopMap.ac" class="list-map"></a>
        </div>
        <div class="list-head-a">
            <input class="list-search" type="text" placeholder="搜索商品" id="searchInput">
        </div>
        <div class="list-head-b">
            <ul class="sp-sort clearfix">
                <%--<li class="sp-sort-zh cur">
                    <div class="dt">综合排序</div>
                    <ul class="dd">
                        <li><a data-active="true" href="javascript:;">综合排序</a></li>
                        <li><a href="javascript:;">好评优先</a></li>
                        <li><a href="javascript:;">配送费最低</a></li>
                    </ul>
                </li>--%>
                <li data-order-by="RATING" class="cur">好评优先</li>
                <li data-order-by="SALES_VOLUME">销量最高</li>
                <li data-order-by="DISTANCE">距离最近</li>
            </ul>
        </div>
    </div>
    <div class="store-inner">
        <h5>附近门店</h5>
        <ul id="shopList">
        </ul>
    </div>
    <div class="bottom-logo"></div>
</div>
<script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.6.1.min.js"></script>
<script src="${webRoot}/template/bdw/wap/statics/js/jquery.cookie.js"></script>
<script type="text/javascript" src="${webRoot}/template/bdw/wap/outlettemplate/default/statics/js/nearByShopList.js" ></script>
<script src="${webRoot}/template/bdw/wap/statics/js/fastShow.js"></script>
<script type="text/javascript">
    var webPath = {
        webRoot: "${webRoot}"
    }
</script>
</body>
</html>
