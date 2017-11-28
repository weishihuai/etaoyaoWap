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
    <meta content="yes" name="apple-mobile-web-app-capable" />
    <meta content="yes" name="apple-touch-fullscreen" />
    <meta content="telephone=no,email=no" name="format-detection" />
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
    <title>收银台</title>

    <link href="${webRoot}/template/bdw/oldWap/statics/css/baseForCashier.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/statics/css/cashier.css" type="text/css" rel="stylesheet" />

    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}",orderIds:"${param.orderIds}",payWayId:"${param.payWayId}"};
    </script>
    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/jqGrid/js/jquery-1.7.2.min.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/wapcart.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/cashier.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/baseForCashier.js"></script>
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

    <form action="${webRoot}/cashier/goBank.ac" method="post" id="goBank" onsubmit="return goToPay()">
        <input type="hidden" value="false" name="isUseAccount" id="isUseAccount"/>
        <input type="hidden" value="${orderTotalAmount}" id="totalAmount" name="totalAmount"/>
        <input type="hidden" value="${param.orderIds}" name="extraData"/>
        <input type="hidden" value="${param.payWayId}" name="payWayId" id="payWayId"/>
        <input type="hidden" value="wap" name="orderType"/>
        <input type="hidden" value="${param.type}" name="carttype"/>
    </form>

    <div class="main m-checkstand">

        <c:set value="0" var="allOrderAmount"/>

        <c:forEach items="${orderList}" var="order">
            <c:set value="${allOrderAmount + order.orderTotalAmount}" var="allOrderAmount"/>
        </c:forEach>

        <c:choose>
            <c:when test="${loginUser.prestore >= allOrderAmount}">
                <div id="prestoreEnough" style="display: none" result="Y"></div>
            </c:when>
            <c:otherwise>
                <div id="prestoreEnough" style="display: none" result="N"></div>
            </c:otherwise>
        </c:choose>

        <div class="tip">
            <p>支付成功后，若订单状态超过30分钟尚未更新为“已支 付”状态，请拨打客服热线：<a href="tel:${sdk:getSysParamValue('webPhone')}">${sdk:getSysParamValue('webPhone')}</a></p>
        </div>

        <ul class="horizontal-list">
            <%--<li>
                <span class="lab">订单编号</span>
                <span class="val">017011619555056698</span>
            </li>--%>
            <li>
                <span class="lab">订单金额</span>
                <span class="val stress"><small>&yen;</small><fmt:formatNumber value="${allOrderAmount}" pattern="#0.0#"/></span>
            </li>
        </ul>

        <%--<div class="balance">
            <span class="lab">账户余额:￥98.99</span>
            <label class="switch">
                <input type="checkbox" checked="">
                <span class="icon"></span>
            </label>
        </div>--%>

        <c:if test="${bdw:getPayWayByPaymentTypeCode(5).isEnable == 'Y'}">
            <c:if test="${sdk:getSysParamValue('prepaid_deposit')  eq 'Y' }">
                <div class="select-box preStore balance">
                    <span class="lab">账户余额：&yen;<fmt:formatNumber value="${loginUser.prestore}" pattern="#0.0#"/></span>
                    <label class="switch">
                        <input class="hide" type="checkbox" id="usePreStore" value="N">
                        <span class="payStoreIcon icon"></span>
                    </label>
                    <span class="lab useStorePay" style="float: right; margin-right: 1rem; display: none">
                        <c:choose>
                            <c:when test="${loginUser.prestore >= allOrderAmount}">
                                -&yen;${allOrderAmount}
                            </c:when>
                            <c:otherwise>
                                -&yen;${loginUser.prestore}
                            </c:otherwise>
                        </c:choose>
                    </span>
                </div>
            </c:if>
        </c:if>

        <%--<dl class="pay-list">
            <dt>选择支付方式</dt>
            <dd class="pay-item active">
                <img src="${webRoot}/template/bdw/oldWap/statics/images/wechat.png" alt="">
                <span>微信支付</span>
            </dd>
        </dl>--%>

        <dl class="pay-list">
            <dt>选择支付方式</dt>
            <c:forEach items="${sdk:getMobilePayWayVo()}" var="payWay" varStatus="s">
                <c:choose>
                    <c:when test="${param.type == 'integralWap'}">
                        <%--这里是遗留代码--%>
                    </c:when>
                    <c:otherwise>
                        <c:if test="${payWay.payWayId != 38}">
                            <c:if test="${isWeixin=='N'}">
                                <%-- wap端不要显示WXZF和给APP用的支付宝支付方式(30微信支付，35APP支付宝支付) --%>
                                <c:if test="${payWay.payWayId != 30 && payWay.payWayId != 35}">
                                    <%--<div class="entry-block" payWayId="${payWay.payWayId}">
                                        <a href="javascript:void(0);">
                                            <span class="img">
                                                <img src="${webRoot}/template/bdw/oldWap/statics/images/pay-aipay.png" alt="">
                                            </span>
                                            <span class="tit">${payWay.payWayNm}</span>
                                            <span class="pay icon-hint"></span>
                                        </a>
                                    </div>--%>
                                    <dd class="pay-item entry-block" payWayId="${payWay.payWayId}">
                                        <img src="${webRoot}/template/bdw/oldWap/statics/images/zhifubao.png" alt="">
                                        <span>${payWay.payWayNm}</span>
                                    </dd>
                                </c:if>
                            </c:if>
                            <c:if test="${isWeixin=='Y'}">
                                <%--当页面是在微信内被浏览的时候，支付时不要显示和支付宝有关的支付信息（32,35,37）--%>
                                <c:if test="${payWay.payWayId != 32 && payWay.payWayId != 35 && payWay.payWayId != 37}">
                                    <%--<div class="entry-block" payWayId="${payWay.payWayId}">
                                        <a href="javascript:void(0);">
                                                <span class="img">
                                                    <img src="${webRoot}/template/bdw/oldWap/statics/images/pay-wechat.png" alt="">
                                                </span>
                                            <span class="tit">${payWay.payWayNm}</span>
                                            <span class="icon-hint"></span>
                                        </a>
                                    </div>--%>
                                    <dd class="pay-item entry-block" payWayId="${payWay.payWayId}">
                                        <img src="${webRoot}/template/bdw/oldWap/statics/images/wechat.png" alt="">
                                        <span>${payWay.payWayNm}</span>
                                    </dd>
                                </c:if>
                            </c:if>
                        </c:if>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </dl>

        <%--<a class="btn-block" href="javascript:;">确认支付&ensp;<small>&yen;</small>639<small>.00</small></a>--%>
        <a class="<%--m-checkout-ft--%> btn-block" href="javascript:void(0);" id="goToPay">
            <%--<button class="btn-block" type="button" id="goToPay">确认使用</button>--%>
            确认支付&ensp;<small>&yen;</small><fmt:formatNumber value="${allOrderAmount}" pattern="#0.0#"/>
        </a>
    </div>


</body>

</html>
