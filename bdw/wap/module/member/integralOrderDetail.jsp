<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getIntegralOrderProxyById(param.id)}" var="orderProxy"/><%--查询订单详细--%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="utf-8">
    <title>积分订单详情-${webName}</title>
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="telephone=no,email=no" name="format-detection">

    <link href="${webRoot}/template/bdw/wap/statics/css/swiper.min.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/order-detail.css" rel="stylesheet" media="screen">

    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-2.1.4.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js" type="text/javascript"></script>
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}", logisticsNum:"${orderProxy.logisticsNum}",logisticsCompany: "${orderProxy.logisticsCompany}",companyHomeUrl: "${orderProxy.companyHomeUrl}", integralOrderId:"${orderProxy.integralOrderId}"};
    </script>
    <script src="${webRoot}/template/bdw/wap/statics/js/integralOrderDetail.js" type="text/javascript"></script>
</head>
<body>
<c:set value="" var="orderStatusNm"/>
<c:choose>
    <c:when test="${orderProxy.orderStat == '未支付'}"><c:set value="待付款" var="orderStatusNm"/></c:when>
    <c:when test="${orderProxy.orderStat == '未发货'}"><c:set value="待发货" var="orderStatusNm"/></c:when>
    <c:when test="${orderProxy.orderStat == '已发货'}"><c:set value="待收货" var="orderStatusNm"/></c:when>
    <c:when test="${orderProxy.orderStat == '已完成'}"><c:set value="已完成" var="orderStatusNm"/></c:when>
    <c:when test="${orderProxy.orderStat == '已取消'}"><c:set value="已取消" var="orderStatusNm"/></c:when>
</c:choose>

<div class="order-d-main">
    <c:choose>
        <c:when test="${orderStatusNm == '待付款'}">
            <div class="zhifu-time-box">
                <div class="zhifu-time-inner">
                    <p class="title">${orderStatusNm}</p>
                    <p class="zhifu-time">订单待付款
                </div>
                <em class="icon1"></em>
            </div>
        </c:when>
        <c:when test="${orderStatusNm == '待发货'}">
            <div class="zhifu-time-box">
                <div class="zhifu-time-inner">
                    <p class="title">${orderStatusNm}</p>
                    <p class="zhifu-time">商家备货中，请耐心等候</p>
                </div>
                <em class="icon2"></em>
            </div>
        </c:when>
        <c:when test="${orderStatusNm == '待收货'}">
            <div class="zhifu-time-box">
                <div class="zhifu-time-inner">
                    <p class="title">${orderStatusNm}</p>
                    <p class="zhifu-time">包裹正向你飞奔过去~</p>
                </div>
                <em class="icon3"></em>
            </div>
        </c:when>
        <c:when test="${orderStatusNm == '已完成'}">
            <div class="zhifu-time-box">
                <div class="zhifu-time-inner">
                    <p class="title">${orderStatusNm}</p>
                    <p class="zhifu-time">交易已完成~<br>感谢亲您对我们的支持！~</p>
                </div>
                <em class="icon4"></em>
            </div>
        </c:when>
        <c:when test="${orderStatusNm == '已取消'}">
            <div class="zhifu-time-box">
                <div class="zhifu-time-inner">
                    <p class="title">${orderStatusNm}</p>
                    <p class="zhifu-time">您的订单取消成功</p>
                </div>
                <em class="icon6"></em>
            </div>
        </c:when>
    </c:choose>
    <div class="kuaidi-info" onclick="window.location.href='${webRoot}/wap/module/member/logisticsDetail.ac?integralOrderId=${orderProxy.integralOrderId}'">
    </div>

    <div class="sp-dd">
        <p class="dd-head dd-head-integral">商品清单</p>
        <c:forEach items="${orderProxy.orderItemProxyList}" var="orderItemProxy" varStatus="status">
            <div class="dd-item">
                <a class="pic" href="javascript:;"><img src="${orderItemProxy.productImage['150X150']}" alt=""></a>
                <a class="name" href="javascript:;">${orderItemProxy.integralProductNm}</a>
                <c:choose>
                    <c:when test="${orderProxy.paymentConvertTypeCode eq '0'}">
                        <p><span class="price"><fmt:formatNumber value="${orderItemProxy.productUnitIntegral}" type="number" pattern="######.##"/>分</span><span class="number">x${orderItemProxy.num}</span></p>
                    </c:when>
                    <c:when test="${orderProxy.paymentConvertTypeCode eq '1'}">
                        <p><span class="price"><fmt:formatNumber value="${orderItemProxy.exchangeIntegral}" type="number" pattern="######.##"/>分
                            + <fmt:formatNumber value="${orderItemProxy.exchangeAmount}" type="number" pattern="######.##"/>元</span>
                            <span class="number">x${orderItemProxy.num}</span></p>
                    </c:when>
                </c:choose>
            </div>
        </c:forEach>
    </div>
    <div style="padding-top: 0;" class="price-operation">
        <c:choose>
            <c:when test="${orderProxy.paymentConvertTypeCode eq '0'}">
                <div class="fukuan">应付积分<span class="fukuan-price"><fmt:formatNumber value="${orderProxy.totalIntegral}" type="number" pattern="######.##"/>分</span></div>
            </c:when>
            <c:when test="${orderProxy.paymentConvertTypeCode eq '1'}">
                <div class="fukuan">应付积分<span class="fukuan-price"><fmt:formatNumber value="${orderProxy.totalExchangeIntegral}" type="number" pattern="######.##"/>分 + <fmt:formatNumber value="${orderProxy.totalExchangeAmount}" type="number" pattern="######.##"/>元</span></div>
            </c:when>
        </c:choose>
    </div>
    <div style="padding-top: 0.3125rem;" class="order-d-info">
        <div class="dd">
            <c:set value="${fn:substring(orderProxy.mobile, 0,3)}" var="mobileHeader"/><%-- 手机前3位 --%>
            <c:set value="${fn:substring(orderProxy.mobile, fn:length(orderProxy.mobile)-4,fn:length(orderProxy.mobile))}" var="mobileStern"/><%-- 手机后4位 --%>
            <p><span>收货人</span>${orderProxy.receiverName}&nbsp;${mobileHeader}****${mobileStern}</p>
            <p><span>收货地址</span>${orderProxy.province}${orderProxy.address}</p>
            <p><span>订单编号</span>${orderProxy.orderNum}</p>
            <p><span>支付方式</span>
                <c:choose>
                    <c:when test="${orderProxy.paymentConvertTypeCode eq '0'}">
                        固定积分
                    </c:when>
                    <c:when test="${orderProxy.paymentConvertTypeCode eq '1'}">
                        部分积分+金额
                    </c:when>
                </c:choose>
            </p>
            <p><span>下单时间</span><fmt:formatDate value="${orderProxy.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
        </div>
    </div>
    <c:choose>
        <c:when test="${orderProxy.orderStat == '已发货'}">
            <div class="bottom-btn-box">
                <a class="zhifu-btn2" href="javascript:;" onclick="buyerSigned(${orderProxy.integralOrderId})">确认收货</a>
            </div>
        </c:when>
    </c:choose>
</div>
</body>
</html>

