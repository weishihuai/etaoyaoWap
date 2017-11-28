<%@ page import="com.iloosen.imall.module.core.domain.code.ChannelCodeEnum" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<%
    request.setAttribute("pc", ChannelCodeEnum.PC.toCode());                         //pc端
    request.setAttribute("wap", ChannelCodeEnum.WAP.toCode());                   	  //wap端
%>

<!--判断是否推广员-->
<c:if test="${loginUser.isPopularizeMan ne 'Y'}">
    <c:redirect url="${webRoot}/wap/module/member/cps/myPromoteRegisterFirstStep.ac"/>
</c:if>

<c:set value="${sdk:findListByPage(2,wap,null)}" var="themesPage"/>             <%--好货推广--%>
<c:set value="${sdk:searchCpsPromotionPrd(3)}"    var="productProxy"/>           <%--精选商品--%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>我要推广</title>
    <meta content="yes" name="apple-mobile-web-app-capable" />
    <meta content="yes" name="apple-touch-fullscreen" />
    <meta content="telephone=no,email=no" name="format-detection" />
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, width=device-width">
    <title>${webName}</title>
    <link type="text/css" rel="stylesheet" href="${webRoot}/template/bdw/wap/module/member/cps/statics/css/header.css">
    <link type="text/css" rel="stylesheet" href="${webRoot}/template/bdw/wap/module/member/cps/statics/css/cps-index.css">
    <link type="text/css" rel="stylesheet" href="${webRoot}/template/bdw/wap/module/member/cps/statics/css/foot.css">

    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/wap/statics/js/base.js"></script>
</head>

<body>
    <%--<header class="header">
        <a href="${webRoot}/wap/module/member/index.ac?type=member" class="back"></a>
        <div class="header-title">我要推广</div>
    </header>--%>
    <div class="main">
        <!-- 搜索入口 -->
        <div class="banner">
            <a class="search" href="${webRoot}/wap/module/member/cps/searchPromotionProducts.ac"><i class="icon icon-search"></i>&ensp;搜索商品</a>
        </div>

        <!-- 导航 -->
        <div class="box-enter">
            <ul>
                <li>
                    <a href="${webRoot}/wap/module/member/cps/cpsAllPromotionProducts.ac">
                        <span class="img"> <img src="${webRoot}/template/bdw/wap/module/member/cps/statics/images/cps-nava-all.png" alt="全品推"> </span>
                        <span class="tit">全品推</span>
                    </a>
                </li>
                <li>
                    <a href="${webRoot}/wap/module/member/cps/myPromotionProducts.ac">
                        <span class="img"> <img src="${webRoot}/template/bdw/wap/module/member/cps/statics/images/cps-nav-buy.png" alt="已购推"> </span>
                        <span class="tit">已购推</span>
                    </a>
                </li>
                <li>
                    <a href="${webRoot}/wap/module/member/cps/cpsGoodRecommend.ac">
                        <span class="img"> <img src="${webRoot}/template/bdw/wap/module/member/cps/statics/images/cps-nav-nice.png" alt="好货推"> </span>
                        <span class="tit">好货推</span>
                    </a>
                </li>
            </ul>
        </div>

        <!-- 规则标题 -->
        <div class="sub-title" onclick="$('#modalRule').show();">
            <h2>规则说明</h2>
        </div>

        <!-- 热门好货 -->
        <div class="hotsale section">
            <dl>
                <dt><span>热门好货</span></dt>

                <c:forEach items="${themesPage.result}" var="themes" varStatus="s">
                <dd class="media">
                    <a class="media-cont" href="${webRoot}/wap/module/member/cps/cpsGoodDetail.ac?themeActivitieId=${themes.cpsThemeActivitieId}">
                        <div class="media-img">
                            <c:if test="${empty themes.wapEffectDisplayId}"><c:set var="imgPictUrl" value="${webRoot}/template/green/statics/images/noPic_160X160.jpg"/> </c:if>
                            <c:if test="${not empty themes.wapEffectDisplayId && themes.wapEffectDisplayId !=''}"> <c:set var="imgPictUrl" value="${themes.wapMainImg['']}"/> </c:if>
                            <img src="${imgPictUrl}" alt="">
                        </div>
                        <div class="wrap">
                            <p class="media-name">${themes.themeName}</p>
                            <p class="media-desc">
                                <c:if test="${not empty themes.explanation}">
                                    ${themes.explanation}
                                </c:if>
                                <c:if test="${empty themes.explanation}">
                                    ${fn:substring(sdk:cleanHTML(themes.themeDescStr,""),0 , 120)  }
                                </c:if>
                            </p>
                        </div>
                    </a>
                    <p class="media-price">佣金金额&ensp;<span>
                        <small>&yen;</small><fmt:formatNumber value="${themes.rebateAmount}" type="number" pattern="#" />
                        <small>.${themes.rebateAmountDecimal}</small></span></p>
                    <a class="action" href="${webRoot}/wap/module/member/cps/cpsGoodDetail.ac?themeActivitieId=${themes.cpsThemeActivitieId}">分享赚钱</a>
                </dd>
                 </c:forEach>
            </dl>
        </div>

        <!-- 每日精选 -->
        <div class="daily section">
            <dl>
                <dt><span>每日精选</span></dt>

                <c:forEach items="${productProxy.result}" var="product">
                <dd class="media" >
                    <a class="media-img" href="${webRoot}/wap/product-${product.productId}.html?cps=${product.ratePrice}">
                        <img src="${product.imageProxy['200X200']}"  width="80" height="80" alt="">
                    </a>

                    <div class="media-cont" onclick="window.location.href='${webRoot}/wap/product-${product.productId}.html?cps=${product.ratePrice}'">
                        <p class="media-name">${product.productNm}</p>
                        <p class="media-desc">商品单价&emsp;￥<fmt:formatNumber value="${product.unitPrice}" type="number" pattern="#0.00#" /></p>
                        <p class="media-desc">佣金比率&emsp;${product.rebateRate}%</p>
                        <p class="media-price">赚&ensp;<span><small>&yen;</small><fmt:formatNumber value="${product.ratePriceIntValue}" type="number" pattern="#" /><small>.${product.ratePriceDecimalValue}</small></span></p>
                    </div>
                    <a class="action" href="${webRoot}/wap/product-${product.productId}.html?cps=${product.ratePrice}">分享赚钱</a>
                </dd>

                </c:forEach>
            </dl>
        </div>
        <c:import url="./cpsFooter.jsp"/>
    </div>

    <!-- 规则说明 -->
    <div class="modal fade in" id="modalRule" style="display: none;">
        <div class="modal-dropback"></div>
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">规则说明</h4>
                </div>
                <div class="modal-body">
                    <c:set var="spreadDesc" value="${sdk:getSpreadDesc()}"/>
                    ${spreadDesc}
                </div>
                <div class="modal-footer">
                    <a class="btn-link" href="javascript:;" onclick="$('#modalRule').hide();">我知道了</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
