<%@ page import="com.iloosen.imall.commons.util.holder.SpringContextHolder" %>
<%@ page import="com.iloosen.imall.sdk.integral.proxy.IntegralOrderProxy" %>
<%@ page import="com.iloosen.imall.sdk.integral.service.IntegralOrderProxyService" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}"};
    </script>
    <title>收银台-${webName}</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/buyCar.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/statics/js/jquery-ui-1.8.13/css/redmond/jquery-ui-1.8.13.custom.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/cashier.js"></script>
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}"};
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/payment.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-ui-1.8.13/js/jquery-ui-1.8.13.custom.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            $("#goToPay").pay({payButtonId:"goToPay",formId:"goBankIntegral"});
        })
    </script>
    <%
        String integralOrderId=request.getParameter("integralOrderId");
        if(StringUtils.isNotBlank(integralOrderId)){
            IntegralOrderProxy integralOrder = SpringContextHolder.getBean(IntegralOrderProxyService.class).getIntegralOrderProxyById(Integer.parseInt(integralOrderId));
            if(integralOrder != null){
                request.setAttribute("integralOrder", integralOrder);
                request.setAttribute("orderTotalAmount", integralOrder.getTotalExchangeAmount());
//            request.setAttribute("otooOrderList", orderList);
//            request.setAttribute("orderSize", orderList.size());
                request.setAttribute("orderType", "integralOrder");
            }

        }
    %>

</head>

<body  style="background:url('${webRoot}/template/bdw/statics/images/header_line_top.gif') repeat-x scroll 0 0 #FFFFFF">
<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp?p=list"/>
<%--页头结束--%>
<div id="Cashier">
    <ul class="nav" style="margin-top:15px;">
        <li class="look done"><span>1.查看购物车</span></li>
        <li class="look done"><span>2.填写订单信息</span></li>
        <li class="cur"><span>3.付款到收银台</span></li>
        <li class="last"><span>4.收货评价</span></li>
    </ul><div class="clear"></div>
    <c:set value="${sdk:getLoginUser()}" var="userProxy"/>
    <div class="m1">
        <a style="text-decoration: none;float: left;" href="javascript:">您正在使用${webName}收银台付款：付款后资金暂由收银台保管</a>
        <div class="next" style="float: right;margin:11px 12px;"><a href="javascript:" style="text-decoration: none;margin-left: 7px;" class="goToPay" id="goToPay">去支付</a></div>
    </div>
    <div class="m2" style="margin-bottom: 40px;">
        <div class="list">
            <div class="orderDetail" style="display: none">
                <div class="btn"><img src="${webRoot}/template/bdw/statics/images/02-2.png"></div>
                <div class="order-list">
                    <div class="title">
                        <h2><span>订单号</span></h2>
                        <h2><span>商家</span></h2>
                        <h3><span>金额</span></h3>
                        <div class="clear"></div>
                    </div>
                    <ul class="in">
                        <li><a style="text-decoration: none;">${integralOrder.orderNum}</a></li>
                        <li><a style="text-decoration: none;">${integralOrder.sysShopInf.shopNm}</a></li>
                        <p><a style="text-decoration: none;">${integralOrder.totalExchangeAmount}</a></p>
                        <div class="clear"></div>
                    </ul>
                    <div class="clear"></div>
                </div>
            </div>
            <div class="all"><p>订单总价：<span class="orderTotalAmount"><fmt:formatNumber value="${orderTotalAmount}" pattern="#,##0.00#"/></span>元（若有改价，请<a href="javascript:" onclick="window.location.reload()">刷新）</a></p></div>
            <div class="account">
                <p>
                    <img src="${webRoot}/template/bdw/statics/images/105.png" /><a style="text-decoration: none;">账户余额：<span class="userAmount"><fmt:formatNumber value="${userProxy.prestore}" pattern="#,##0.00#"/></span>元</a>
                    <input class="check"  style="margin:0 -5px 0 25px; vertical-align:middle;" type="checkbox" name="ch[]" />
                </p>
                <div class="clear"></div>
                <h4><a class="tip" style="text-decoration: none;">使用账号余额支付0.00元。剩下<fmt:formatNumber value="${orderTotalAmount}" pattern="#,##0.00#"/>可以选择其他方式付款</a></h4>
            </div>
            <div class="other"><a style="text-decoration: none;" href="javascript:">其他支付方式</a></div>
        </div>
        <form action="${webRoot}/cashier/goBankIntegral.ac" method="post"  id="goBankIntegral" onsubmit="return submitGoBank()">
            <input type="hidden" value="false" name="isUseAccount" id="isUseAccount"/>
            <input type="hidden" value="${orderTotalAmount}" id="totalAmount" name="totalAmount"/>
            <input type="hidden" value="${param.integralOrderId}" name="integralId"/>
            <input type="hidden" value="${orderType}" name="orderType"/>
            <div class="select">
                <p><a style="text-decoration: none;">选择您已开通的网上银行</a></p>
                <ul class="payWay">
                    <c:forEach items="${sdk:getPayWayList()}" var="payWay" varStatus="s">

                        <li><input type="radio" value="${payWay.payWayId}" name="payWayId" <c:if test="${s.first}">checked="checked" </c:if> /><a href="javascript:" title="${payWay.payWayNm}"><img src="${payWay.fileUrl}" height="38" alt="${payWay.payWayNm}"/></a></li>

                    </c:forEach>
                </ul>

            </div>
            <div class="clear"></div>
        </form>
    </div>
</div>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页头结束--%>
</body>
</html>
