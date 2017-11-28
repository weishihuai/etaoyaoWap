<%@ page import="com.iloosen.imall.commons.util.holder.SpringContextHolder" %>
<%@ page import="com.iloosen.imall.sdk.integral.proxy.IntegralOrderProxy" %>
<%@ page import="com.iloosen.imall.sdk.integral.service.IntegralOrderProxyService" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="userProxy"/>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}"};
    </script>
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
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/integralCashier.js"></script>
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

<c:set value="${sdk:getIntegralOrderProxyById(param.integralOrderId)}" var="integralOrderProxy" />
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
                    实付金额：<i>￥</i><span  class="orderTotalAmount"><fmt:formatNumber value="${orderTotalAmount}" pattern="#,##0.00#"/></span>
                </div>
                <div class="bot">
                    <%--<a href="##" class="pay">我要付款</a>--%>
                    <a href="${webRoot}/index.ac" class="back">返回首页</a>
                    <a href="${webRoot}/module/member/integralOrderList.ac" class="od-info">查看积分订单</a>
                </div>
            </div>
            <div class="m-bot">
                <div class="mb-lt">订单信息</div>
                <div class="mb-rt">
                    <p>收货人&nbsp;&nbsp;${integralOrderProxy.receiverName}</p>
                    <p>联系电话&nbsp;&nbsp;${integralOrderProxy.mobile}</p>
                    <p>收货地址&nbsp;&nbsp;${integralOrderProxy.address}</p>
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
                    <form action="${webRoot}/cashier/goBankIntegral.ac" method="post"  id="goBankIntegral" onsubmit="return submitGoBank()">
                        <input type="hidden" value="false" name="isUseAccount" id="isUseAccount"/>
                        <input type="hidden" value="${orderTotalAmount}" id="totalAmount" name="totalAmount"/>
                        <input type="hidden" value="${param.integralOrderId}" name="integralId"/>
                        <input type="hidden" value="${orderType}" name="orderType"/>
                        <input type="hidden" name="payWayId" id="payWayId"/>
                        <div class="rt-bot clearfix">
                            <ul class="payWay">
                                <c:forEach items="${sdk:getPayWayList()}" var="payWay" varStatus="s">
                                    <c:choose>
                                        <c:when test="${s.first && userProxy.prestore < orderTotalAmount}">
                                            <li class="item cur"  payWayId="${payWay.payWayId}" >
                                                <a href="javascript:" class="useBank" title="${payWay.payWayNm}">
                                                    <img src="${payWay.fileUrl}" alt="${payWay.payWayNm}" width="80px" height="80px"/></a>
                                            </li>
                                        </c:when>
                                        <c:otherwise>
                                            <li class="item" payWayId="${payWay.payWayId}" >
                                                <a href="javascript:" title="${payWay.payWayNm}">
                                                    <img src="${payWay.fileUrl}" alt="${payWay.payWayNm}" width="80px" height="80px"/></a>
                                            </li>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </ul>

                        </div>
                        <div class="clear"></div>
                    </form>
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
