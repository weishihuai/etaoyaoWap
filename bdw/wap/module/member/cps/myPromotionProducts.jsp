<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${empty param.category ? 1 : param.category}" var="categoryId"/>
<c:set value="${sdk:findAllProductCategory()}" var="mian_cate"/>
<c:set value="${sdk:findCpsOrderedPrd(6)}" var="productProxy"/>
<%--获取当前用户--%>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<c:set value="${webUrl}/wap/product-${param.id}.html?1=1" var="prdHref"/>
<c:set value="${webUrl}/product-${param.id}.html?1=1" var="prdPCHref"/>
<c:if test="${loginUser.isPopularizeMan eq 'Y'}">
    <c:set value="${sdk:getPromoteMemberByUserId()}" var="promoteMember"/>
    <c:set value="${webUrl}/cps/cpsPromote.ac?unid=${promoteMember.id}&target=${prdHref}" var="prdHref"/>
    <c:set value="${webUrl}/cps/cpsPromote.ac?unid=${promoteMember.id}&target=${prdPCHref}" var="prdPCHref"/>
</c:if>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>已购推-${webName}</title>
    <meta content="yes" name="apple-mobile-web-app-capable" />
    <meta content="yes" name="apple-touch-fullscreen" />
    <meta content="telephone=no,email=no" name="format-detection" />
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>

    <link type="text/css" rel="stylesheet" href="${webRoot}/template/bdw/wap/module/member/cps/statics/css/header.css">
    <link type="text/css" rel="stylesheet" href="${webRoot}/template/bdw/wap/module/member/cps/statics/css/cps-all-recommend.css">

    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/wap/statics/js/base.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/wap/statics/js/jquery.infinitescroll.min.js"></script>
    <script type="text/javascript">
        var webPath = {
            webRoot: "${webRoot}",
            lastPageNumber: ${productProxy.lastPageNumber}
        };
        //分页
        $(function(){
            var readedpage = 1;//当前滚动到的页数
            var lastPageNumber = webPath.lastPageNumber;
            $("#main").infinitescroll({
                navSelector: "#page-nav",     //页面分页元素--成功后自动隐藏
                nextSelector: "#page-nav a",
                itemSelector: ".good-list" ,
                animate: true,
                loading: {
                    finishedMsg: '无更多数据'
                },
                extraScrollPx: 50
            }, function(newElements) {
                readedpage++;
                if(readedpage > webPath.lastPageNumber){//如果滚动到超过最后一页，置成不要再滚动。
                    $("#page-nav").remove();
                    $("#main").infinitescroll({state:{isDone:true},extraScrollPx: 50});
                }else{
                    $("#page-nav a").attr("href",webPath.webRoot + "/wap/module/member/cps/myPromotionProducts.ac?page="+readedpage);
                }
            });
        })
    </script>
</head>

<body>
<%--<header class="header">
    <a href="javascript:history.go(-1);" class="back"></a>
    <div class="header-title">已购推</div>
</header>--%>
<div class="main" id="main">

    <div class="tab-content">
        <div class="tab-panel">
            <c:if test="${fn:length(productProxy.result) > 0}">
                <ul class="good-list">
                    <c:forEach items="${productProxy.result}" var="product">
                        <li class="media">
                            <a class="media-img" href="${webRoot}/wap/product-${product.productId}.html?cps=${product.ratePrice}">
                                <img src="${product.imageProxy['200X200']}" alt="">
                            </a>
                            <div class="media-cont" onclick="window.location.href='${webRoot}/wap/product-${product.productId}.html?cps=${product.ratePrice}'">
                                <p class="media-name">${product.productNm}</p>
                                <p class="media-desc"> 商品单价&emsp;&yen;<fmt:formatNumber value="${product.unitPrice}" type="number" pattern="#0.00#" /></p>
                                <p class="media-desc"> 佣金比率&emsp;<fmt:formatNumber value="${product.rebateRate}" type="number" pattern="#0.00#" />% </p>
                                <p class="media-price">赚&ensp;<span><small>&yen;</small>${product.ratePriceIntValue}<small>.${product.ratePriceDecimalValue}</small></span></p>
                            </div>

                            <a class="action" href="${webRoot}/wap/product-${product.productId}.html?cps=${product.ratePrice}" shareId="${product.productId}">分享赚钱</a>
                        </li>
                    </c:forEach>
                </ul>
            </c:if>
        </div>
    </div>
</div>
<nav id="page-nav">
    <a href="${webRoot}/wap/module/member/cps/myPromotionProducts.ac?page=2"></a>
</nav>
<div id="loadDiv" >  </div>
</body>

</html>
