<%@ page import="com.iloosen.imall.commons.util.BigDecimalUtil" %>
<%@ page import="com.iloosen.imall.sdk.order.proxy.OrderProxy" %>
<%@ page import="com.iloosen.imall.sdk.order.service.OrderProxyService" %>
<%@ page import="com.iloosen.imall.sdk.otoo.proxy.OtooOrderProxy" %>
<%@ page import="com.iloosen.imall.sdk.otoo.service.OtooOrderProxyService" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>收银台-${webName}</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/buyCar.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/statics/js/jquery-ui-1.8.13/css/redmond/jquery-ui-1.8.13.custom.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/cashier_bak.js"></script>
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}"};
    </script>
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}",userMobile:"${user.userMobile}"};
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/payment.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-ui-1.8.13/js/jquery-ui-1.8.13.custom.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            $("#goToPay").pay({payButtonId:"goToPay",formId:"goBank"});
        })
    </script>
    <%
        String orderIds=request.getParameter("orderIds");
        String orderType=request.getParameter("orderType");

        if (StringUtils.isNotBlank(orderType) && "otooOrder".equals(orderType)){
            //OTO订单
            List<OtooOrderProxy> orderList = new ArrayList<OtooOrderProxy>();
            OtooOrderProxyService orderProxyService = new OtooOrderProxyService();
            for (String orderId : orderIds.split(",")) {
                orderList.add(orderProxyService.getOrderProxyById(Integer.parseInt(orderId)));
            }

            double orderTotalAmount = 0.0;
            for (OtooOrderProxy orderProxy : orderList) {
                orderTotalAmount = BigDecimalUtil.add(orderTotalAmount, orderProxy.getTotalPrice());
            }
            request.setAttribute("orderTotalAmount", orderTotalAmount);
            request.setAttribute("otooOrderList", orderList);
            request.setAttribute("orderSize", orderList.size());
            request.setAttribute("orderType", "otooOrder");
        }else {
            List<OrderProxy> orderList = new ArrayList<OrderProxy>();
            OrderProxyService orderProxyService = new OrderProxyService();
            for (String orderId : orderIds.split(",")) {
                orderList.add(orderProxyService.getOrderProxy(Integer.parseInt(orderId)));
            }

            double orderTotalAmount = 0.0;
            for (OrderProxy orderProxy : orderList) {
                orderTotalAmount = BigDecimalUtil.add(orderTotalAmount, orderProxy.getOrderTotalAmount());
            }
            request.setAttribute("orderTotalAmount", orderTotalAmount);
            request.setAttribute("orderList", orderList);
            request.setAttribute("orderSize", orderList.size());
            request.setAttribute("orderType", "order");
        }

    %>
    <script type="text/javascript">
        var leftAmountForPaymentJs = ${orderTotalAmount};
    </script>

</head>

<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp?p=list"/>
<%--页头结束--%>

<body  style="background:url('${webRoot}/template/bdw/statics/images/header_line_top.gif') repeat-x scroll 0 0 #FFFFFF">
<div id="Cashier">
    <ul class="nav" style="margin-top:15px;">
        <li class="look done"><span>1.查看购物车</span></li>
        <li class="look done"><span>2.填写订单信息</span></li>
        <li class="cur"><span>3.付款到收银台</span></li>
        <li class="last"><span>4.收货评价</span></li>
    </ul><div class="clear"></div>
    <c:set value="${sdk:getLoginUser()}" var="userProxy"/>
    <div class="m1">
        <a style="text-decoration: none;" href="javascript:">您正在使用${webName}收银台付款：付款后资金暂由收银台保管</a>
        <div class="next" style="float: right;margin: 12px 9px -7px 50px;cursor:pointer;"id="goToPay"><a href="javascript:" style="text-decoration: none;margin-left: 7px;" class="goToPay" >去支付</a></div>
    </div>
    <div class="m2" style="margin-bottom: 40px;">
        <div class="list">
            <c:if test="${!orderType eq 'otooOrder'}">
                <div class="order">
                    <a style="text-decoration: none;">合并|  ${orderSize}笔订单</a><a style="text-decoration: none;"><span>订单详情</span></a><a href="javascript:" class="openOrderDetail"><em>展开</em></a>
                </div>
            </c:if>
            <div class="orderDetail" style="display: none">
                <div class="btn"><img src="${webRoot}/template/bdw/statics/images/02-2.png"></div>
                <div class="order-list">
                    <div class="title">
                        <h2><span>订单号</span></h2>
                        <h2><span>商家</span></h2>
                        <h3><span>金额</span></h3>
                        <div class="clear"></div>
                    </div>
                    <c:choose>
                        <c:when test="${orderType eq 'otooOrder'}">
                            <c:forEach items="${otooOrderList}" var="order">
                                <ul class="in">
                                    <li><a style="text-decoration: none;">${order.otooOrderNum}</a></li>
                                    <li><a style="text-decoration: none;">${order.sysShopInf.shopNm}</a></li>
                                    <p><a style="text-decoration: none;">${order.totalPrice}</a></p>
                                    <div class="clear"></div>
                                </ul>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${orderList}" var="order">
                                <ul class="in">
                                    <li><a style="text-decoration: none;">${order.orderNum}</a></li>
                                    <li><a style="text-decoration: none;">${order.sysShopInf.shopNm}</a></li>
                                    <p><a style="text-decoration: none;">${order.orderTotalAmount}</a></p>
                                    <div class="clear"></div>
                                </ul>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    <div class="clear"></div>
                </div>
            </div>
            <div class="all"><p>订单总价：<span class="orderTotalAmount"><fmt:formatNumber value="${orderTotalAmount}" pattern="#,#00.0#"/></span>元（若有改价，请<a href="javascript:" onclick="window.location.reload()">刷新）</a></p></div>
           <c:if test="${bdw:getPayWayByPaymentTypeCode('5').isEnable == 'Y'}">
                <div class="account" id="account">
                    <p>
                        <img src="${webRoot}/template/bdw/statics/images/105.png" /><a style="text-decoration: none;">账户余额：<span class="userAmount"><fmt:formatNumber value="${userProxy.prestore}" pattern="#,#00.0#"/></span>元</a>
                        <input class="check"  style="margin:0 -5px 0 25px; vertical-align:middle;" type="checkbox" name="ch[]" />
                    </p>
                    <div class="clear"></div>
                    <h4><a class="tip" style="text-decoration: none;">使用账号余额支付0.00元。剩下<fmt:formatNumber value="${orderTotalAmount}" pattern="#,#00.0#"/>可以选择其他方式付款</a></h4>
                </div>
           </c:if>
            <div class="other"><a style="text-decoration: none;" href="javascript:">其他支付方式</a></div>
        </div>
        <form action="${webRoot}/cashier/goBank.ac" method="post"  id="goBank" onsubmit="return submitGoBank()" style="margin-bottom: 20px;">
            <input type="hidden" value="false" name="isUseAccount" id="isUseAccount"/>
            <input type="hidden" value="${orderTotalAmount}" id="totalAmount" name="totalAmount"/>
            <input type="hidden" value="${param.orderIds}" name="extraData"/>
            <input type="hidden" value="${orderType}" name="orderType"/>
            <div class="select">
                <p style="margin-top: 10px;"><a style="text-decoration: none;">选择您已开通的网上银行</a></p>
                <ul class="payWay">
                    <c:forEach items="${sdk:getPayWayList()}" var="payWay" varStatus="s">
                        <li><input type="radio" class="useBank" value="${payWay.payWayId}" name="payWayId" <c:if test="${s.first}">checked="checked" </c:if> /><a href="javascript:" title="${payWay.payWayNm}"><img src="${payWay.fileUrl}" height="32" alt="${payWay.payWayNm}"/></a></li>
                    </c:forEach>
                </ul>
            </div><div class="clear"></div>
        </form>
    </div>
</div>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页头结束--%>
</body>
</html>
