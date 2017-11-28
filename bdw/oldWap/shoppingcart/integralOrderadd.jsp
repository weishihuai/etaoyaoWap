<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%--<c:set value="${sdk:getLoginUser()}" var="loginUser"/> &lt;%&ndash;获取当前用户&ndash;%&gt;--%>
<%--<c:set var="handler" value="${empty param.handler ? 'sku' : param.handler}"/>--%>
<c:set var="carttype" value="${empty param.carttype ? 'normal' : param.carttype}"/>
${sdk:saveOrderParam(carttype)}
<c:set value="${sdk:getUserCartListProxy(carttype)}" var="userCartListProxy"/>
<%--<c:set value="${empty param.isCod ? 'N' : param.isCod}" var="isCodStr" />--%>
<%--<c:set value="${isCodStr=='N' ? false :true}" var="isCod" />--%>
<%--获取当前用户--%>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<%--还未登录跳转跳转--%>
<c:if test="${empty loginUser}">
    <c:redirect url="/integralList.ac"></c:redirect>
</c:if>

<%--根据积分商品Id取出积分商品--%>
<c:set value="${sdk:getIntegralProduct(param.integralProductId)}" var="integralProduct"/>
<!--获取瑞环的数量-->
<c:set var="num" value="${param.num}"/>
<!--获取兑换类型-->
<c:set var="integralExchangeType" value="${param.integralExchangeType}"/>
<%--验证是否参数传入--%>
<c:if test="${empty param.integralProductId || empty param.num || empty param.integralExchangeType}">
    <c:redirect url="/integralList.ac"></c:redirect>
</c:if>
<!doctype html>
<html>
<head>
    <title>填写订单信息-${webName}</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <!-- Bootstrap -->
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.min.css" rel="stylesheet">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/header.css" rel="stylesheet">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/orderadd20160816.css" rel="stylesheet" media="screen">

    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery-1.7.1.min.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/common.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/integralOrderadd.js"></script>
    <script type="text/javascript">
        <%--var orderData = {isCod:${isCod},productTotal:${userCartListProxy.selectCartNum}};--%>
        var webPath = {
            webRoot: "${webRoot}",
            integralProductId: "${integralProduct.integralProductId}",
            num: "${num}",
            integralExchangeType: "${integralExchangeType}"
        };
    </script>
</head>
<body>
<%--页头开始--%>
<c:import url="/template/bdw/oldWap/module/common/head.jsp?title=积分商品订单"/>
<%--页头结束--%>

<%--选择地址 --%>
<div class="row addr">
    <div class="col-xs-12 selectAddr">
        <c:forEach items="${userCartListProxy.receiverAddrVoByUserId}" var="receiver" varStatus="status">
            <c:if test="${receiver.isDefault == 'Y'}">
                <c:set var="defaultReceiver" value="${receiver}"/>
                <input type="hidden" id="receiveAddrId" value="${receiver.receiveAddrId}">
            </c:if>
        </c:forEach>
        <c:choose>
            <c:when test="${empty defaultReceiver}">
                <input type="hidden" id="isReceiver" value="false">

                <div class="row">
                    <div class="col-xs-3 rows5_left5">收货地址：</div>
                    <div class="col-xs-8 rows5_right5">添加新地址</div>
                    <div class="col-xs-1"><span class="glyphicon glyphicon-chevron-right pull-right"
                                                style="margin-right:8px;"></span></div>
                </div>
            </c:when>
            <c:otherwise>
                <input type="hidden" id="isReceiver" value="true"/>

                <div class="row">
                    <div class="col-xs-3 rows5_left5">收货信息：</div>
                    <div class="col-xs-9 rows5_right5">${defaultReceiver.name}
                        &nbsp;${defaultReceiver.mobile}&nbsp;${defaultReceiver.tel}</div>
                </div>
                <div class="row">
                    <div class="col-xs-3 rows5_left5">收货地址：</div>
                    <div class="col-xs-8 rows5_right5" style="word-break: break-all;">${defaultReceiver.addressPath}&nbsp;${defaultReceiver.addr}</div>
                    <div class="col-xs-1"><span class="glyphicon glyphicon-chevron-right pull-right"
                                                style="margin-right:8px;"></span></div>
                </div>
            </c:otherwise>
        </c:choose>

        <c:choose>
            <c:when test="${integralProduct.exchangeIntegral * num <= loginUser.integral}">
                <input type="hidden" id="isIntegral" value="true"/>
            </c:when>
            <c:otherwise>
                <input type="hidden" id="isIntegral" value="false"/>
            </c:otherwise>
        </c:choose>

    </div>
</div>
<%--选择地址 --%>

<div class="row main">
    <div class="col-xs-12 pay-goods">
        <div class="row g-title shops" data-toggle="collapse">
            <div class="col-xs-11 t-left">
                        <span>商品名称：<i>${integralProduct.integralProductNm}</i>
                        </span>
            </div>
            <div class="col-xs-1">
                <span style="margin-right:22px;margin-top:18px;"
                      class="glyphicon glyphicon-chevron-down pull-right"></span>
                <span style="margin-right:22px;margin-top:18px;display:none;"
                      class="glyphicon glyphicon-chevron-up pull-right"></span>
            </div>
        </div>
        <div style="background: none repeat scroll 0% 0% rgb(220, 221, 221); height: auto;" class="in shop">
            <div class="row sy_rows"
                 style="border:#ddd 5px solid; padding:10px 15px; border-radius:10px; background:#fff;margin-top:0;">
                <div class="row g-main">
                    <div class="col-xs-12 gm-box <c:if test="${s.last}">no-bb</c:if>">
                        <div class="col-xs-5"><a href="#">
                            <img src="${integralProduct.icon["100X100"]}" width="100" height="100"/></a></div>
                        <div class="col-xs-7 box-right">
                            <div class="col-xs-6 gm-num">数量：${num}</div>
                            <div class="col-xs-12 gm-title" style="float:left;margin-top:5px;">单品：
                                <c:choose> <c:when test="${integralExchangeType eq '0'}">
                                    <fmt:formatNumber value="${integralProduct.integral}" type="number" pattern="#.##"/>分
                                </c:when>
                                    <c:otherwise>
                                        <fmt:formatNumber value="${integralProduct.exchangeIntegral}" type="number"
                                                          pattern="#.##"/>分+<fmt:formatNumber
                                            value="${integralProduct.exchangeAmount}" type="number" pattern="#.##"/>元
                                    </c:otherwise>
                                </c:choose>

                            </div>
                            <br/>
                            <div class="col-xs-12 gm-title" style="float:left;margin-top:5px;">支付方式：
                                <c:choose> <c:when test="${integralExchangeType eq 0}">
                                    固定积分
                                </c:when>
                                    <c:otherwise>
                                        积分+现金
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row g-bot">
                    <div class="row">
                        <!---结算中积分-->
                        <div class="col-xs-4 g-total" style="width:25%;"> 积分：<em>
                            <c:choose> <c:when test="${integralExchangeType eq 0}">
                                <fmt:formatNumber value="${integralProduct.integral * num}" type="number"
                                                  pattern="#.##"/>
                            </c:when>
                                <c:otherwise>
                                    <fmt:formatNumber value="${integralProduct.exchangeIntegral * num}" type="number"
                                                      pattern="#.##"/>
                                </c:otherwise>
                            </c:choose>
                        </em>分
                        </div>
                        <!---结算总现金-->
                        <div class="col-xs-3 g-total"  style="width:30%;">现金： <em>
                            <c:choose> <c:when test="${integralExchangeType eq 0}">
                                0.0
                            </c:when>
                                <c:otherwise>
                                    <fmt:formatNumber value="${integralProduct.exchangeAmount * num}" type="number"
                                                      pattern="#.##"/>
                                </c:otherwise>
                            </c:choose>
                        </em>元
                        </div>
                        <!---总计-->
                        <div class="col-xs-5 g-total"  style="width:45%;color:red;">合计：
                            <c:choose> <c:when test="${integralExchangeType eq 0}">
                                <fmt:formatNumber value="${integralProduct.integral * num}" type="number"
                                                  pattern="#.##"/>分
                            </c:when>
                                <c:otherwise>
                                    <fmt:formatNumber value="${integralProduct.exchangeIntegral * num}" type="number"
                                                      pattern="#.##"/>分+ <fmt:formatNumber
                                        value="${integralProduct.exchangeAmount * num}" type="number" pattern="#.##"/>元
                                </c:otherwise>
                            </c:choose>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="col-xs-12 submit">
        <img src="${webRoot}/template/bdw/oldWap/statics/images/wsc_byc_icon03.png" width="22" height="22"/>
        <em>实付款：<i id="allOrderTotalAmount">￥ <c:choose> <c:when test="${integralExchangeType eq 0}">
            0.0
        </c:when>
            <c:otherwise>
                <fmt:formatNumber value="${integralProduct.exchangeAmount * num}" type="number" pattern="#.##"/>
            </c:otherwise>
        </c:choose></i></em>
        <a href="javascript:" class="submitOrder" integralExchangeType="${integralExchangeType}" num="${num}"
           integralProductNum="${integralProduct.num}" integralProductId="${integralProduct.integralProductId}">提交订单</a>
    </div>
    <form id="orderForm" action="${webRoot}/cart/addOrder.ac" method="get">
        <input name="orderSourceCode" value="${isWeixin =='Y'?'3':'2'}" type="hidden"/>
        <input name="processStatCode" value="0" type="hidden"/>
        <input name="type" id="type" value="${carttype}" type="hidden"/>
        <input id="isNeedInvoice" name="invoice.isNeedInvoice" value="N" type="hidden"/>
        <input id="invoiceType" name="invoice.invoiceType" value="0" type="hidden"/>
        <input id="invoiceTitle" name="invoice.invoiceTitle" class="invoiceTitle" type="hidden"/>
        <input name="isCod" value="${empty param.isCod ?  'N' : param.isCod}" type="hidden"/>

    </form>
</div>

<c:choose>
    <c:when test="${empty loginUser.bytUserId}">
        <%--页脚开始1--%>
        <c:import url="/template/bdw/oldWap/module/common/bottom.jsp"/>
        <%--页脚结束--%>
    </c:when>
</c:choose>

</body>
</html>
