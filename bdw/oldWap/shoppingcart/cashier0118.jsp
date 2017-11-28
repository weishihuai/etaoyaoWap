<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="f" uri="/iMallTag" %>
<%@ page import="com.iloosen.imall.commons.util.BigDecimalUtil" %>
<%@ page import="com.iloosen.imall.sdk.order.proxy.OrderProxy" %>
<%@ page import="com.iloosen.imall.sdk.order.service.OrderProxyService" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<c:if test="${empty loginUser}">
    <c:redirect url="${webRoot}/wap/login.ac"></c:redirect>
</c:if>

<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="format-detection" content="telphone=no, email=no"/>
    <title>收银台</title>
    <link href="${webRoot}/template/bdw/oldWap/statics/css/base.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/statics/css/header.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/statics/css/cashier.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet">

    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}",orderIds:"${param.orderIds}",payWayId:"${param.payWayId}"};
    </script>
    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/jqGrid/js/jquery-1.7.2.min.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/wapcart.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/cashier.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/paymentForWap.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            $("#goToPay").pay({payButtonId:"goToPay",formId:"goBank"});
        })
    </script>
    <%

        String orderIds=request.getParameter("orderIds");

        List<OrderProxy> orderList=new ArrayList<OrderProxy>();
        OrderProxyService orderProxyService=new OrderProxyService();
        for(String orderId:orderIds.split(",")){
            orderList.add(orderProxyService.getOrderProxy(Integer.parseInt(orderId)));
        }

        double orderTotalAmount=0.0;
        for(OrderProxy orderProxy:orderList){
            orderTotalAmount= BigDecimalUtil.add(orderTotalAmount,orderProxy.getOrderTotalAmount());
        }
        request.setAttribute("orderTotalAmount",orderTotalAmount);
        request.setAttribute("orderList",orderList);
        request.setAttribute("orderSize",orderList.size());


    %>
</head>

<body>
<%--页头开始--%>
<%--<c:import url="/template/bdw/oldWap/module/common/head.jsp?title=收银台"/>--%>
<%--页头结束--%>

    <form action="${webRoot}/cashier/goBank.ac" method="post" id="goBank" onsubmit="return goToPay()">
        <input type="hidden" value="false" name="isUseAccount" id="isUseAccount"/>
        <input type="hidden" value="${orderTotalAmount}" id="totalAmount" name="totalAmount"/>
        <input type="hidden" value="${param.orderIds}" name="extraData"/>
        <input type="hidden" value="${param.payWayId}" name="payWayId" id="payWayId"/>
        <input type="hidden" value="wap" name="orderType"/>
        <input type="hidden" value="${param.type}" name="carttype"/>
     </form>

    <!--中间内容-->
    <div class="main m-checkout">

        <c:set value="0" var="allOrderAmount"/>

        <c:forEach items="${orderList}" var="order">
            <c:set value="${allOrderAmount + order.orderTotalAmount}" var="allOrderAmount"/>
        </c:forEach>

        <div class="tipMsg">
            <p style = "line-height:1.5;">支付成功之后，若订单状态超过30分钟尚未更新为"已支付"状态, 请拨打客服热线：<span style="color: red;font-weight: bold;">&nbsp;${sdk:getSysParamValue('webPhone')}</span>。
            </p>
        </div>
        <div class="tip payAmount">
            <p><b style="font-size: 14px;">实付金额</b>：<span><small>&yen;</small><i><fmt:formatNumber value="${allOrderAmount}" pattern="#0.0#"/></i></span></p>
        </div>
        <c:if test="${bdw:getPayWayByPaymentTypeCode(5).isEnable == 'Y'}">
            <c:if test="${sdk:getSysParamValue('prepaid_deposit')  eq 'Y' }">
                <div class="select-box preStore">
                    <span class="lab">账户余额：<small>&yen;</small><i><fmt:formatNumber value="${loginUser.prestore}" pattern="#00.0#"/></i></span>
                    <label class="switch">
                        <input class="hide" type="checkbox" id="usePreStore" value="N">
                        <span class="payStoreIcon icon"></span>
                    </label>
                </div>
            </c:if>
        </c:if>
        <div class="m-checkout-bd">
            <div class="entry-list">
                <h2 class="entry-list-title">在线支付</h2>
                <c:forEach items="${sdk:getMobilePayWayVo()}" var="payWay" varStatus="s">
                    <c:choose>
                        <c:when test="${param.type == 'integralWap'}">
                            <div class="entry-block">
                                <a href="${webRoot}/wap/shoppingcart/integralCashier.ac?integralOrderId=${param.orderIds}&payWayId=${payWay.payWayId}&&payWayNm=${payWay.payWayNm}">
                                    <span class="tit">${payWay.payWayNm}</span>
                                    <span></span>
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:if test="${payWay.payWayId != 38}">
                                <c:if test="${isWeixin=='N'}">
                                    <%-- wap端不要显示WXZF和给APP用的支付宝支付方式(30微信支付，35APP支付宝支付) --%>
                                    <c:if test="${payWay.payWayId != 30 && payWay.payWayId != 35}">
                                        <div class="entry-block" payWayId="${payWay.payWayId}">
                                            <a href="javascript:void(0);">
                                                <span class="img">
                                                    <img src="${webRoot}/template/bdw/oldWap/statics/images/pay-aipay.png" alt="">
                                                </span>
                                                <span class="tit">${payWay.payWayNm}</span>
                                                <span class="pay icon-hint"></span>
                                            </a>
                                        </div>
                                    </c:if>
                                </c:if>
                                <c:if test="${isWeixin=='Y'}">
                                    <%--当页面是在微信内被浏览的时候，支付时不要显示和支付宝有关的支付信息（32,35,37）--%>
                                    <c:if test="${payWay.payWayId != 32 && payWay.payWayId != 35 && payWay.payWayId != 37}">
                                        <div class="entry-block" payWayId="${payWay.payWayId}">
                                            <a href="javascript:void(0);">
                                                <span class="img">
                                                    <img src="${webRoot}/template/bdw/oldWap/statics/images/pay-wechat.png" alt="">
                                                </span>
                                                <span class="tit">${payWay.payWayNm}</span>
                                                <span class="icon-hint"></span>
                                            </a>
                                        </div>
                                    </c:if>
                                </c:if>
                            </c:if>
                            <%--<li class="col-xs-12"><a href="${webRoot}/wap/shoppingcart/cashier.ac?orderIds=${param.orderIds}&payWayId=${payWay.payWayId}&&payWayNm=${payWay.payWayNm}">${payWay.payWayNm}</a></li>--%>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </div>
        </div>

        <div class="m-checkout-ft" style="display:none">
            <button class="btn-block" type="button" id="goToPay">确认使用</button>
        </div>

    </div>
</body>

</html>




