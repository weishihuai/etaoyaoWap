<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<c:set value="${empty param.page?1:param.page}" var="pageNum"/> <%--订单翻页数，默认为第一页--%>
<c:set value="${sdk:findIntegralOrderByStatus(loginUser.userId,pageNum,8)}" var="orderProxyPage"/>

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
                        <p><span class="integral"><fmt:formatNumber value="${orderProxy.orderItemProxyList[0].productUnitIntegral}" type="number" pattern="######.##"/>分</span><span class="number">x${orderProxy.orderItemProxyList[0].num}</span></p>
                    </c:when>
                    <c:when test="${orderProxy.paymentConvertTypeCode eq '1'}">
                        <p><span class="integral"><fmt:formatNumber value="${orderProxy.orderItemProxyList[0].exchangeIntegral}" type="number" pattern="######.##"/>分
                            + <fmt:formatNumber value="${orderProxy.orderItemProxyList[0].exchangeAmount}" type="number" pattern="######.##"/>元</span>
                            <span class="number">x${orderProxy.orderItemProxyList[0].num}</span>
                        </p>
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