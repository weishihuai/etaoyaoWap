<%--
  Created by IntelliJ IDEA.
  User: liuray
  Date: 13-11-26
  Time: 上午10:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:findOrderDetailed(param.id)}" var="orderProxy"/><%--查询订单详细--%>
<c:set value="${sdk:getSysParamValue('webName')}" var="webName"/><%--网站名称--%>
<c:set value="${sdk:getSysParamValue('auditGroupBuy')}" var="auditGroupBuy"/><%--团购审核参数--%>
<%
    StringBuffer url = request.getRequestURL();
    String tempContextUrl = url.delete(url.length() - request.getRequestURI().length(), url.length()).append("/").toString();
    request.setAttribute("tempContextUrl", tempContextUrl);
%>
<%@ taglib prefix="f" uri="/iMallTag" %>
<!DOCTYPE HTML>
<html>
<head>
    <title>订单详情</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <!-- Bootstrap -->
    <script type="text/javascript">var webPath = {webRoot: "${tempContextUrl}", orderId: "${param.orderId}"};</script>
    <link href="${webRoot}/template/bdw/wap/statics/css/bootstrap.min.css" rel="stylesheet">
    <link href="${webRoot}/template/bdw/wap/statics/css/footer.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/details.css" rel="stylesheet">
    <script type="text/javascript" language="javascript">

        var dataValue = {
            webRoot: "${webRoot}",
            orderId: "${param.id}",
            logisticsCompany: "${orderProxy.logisticsCompany}",
            logisticsNum: "${orderProxy.logisticsNum}",
            companyHomeUrl: "${orderProxy.companyHomeUrl}"
        }

    </script>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery.js"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/bootstrap.min.js"></script>
</head>
<body>
<%--页头开始--%>
<c:import url="/template/bdw/wap/module/common/head.jsp?title=订单详情"/>
<%--页头结束--%>
<div class="container container3" style="margin-top: 10px;">
    <div class="row d_rows5">
        <div class="row">
            <div class="col-xs-4 rows5_left4">订单状态：</div>
            <div class="col-xs-8 rows5_right4">${orderProxy.orderStat}</div>
        </div>
        <div class="row">
            <div class="col-xs-4 rows5_left5">订单编号：</div>
            <div class="col-xs-8 rows5_right5">${orderProxy.orderNum}</div>
        </div>
        <div class="row">
            <div class="col-xs-4 rows5_left5">订单金额：</div>
            <div class="col-xs-8 rows5_right5">¥<fmt:formatNumber value="${orderProxy.orderTotalAmount}" type="number"
                                                                  pattern="#0.00#"/></div>
        </div>
        <div class="row">
            <div class="col-xs-4 rows5_left5">下单时间：</div>
            <div class="col-xs-8 rows5_right5"><fmt:formatDate value="${orderProxy.createDate}"
                                                               pattern="yyyy-MM-dd HH:mm:ss"/></div>
        </div>
        <div class="row">

            <c:if test="${not orderProxy.pay && orderProxy.orderStat != '已取消' &&!orderProxy.isCod}">
                <div class="col-xs-12" style="padding:5px 10px;">
                    <a class="btn btn-danger btn-danger3"
                       type="button" href="${webRoot}/wap/shoppingcart/cashier.ac?orderIds=${orderProxy.orderId}">立即支付</a></div>
            </c:if>

            <c:if test="${orderProxy.orderStat != '已取消'&& orderProxy.orderStat=='待买家确认收货'}">
                <div class="col-xs-12" style="padding:5px 10px;">
                    <a class="btn btn-danger btn-danger2" type="button" href="${webRoot}/wap/module/member/queryLogistic.ac?orderId=${orderProxy.orderId}">查看物流</a>
                </div>
            </c:if>

            <c:if test="${orderProxy.orderStat=='未确认'|| (!orderProxy.isCod && orderProxy.pay && orderProxy.isPicking == 'N' && orderProxy.orderStat=='待发货')}">
                <div class="col-xs-12" style="padding:5px 10px;"><a href="javascript:;"
                                                                    onclick="cancelOrder('${orderProxy.orderId}')"
                                                                    class="btn btn-danger btn-danger4"
                                                                    type="button">取消</a></div>
            </c:if>
            <c:if test="${orderProxy.orderStat=='待买家确认收货'}">
                <div class="col-xs-12" style="padding:5px 10px;"><a href="javascript:;"
                                                                    onclick="buyerSigned('${orderProxy.orderId}')"
                                                                    class="btn btn-danger btn-danger4" type="button">确认收货</a>
                </div>
            </c:if>
            <c:if test="${orderProxy.orderStat=='已取消'}">
                <c:if test="${orderProxy.orderItemProxyList[0].productProxy.isCanBuy}">
                    <div class="col-xs-12" style="padding:5px 10px;"><a href="${webRoot}/wap/product.ac?id=${orderProxy.orderItemProxyList[0].productProxy.productId}"
                                                                        class="btn btn-danger btn-danger4" type="button">重新购买</a>
                    </div>
                </c:if>
            </c:if>
        </div>

    </div>
    <div class="row">
        <div class="col-xs-12 box_bottom"></div>
    </div>
    <div class="row d_rows5">
        <%--<div class="row">--%>
        <%--<div class="col-xs-4 rows5_left4">支付方式：</div>--%>
        <%--<div class="col-xs-8 rows5_right4">${orderProxy.payment.payWayNm}</div>--%>
        <%--</div>--%>
        <div class="row">
            <div class="col-xs-4 rows5_left5">商品总价：</div>
            <div class="col-xs-8 rows5_right5">￥<fmt:formatNumber value="${orderProxy.productTotalAmount}" type="number"
                                                                  pattern="#0.00#"/></div>
        </div>
        <div class="row">
            <div class="col-xs-4 rows5_left5">订单运费：</div>
            <div class="col-xs-8 rows5_right5">￥<fmt:formatNumber value="${orderProxy.freightAmount}" type="number"
                                                                  pattern="#0.00#"/></div>
        </div>
        <div class="row">
            <div class="col-xs-4 rows5_left5">促销优惠：</div>
            <div class="col-xs-8 rows5_right5"> <%--获取订单优惠 start--%>
                <c:forEach items="${orderProxy.orderDiscount}" var="favorable">
                    ${favorable}&nbsp;
                </c:forEach>
                <%--获取订单优惠 end--%></div>
        </div>
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
    <div class="row d_rows5">
        <div class="row">
            <div class="col-xs-4 rows5_left5">发票信息</div>
            <div class="col-xs-8 rows5_right5"></div>
        </div>
        <div class="row">
            <div class="col-xs-4 rows5_left7">发票抬头</div>
            <div class="col-xs-8 rows5_right7"
                 style="color:#666; font-weight:normal;">${orderProxy.invoiceType}
                <c:if test="${not empty fn:substring(orderProxy.invoiceTitle,0 ,50)}">
                    (${fn:substring(orderProxy.invoiceTitle,0 ,50)})
                </c:if>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12 box_bottom"></div>
    </div>
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
    <div class="row d_rows5">
        <div class="row">
            <div class="col-xs-10 rows5_left5">购物清单</div>
            <div class="col-xs-2 rows5_right5">共 ${fn:length(orderProxy.orderItemProxyList)}件</div>
        </div>
        <c:forEach items="${orderProxy.orderItemProxyList}" var="orderItemProxy" varStatus="status">
            <div class="row" style=" border-bottom: #ddd 1px dashed;">

                <div class="col-xs-3 rows5_left2">
                    <c:choose>
                        <c:when test="${not empty orderProxy.sysShopInf.shopType && orderProxy.sysShopInf.shopType == '2'}">
                            <a href="${webRoot}/wap/citySend/product.ac?productId=${orderItemProxy.productProxy.productId}">
                                <img src="${orderItemProxy.productProxy.defaultImage["50X50"]}" width="60px;" height="60px;"
                                     alt="${orderItemProxy.productProxy.name}"/></a>
                        </c:when>
                        <c:otherwise>
                            <a href="${webRoot}/wap/product.ac?id=${orderItemProxy.productProxy.productId}">
                                <img src="${orderItemProxy.productProxy.defaultImage["50X50"]}" width="60px;" height="60px;"
                                     alt="${orderItemProxy.productProxy.name}"/></a>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="col-xs-9 rows5_right2">
                    <div class="rows5_title2">
                        <c:choose>
                            <c:when test="${not empty orderProxy.sysShopInf.shopType && orderProxy.sysShopInf.shopType == '2'}">
                                <a href="${webRoot}/wap/citySend/product.ac?productId=${orderItemProxy.productProxy.productId}">${orderItemProxy.productProxy.name}</a>
                            </c:when>
                            <c:otherwise>
                                <a href="${webRoot}/wap/product.ac?id=${orderItemProxy.productProxy.productId}">${orderItemProxy.productProxy.name}</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="col-xs-12">
                        <div class="rows5_title3">${orderItemProxy.productSpecNm}</div>
                    </div>
                    <div class="col-xs-12">
                        <div class="rows5_price">￥<fmt:formatNumber value="${orderItemProxy.productUnitPrice}"
                                                                    type="number"
                                                                    pattern="#0.00#"/><i>x${orderItemProxy.num}</i>
                        </div>
                    </div>
                    <div class="col-xs-12">
                        <c:if test="${orderProxy.orderRatingStat=='买家未评'}">
                            <a class="btn btn-primary btn-primary3" type="button" href="${webRoot}/wap/productComment.ac?id=${orderItemProxy.productProxy.productId}">发表评论</a>
                        </c:if>

                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
    <div class="row">
        <div class="col-xs-12 box_bottom"></div>
    </div>
    <c:if test="${orderProxy.orderStat  eq '交易完成'}">
        <div class="row d_rows5">
            <div class="row">
                <div class="shopJudgement" ><a href="${webRoot}/wap/shopJudgement.ac?orderId=${orderProxy.orderId}">店铺评价</a></div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12 box_bottom"></div>
        </div>
    </c:if>
</div>

<%--页脚开始--%>
<c:import url="/template/bdw/wap/module/common/bottom.jsp"/>
<%--页脚结束--%>
<script type="text/javascript" src="${webRoot}/template/bdw/wap/statics/js/myOrders.js"></script>
</body>
</html>
