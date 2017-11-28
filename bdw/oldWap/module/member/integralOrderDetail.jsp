<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%--<c:set value="${sdk:findOrderDetailed(param.id)}" var="orderProxy"/>&lt;%&ndash;查询订单详细&ndash;%&gt;--%>
<%--<c:set value="${sdk:getSysParamValue('webName')}" var="webName"/>&lt;%&ndash;网站名称&ndash;%&gt;--%>
<c:set value="${sdk:getIntegralOrderProxyById(param.id)}" var="orderProxy"/><%--查询订单详细--%>
<c:set value="${sdk:getSysParamValue('webName')}" var="webName"/><%--网站名称--%>


<%--<%@ taglib prefix="f" uri="/iMallTag" %>--%>
<!DOCTYPE HTML>
<html>
<head>
    <title>订单详情</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <!-- Bootstrap -->
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.min.css" rel="stylesheet">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/details.css" rel="stylesheet">
    <script type="text/javascript" language="javascript">
        var dataValue = {
            webRoot: "${webRoot}",
            orderId: "${param.id}",
            logisticsCompany: "${orderProxy.logisticsCompany}",
            logisticsNum: "${orderProxy.logisticsNum}",
            companyHomeUrl: "${orderProxy.companyHomeUrl}"
        }

    </script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
</head>
<body>
<%--页头开始--%>
<c:import url="/template/bdw/oldWap/module/common/head.jsp?title=订单详情"/>
<%--页头结束--%>

<div class="container container3" style="margin-top: 10px;">
<div class="row d_rows5">
    <div class="row">
        <div class="col-xs-4 rows5_left4">订单状态：</div>
        <div class="col-xs-8 rows5_right4">${orderProxy.orderStat}

        </div>
    </div>
    <div class="row">
        <div class="col-xs-4 rows5_left5">订单编号：</div>
        <div class="col-xs-8 rows5_right5">${orderProxy.orderNum}</div>
    </div>
    <div class="row">
        <div class="col-xs-4 rows5_left5">支付方式：</div>
        <div class="col-xs-8 rows5_right5">
            <c:choose>
                <c:when test="${orderProxy.paymentConvertTypeCode eq '0'}">
                    固定积分
                </c:when>
                <c:when test="${orderProxy.paymentConvertTypeCode eq '1'}">
                    部分积分+部分现金
                </c:when>
            </c:choose>
        </div>
    </div>
            <div class="row">
                <div class="col-xs-4 rows5_left5">商品积分：</div>
                <div class="col-xs-8 rows5_right5">
                    <c:choose>
                        <c:when test="${orderProxy.paymentConvertTypeCode eq '0'}">
                            <fmt:formatNumber value="${orderProxy.orderItemProxyList[0].totalIntegral}" type="number" pattern="######.##"/>分  X ${orderProxy.orderItemProxyList[0].num} 件
                        </c:when>
                        <c:when test="${orderProxy.paymentConvertTypeCode eq '1'}">
                            <fmt:formatNumber value="${orderProxy.orderItemProxyList[0].exchangeIntegral}" type="number" pattern="######.##"/>分 +
                            <fmt:formatNumber value="${orderProxy.orderItemProxyList[0].exchangeAmount}" type="number" pattern="######.##"/>元  X ${orderProxy.orderItemProxyList[0].num} 件
                        </c:when>
                    </c:choose>
                </div>
            </div>
        <%--</c:otherwise>--%>
    <%--</c:choose>--%>
    <div class="row">
        <div class="col-xs-4 rows5_left5">下单时间：</div>
        <div class="col-xs-8 rows5_right5"><fmt:formatDate value="${orderProxy.createDate}"
                                                           pattern="yyyy-MM-dd HH:mm:ss"/></div>
        <c:if test="${orderProxy.orderStat eq '未支付'}">
            <a href="${webRoot}/wap/shoppingcart/integralCashier.ac?integralOrderId=${orderProxy.integralOrderId}" style="" class="payButtom">订单支付</a>
            <a href="javascript:"onclick="cancelIntegralOrder(${orderProxy.integralOrderId})" style="" class="cancleButtom">取消</a>
        </c:if>
    </div>
    <div class="row">
        <%--   <c:if test="${not orderProxy.pay && orderProxy.orderStat != '已取消'}">
               <c:if test="${orderProxy.payment.payWayId != 1}">
               <c:choose>
                   <c:when test="${isWeixin == 'Y'}">
                       <c:if test="${orderProxy.payment.payWayId == 30}">
                       <div class="col-xs-12" style="padding:5px 10px;">
                           <a class="btn btn-danger btn-danger3 imall_pay" type="button" onclick="window.location.href='${webRoot}/wechat/vpay.ac?orderId=${orderProxy.orderId}&time='+(new Date()).toTimeString();">微信支付</a></div>
                       </c:if>
                       <c:if test="${orderProxy.payment.payWayId != 30}">
                         <div class="col-xs-12" style="padding:5px 10px;">
                             <a class="btn btn-danger btn-danger3" type="button" style="background:#EDEEEE; border:#EDEEEE 1px solid;color:#666666;">当前环境无法进行支付</a>
                         </div>
                       </c:if>
                   </c:when>
                   <c:otherwise>
                       <c:if test="${orderProxy.payment.payWayId != 30}">
                           <div class="col-xs-12" style="padding:5px 10px;"><a class="btn btn-danger btn-danger3 imall_pay"
                                                                               type="button">立即支付</a></div>
                           <c:if test="${!orderProxy.pay}">
                               <div style="display: none">
                                       ${orderProxy.payment.paymentHtml}
                               </div>
                           </c:if>
                       </c:if>
                       <c:if test="${orderProxy.payment.payWayId == 30}">
                           <div class="col-xs-12" style="padding:5px 10px;">
                               <a class="btn btn-danger btn-danger3" type="button" style="background:#EDEEEE; border:#EDEEEE 1px solid;color:#666666;">当前环境无法进行支付</a>
                           </div>
                       </c:if>
                   </c:otherwise>
               </c:choose>
               </c:if>
           </c:if>--%>

        <%--<c:if test="${not orderProxy.pay && orderProxy.orderStat != '已取消' &&!orderProxy.isCod}">--%>
            <%--<div class="col-xs-12" style="padding:5px 10px;">--%>
                <%--<a class="btn btn-danger btn-danger3"--%>
                   <%--type="button" href="${webRoot}/wap/shoppingcart/cashier.ac?orderIds=${orderProxy.orderId}">立即支付</a></div>--%>
        <%--</c:if>--%>

        <%--<c:if test="${orderProxy.orderStat != '已取消'&& orderProxy.orderStat=='待买家确认收货'}">
            <div class="col-xs-12" style="padding:5px 10px;"><a class="btn btn-danger btn-danger2" type="button"
                                                                href="${webRoot}/wap/module/member/queryLogistic.ac?orderId=${orderProxy.orderId}">查看物流</a>
            </div>
        </c:if>

        <c:if test="${orderProxy.orderStat=='未确认'}">
            <div class="col-xs-12" style="padding:5px 10px;"><a href="javascript:"
                                                                onclick="cancelOrder('${orderProxy.orderId}')"
                                                                class="btn btn-danger btn-danger4"
                                                                type="button">取消</a></div>
        </c:if>
        <c:if test="${orderProxy.orderStat=='待买家确认收货'}">
            <div class="col-xs-12" style="padding:5px 10px;"><a href="javascript:"
                                                                onclick="buyerSigned('${orderProxy.orderId}')"
                                                                class="btn btn-danger btn-danger4" type="button">确认收货</a>
            </div>
        </c:if>--%>
        <%--<div class="col-xs-4 rows5_left5">
            确认收货:
        </div>

        <div class="col-xs-8 rows5_right5">
            <c:if test="${orderProxy.isBuyerSigned=='N'&&orderProxy.orderStat=='已发货'}">
                <p ><a id="buyerSignedBtn" class="btn btn-xs btn-default" href="javascript:" onclick="buyerSigned('${orderProxy.integralOrderId}')">确认 </a></p>
                &lt;%&ndash;<script type="text/javascript">$(".infoItem3_detail").css("margin-top", "8px");</script>&ndash;%&gt;
            </c:if>
            <c:if test="${orderProxy.isPayed eq 'N' && orderProxy.orderStat eq '未支付'}">
                <p><a class="btn btn-xs" href="javascript:" onclick="goToPay('${orderProxy.integralOrderId}')">在线支付</a></p>
                &lt;%&ndash;<script type="text/javascript">$(".infoItem3_detail").css("margin-top", "8px");</script>&ndash;%&gt;
            </c:if>
        </div>--%>
    </div>
</div>
<div class="row">
    <div class="col-xs-12 box_bottom"></div>
</div>
<div class="row d_rows5">
    <%--<div class="row">--%>
        <%--<div class="col-xs-4 rows5_left4">支付方式：</div>--%>
        <%--<div class="col-xs-8 rows5_right4">${orderProxy.isCod?'货到付款':'在线支付'}</div>--%>
    <%--</div>--%>

    <%--<c:if test="${orderProxy.orderType!='积分兑换订单'}">--%>
        <div class="row">
            <div class="col-xs-4 rows5_left5">订单总计：</div>
            <div class="col-xs-8 rows5_right5">  <c:choose>
                <c:when test="${orderProxy.paymentConvertTypeCode eq '0'}">
                    <fmt:formatNumber value="${orderProxy.totalIntegral}" type="number" pattern="######.##"/>分
                </c:when>
                <c:when test="${orderProxy.paymentConvertTypeCode eq '1'}">
                    <fmt:formatNumber value="${orderProxy.totalExchangeIntegral}" type="number" pattern="######.##"/>分 +
                    <fmt:formatNumber value="${orderProxy.totalExchangeAmount}" type="number" pattern="######.##"/>元
                </c:when>
            </c:choose>
            </div>
        </div>
    <%--</c:if>--%>

    <%--<div class="row">--%>
        <%--<div class="col-xs-4 rows5_left5">订单运费：</div>--%>
        <%--<div class="col-xs-8 rows5_right5">￥</div>--%>
    <%--</div>--%>
<%--    <c:if test="${orderProxy.orderType!='积分兑换订单'}">
        <div class="row">
            <div class="col-xs-4 rows5_left5">促销优惠：</div>
            <div class="col-xs-8 rows5_right5"> &lt;%&ndash;获取订单优惠 start&ndash;%&gt;
                <c:forEach items="${orderProxy.orderDiscount}" var="favorable">
                    ${favorable}&nbsp;
                </c:forEach>
                    &lt;%&ndash;获取订单优惠 end&ndash;%&gt;</div>
        </div>
        &lt;%&ndash;        <div class="row">
                    <div class="col-xs-4 rows5_left7">应付金额：</div>
                    <div class="col-xs-8 rows5_right7">￥<fmt:formatNumber value="${orderProxy.unpaidAmount}" type="number"
                                                                          pattern="#0.00#"/></div>
                </div>&ndash;%&gt;
    </c:if>--%>
</div>
<div class="row">
    <div class="col-xs-12 box_bottom"></div>
</div>
<div class="row d_rows5">
    <div class="row">
        <div class="col-xs-4 rows5_left5">收货信息：</div>
        <div class="col-xs-8 rows5_right5">${orderProxy.receiverName}&nbsp;${orderProxy.mobile}&nbsp;${orderProxy.tel}&nbsp;</div>
    </div>
    <div class="row">
        <div class="col-xs-4 rows5_left5">收货地址：</div>
        <div class="col-xs-8 rows5_right5">${orderProxy.province}${orderProxy.address}</div>
    </div>
    <div class="row">
        <div class="col-xs-4 rows5_left7">配送方式：</div>
        <div class="col-xs-8 rows5_right7" style="color:#666; font-weight:normal;">${orderProxy.deliveryWay}</div>
    </div>
</div>
<div class="row">
    <div class="col-xs-12 box_bottom"></div>
</div>

<c:if test="${not empty orderProxy.remark}">
    <div class="row d_rows5">
        <div class="row">
            <div class="col-xs-4 rows5_left5">备注信息</div>
            <div class="col-xs-8 rows5_right5"></div>
        </div>
        <div class="row">
            <div class="col-xs-4 rows5_left7">${fn:substring(orderProxy.remark,0 ,150)}</div>
            <div class="col-xs-8 rows5_right7" style="color:#666; font-weight:normal;"></div>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12 box_bottom"></div>
    </div>
</c:if>
<div class="row d_rows5">
    <div class="row">
        <div class="col-xs-10 rows5_left5">购物清单</div>
        <div class="col-xs-2 rows5_right5">共 ${orderProxy.orderItemProxyList[0].num}&nbsp;件</div>
    </div>
    <c:forEach items="${orderProxy.orderItemProxyList}" var="orderItemProxy" varStatus="status">
        <div class="row">
            <div class="col-xs-3 rows5_left7"> 商品名称</div>
            <div class="col-xs-3 rows5_left7"> 商品积分</div>
            <div class="col-xs-3 rows5_left7"> 数量</div>
            <div class="col-xs-3 rows5_left7"> 总积分</div>
        </div>
        <div class="row">
            <div class="col-xs-3 rows5_left5">
                <a  href="${webRoot}/wap/integralDetails.ac?integralProductId=${orderItemProxy.integralProductId}">
                    <img src="${orderItemProxy.productImage["50X50"]}" width="40px" height="40px" alt="${orderItemProxy.integralProductNm}"/></a>
                <a  href="${webRoot}/wap/integralDetails.ac?integralProductId=${orderItemProxy.integralProductId}" title="${orderItemProxy.integralProductNm}">
                        ${sdk:cutString(orderItemProxy.integralProductNm, 30, "...")}</a>
            </div>
            <div class="col-xs-3 rows5_left5">
                <c:choose>
                    <c:when test="${orderProxy.paymentConvertTypeCode eq '0'}">
                        <fmt:formatNumber value="${orderProxy.orderItemProxyList[0].totalIntegral}" type="number" pattern="##"/>分  X ${orderProxy.orderItemProxyList[0].num} 件
                    </c:when>
                    <c:when test="${orderProxy.paymentConvertTypeCode eq '1'}">
                        <fmt:formatNumber value="${orderProxy.orderItemProxyList[0].exchangeIntegral}" type="number" pattern="######.##"/>分 +
                        <fmt:formatNumber value="${orderProxy.orderItemProxyList[0].exchangeAmount}" type="number" pattern="######.##"/>元
                    </c:when>
                </c:choose>
            </div>
            <div class="col-xs-3 rows5_left5"> ${orderItemProxy.num}</div>
            <div class="col-xs-3 rows5_left5">
                <c:choose>
                    <c:when test="${orderProxy.paymentConvertTypeCode eq '0'}">
                        <fmt:formatNumber value="${orderProxy.orderItemProxyList[0].totalIntegral}" type="number" pattern="##"/>分  X ${orderProxy.orderItemProxyList[0].num} 件
                    </c:when>
                    <c:when test="${orderProxy.paymentConvertTypeCode eq '1'}">
                        <fmt:formatNumber value="${orderProxy.orderItemProxyList[0].totalIntegral}" type="number" pattern="##"/>分 +
                        <fmt:formatNumber value="${orderProxy.totalExchangeAmount}" type="number" pattern="######.##"/>元
                    </c:when>
                </c:choose>
            </div>
        </div>
    </c:forEach>
</div>
<div class="row">
    <div class="col-xs-12 box_bottom"></div>
</div>
</div>

<%--页脚开始--%>
<c:import url="/template/bdw/oldWap/module/common/bottom.jsp"/>
<%--页脚结束--%>

<script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/myOrders.js"></script>
</body>
</html>