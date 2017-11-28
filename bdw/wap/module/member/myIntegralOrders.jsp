<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="8" var="limit"/>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<c:if test="${empty loginUser}">
    <c:redirect url="${webRoot}/wap/login.ac"/>
</c:if>
<c:set value="${empty param.page?1:param.page}" var="pageNum"/> <%--订单翻页数，默认为第一页--%>
<c:set value="${sdk:findIntegralOrderByStatus(loginUser.userId,pageNum,8)}" var="orderProxyPage"/>
<!DOCTYPE HTML>
<html>
<head lang="en">
    <meta charset="utf-8">
    <title>积分订单列表-${webName}</title>
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="telephone=no,email=no" name="format-detection">

    <link href="${webRoot}/template/bdw/wap/statics/css/swiper.min.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/myOrders.css" rel="stylesheet" media="screen">

    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-2.1.4.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery.infinitescroll.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}"};
    </script>
    <script src="${webRoot}/template/bdw/wap/statics/js/integralOrders.js" type="text/javascript"></script>
</head>
<body>
<div class="m-top">
    <a class="back" href="javascript:;" onclick="history.go(-1);"></a>
    <div class="xiala-box">
        <div class="dt">积分订单</div>
        <div class="dd">
            <ul class="dd-inner">
                <li onclick="window.location.href = '${webRoot}/wap/module/member/myOrders.ac'">普通订单</li>
                <li onclick="window.location.href = '${webRoot}/wap/module/member/storeOrder.ac'">门店订单</li>
                <li onclick="window.location.href = '${webRoot}/wap/module/member/myOrders.ac?promotionTypeCode=1'">团购订单</li>
                <li class="cur" onclick="window.location.href = '${webRoot}/wap/module/member/myIntegralOrders.ac'">积分订单</li>
            </ul>
        </div>
    </div>
    <a class="search1" href="javascript:;"></a>
</div>

<div class="search1-box"><div class="dd-inner"><input type="text" placeholder="商品名称/订单编号" id="searchField" ><a class="cancle-btn" href="javascript:;" onclick="searchIntegralOrder()">搜索</a></div></div>


<div class="order-m-main">
    <div class="order-class-toggle">
        <ul class="dt dt1" id="selectStatus">
            <li onclick="selectIntegralOrder(10)" <c:if test="${empty param.status}">class="cur"</c:if>>全部</li>
            <li status="4" onclick="selectIntegralOrder(4)" <c:if test="${param.status == '4'}">class="cur"</c:if>>待收货</li>
            <li status="1" onclick="selectIntegralOrder(1)" <c:if test="${param.status == '1'}">class="cur"</c:if>>已完成</li>
        </ul>
    </div>
    <div id="order-panel">
        <c:forEach items="${orderProxyPage.result}" var="orderProxy" varStatus="status">
            <c:set value="" var="orderStatusNm"/>
            <c:choose>
                <c:when test="${orderProxy.orderStat == '未支付'}"><c:set value="待付款" var="orderStatusNm"/></c:when>
                <c:when test="${orderProxy.orderStat == '未发货'}"><c:set value="待发货" var="orderStatusNm"/></c:when>
                <c:when test="${orderProxy.orderStat == '已发货'}"><c:set value="待收货" var="orderStatusNm"/></c:when>
                <c:when test="${orderProxy.orderStat == '已完成'}"><c:set value="已完成" var="orderStatusNm"/></c:when>
                <c:when test="${orderProxy.orderStat == '已取消'}"><c:set value="已取消" var="orderStatusNm"/></c:when>
            </c:choose>
            <div class="order-list integral-order-list">
                <p class="list-head">订单号：${orderProxy.orderNum}<a class="list-head-r" href="javascript:;">${orderStatusNm}</a></p>
                <c:forEach items="${orderProxy.orderItemProxyList}" var="orderItemProxy" end="0">
                    <div class="list-item" onclick="window.location.href = '${webRoot}/wap/module/member/integralOrderDetail.ac?id=${orderProxy.integralOrderId}'">
                        <a class="pic" href="javascript:;"><img src="${orderItemProxy.productImage['150X150']}" alt=""></a>
                        <a class="name" href="javascript:;">${orderItemProxy.integralProductNm}</a>
                        <c:choose>
                            <c:when test="${orderProxy.paymentConvertTypeCode eq '0'}">
                                <p><span class="integral"> <fmt:formatNumber value="${orderProxy.orderItemProxyList[0].productUnitIntegral}" type="number" pattern="######.##"/>分</span><span class="number">x${orderProxy.orderItemProxyList[0].num}</span></p>
                            </c:when>
                            <c:when test="${orderProxy.paymentConvertTypeCode eq '1'}">
                                <p><span class="integral">
                                    <fmt:formatNumber value="${orderProxy.orderItemProxyList[0].exchangeIntegral}" type="number" pattern="######.##"/>分
                                    + <fmt:formatNumber value="${orderProxy.orderItemProxyList[0].exchangeAmount}" type="number" pattern="######.##"/>元</span>
                                    <span class="number">x${orderProxy.orderItemProxyList[0].num}
                                </span></p>
                            </c:when>
                        </c:choose>
                    </div>
                </c:forEach>
                <div class="list-zhifu">
                    <p>共<span class="sp-number">${orderProxy.orderItemProxyList[0].num}</span>件  应付积分:
                        <c:choose>
                            <c:when test="${orderProxy.paymentConvertTypeCode eq '0'}">
                                <span class="integral"><fmt:formatNumber value="${orderProxy.totalIntegral}" type="number" pattern="######.##"/>分</span>
                            </c:when>
                            <c:when test="${orderProxy.paymentConvertTypeCode eq '1'}">
                                <span class="integral"><fmt:formatNumber value="${orderProxy.totalExchangeIntegral}" type="number" pattern="######.##"/>分 +<fmt:formatNumber value="${orderProxy.totalExchangeAmount}" type="number" pattern="######.##"/>元</span>
                            </c:when>
                        </c:choose>
                    </p>
                    <c:choose>
                        <c:when test="${orderProxy.orderStat == '已发货'}">
                            <a class="zhifu-btn3" href="${webRoot}/wap/module/member/logisticsDetail.ac?integralOrderId=${orderProxy.integralOrderId}">查看物流</a>
                            <a class="zhifu-btn2" href="javascript:;" onclick="buyerSigned(${orderProxy.integralOrderId})">确认收货</a>
                        </c:when>
                        <c:when test="${orderProxy.orderStat == '已完成'}">
                            <a class="zhifu-btn3" href="${webRoot}/wap/module/member/logisticsDetail.ac?integralOrderId=${orderProxy.integralOrderId}">查看物流</a>
                        </c:when>
                    </c:choose>
                </div>
            </div>
        </c:forEach>
    </div>
    <nav id="page-nav">
        <a href="${webRoot}/wap/module/member/loadMyIntegralOrders.ac?status=${param.status}&searchField=${param.searchField}&page=2&limit=8"></a>
    </nav>
</div>
</body>
</html>