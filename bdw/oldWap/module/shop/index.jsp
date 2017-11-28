<%@ page import="com.iloosen.imall.commons.web.WebContextFactory" %>
<%@ page import="java.util.GregorianCalendar" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.UUID" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="f" uri="/iMallTag" %>

<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<c:set value="${sdk:getShopInfProxyById(param.shopId)}" var="shop"/>
<c:if test="${empty shop || shop.isFreeze == 'Y'}">
    <c:redirect url="/wap/index.ac"></c:redirect>
</c:if>

<c:set value="${sdk:getShopCategoryProxy(param.shopId)}" var="shopCategory"/>
<c:set value="${empty param.page ? 1 : param.page}" var="_page"/>
<c:set value="${sdk:search(10)}" var="productProxys"/>
<c:set value="${empty param.shopCategoryId ? '' : param.shopCategoryId}" var="shopCategoryId"/>

<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${webName}-${shop.shopNm}</title>
    <link href="${webRoot}/template/bdw/oldWap/module/shop/statics/css/base.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/module/shop/statics/css/header.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/module/shop/statics/css/shop-index.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/statics/js/Tiny-Alert/css/zepto.alert.css" rel="stylesheet" type="text/css" >
    <link href="${webRoot}/template/bdw/statics/js/easydialog/easydialog.css" rel="stylesheet" type="text/css"/>

    <script type="text/javascript">
        var paramData={
            webRoot:"${webRoot}",
            page:"${_page}",
            /*category:"${shopCategoryId}",*/
            keyword:"${param.keyword}",
            order:"${param.order}",
            shopId:"${param.shopId}",
            /*q是queryString*/
            q:"${param.q}",
            shopCategoryId:"${shopCategoryId}"
        };
 <%
    Map<String, String> codeMap = new HashMap<String, String>();
    GregorianCalendar cal = new GregorianCalendar();
    cal.setTime(new Date());
    String uuid = UUID.randomUUID().toString();
    String shopId =request.getParameter("shopId");
    StringBuilder builder = new StringBuilder();
    builder.append(uuid).append(cal.getTimeInMillis());
    codeMap.put(builder.toString(), "http://" + request.getHeader("host") + "/wap/module/shop/index.ac?shopId=" + shopId);
    WebContextFactory.getWebContext().setSessionAttr("qrcodeLongCode", codeMap);
    pageContext.setAttribute("shopQrCode", builder.toString());
%>
    </script>
    <%--<script src="${webRoot}/template/bdw/oldWap/module/shop/statics/js/jquery-1.6.1.min.js" type="text/javascript"></script>--%>
    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/jqGrid/js/jquery-1.7.2.min.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/Tiny-Alert/js/zepto.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/Tiny-Alert/js/zepto.alert.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/tinyAlertDialog.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/oldWap/module/shop/statics/js/index.js" type="text/javascript"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/easydialog/easydialog.js"></script>

    <script type="text/javascript">
        $(function(){
            if(${isWeixin=="Y"}){
                $(".main").css("padding-top","0px");
            }
        });
    </script>
</head>

<body>
    <!--头部-->
    <c:if test="${isWeixin!='Y'}">
    <header class="header">
        <a onclick="history.go(-1);" href="javascript:void(0);" class="back"></a>
        <span class="title">店铺详情</span>
        <a href="javascript:void(0);" class="home" onclick="window.location.href='${webRoot}/wap/index.ac?time='+ new Date().getTime()"></a>
    </header>
    </c:if>
    <!--中间内容-->
    <div class="main">
        <div class="top-search"><input type="text" placeholder="搜索商品" class="keyword" id="indexSearchBtn"></div>
        <div class="mt">
            <c:choose>
                <c:when test="${not empty shop.backgroundPicUrl}">
                        <img src="${webRoot}/upload/${shop.backgroundPicUrl}" style="height: 192px;"/>
                </c:when>
                <c:otherwise>
                    <img src="${webRoot}/template/bdw/oldWap/module/shop/statics/images/shop_bg.jpg" alt="" style="height: 192px;">
                </c:otherwise>
            </c:choose>

            <div class="mt-btn">
                <a href="javascript:void(0);" class="share" shopId="${shop.shopInfId}" id="share">分享店铺</a>
                <c:if test="${not empty loginUser}">
                    <a href="javascript:void(0);" class="collect ${shop.collect ? 'cur' : ''}" shopId="${shop.shopInfId}" isCollect="${shop.collect}">${shop.collect ? '已收藏' : '收藏店铺'}</a>
                </c:if>
                <c:if test="${empty loginUser}">
                    <a href="javascript:void(0);" class="collect" onclick="window.location.href='${webRoot}/wap/login.ac';">收藏店铺</a>
                </c:if>
            </div>

                <div class="mt-cont">
                <div class="pic">
                    <c:choose>
                        <c:when test="${not empty shop.shopPicUrl}">
                            <img id="shopPic" src="${webRoot}/upload/${shop.shopPicUrl}">
                        </c:when>
                        <c:otherwise>
                            <img id="shopPic" src="${webRoot}/template/bdw/oldWap/citySend/statics/images/store-avatar.png">
                        </c:otherwise>
                    </c:choose>
                </div>
                <h5 style="color: #fff;">${shop.shopNm}</h5>
            </div>
            <div class="mt-cont">
                <img src="${webRoot}/QRCodeServlet?qrcodelong=${shopQrCode}" width="300" height="300" style="display: none;z-index: 9999;margin:0 auto" id="shopShare"/>
            </div>
        </div>
        <div class="server">
            <c:choose>
                <c:when test="${not empty shop.tel}">
                    <a href="tel:${shop.tel}" class="phone">联系卖家</a>
                </c:when>
                <c:otherwise>
                    <c:choose>
                        <c:when test="${not empty shop.mobile}">
                            <a href="tel:${shop.mobile}" class="phone">联系卖家</a>
                        </c:when>
                        <c:otherwise>
                            <a href="javascript:void(0);" class="phone" onclick="noCustomService()">联系卖家</a>
                        </c:otherwise>
                    </c:choose>
                </c:otherwise>
            </c:choose>
        <a href="javascript:void(0);" class="ins-msg" onclick="noCustomService()">在线咨询</a>
        </div>
        <div class="mc">
            <div class="mc-nav">
                <ul>
                    <li class="st-icon1 cur"><a href="${webRoot}/wap/module/shop/index.ac?shopId=${shop.shopInfId}">全部商品</a></li>
                    <li class="st-icon2"><a href="${webRoot}/wap/module/shop/shopCategory.ac?shopId=${shop.shopInfId}">商品分类</a></li>
                    <li class="st-icon3"><a href="${webRoot}/wap/module/shop/shopActivity.ac?shopId=${shop.shopInfId}">店铺活动</a></li>
                    <li class="st-icon4"><a href="${webRoot}/wap/module/shop/shopInfo.ac?shopId=${shop.shopInfId}">店铺信息</a></li>
                </ul>
            </div>
            <c:choose>
                <c:when test="${empty productProxys.result}">
                    <div class="mc-cont" style="text-align: center;margin-top: 1.0rem;margin-bottom: 2.0rem;font-size: 12px">
                        查询不到相关信息！
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="mc-cont">
                        <div class="mc-tab">
                            <ul>
                                <li id="defaultOrder" class="cur"><a href="javacript:void(0);">默认排行</a></li>
                                <li id="saleOrder"><a href="javacript:void(0);">销量</a></li>
                                <li id="priceOrder"><a href="javacript:void(0);">价格</a></li>
                            </ul>
                        </div>
                        <div class="tab-cont">
                            <ul id="productUl">
                                <c:forEach items="${productProxys.result}" var="product" varStatus="status" end="9">
                                    <li>
                                        <c:if test="${product.isJoinActivity && not empty product.activityPlateImageUrl}">
                                            <div class="ac_image"><img src="${webRoot}/upload/${product.activityPlateImageUrl}" alt=""/></div>
                                        </c:if>
                                        <a href="${webRoot}/wap/product.ac?id=${product.productId}">
                                            <div class="g-pic">
                                                <img class="productPic" src="${product.defaultImage["320X320"]}" alt="${product.name}">
                                            </div>
                                            <div class="g-title">${product.name}</div>
                                        </a>
                                        <div class="g-price">¥ <span>${product.price.unitPrice}</span></div>
                                        <div class="old-price"><del>¥ <span>${product.marketPrice}</span></del></div>
                                        <div style="clear: both;"></div>
                                        <a class="star ${product.collect ? 'cur' : ''}" productId="${product.productId}" isCollect="${product.collect}" href="javascript:"></a>
                                    </li>
                                </c:forEach>
                            </ul>
                            <c:if test="${productProxys.lastPageNumber ne _page}">
                                <a href="javascript:void(0);" class="more">查看更多商品</a>
                            </c:if>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    <%--<div class="footer">
        <c:if test="${not empty productProxys.result}">
            <div class="footer-logo">
                <img src="${webRoot}/template/bdw/oldWap/module/shop/statics/images/footer-logo.png" alt="亚中e淘">
            </div>
        </c:if>
    </div>--%>
</body>

</html>




