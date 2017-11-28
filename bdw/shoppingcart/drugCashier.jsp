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
<c:set value="${sdk:getLoginUser()}" var="userProxy"/>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>${webName}</title>
    <link href="${webRoot}/template/bdw/statics/css/base.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/pharmacist-callb.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/cashier.js"></script>
    <script type="text/javascript">
        var webPath = {
            webRoot:"${webRoot}",
            userMobile:"${user.userMobile}"
        };
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
    %>
    <script type="text/javascript">
        var leftAmountForPaymentJs = ${orderTotalAmount};
    </script>
</head>
<c:set value="${bdw:getUserReceiveAddr(param.orderIds)}" var="userDefaultReceiveAddr" />
<body >
<%--页头开始--%>
<c:import url="/template/bdw/module/common/cartTop.jsp"/>
<%--页头结束--%>

<!--主体-->
<div class="main">
    <div class="main-pharmacist-callb">
        <div class="fl">
            <p class="dt">恭喜！您已成功提交预定</p>
            <p class="tips">药房会通过电话或者短信通知您预定结果</p>
            <div class="price-number">待支付金额：<span><i>￥</i><fmt:formatNumber value="${orderTotalAmount}" pattern="#,##0.00#"/></span></div>
            <div class="btn-box"><a class="btn1" href="${webRoot}/index.ac">返回首页</a><a class="btn2" href="${webRoot}/module/member/orderList.ac?pitchOnRow=11">预定详情</a></div>
        </div>
        <div class="fr">
            <div class="header-shop-cart header-shop-cart2">
                <div class="icon">
                    <span class="wire" style="width: 34%;"></span>
                    <span class="dot dot1 dot-cur"></span>
                    <span class="dot dot-cur"></span>
                    <span class="dot"></span>
                    <span class="dot"></span>
                </div>
                <div class="txt"><span class="cur">提交预定需求</span><span class="cur">药师回拨</span><span>线下付款</span><span>结束流程</span></div>
            </div>
        </div>
    </div>
</div>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页头结束--%>
</body>
</html>
