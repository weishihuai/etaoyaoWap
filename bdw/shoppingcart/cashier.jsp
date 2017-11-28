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
<c:if test="${param.type=='drug'}">
    <c:redirect url="/shoppingcart/drugCashier.ac?type=${param.type}&orderIds=${param.orderIds}"></c:redirect>
</c:if>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>收银台-${webName}</title>
    <link href="${webRoot}/template/bdw/statics/css/base.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/sp-header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/order-item.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/buyCar.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/statics/js/jquery-ui-1.8.13/css/redmond/jquery-ui-1.8.13.custom.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/cashier.js"></script>
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
<c:set value="${bdw:getUserReceiveAddr(param.orderIds)}" var="userDefaultReceiveAddr" />
<body  style="background:url('${webRoot}/template/bdw/statics/images/header_line_top.gif') repeat-x scroll 0 0 #FFFFFF">
<%--页头开始--%>
<c:import url="/template/bdw/shoppingcart/cashierTop.jsp"/>
<%--页头结束--%>

<div class="main-bg">>
    <div class="main">
        <div class="mt">
            <div class="suc-icon"></div>
            <div class="m-top">
                <h5>订单已提交，请尽快完成支付</h5>
                <%--<p>请在逾期时间内付款，否则订单将被取消</p>--%>
                <div class="price">
                    待支付金额：<i>￥</i><span  class="orderTotalAmount"><fmt:formatNumber value="${orderTotalAmount}" pattern="#,##0.00#"/></span>
                </div>
                <div class="bot">
                    <%--<a href="##" class="pay">我要付款</a>--%>
                    <a href="${webRoot}/index.ac" class="back">返回首页</a>
                    <a href="${webRoot}/module/member/index.ac" class="od-info">查看订单</a>
                </div>
            </div>
            <div class="m-bot">
                <div class="mb-lt">订单信息</div>
                <div class="mb-rt">
                    <p>收货人&nbsp;&nbsp;${userDefaultReceiveAddr.name}</p>
                    <p>联系电话&nbsp;&nbsp;${userDefaultReceiveAddr.mobile}</p>
                    <p>收货地址&nbsp;&nbsp;${userDefaultReceiveAddr.addressPath}${userDefaultReceiveAddr.addressStr}</p>
                </div>
            </div>
        </div>
        <div class="mc">
            <div class="prepay">
                <div class="pre-lt"><span id="usePrestore" class="selected">预存款</span></div>
                <div class="pre-rt">
                    <p><span class="userAmount"><fmt:formatNumber value="${userProxy.prestore}" pattern="#,##0.00#"/></span> 元  余额</p>
                    <%--<p class="tip">使用账号余额支付0.00元。剩下<span><fmt:formatNumber value="${orderTotalAmount}" pattern="#,##0.00#"/></span>可以选择其他方式付款</p>--%>
                    <c:choose>
                        <c:when test="${userProxy.prestore > orderTotalAmount}">
                            <p class="tip">使用账号余额支付<fmt:formatNumber value="${orderTotalAmount}" pattern="#,##0.00#"/>元。剩下<span>0.00</span>可以选择其他方式付款</p>
                        </c:when>
                        <c:otherwise>
                            <p class="tip">使用账号余额支付<fmt:formatNumber value="${userProxy.prestore}" pattern="#,##0.00#"/>元。剩下<span><fmt:formatNumber value="${orderTotalAmount - userProxy.prestore}" pattern="#,##0.00#"/></span>可以选择其他方式付款</p>
                        </c:otherwise>
                    </c:choose>

                </div>
            </div>
            <div class="terrace">
                <div class="ter-lt">
                    <c:choose>
                        <c:when test="${userProxy.prestore > orderTotalAmount}">
                            <span>支付平台</span>
                        </c:when>
                        <c:otherwise>
                            <span class="selected" >支付平台</span>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="ter-rt">
                    <div class="rt-top">
                        <span>请选择您的支付网关</span>
                        <c:choose>
                            <c:when test="${userProxy.prestore > orderTotalAmount}">
                                <i>需支付：<em id="otherPayWay">0.00</em> 元</i>
                            </c:when>
                            <c:otherwise>
                                <i>需支付：<em id="otherPayWay"><fmt:formatNumber value="${orderTotalAmount - userProxy.prestore}" pattern="#,##0.00#"/></em> 元</i>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <form action="${webRoot}/cashier/goBank.ac" method="post"  id="goBank" onsubmit="return submitGoBank()" style="margin-bottom: 20px;">
                        <input type="hidden" value="false" name="isUseAccount" id="isUseAccount"/>
                        <input type="hidden" value="${orderTotalAmount}" id="totalAmount" name="totalAmount"/>
                        <input type="hidden" value="${param.orderIds}" name="extraData"/>
                        <input type="hidden" value="${orderType}" name="orderType"/>
                        <input type="hidden" name="payWayId" id="payWayId"/>
                        <div class="rt-bot clearfix">
                            <ul class="payWay">
                                <c:forEach items="${sdk:getPayWayList()}" var="payWay" varStatus="s">
                                    <c:choose>
                                        <c:when test="${s.first && userProxy.prestore < orderTotalAmount}">
                                            <li class="item cur"  payWayId="${payWay.payWayId}" >
                                                <a href="javascript:" class="useBank" title="${payWay.payWayNm}">
                                                    <img src="${payWay.fileUrl}" alt="${payWay.payWayNm}"/></a>
                                            </li>
                                        </c:when>
                                        <c:otherwise>
                                            <li class="item" payWayId="${payWay.payWayId}" >
                                                <a href="javascript:" title="${payWay.payWayNm}">
                                                    <img src="${payWay.fileUrl}" alt="${payWay.payWayNm}"/></a>
                                            </li>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </ul>
                        </div>
                    </form>
                </div>
            </div>

            <c:set var="zjPayWayList" value="${sdk:getZjPayWayList()}"/>
            <div class="pay-box" style="display:${empty zjPayWayList?'none':'block'}">
                <div class="pay-item">
                    <a class="radio" href="javascript:;"></a>
                    <h3>其他方式</h3>
                    <div class="cont">
                        <p class="cont-t">请选择第三方支付平台<span class="pay-count fr">需支付：<em><fmt:formatNumber value="${orderTotalAmount - userProxy.prestore}" pattern="#,##0.00#"/></em>&nbsp;元</span></p>
                        <div class="bank-list clearfix">
                            <c:forEach var="zjPay" items="${zjPayWayList}">
                                <a class="scanClass bank-item <%--selected--%>" href="javascript:;" paymentTypeCode="${zjPay.paymentTypeCode}" payWayId="${zjPay.payWayId}" onclick="selectScanPay(this)">
                                    <img src="${zjPay.fileUrl}" alt="">
                                </a>
                            </c:forEach>
                        </div>
                        <div class="pic-box" id="scanDiv" style="display:none;">
                            <div class="box-lt">
                                <p>距离二维码过期还剩10分钟，过期后请刷新页面重新获取二维码。</p>
                                <div class="pic"><img id="scanImg" src="" alt="" width="240" height="240"></div>
                                <span id="scanImgText">请使用微信扫一扫</span>
                            </div>
                            <div class="box-rt"><img id="scanExampleImg" src="" alt=""></div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="mc-bot" id="goToPay"><a href="javascript:" class="goToPay" payWayId="">立即付款</a></div>
        </div>
    </div>
</div>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页头结束--%>
</body>
</html>
