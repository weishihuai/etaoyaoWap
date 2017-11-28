<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="f" uri="/iMallTag" %>

<html>
<head>
    <title>收银台页面-选择支付方式</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <!-- Bootstrap -->
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.min.css" rel="stylesheet" >
    <link href="${webRoot}/template/bdw/oldWap/statics/css/jquery.mmenu.positioning.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/buycar2.css" rel="stylesheet">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/header.css" rel="stylesheet">
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery-1.7.1.min.js"></script>

</head>
<body>
<%--页头开始--%>
<c:import url="/template/bdw/oldWap/module/common/head.jsp?title=选择支付方式"/>
<%--页头结束--%>

<article class="tips">
    <img src="${webRoot}/template/bdw/oldWap/statics/images/wsc_byc_icon03.png" width="22" height="22" />
    <em>选择您已开通的网上银行</em>
</article>

<div class="row online-banking">
    <ul class="list-unstyled">
        <%--<c:if test="${isWeixin == 'Y'}">--%>
            <%--<li class="col-xs-12"><a href="${webRoot}/wap/shoppingcart/cashier.ac?orderIds=${param.orderIds}&&payWayId=${payWay.payWayId}&&payWayNm=微信支付">微信支付</a></li>--%>
        <%--</c:if>--%>
        <c:forEach items="${sdk:getMobilePayWayVo()}" var="payWay" varStatus="s">
            <c:choose>
                <c:when test="${param.type == 'integralWap'}">
                    <%--<li class="col-xs-12"><a href="${webRoot}/wap/shoppingcart/integralCashier.ac?integralOrderId=${param.orderIds}&payWayId=${payWay.payWayId}&&payWayNm=${payWay.payWayNm}">${payWay.payWayNm}</a></li>--%>
                    <c:if test="${payWay.payWayId != 38}">
                        <c:if test="${isWeixin=='N'}">
                            <%-- wap端不要显示WXZF和给APP用的支付宝支付方式(30微信支付，35APP支付宝支付) --%>
                            <c:if test="${payWay.payWayId != 30 && payWay.payWayId != 35}">
                                <li class="col-xs-12"><a href="${webRoot}/wap/shoppingcart/integralCashier.ac?integralOrderId=${param.orderIds}&payWayId=${payWay.payWayId}&&payWayNm=${payWay.payWayNm}">${payWay.payWayNm}</a></li>
                            </c:if>
                        </c:if>
                        <c:if test="${isWeixin=='Y'}">
                            <%--当页面是在微信内被浏览的时候，支付时不要显示和支付宝有关的支付信息（32,35,37）--%>
                            <c:if test="${payWay.payWayId != 32 && payWay.payWayId != 35 && payWay.payWayId != 37}">
                                <li class="col-xs-12"><a href="${webRoot}/wap/shoppingcart/integralCashier.ac?integralOrderId=${param.orderIds}&payWayId=${payWay.payWayId}&&payWayNm=${payWay.payWayNm}">${payWay.payWayNm}</a></li>
                            </c:if>
                        </c:if>
                    </c:if>
                </c:when>
                <c:otherwise>
                    <c:if test="${payWay.payWayId != 38}">
                        <c:if test="${isWeixin=='N'}">
                            <%-- wap端不要显示WXZF和给APP用的支付宝支付方式(30微信支付，35APP支付宝支付) --%>
                            <c:if test="${payWay.payWayId != 30 && payWay.payWayId != 35}">
                                <li class="col-xs-12"><a href="${webRoot}/wap/shoppingcart/cashier.ac?orderIds=${param.orderIds}&payWayId=${payWay.payWayId}&&payWayNm=${payWay.payWayNm}">${payWay.payWayNm}</a></li>
                            </c:if>
                        </c:if>
                        <c:if test="${isWeixin=='Y'}">
                            <%--当页面是在微信内被浏览的时候，支付时不要显示和支付宝有关的支付信息（32,35,37）--%>
                            <c:if test="${payWay.payWayId != 32 && payWay.payWayId != 35 && payWay.payWayId != 37}">
                                <li class="col-xs-12"><a href="${webRoot}/wap/shoppingcart/cashier.ac?orderIds=${param.orderIds}&payWayId=${payWay.payWayId}&&payWayNm=${payWay.payWayNm}">${payWay.payWayNm}</a></li>
                            </c:if>
                        </c:if>
                    </c:if>
                    <%--<li class="col-xs-12"><a href="${webRoot}/wap/shoppingcart/cashier.ac?orderIds=${param.orderIds}&payWayId=${payWay.payWayId}&&payWayNm=${payWay.payWayNm}">${payWay.payWayNm}</a></li>--%>
                </c:otherwise>
            </c:choose>
        </c:forEach>

       <%-- <li class="col-xs-12">支付宝手机支付</li>--%>
        <%--    <li class="col-xs-12">财付通在线支付</li>
       <li class="col-xs-12 cur">招商银行信用卡支付</li>
       <li class="col-xs-12">交通银行</li>
       <li class="col-xs-12">易宝支付</li>
       <li class="col-xs-12">银联</li>
       <li class="col-xs-12 last">中国农业银行</li>--%>
    </ul>
</div>

<%--页头开始--%>
<c:import url="/template/bdw/oldWap/module/common/bottom.jsp"/>
<%--页头结束--%>

</body>
</html>
