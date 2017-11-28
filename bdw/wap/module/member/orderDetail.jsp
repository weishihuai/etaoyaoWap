<%@ page import="com.iloosen.imall.module.order.domain.code.ProcessStatCodeEnum" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="f" uri="/iMallTag" %>
<c:set var="payEndTimeStr" value="${bdw:getPayEndTimeStr(param.id)}"/>
<c:set value="${sdk:findOrderDetailed(param.id)}" var="orderProxy"/><%--查询订单详细--%>
<%@ include file="/template/bdw/wap/fastShow.jsp" %>

<!--订单状态-->
<%
    request.setAttribute("toConfirm", ProcessStatCodeEnum.TO_CONFIRM.toCode());                  //待确认
    request.setAttribute("confirmed", ProcessStatCodeEnum.CONFIRMED.toCode());                   //已确认
    request.setAttribute("sent", ProcessStatCodeEnum.SENT.toCode());                              //已送货
    request.setAttribute("canceled", ProcessStatCodeEnum.CANCELED.toCode());                     //已取消
    request.setAttribute("rejection", ProcessStatCodeEnum.REJECTION.toCode());                  //拒收
%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="utf-8">
    <title>普通订单详情-${webName}</title>
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="telephone=no,email=no" name="format-detection">

    <link href="${webRoot}/template/bdw/wap/statics/css/swiper.min.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/order-detail.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/order.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/fastShow.css" type="text/css" rel="stylesheet" />

    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-2.1.4.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/fastShow.js"></script>

    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}", logisticsCompany: "${orderProxy.logisticsCompany}",logisticsNum:"${orderProxy.logisticsNum}",companyHomeUrl: "${orderProxy.companyHomeUrl}", orderId:"${orderProxy.orderId}"};
    </script>
    <script src="${webRoot}/template/bdw/wap/statics/js/orderDetail.js" type="text/javascript"></script>
</head>

<body>
<c:set value="N" var="isDrug"/>
<c:set value="" var="orderStatusNm"/>
<c:set value="N" var="groupBuyOrder"/>
<c:choose>
    <%-------------------待 付 款----------------%>
    <c:when test="${ (orderProxy.processStatCode == toConfirm && orderProxy.pay == false && orderProxy.isCod == false ) ||  (orderProxy.processStatCode == confirmed && orderProxy.pay == false && orderProxy.isCod == false)}">
        <c:set value="待付款" var="orderStatusNm"/>
    </c:when>
    <%------------------待 确 认----------------%>
    <c:when test="${orderProxy.processStatCode == toConfirm && orderProxy.isCod == true}">
        <c:set value="待确认" var="orderStatusNm"/>
    </c:when>
    <%------------------待 发 货----------------%>
    <c:when test="${orderProxy.processStatCode == confirmed}">
        <c:set value="待发货" var="orderStatusNm"/>
    </c:when>
    <%------------------待 收 货----------------%>
    <c:when test="${ (orderProxy.processStatCode == sent && orderProxy.isBuyerSigned != true) }">
        <c:set value="待收货" var="orderStatusNm"/>
    </c:when>
    <%----------------待 评 价----------------%>
    <c:when test="${ (orderProxy.processStatCode == sent && orderProxy.isBuyerSigned == true && orderProxy.isComment =='Y')}">
        <c:set value="待评价" var="orderStatusNm"/>
    </c:when>
    <%----------------已 完 成----------------%>
    <c:when test="${ (orderProxy.processStatCode == sent && orderProxy.isBuyerSigned == true &&  (orderProxy.isComment =='N' || orderProxy.isComment =='Y'))}">
        <c:set value="已完成" var="orderStatusNm"/>
    </c:when>
    <%----------------已 取 消----------------%>
    <c:when test="${ orderProxy.processStatCode == canceled }">
        <c:set value="已取消" var="orderStatusNm"/>
    </c:when>
    <%----------------已 取 消----------------%>
    <c:when test="${ orderProxy.processStatCode == rejection }">
        <c:set value="已拒收" var="orderStatusNm"/>
    </c:when>
</c:choose>

<div class="order-d-main">
    <div class="zhifu-time-box">
        <c:choose>
            <c:when test="${orderStatusNm == '待付款'}">
                <div class="zhifu-time-inner">
                    <p class="title">${orderStatusNm}</p>
                    <p class="zhifu-time" id="countDown" lastPayTime="${payEndTimeStr}">请在<span>${payEndTimeStr}</span>内完成支付<br>超时订单自动取消
                    </p>
                </div>
                <em class="icon1"></em>
            </c:when>
            <c:when test="${orderStatusNm == '待确认'}">
                <div class="zhifu-time-inner">
                    <p class="title">${orderStatusNm}</p>
                    <p class="zhifu-time">商家审核预定申请中，请耐心等候</p>
                </div>
                <em class="icon7"></em>
            </c:when>
            <c:when test="${orderStatusNm == '待发货'}">
                <div class="zhifu-time-inner">
                    <p class="title">${orderStatusNm}</p>
                    <p class="zhifu-time">商家备货中，请耐心等候</p>
                </div>
                <em class="icon2"></em>
            </c:when>
            <c:when test="${orderStatusNm == '待收货'}">
                <div class="zhifu-time-inner">
                    <p class="title">${orderStatusNm}</p>
                    <p class="zhifu-time">包裹正向你飞奔过去~</p>
                </div>
                <em class="icon3"></em>
            </c:when>
            <c:when test="${orderStatusNm == '已完成'}">
                <div class="zhifu-time-inner">
                    <p class="title">${orderStatusNm}</p>
                    <p class="zhifu-time">交易已完成~<br>感谢亲您对我们的支持！</p>
                </div>
                <em class="icon4"></em>
            </c:when>
            <c:when test="${orderStatusNm == '待评价'}">
                <div class="zhifu-time-inner">
                    <p class="title">${orderStatusNm}</p>
                    <p class="zhifu-time">评价商品送积分~</p>
                </div>
                <em class="icon5"></em>
            </c:when>
            <c:when test="${orderStatusNm == '已取消'}">
                <div class="zhifu-time-inner">
                    <p class="title">${orderStatusNm}</p>
                    <p class="zhifu-time">您的订单取消成功</p>
                </div>
                <em class="icon6"></em>
            </c:when>
            <c:when test="${orderStatusNm == '已拒收'}">
                <div class="zhifu-time-inner">
                    <p class="title">${orderStatusNm}</p>
                    <p class="zhifu-time">您的订单已拒收</p>
                </div>
                <em class="icon6"></em>
            </c:when>
        </c:choose>
    </div>
    <c:set value="${sdk:getShopInfProxyById(orderProxy.sysShopInf.shopInfId)}" var="shopInf"/>
    <c:set value="${shopInf.shopType eq '2'}" var="isOutlet"/>
    <c:if test="${!isOutlet}">
        <div class="kuaidi-info" onclick="window.location.href='${webRoot}/wap/module/member/logisticsDetail.ac?id=${orderProxy.orderId}'"></div>
    </c:if>
    <c:choose>
        <c:when test="${isOutlet}">
            <c:set var="prdUrl" value="${webRoot}/wap/outlettemplate/default/product.ac?id=${orderProxy.orderItemProxyList[0].productId}"/>
            <c:set var="shopUrl" value="${webRoot}/wap/outlettemplate/default/outletIndex.ac?shopId=${shopInf.shopInfId}"/>
        </c:when>
        <c:otherwise>
            <c:set var="prdUrl" value="${webRoot}/wap/product.ac?id=${orderProxy.orderItemProxyList[0].productId}"/>
            <c:set var="shopUrl" value="${webRoot}/wap/shop/shopIndex.ac?shopId=${shopInf.shopInfId}"/>
        </c:otherwise>
    </c:choose>
    <div class="sp-dd">
        <c:set value="" var="phoneNum"/>
        <c:choose>
            <c:when test="${!empty shopInf.tel}">
                <c:set value="${shopInf.tel}" var="phoneNum"/>
            </c:when>
            <c:when test="${!empty shopInf.mobile}">
                <c:set value="${shopInf.mobile}" var="phoneNum"/>
            </c:when>
            <c:when test="${!empty shopInf.ceoMobile}">
                <c:set value="${shopInf.ceoMobile}" var="phoneNum"/>
            </c:when>
        </c:choose>
        <p class="dd-head"><a class="shop-name" href="${shopUrl}">${shopInf.shopNm}</a><a class="contact-merchant" href="tel:${phoneNum}">联系商家</a></p>
        <c:forEach items="${orderProxy.orderItemProxyList}" var="orderItemProxy">
            <c:if test="${orderItemProxy.promotionType ne '赠品商品'}">
                <c:choose>
                    <c:when test="${isOutlet}">
                        <c:set var="prdUrl" value="${webRoot}/wap/outlettemplate/default/product.ac?id=${orderItemProxy.productId}"/>
                    </c:when>
                    <c:otherwise>
                        <c:set var="prdUrl" value="${webRoot}/wap/product.ac?id=${orderItemProxy.productId}"/>
                    </c:otherwise>
                </c:choose>
                <div class="dd-item">
                    <c:choose>
                        <c:when test="${orderItemProxy.promotionType eq '团购商品'}">
                            <c:set value="${sdk:findGroupBuyProxy(orderItemProxy.groupBuyId)}" var="groupBuyItem"/>
                            <a class="pic" href="${webRoot}/wap/tuanDetail.ac?id=${groupBuyItem.groupBuyId}"><img src="${groupBuyItem.pic["150X150"]}" alt=""></a>
                            <a class="name" href="${webRoot}/wap/tuanDetail.ac?id=${groupBuyItem.groupBuyId}">${groupBuyItem.title}</a>
                            <c:set value="Y" var="groupBuyOrder"/>
                        </c:when>
                        <c:otherwise>
                            <a class="pic" href="${prdUrl}"><img src="${orderItemProxy.productProxy.defaultImage["150X150"]}" alt=""></a>
                            <a class="name" href="${prdUrl}">${orderItemProxy.productProxy.name}</a>
                        </c:otherwise>
                    </c:choose>
                    <p><span class="price">￥<fmt:formatNumber value="${orderItemProxy.productUnitPrice}" type="number" pattern="#0.00#" /></span><span class="number">x${orderItemProxy.num}</span></p>
                    <c:if test="${orderProxy.pay == true and (orderStatusNm == '待评价' or orderStatusNm == '已完成') and (orderItemProxy.isCanExchange or orderItemProxy.isCanReturn) and orderItemProxy.promotionType ne '团购商品'}">
                        <a class="after-sales" href="${webRoot}/wap/module/member/choseAfterSalesService.ac?id=${orderItemProxy.orderItemId}">申请售后</a>
                    </c:if>
                </div>
                <c:if test="${orderItemProxy.promotionType eq '预定药品'}">
                    <c:set value="Y" var="isDrug"/>
                </c:if>
            </c:if>
        </c:forEach>
        <c:forEach items="${orderProxy.orderItemProxyList}" var="orderItemProxy">
            <c:if test="${orderItemProxy.promotionType eq '赠品商品'}">
                <c:choose>
                    <c:when test="${isOutlet}">
                        <c:set var="prdUrl" value="${webRoot}/wap/outlettemplate/default/product.ac?id=${orderItemProxy.productId}"/>
                    </c:when>
                    <c:otherwise>
                        <c:set var="prdUrl" value="${webRoot}/wap/product.ac?id=${orderItemProxy.productId}"/>
                    </c:otherwise>
                </c:choose>
                <div class="dd-item">
                    <a class="pic" href="${prdUrl}"><img src="${orderItemProxy.productProxy.defaultImage["150X150"]}" alt=""></a>
                    <a class="name" href="${prdUrl}">${orderItemProxy.productProxy.name}</a>
                    <p><span class="price">￥<fmt:formatNumber value="${orderItemProxy.productUnitPrice}" type="number" pattern="#0.00#" /></span><span class="number">x${orderItemProxy.num}</span></p>
                    <div class="zp">赠品</div>
                </div>
            </c:if>
        </c:forEach>
    </div>
    <div class="price-operation">
        <p><span>商品总金额</span>￥<fmt:formatNumber value="${orderProxy.productTotalAmount}" type="number" pattern="#0.00#" /></p>
        <p><span>运费</span>￥<fmt:formatNumber value="${orderProxy.freightAmount}" type="number" pattern="#0.00#"/></p>
        <c:if test="${orderProxy.useCouponAmountAbs ne '0'}"><p><span>用券抵扣</span>-￥${orderProxy.useCouponAmountAbs}</p></c:if>
        <c:if test="${orderProxy.discountAmountAbs ne '0'}"><div class="youhui"><em>减</em><span class="youhui-name">满减优惠</span><span class="youhui-price">-¥ ${orderProxy.discountAmountAbs}</span></div></c:if>
        <div class="integral"><span class="integral-name">赠送积分</span><span class="integral-number">${orderProxy.obtainTotalIntegral}积分</span></div>
        <div class="fukuan">${isDrug == 'Y' ? '预定金额': '实付款'}<span class="fukuan-price">¥<fmt:formatNumber value="${orderProxy.orderTotalAmount}" type="number" pattern="#0.00#" /></span></div>
    </div>

    <div class="delivery-info order-d-info">
        <div class="dt">配送信息</div>
        <div class="dd">
            <c:set value="${fn:substring(orderProxy.mobile, 0,3)}" var="mobileHeader"/><%-- 手机前3位 --%>
            <c:set value="${fn:substring(orderProxy.mobile, fn:length(orderProxy.mobile)-4,fn:length(orderProxy.mobile))}" var="mobileStern"/><%-- 手机后4位 --%>
            <p><span>收货人</span>${orderProxy.receiverName}&nbsp;${mobileHeader}****${mobileStern}</p>
            <p><span>收货地址</span>${orderProxy.province}${orderProxy.address}</p>
            <p><span>配送方式</span>${orderProxy.deliveryWay}</p>
            <c:if test="${isOutlet}">
            <p><span>配送时间</span>
                <c:choose>
                    <c:when test="${orderProxy.deliveryTimeStr eq '尽快送达'}">
                        尽快送达
                    </c:when>
                    <c:otherwise>
                        <fmt:formatDate value="${orderProxy.deliveryStartTime}" pattern="yyyy-MM-dd HH:mm" />&nbsp;-&nbsp;<fmt:formatDate value="${orderProxy.deliveryEndTime}" pattern="yyyy-MM-dd HH:mm" />
                    </c:otherwise>
                </c:choose>
            </p>
            </c:if>
        </div>
    </div>
    <div class="invoice-info order-d-info">
        <div class="dt">发票信息</div>
        <div class="dd">
            <c:if test="${orderProxy.isNeedInvoice == true}">
                <p><span>发票类型</span>${orderProxy.invoiceType}</p>
                <p><span>发票抬头</span>${orderProxy.invoiceTitle}</p>
                <c:if test="${! empty orderProxy.invoiceTaxPayerNum}"><p><span>发票税号</span>${orderProxy.invoiceTaxPayerNum}</p></c:if>
            </c:if>
            <c:if test="${orderProxy.isNeedInvoice != true}">
                <p><span>发票类型</span>${orderProxy.invoiceType}</p>
            </c:if>
        </div>
    </div>
    <div class="order-info order-d-info">
        <div class="dt">订单信息</div>
        <div class="dd">
            <p><span>订单编号</span>${orderProxy.orderNum}</p>
            <p><span>支付方式</span>${orderProxy.isCod?'货到付款':'在线支付'}</p>
            <p><span>下单时间</span><fmt:formatDate value="${orderProxy.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
            <c:if test="${not empty orderProxy.remark}">
                <p class="elli"><span>备注信息</span>${orderProxy.remark}</p>
            </c:if>
        </div>
    </div>
    <c:choose>
        <c:when test="${orderStatusNm == '待付款'}">
            <div class="bottom-btn-box">
                <a class="zhifu-btn1" href="javascript:;" id="pay-btn" lastPayTime="${bdw:getPayEndTimeStr(orderProxy.orderId)}">立即支付<span>${bdw:getPayEndTimeStr(orderProxy.orderId)}</span></a>
                <a class="zhifu-btn3" href="javascript:;"  onclick="cancelOrder('${orderProxy.orderId}')">取消订单</a>
            </div>
        </c:when>
        <c:when test="${orderStatusNm == '待确认'}">
            <div class="bottom-btn-box">
                <a class="zhifu-btn2" href="javascript:;" onclick="cancelOrder(${orderProxy.orderId})">${isDrug == 'Y' ? '取消预定': '取消购买'}</a>
            </div>
        </c:when>
        <c:when test="${orderStatusNm == '待发货'}">
            <div class="bottom-btn-box">
                <c:if test="${orderProxy.isRemindSent != true}"><a class="zhifu-btn2" href="javascript:;" id="btn-remindOrder" data-orderId="${orderProxy.orderId}">提醒发货</a></c:if>
                <c:if test="${orderProxy.isRemindSent == true}"><a class="zhifu-btn3" href="javascript:;">已提醒发货</a></c:if>
            </div>
        </c:when>
        <c:when test="${orderStatusNm == '待收货'}">
            <div class="bottom-btn-box">
                <a class="zhifu-btn2" href="javascript:;" onclick="buyerSigned('${orderProxy.orderId}')">确认收货</a>
            </div>
        </c:when>
        <c:when test="${orderStatusNm == '已完成'}">
            <div class="bottom-btn-box">
                <c:if test="${orderProxy.isComment =='Y'}"><a class="zhifu-btn2" href="${webRoot}/wap/module/member/orderComment.ac?id=${orderProxy.orderId}">评价晒单</a></c:if>
                <c:if test="${orderProxy.isComment =='N'}"><a class="zhifu-btn3" href="${webRoot}/wap/module/member/orderComment.ac?id=${orderProxy.orderId}">查看评价</a></c:if>
                <c:if test="${groupBuyOrder == 'Y'}"><a class="zhifu-btn3"  href="${webRoot}/wap/tuanDetail.ac?id=${groupBuyItem.groupBuyId}">'再次购买'</a></c:if>
                <c:if test="${groupBuyOrder == 'N'}"><a class="zhifu-btn3"  href="${prdUrl}">${isDrug == 'Y' ? '再次预定': '再次购买'}</a></c:if>
                <a class="zhifu-btn3" href="javascript:;" onclick="orderDelete('${orderProxy.orderId}')">删除订单</a>
            </div>
        </c:when>
        <c:when test="${orderStatusNm == '待评价'}">
            <div class="bottom-btn-box">
                <a class="zhifu-btn2" href="${webRoot}/wap/module/member/orderComment.ac?id=${orderProxy.orderId}">评价晒单</a>
                <a class="zhifu-btn3" href="javascript:;" onclick="orderDelete('${orderProxy.orderId}')">删除订单</a>
            </div>
        </c:when>
        <c:when test="${orderStatusNm == '已取消'}">
            <div class="bottom-btn-box">
                <c:if test="${groupBuyOrder == 'Y'}"><a class="zhifu-btn2"  href="${webRoot}/wap/tuanDetail.ac?id=${groupBuyItem.groupBuyId}">再次购买</a></c:if>
                <c:if test="${groupBuyOrder == 'N'}"><a class="zhifu-btn2"  href="${prdUrl}">${isDrug == 'Y' ? '再次预定': '再次购买'}</a></c:if>
                <a class="zhifu-btn3" href="javascript:;" onclick="orderDelete('${orderProxy.orderId}')">删除订单</a>
            </div>
        </c:when>
        <c:when test="${orderStatusNm == '已拒收'}">
            <div class="bottom-btn-box">
                <a class="zhifu-btn3" href="javascript:;" onclick="orderDelete('${orderProxy.orderId}')">删除订单</a>
            </div>
        </c:when>
    </c:choose>
</div>

<!-- 选择支付方式 -->
<div id="paymentLoad">
</div>

<div class="overlay" style="display: none;">
    <img src="${webRoot}/template/bdw/statics/images/zoomloader.gif" style="position: absolute; top: 50%; left: 50%;" />
</div>
</body>

</html>

