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
<%@ taglib prefix="f" uri="/iMallTag" %>
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
<c:set value="${empty param.title?'':param.title}" var="title"/>
<c:if test="${isWeixin!='Y'}">
    <div class="row" id="d_row1">
        <div class="col-xs-2">
            <a onclick="/*detailBack();*/history.go(-1);" href="javascript:void(0);" style="color:#FFF">
                <span class="glyphicon glyphicon-arrow-left"></span>
            </a>
        </div>
        <c:choose>
            <c:when test="${title=='product'}">
                <div class="col-xs-8">商品详情</div>
            </c:when>
            <c:otherwise>
                <div class="col-xs-8">${title}</div>
            </c:otherwise>
        </c:choose>
    </div>
</c:if>

<c:if test="${isWeixin=='Y'&&title=='商品列表'}">
    <div class="row" id="d_row1" style="height:1px;"></div>
</c:if>
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
    <c:choose>
        <c:when test="${orderProxy.orderType=='积分兑换订单'}">
            <div class="row">
                <div class="col-xs-4 rows5_left5">消耗积分：</div>
                <div class="col-xs-8 rows5_right5"><fmt:formatNumber value="${orderProxy.paidMoneyAmount}" type="number" pattern="#0.00#"/></div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="row">
                <div class="col-xs-4 rows5_left5">商品总金额：</div>
                <div class="col-xs-8 rows5_right5">¥<fmt:formatNumber value="${orderProxy.orderTotalAmount}" type="number" pattern="#0.00#"/></div>
            </div>
        </c:otherwise>
    </c:choose>
    <div class="row">
        <div class="col-xs-4 rows5_left5">下单时间：</div>
        <div class="col-xs-8 rows5_right5"><fmt:formatDate value="${orderProxy.createDate}"
                                                           pattern="yyyy-MM-dd HH:mm:ss"/></div>
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

        <c:if test="${not orderProxy.pay && orderProxy.orderStat != '已取消' &&!orderProxy.isCod}">
            <div class="col-xs-12" style="padding:5px 10px;">
                <a class="btn btn-danger btn-danger3" type="button" href="javascript:void(0);" onclick="confirmStatus('${orderProxy.orderId}');">立即支付</a></div>
        </c:if>

        <c:if test="${orderProxy.orderStat != '已取消'&& orderProxy.orderStat=='待买家确认收货'}">
            <div class="col-xs-12" style="padding:5px 10px;"><a class="btn btn-danger btn-danger2" type="button"
                                                                href="${webRoot}/wap/module/member/queryLogistic.ac?orderId=${orderProxy.orderId}">查看物流</a>
            </div>
        </c:if>

        <c:if test="${orderProxy.orderStat=='未确认' || (!orderProxy.isCod && orderProxy.pay && orderProxy.isPicking == 'N' && orderProxy.orderStat=='待发货')}">
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
    <div class="row">
        <div class="col-xs-4 rows5_left4">支付方式：</div>
        <div class="col-xs-8 rows5_right4">${orderProxy.isCod?'货到付款':'在线支付'}</div>
    </div>

    <c:if test="${orderProxy.orderType!='积分兑换订单'}">
        <div class="row">
            <div class="col-xs-4 rows5_left5">订单总价：</div>
            <div class="col-xs-8 rows5_right5">￥<fmt:formatNumber value="${orderProxy.orderTotalAmount}" type="number" pattern="#0.00#"/></div>
        </div>
    </c:if>

    <div class="row">
        <div class="col-xs-4 rows5_left5">订单运费：</div>
        <div class="col-xs-8 rows5_right5">￥<fmt:formatNumber value="${orderProxy.freightAmount}" type="number"
                                                              pattern="#0.00#"/></div>
    </div>
    <c:if test="${orderProxy.orderType!='积分兑换订单'}">
        <div class="row">
            <div class="col-xs-4 rows5_left5">促销优惠：</div>
            <div class="col-xs-8 rows5_right5"> <%--获取订单优惠 start--%>
                <c:forEach items="${orderProxy.orderDiscount}" var="favorable">
                    ${favorable}&nbsp;
                </c:forEach>
                    <%--获取订单优惠 end--%></div>
        </div>
        <%--        <div class="row">
                    <div class="col-xs-4 rows5_left7">应付金额：</div>
                    <div class="col-xs-8 rows5_right7">￥<fmt:formatNumber value="${orderProxy.unpaidAmount}" type="number"
                                                                          pattern="#0.00#"/></div>
                </div>--%>
    </c:if>
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
    <c:if test="${not empty orderProxy.logisticsNum}">
        <div class="row">
            <div class="col-xs-4 rows5_left7">物流单号：</div>
            <div class="col-xs-8 rows5_right7" style="color:#666; font-weight:normal;">${orderProxy.logisticsNum}</div>
        </div>
    </c:if>

</div>
<div class="row">
    <div class="col-xs-12 box_bottom"></div>
</div>

<c:if test="${orderProxy.orderType!='积分兑换订单'}">
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
</c:if>

<c:if test="${not empty orderProxy.remark}">
    <div class="row d_rows5">
        <div class="row">
            <div class="col-xs-4 rows5_left5">备注信息</div>
            <div class="col-xs-8 rows5_right5"></div>
        </div>
        <div class="row">
            <div class="col-xs-4 rows5_left7" style="width: auto">${fn:substring(orderProxy.remark,0 ,150)}</div>
            <div class="col-xs-8 rows5_right7" style="color:#666; font-weight:normal;width: auto"></div>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12 box_bottom"></div>
    </div>
</c:if>
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
                    <c:choose>
                        <c:when test="${orderProxy.orderType!='积分兑换订单'}">
                            <div class="rows5_price">￥<fmt:formatNumber value="${orderItemProxy.productUnitPrice}" type="number" pattern="#0.00#"/><i>x${orderItemProxy.num}</i>
                                <c:if test="${orderProxy.orderStat  eq '交易完成'}">
                                    <div class="goodsJudgement"><a href="${webRoot}/oldWap/module/member/goodJudgement.ac?id=${orderItemProxy.productId}&orderId=${orderProxy.orderId}">商品评价</a></div>
                                </c:if>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="rows5_price">￥<fmt:formatNumber value="${orderItemProxy.productUnitPrice}" type="number" pattern="#0.00#"/><i>x${orderItemProxy.num}</i>
                                <c:if test="${orderProxy.orderStat  eq '交易完成'}">
                                    <div class="goodsJudgement"><a href="${webRoot}/oldWap/module/member/goodJudgement.ac?id=${orderItemProxy.productId}&orderId=${orderProxy.orderId}">商品评价</a></div>
                                </c:if>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="col-xs-12">
                        <%--                        <c:if test="${orderProxy.orderStat!='待买家确认收货'}">
                                                    <a class="btn btn-primary btn-primary3" type="button" href="${webRoot}/wap/productComment.ac?id=${orderItemProxy.productProxy.productId}">发表评论</a>
                                                </c:if>--%>

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
                <div class="shopJudgement" ><a href="${webRoot}/oldWap/module/member/shopJudgement.ac?orderId=${orderProxy.orderId}">店铺评价</a></div>
            </div>
        </div>

        <div class="row">
            <div class="col-xs-12 box_bottom"></div>
        </div>
    </c:if>
</div>

<%--页脚开始--%>
<c:import url="/template/bdw/oldWap/module/common/bottom.jsp"/>
<%--页脚结束--%>

<script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/myOrders.js"></script>
</body>
</html>