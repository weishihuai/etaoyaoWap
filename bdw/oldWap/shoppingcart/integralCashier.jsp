<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="f" uri="/iMallTag" %>
<%@ page import="com.iloosen.imall.commons.util.holder.SpringContextHolder" %>
<%@ page import="com.iloosen.imall.sdk.integral.proxy.IntegralOrderProxy" %>
<%@ page import="com.iloosen.imall.sdk.integral.service.IntegralOrderProxyService" %>

<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<c:if test="${empty loginUser}">
    <c:redirect url="${webRoot}/wap/login.ac"></c:redirect>
</c:if>


<html>
<head>
    <title>收银台页面</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <!-- Bootstrap -->
  <%--  <link href="../css/bootstrap.min.css" rel="stylesheet" >
    <link href="../css/jquery.mmenu.css" rel="stylesheet">
    <link type="text/css" rel="stylesheet" href="../css/jquery.mmenu.positioning.css" />
    <link href="../style/header.css" rel="stylesheet" media="screen">
    <link href="../style/buycar2.css" rel="stylesheet" media="screen">--%>

    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.min.css" rel="stylesheet" >
    <link href="${webRoot}/template/bdw/oldWap/statics/css/jquery.mmenu.positioning.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/buycar2.css" rel="stylesheet">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/header.css" rel="stylesheet">


    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery-1.7.1.min.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/wapcart.js"></script>

    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}",orderIds:"${param.orderIds}",payWayId:"${param.payWayId}",type:"integralWap"};
    </script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/cashier.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/paymentForWap.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            $("#goToPay").pay({payButtonId:"goToPay",formId:"goBankIntegral"});
        })
    </script>
    <%

        String integralOrderId=request.getParameter("integralOrderId");
        IntegralOrderProxy integralOrder = SpringContextHolder.getBean(IntegralOrderProxyService.class).getIntegralOrderProxyById(Integer.parseInt(integralOrderId));
        request.setAttribute("integralOrder",integralOrder);


    %>
</head>
<body>
<%--页头开始--%>
<c:import url="/template/bdw/oldWap/module/common/head.jsp?title=收银台"/>
<%--页头结束--%>

<article class="tips">
    <img src="${webRoot}/template/bdw/oldWap/statics/images/wsc_byc_icon03.png" width="22" height="22" />
    <em>付款后资金暂由${webName}收银台保管</em>
</article>

<form action="${webRoot}/cashier/goBankIntegral.ac" method="post" id="goBankIntegral" onsubmit="return goToPay()">
    <input type="hidden" value="false" name="isUseAccount" id="isUseAccount"/>
    <input type="hidden" value="${integralOrder.totalExchangeAmount}" id="totalAmount" name="totalAmount"/>
    <input type="hidden" value="${integralOrder.integralOrderId}" name="integralId"/>
    <input type="hidden" value="${param.payWayId}" name="payWayId"/>
    <input type="hidden" value="integralOrder" name="orderType"/>

<div class="row ckout-main">
            <div class="row order-one showMyOrder hideThis">
                <div class="col-xs-12 ">订单编号 ：<i>${integralOrder.orderNum}</i></div>
                <div class="col-xs-12 form ">${integralOrder.sysShopInf.shopNm}</div>
                <div class="col-xs-12 form">金额:<fmt:formatNumber value="${integralOrder.totalExchangeAmount}" pattern="######.##"/></div>
            </div>
        <%--<div class="row order-one">
            <div class="col-xs-12 ">订单编号 ：<i>140902105710054</i></div>
            <div class="col-xs-12 form ">乐商商城自营店</div>
        </div>
        <div class="row order-one last">
            <div class="col-xs-12 ">订单编号 ：<i>140902105710054</i></div>
            <div class="col-xs-12 form ">乐商商城自营店</div>
        </div>--%>
    </div>
<%--    <div class="col-xs-12 acc-pay">
        <a href="#" class="cur2"></a>
        <span>使用账户余额支付</span>
        <i>余额：</i>
        <em>￥58.00</em>
    </div>--%>
<%--    <div class="col-xs-12 ano-pay">使用余额支付<em>￥0.00</em>，剩下金额用其他方式付款</div>--%>



    <c:choose>
        <c:when test="${empty param.payWayId}">
            <div class="col-xs-12 payment"><i>选择支付方式：</i>
                <a href="${webRoot}/wap/shoppingcart/payWay.ac?orderIds=${param.integralOrderId}&type=integralWap">
                    <k1 style="font-size: 20px; color:red;">选择</k1>
                </a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="col-xs-12 payment"><i>已选择支付方式：</i>
                <a href="${webRoot}/wap/shoppingcart/payWay.ac?orderIds=${param.integralOrderId}&type=integralWap"><k style="font-size: 15px;color:red;">${param.payWayNm}</k></a>;
            </div>
        </c:otherwise>
    </c:choose>





<div class="row">
    <div class="col-xs-12 submit">
        <img src="${webRoot}/template/bdw/oldWap/statics/images/wsc_byc_icon03.png" width="22" height="22" />
        <em>实付款：<i>￥<fmt:formatNumber value="${integralOrder.totalExchangeAmount}" pattern="######.##"/></i></em>
        <a href="javascript:void(0)" id="goToPay" >去支付</a>
    </div>
</div>

</form>

<%--页头开始--%>
<c:import url="/template/bdw/oldWap/module/common/bottom.jsp"/>
<%--页头结束--%>

</body>
</html>
