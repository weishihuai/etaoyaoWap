<%@ page import="com.iloosen.imall.module.order.domain.code.ProcessStatCodeEnum" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="8" var="limit"/>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<c:if test="${empty loginUser}">
    <c:redirect url="${webRoot}/wap/login.ac"/>
</c:if>
<c:set value="${empty param.page ? 1 : param.page}" var="page"/> <%--订单翻页数，默认为第一页--%>
<c:set value="${empty param.status ? 10 : param.status}" var="orderStatus"/> <%--订单状态代码，默认为全部--%>
<c:set value="${empty param.searchField ? '': param.searchField}" var="searchField"/> <%--订单搜索关键字，默认为空--%>
<c:set value="${sdk:findStoreOrder(page, limit)}" var="orderProxyPage"/> <%--获取门店订单--%>

<!--订单状态-->
<%
    request.setAttribute("toConfirm", ProcessStatCodeEnum.TO_CONFIRM.toCode());                  //待确认
    request.setAttribute("confirmed", ProcessStatCodeEnum.CONFIRMED.toCode());                   //已确认
    request.setAttribute("sent", ProcessStatCodeEnum.SENT.toCode());                              //已送货
    request.setAttribute("canceled", ProcessStatCodeEnum.CANCELED.toCode());                     //已取消
%>
<c:forEach items="${orderProxyPage.result}" var="orderProxys" varStatus="status">
    <c:set value="${bdw:getPayEndTimeStr(orderProxys.orderId)}" var="payEndTime"/>
</c:forEach>

<!DOCTYPE HTML>
<html>
<head lang="en">
    <meta charset="utf-8">
    <title>门店订单列表-${webName}</title>
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="telephone=no,email=no" name="format-detection">

    <link href="${webRoot}/template/bdw/wap/statics/css/swiper.min.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/myOrders.css" rel="stylesheet" media="screen">

    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-2.1.4.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/swiper.min.js"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery.infinitescroll.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/storeOrders.js" type="text/javascript"></script>
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}",
            lastPageNumber: "${orderProxyPage.lastPageNumber}",
            orderStatus:'${orderStatus}',
            searchField:'${searchField}'
        };
    </script>
</head>
<body>
<div class="m-top">
    <a class="back" href="${webRoot}/wap/module/member/index.ac"></a>
    <div class="xiala-box">
        <div class="dt">门店订单</div>
        <div class="dd">
            <ul class="dd-inner">
                <li onclick="window.location.href = '${webRoot}/wap/module/member/myOrders.ac'">普通订单</li>
                <li class="cur" onclick="window.location.href = '${webRoot}/wap/module/member/storeOrder.ac'">门店订单</li>
                <li onclick="window.location.href = '${webRoot}/wap/module/member/myOrders.ac?promotionTypeCode=1'">团购订单</li>
                <li onclick="window.location.href = '${webRoot}/wap/module/member/myIntegralOrders.ac'">积分订单</li>
            </ul>
        </div>
    </div>
    <a class="search1" href="javascript:;"></a>
</div>

<div class="search1-box"><div class="dd-inner"><input type="text" id="searchField"  placeholder="商品名称/商品编号/订单编号"><a class="cancle-btn" href="javascript:;" onclick="searchOrder()">搜索</a></div></div>

<div class="order-m-main" id="ordersDiv">
    <div class="order-class-toggle">
        <div>
        <div class="swiper-container dt">
            <ul class="swiper-wrapper">
                <li class="swiper-slide <c:if test="${param.status == '10' || empty param.status}">cur</c:if>"><a rel="10" class="cur">全部</a></li>
                <li class="swiper-slide <c:if test="${param.status == '2'}">cur</c:if>"><a rel="2">待确认</a></li>
                <li class="swiper-slide <c:if test="${param.status == '7'}">cur</c:if>"><a rel="7">待付款</a></li>
                <li class="swiper-slide <c:if test="${param.status == '3'}">cur</c:if>"><a rel="3">待发货</a></li>
                <li class="swiper-slide <c:if test="${param.status == '4'}">cur</c:if>"><a rel="4">待收货</a></li>
                <li class="swiper-slide <c:if test="${param.status == '8'}">cur</c:if>"><a rel="8">待评价</a></li>
                <li class="swiper-slide <c:if test="${param.status == '1'}">cur</c:if>"><a rel="1">已完成</a></li>
                <li class="swiper-slide <c:if test="${param.status == '5'}">cur</c:if>"><a rel="5">已取消</a></li>
            </ul>
        </div>
        </div>
        <div class="dd">
            <ul class="dd-inner" id="selectStatus">
                <li rel="10" <c:if test="${param.status == '10' || empty param.status}">class="cur"</c:if>>全部</li>
                <li rel="2" <c:if test="${param.status == '2'}">class="cur"</c:if>>待确认</li>
                <li rel="7" <c:if test="${param.status == '7'}">class="cur"</c:if>>待付款</li>
                <li rel="3" <c:if test="${param.status == '3'}">class="cur"</c:if>>待发货</li>
                <li rel="4" <c:if test="${param.status == '4'}">class="cur"</c:if>>待收货</li>
                <li rel="8" <c:if test="${param.status == '8'}">class="cur"</c:if>>待评价</li>
                <li rel="1" <c:if test="${param.status == '1'}">class="cur"</c:if>>已完成</li>
                <li rel="5" <c:if test="${param.status == '5'}">class="cur"</c:if>>已取消</li>
            </ul>
        </div>
        <em id="iconXiaLa" class="icon-xiala"></em>
    </div>

    <c:choose>
        <c:when test="${empty orderProxyPage.result}">
            <%--暂无订单--%>
            <div class="none-box">
                <img class="none-icon" src="${webRoot}/template/bdw/wap/module/member/statics/images/kongdingdan.png" alt="">
                <p>您还没有相关订单</p>
            </div>
        </c:when>

        <c:otherwise>
            <div id="order-panel">
                <c:forEach items="${orderProxyPage.result}" var="orderProxy" varStatus="status">
                    <c:set value="${bdw:getPayEndTimeStr(orderProxy.orderId)}" var="payEndTimeStr" />
                    <c:set value="" var="orderStatusNm"/>
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
                        <c:when test="${ (orderProxy.processStatCode == sent && orderProxy.isBuyerSigned == true && orderProxy.isComment =='Y') && (param.status =='10' || param.status =='8' || empty param.status)}">
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
                    </c:choose>

                    <div class="order-list">
                        <c:set value="${sdk:getShopInfProxyById(orderProxy.sysShopInf.shopInfId)}" var="shopInf"/>
                        <c:set value="${shopInf.shopType eq '2'}" var="isOutlet"/>
                        <p class="list-head"><a class="shop-name" href="${webRoot}/wap/outlettemplate/default/outletIndex.ac?shopId=${shopInf.shopInfId}">${shopInf.shopNm}</a>
                            <a class="list-head-r" href="javascript:;">${orderStatusNm}</a>
                        </p>

                        <c:set value="N" var="isDrug"/>
                        <c:set value="" var="orderProductNum"/>
                        <c:forEach items="${orderProxy.orderItemProxyList}" var="orderItemProxy">
                            <c:if test="${orderItemProxy.promotionType ne '赠品商品'}">
                                <div class="list-item" onclick="window.location.href='${webRoot}/wap/module/member/orderDetail.ac?id=${orderProxy.orderId}'">
                                    <a class="pic" href="javascript:;"><img src="${orderItemProxy.productProxy.defaultImage["150X150"]}" alt=""></a>
                                    <a class="name" href="javascript:;">${orderItemProxy.productProxy.name}</a>
                                    <p><span class="price">￥<fmt:formatNumber value="${orderItemProxy.productUnitPrice}" type="number" pattern="#0.00#" /></span><span class="number">x${orderItemProxy.num}</span></p>
                                    <c:if test="${orderItemProxy.promotionType eq '预定药品'}">
                                        <c:set value="Y" var="isDrug"/>
                                    </c:if>
                                    <c:set value="${orderProductNum + orderItemProxy.num}" var="orderProductNum"/>
                                </div>
                            </c:if>
                        </c:forEach>
                        <c:forEach items="${orderProxy.orderItemProxyList}" var="orderItemProxy">
                            <c:if test="${orderItemProxy.promotionType eq '赠品商品'}">
                                <div class="list-item" onclick="window.location.href='${webRoot}/wap/module/member/orderDetail.ac?id=${orderProxy.orderId}'">
                                    <a class="pic" href="javascript:;"><img src="${orderItemProxy.productProxy.defaultImage["150X150"]}" alt=""></a>
                                    <a class="name" href="javascript:;">${orderItemProxy.productProxy.name}</a>
                                    <p><span class="price">￥<fmt:formatNumber value="${orderItemProxy.productUnitPrice}" type="number" pattern="#0.00#" /></span><span class="number">x${orderItemProxy.num}</span></p>
                                    <div class="zp">赠品</div>
                                    <c:if test="${orderItemProxy.promotionType eq '预定药品'}">
                                        <c:set value="Y" var="isDrug"/>
                                    </c:if>
                                    <c:set value="${orderProductNum + orderItemProxy.num}" var="orderProductNum"/>
                                </div>
                            </c:if>
                        </c:forEach>
                        <c:choose>
                            <c:when test="${orderStatusNm == '待付款'}">
                                <div class="list-zhifu">
                                    <p>共<span class="sp-number">${orderProductNum}</span>件  ${isDrug == 'Y' ? '预定金额': '实付款'}:<span class="price">￥<fmt:formatNumber value="${orderProxy.orderTotalAmount}" type="number" pattern="#0.00#" /></span>
                                        (含运费:¥<fmt:formatNumber value="${orderProxy.freightAmount}" type="number" pattern="#0.00#"/>)
                                    </p>
                                    <a class="zhifu-btn1 countDown" href="${webRoot}/wap/module/member/orderDetail.ac?id=${orderProxy.orderId}" id="orderId${orderProxy.orderId}" lastPayTime="${payEndTimeStr}" orderId="${orderProxy.orderId}">立即支付<span>${payEndTimeStr}</span></a>
                                </div>
                            </c:when>
                            <c:when test="${orderStatusNm == '待确认'}">
                                <div class="list-zhifu">
                                    <p>共<span class="sp-number">${orderProductNum}</span>件  ${isDrug == 'Y' ? '预定金额': '实付款'}:<span class="price">￥<fmt:formatNumber value="${orderProxy.orderTotalAmount}" type="number" pattern="#0.00#" /></span>
                                        (含运费:¥<fmt:formatNumber value="${orderProxy.freightAmount}" type="number" pattern="#0.00#"/>)
                                    </p>
                                    <a class="zhifu-btn2" href="javascript:;" onclick="cancelOrder(${orderProxy.orderId})">${isDrug == 'Y' ? '取消预定': '取消购买'}</a>
                                </div>
                            </c:when>
                            <c:when test="${orderStatusNm == '待发货'}">
                                <div class="list-zhifu">
                                    <p>共<span class="sp-number">${orderProductNum}</span>件   ${isDrug == 'Y' ? '预定金额': '实付款'}:<span class="price">￥<fmt:formatNumber value="${orderProxy.orderTotalAmount}" type="number" pattern="#0.00#" /></span>
                                        (含运费:¥<fmt:formatNumber value="${orderProxy.freightAmount}" type="number" pattern="#0.00#"/>)</p>
                                    <c:if test="${orderProxy.isRemindSent != true}"><a class="zhifu-btn2" href="javascript:;" data-orderId="${orderProxy.orderId}" onclick="remindOrder(this,${orderProxy.orderId})">提醒发货</a></c:if>
                                    <c:if test="${orderProxy.isRemindSent == true}"><a class="zhifu-btn3" href="javascript:;">已提醒发货</a></c:if>
                                </div>
                            </c:when>
                            <c:when test="${orderStatusNm == '待收货'}">
                                <div class="list-zhifu">
                                    <p>共<span class="sp-number">${orderProductNum}</span>件  ${isDrug == 'Y' ? '预定金额': '实付款'}:<span class="price">￥<fmt:formatNumber value="${orderProxy.orderTotalAmount}" type="number" pattern="#0.00#" /></span>
                                        (含运费:¥<fmt:formatNumber value="${orderProxy.freightAmount}" type="number" pattern="#0.00#"/>)</p>
                                    <c:if test="${!isOutlet}">
                                        <a class="zhifu-btn3" href="${webRoot}/wap/module/member/logisticsDetail.ac?id=${orderProxy.orderId}">查看物流</a>
                                    </c:if>
                                    <a class="zhifu-btn2" href="javascript:;" onclick="buyerSigned('${orderProxy.orderId}')">确认收货</a>
                                </div>
                            </c:when>
                            <c:when test="${orderStatusNm == '已完成'}">
                                <div class="list-zhifu">
                                    <p>共<span class="sp-number">${orderProductNum}</span>件  ${isDrug == 'Y' ? '预定金额': '实付款'}:<span class="price">￥<fmt:formatNumber value="${orderProxy.orderTotalAmount}" type="number" pattern="#0.00#" /></span>
                                        (含运费:¥<fmt:formatNumber value="${orderProxy.freightAmount}" type="number" pattern="#0.00#"/>)</p>
                                    <a class="zhifu-btn3" href="${webRoot}/wap/product.ac?id=${orderProxy.orderItemProxyList[0].productProxy.productId}">${isDrug == 'Y' ? '再次预定': '再次购买'}</a>
                                    <c:if test="${!isOutlet}">
                                        <a class="zhifu-btn3" href="${webRoot}/wap/module/member/logisticsDetail.ac?id=${orderProxy.orderId}">查看物流</a>
                                    </c:if>
                                    <c:if test="${orderProxy.isComment =='Y'}"><a class="zhifu-btn2" href="${webRoot}/wap/module/member/orderComment.ac?id=${orderProxy.orderId}&status=${param.status}">评价晒单</a></c:if>
                                    <c:if test="${orderProxy.isComment =='N'}"><a class="zhifu-btn3" href="${webRoot}/wap/module/member/orderComment.ac?id=${orderProxy.orderId}">查看评价</a></c:if>
                                </div>
                            </c:when>
                            <c:when test="${orderStatusNm == '待评价'}">
                                <div class="list-zhifu">
                                    <p>共<span class="sp-number">${orderProductNum}</span>件  ${isDrug == 'Y' ? '预定金额': '实付款'}:<span class="price">￥<fmt:formatNumber value="${orderProxy.orderTotalAmount}" type="number" pattern="#0.00#" /></span>
                                        (含运费:¥<fmt:formatNumber value="${orderProxy.freightAmount}" type="number" pattern="#0.00#"/>)</p>
                                    <a class="zhifu-btn2" href="${webRoot}/wap/module/member/orderComment.ac?id=${orderProxy.orderId}&status=${param.status}">评价晒单</a>
                                </div>
                            </c:when>
                            <c:when test="${orderStatusNm == '已取消'}">
                                <div class="list-zhifu">
                                    <p>共<span class="sp-number">${orderProductNum}</span>件  ${isDrug == 'Y' ? '预定金额': '实付款'}:<span class="price">￥<fmt:formatNumber value="${orderProxy.orderTotalAmount}" type="number" pattern="#0.00#" /></span>
                                        (含运费:¥<fmt:formatNumber value="${orderProxy.freightAmount}" type="number" pattern="#0.00#"/>)</p>
                                    <a class="zhifu-btn2" href="${webRoot}/wap/product.ac?id=${orderProxy.orderItemProxyList[0].productProxy.productId}">${isDrug == 'Y' ? '再次预定': '再次购买'}</a>
                                </div>
                            </c:when>
                        </c:choose>
                    </div>
                </c:forEach>
            </div>
            <nav id="page-nav">
                <a href="${webRoot}/wap/module/member/storeOrder.ac?page=2&status=${orderStatus}<c:if test="${not empty param.searchField}">&searchField=${searchField}</c:if>"></a>
            </nav>
        </c:otherwise>
    </c:choose>
</div>

<script>
    var swiper04 = new Swiper('.order-class-toggle .dt',{
        freeMode : true,
        slidesPerView : 'auto'
    });
</script>
</body>
</html>

