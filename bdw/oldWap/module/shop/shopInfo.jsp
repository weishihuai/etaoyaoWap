<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="f" uri="/iMallTag" %>

<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<c:set value="${sdk:getShopInfProxyById(param.shopId)}" var="shop"/>
<c:if test="${empty shop || shop.isFreeze == 'Y'}">
    <c:redirect url="/wap/index.ac"></c:redirect>
</c:if>

<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="format-detection" content="telphone=no, email=no"/>
    <title>店铺信息</title>
    <link href="${webRoot}/template/bdw/oldWap/module/shop/statics/css/base.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/module/shop/statics/css/header.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/module/shop/statics/css/shop-info.css" type="text/css" rel="stylesheet" />

    <script src="${webRoot}/template/bdw/oldWap/module/shop/statics/js/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            $('#shopPic').css('height',$('#shopPic').css('width'));
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
        <span class="title">店铺信息</span>
        <a href="javascript:void(0);" class="home" onclick="window.location.href='${webRoot}/wap/index.ac?time='+ new Date().getTime()"></a>
    </header>
    </c:if>
    <!--中间内容-->
    <div class="main">
        <div class="mt">
            <%-- 因为店铺入口已经有个关注按钮了，所以这里这个去掉，功能重复 --%>
            <%--<a href="#" class="attention">关注</a>--%>
            <div class="pic"><img src="${shop.defaultImage["100X100"]}" id="shopPic" alt="${shop.shopNm}"></div>
            <div class="name elli"><a href="javascript:void(0);">${shop.shopNm}</a></div>
            <div class="fans elli">${shop.collectdByUserNum}粉丝</div>
            <div class="shop-rank">
                <img src="${shop.shopLevel.levelIcon['']}"/>
            </div>
        </div>
        <div class="item store-number">
            <span>店铺号</span>
            <em>${shop.shopInfId}</em>
        </div>
        <div class="m-box">
            <%--<div class="item">
                <span>好评率</span>
                <em>${shop.}</em>
            </div>--%>
            <div class="item">
                <span>商家地址</span>
                <em>${shop.shopAddr}</em>
            </div>
            <div class="item">
                <span>开店时间</span>
                <em>${shop.startDateString}</em>
            </div>
        </div>
        <div class="m-box">
            <div class="item">
                <span>描述相符</span>
                <em class="green"><fmt:formatNumber value="${shop.shopRatingAvgVo.productDescrSame}" pattern="#0.00"/></em>
            </div>
            <div class="item">
                <span>服务态度</span>
                <em class="green"><fmt:formatNumber value="${shop.shopRatingAvgVo.sellerServiceAttitude}" pattern="#0.00"/></em>
            </div>
            <div class="item">
                <span>物流服务</span>

                <em class="green"><fmt:formatNumber value="${shop.shopRatingAvgVo.sellerSendOutSpeed}" pattern="#0.00"/></em>
            </div>
        </div>
        <div class="m-box">
            <div class="item ins-msg">
                <span>掌柜名</span>
                <em>${shop.name}</em>
                <%-- 这里是掌柜名后面有一个QQ的图标，但是现在系统没有在线客服功能，所以先隐藏掉，等以后有了之后再说 --%>
                <%--<a href="javascript:void(0);"></a>--%>
            </div>
            <div class="item phone">
                <span>服务电话</span>
                <c:choose>
                    <c:when test="${not empty shop.tel}">
                        <em>${shop.tel}</em>
                        <a href="tel:${shop.tel}"></a>
                    </c:when>
                    <c:otherwise>
                        <c:choose>
                            <c:when test="${not empty shop.mobile}">
                                <em>${shop.mobile}</em>
                                <a href="tel:${shop.mobile}"></a>
                            </c:when>
                            <c:otherwise>
                                <em>暂无开放客服</em>
                            </c:otherwise>
                        </c:choose>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <c:if test="${!empty shop.certifiedImages}">
            <div class="item qualification">
                <span>资质</span>
                <a href="${webRoot}/wap/module/shop/shopCert.ac?shopId=${shop.shopInfId}" class="blue">查看资质图片</a>
            </div>
        </c:if>
    </div>
</body>

</html>




