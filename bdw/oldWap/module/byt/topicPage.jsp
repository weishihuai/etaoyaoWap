<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="f" uri="/iMallTag" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>专题首页</title>
    <link rel="stylesheet" type="text/css" href="${webRoot}/template/bdw/oldWap/statics/css/swiper.min.css">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/base.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/statics/css/header.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/statics/css/page.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript">
        var webPath = {
            webRoot: '${webROot}'
        }
    </script>
</head>

<body>
<header class="header">
    <div class="index-top">
        <div class="logo frameEdit" frameInfo="byt_main_logo|65X25">
            <c:forEach items="${sdk:findPageModuleProxy('byt_main_logo').advt.advtProxy}" var="logo" end="0">
                <i style="display:block;background: url(${logo.advUrl}) no-repeat 0 0 / 92px 25px;" onclick="window.location.href='${logo.link}'"></i>
            </c:forEach>
        </div>
        <form action="${webRoot}/wap/list.ac" method="get" class="yz-search-form" id="searchForm">
            <div class="yz-search-form-box">
                <a href="${webRoot}/wap/module/byt/topicPageSearch.ac">
                    <span class="yz-search-form-icon" id="search_btn"></span>
                    <div class="yz-search-form-input" style="line-height: 24px;font-size: 14px;padding-left: 3px;color: #A9A9B1;">
                        搜索商品
                    </div>
                </a>
            </div>
        </form>

        <%-- 右上角的消息记录页面 --%>
        <div class="yz-search-login" style="display: none;">
            <a href="${webRoot}/wap/mySystemMsg.ac" class="login" >
                <%--<span class="yz-msg">${fn:length(loginUser.userMsgListBySystem)}</span>--%>
            </a>
        </div>
    </div>
</header>
<div class="main">
    <div class="swiper-container banner frameEdit"  frameInfo="byt_main_banner" >
        <div class="swiper-wrapper" style="height: auto;">
            <c:forEach items="${sdk:findPageModuleProxy('byt_main_banner').advt.advtProxy}" var="advtProxys">
                <div class="swiper-slide"><a href="${advtProxys.link}"><img src="${advtProxys.advUrl}" alt=""></a></div>
            </c:forEach>
        </div>
        <!-- Add Pagination -->
        <div class="swiper-pagination"></div>
    </div>



    <div class="nav-item frameEdit" frameInfo="yaliantong_Navigate_new|89X89">
        <nav class="quick-entry-nav">
            <c:forEach items="${sdk:findPageModuleProxy('yaliantong_Navigate_new').advt.advtProxy}" var="advtProxys" varStatus="s" end="5">
                <a class="quick-entry-link" href="${advtProxys.link}">
                    <img class="lazy" data-original="${advtProxys.advUrl}">
                    <span>${fn:substring(advtProxys.title,0,4)}</span>
                </a>
            </c:forEach>
        </nav>
    </div>
    <div class="hot">
        <div class="mt frameEdit" frameInfo="byt_hoteSale_title">
            <div class="mt-box">
                <c:forEach items="${sdk:findPageModuleProxy('byt_hoteSale_title').advt.advtProxy}" var="hoteSaleAdvtProxys">
                    <a href="${hoteSaleAdvtProxys.link}"><img src="${hoteSaleAdvtProxys.advUrl}" alt=""></a>
                </c:forEach>
            </div>
        </div>
        <div class="mc frameEdit" frameInfo="byt_hoteSale_product">
            <c:forEach items="${sdk:findPageModuleProxy('byt_hoteSale_product').advt.advtProxy}" var="hoteSaleProductAdvtProxys">
                <div class="pic-item"><a href="${hoteSaleProductAdvtProxys.link}"><img src="${hoteSaleProductAdvtProxys.advUrl}" alt=""></a> </div>
            </c:forEach>
        </div>
    </div>
    <div class="m-cont">
        <%--<div class="mt frameEdit" frameInfo="byt_health_supplies">--%>
            <%--<div class="mt-box">--%>
                <%--<c:forEach items="${sdk:findPageModuleProxy('byt_health_supplies').advt.advtProxy}" var="healthSuppliesAdvtProxys">--%>
                    <%--<a href="${healthSuppliesAdvtProxys.link}"><img src="${healthSuppliesAdvtProxys.advUrl}" alt=""></a>--%>
                <%--</c:forEach>--%>
            <%--</div>--%>

        <%--</div>--%>

        <%--<div class="m-cont">--%>
        <%--<div class="mt frameEdit" frameInfo="byt_bottom_floor">--%>
            <%--<div class="mt-box">--%>
                <%--<c:forEach items="${sdk:findPageModuleProxy('byt_bottom_floor').advt.advtProxy}" var="bottomFloorAdvtProxys">--%>
                    <%--<a href="${bottomFloorAdvtProxys.link}"><img src="${bottomFloorAdvtProxys.advUrl}" alt=""> </a>--%>
                <%--</c:forEach>--%>
            <%--</div>--%>
        <%--</div>--%>
        <%--</div>--%>

        <%--<div class="m-cont">--%>
        <%--<div class="mt frameEdit" frameInfo="byt_bottom_floor2">--%>
            <%--<div class="mt-box">--%>
                <%--<c:forEach items="${sdk:findPageModuleProxy('byt_bottom_floor2').advt.advtProxy}" var="bottomFloorAdvtProxys">--%>
                    <%--<a href="${bottomFloorAdvtProxys.link}"><img src="${bottomFloorAdvtProxys.advUrl}" alt=""> </a>--%>
                <%--</c:forEach>--%>
            <%--</div>--%>
        <%--</div>--%>
        <%--</div>--%>

        <%--<div class="m-cont">--%>
        <%--<div class="mt frameEdit" frameInfo="byt_bottom_floor3">--%>
            <%--<div class="mt-box">--%>
                <%--<c:forEach items="${sdk:findPageModuleProxy('byt_bottom_floor3').advt.advtProxy}" var="bottomFloorAdvtProxys">--%>
                    <%--<a href="${bottomFloorAdvtProxys.link}"><img src="${bottomFloorAdvtProxys.advUrl}" alt=""> </a>--%>
                <%--</c:forEach>--%>
            <%--</div>--%>
        <%--</div>--%>
        <%--</div>--%>
        <%--<div class="mc frameEdit" frameInfo="byt_health_supplies_recommend" data-pageModuleId="${sdk:findPageModuleProxy('byt_health_supplies_recommend').moduleId}">--%>
            <%--<c:forEach items="${sdk:findPageModuleProxy('byt_health_supplies_recommend').recommendProducts}" var="prd" end="5" varStatus="s">--%>
                <%--<div class="item">--%>
                    <%--<div class="pic"><a href="${webRoot}/product-${prd.productId}.html"><img src="${empty prd.images ? prd.defaultImage['220X220'] : prd.images[0]['220X220']}" alt=""></a></div>--%>
                    <%--<a href="${webRoot}/product-${prd.productId}.html" class="title">${prd.name}</a>--%>
                    <%--<div class="price"><em>￥</em>${prd.price.unitPrice}</div>--%>
                    <%--<a href="javascript:void(0);" class="buy-btn" skuid="${prd.isEnableMultiSpec=='Y' ?  '': prd.skus[0].skuId}"  num="1" carttype="normal" handler="sku"></a>--%>
                <%--</div>--%>
            <%--</c:forEach>--%>
        <%--</div>--%>
        <%--<div class="mt frameEdit" frameInfo="byt_gastrointestinal_medication">--%>
            <%--<div class="mt-box">--%>
                <%--<c:forEach items="${sdk:findPageModuleProxy('byt_gastrointestinal_medication').advt.advtProxy}" var="medicationAdvtProxys">--%>
                    <%--<a href="${medicationAdvtProxys.link}"><img src="${medicationAdvtProxys.advUrl}" alt=""> </a>--%>
                <%--</c:forEach>--%>
            <%--</div>--%>
        <%--</div>--%>



        <%--<div class="mc frameEdit" frameInfo="byt_gastrointestinal_medication_recommend" data-pageModuleId="${sdk:findPageModuleProxy('byt_gastrointestinal_medication_recommend').moduleId}">--%>
            <%--<c:forEach items="${sdk:findPageModuleProxy('byt_gastrointestinal_medication_recommend').recommendProducts}" var="prd" end="5" varStatus="s">--%>
                <%--<div class="item">--%>
                    <%--<div class="pic"><a href="${webRoot}/product-${prd.productId}.html"><img src="${empty prd.images ? prd.defaultImage['220X220'] : prd.images[0]['220X220']}" alt=""></a></div>--%>
                    <%--<a href="${webRoot}/product-${prd.productId}.html" class="title">${prd.name}</a>--%>
                    <%--<div class="price"><em>￥</em>${prd.price.unitPrice}</div>--%>
                    <%--<a href="javascript:void(0);" class="buy-btn" skuid="${prd.isEnableMultiSpec=='Y' ?  '': prd.skus[0].skuId}"  num="1" carttype="normal" handler="sku"></a>--%>
                <%--</div>--%>
            <%--</c:forEach>--%>
        <%--</div>--%>


        <div class="m-cont">
            <div class="mt frameEdit" frameInfo="byt_bottom_floor">
                <div class="mt-box">
                    <c:forEach items="${sdk:findPageModuleProxy('byt_bottom_floor').advt.advtProxy}" var="bottomFloorAdvtProxys">
                        <a href="${bottomFloorAdvtProxys.link}"><img src="${bottomFloorAdvtProxys.advUrl}" alt=""> </a>
                    </c:forEach>
                </div>
            </div>
        </div>

        <div class="mc frameEdit" frameInfo="byt_bottom_floor_recommend" data-pageModuleId="${sdk:findPageModuleProxy('byt_bottom_floor_recommend').moduleId}">
            <c:forEach items="${sdk:findPageModuleProxy('byt_bottom_floor_recommend').recommendProducts}" var="prd" end="98" varStatus="s">
                <div class="item">
                    <div class="pic"><a href="${webRoot}/product-${prd.productId}.html"><img src="${empty prd.images ? prd.defaultImage['220X220'] : prd.images[0]['220X220']}" alt=""></a></div>
                    <a href="${webRoot}/product-${prd.productId}.html" class="title">${prd.name}</a>
                    <div class="price"><em>￥</em>${prd.price.unitPrice}</div>
                    <a href="javascript:void(0);" class="buy-btn" skuid="${prd.isEnableMultiSpec=='Y' ?  '': prd.skus[0].skuId}"  num="1" carttype="normal" handler="sku"></a>
                </div>
            </c:forEach>
        </div>

    </div>
</div>

<script src="${webRoot}/template/bdw/oldWap/statics/js/base.js" type="text/javascript"> </script>
<script src="${webRoot}/template/bdw/oldWap/statics/js/jquery-1.7.1.min.js"></script>
<script src="${webRoot}/template/bdw/oldWap/statics/js/swiper.min.js" ></script>
<script src="${webRoot}/template/bdw/oldWap/statics/js/common.js" ></script>
<script src="${webRoot}/template/bdw/oldWap/statics/js/xyPop/xyPop.js" ></script>
<script src="${webRoot}/template/bdw/statics/js/jquery.lazyload.js" type="text/javascript" ></script>
<script src="${webRoot}/template/bdw/oldWap/statics/js/topicPage.js" ></script>

<script>
    //        轮播图
    var swiper01 = new Swiper('.banner', {
        pagination: '.swiper-pagination',/*分页器*/
        slidesPerView: 1,
        paginationClickable: true,/*点击那几个小点*/
        autoplay : 3000,
        loop : true
    });
    $(document).ready(function(){
    $("img.lazy").lazyload(
            {
                effect: "fadeIn",
                failure_limit : 5,
                threshold : 150
            }
    ); });
</script>

<f:FrameEditTag />     <%--页面装修专用标签--%>
</body>

</html>
