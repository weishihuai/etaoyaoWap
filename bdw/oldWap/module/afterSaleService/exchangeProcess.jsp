<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<c:set value="${bdw:getExchangedPurchaseOrderPage(loginUser.userId,pageNum,8)}" var="exchangeOrderPage"/> <%--获取当前用户普通订单--%>
<html>
<head>
    <meta charset="utf-8">
    <title>换货进度-${webName}</title>
    <meta content="yes" name="apple-mobile-web-app-capable" />
    <meta content="yes" name="apple-touch-fullscreen" />
    <meta content="telephone=no,email=no" name="format-detection" />
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
    <link rel="stylesheet" href="${webRoot}/template/bdw/oldWap/statics/css/base.css" />
    <link rel="stylesheet" href="${webRoot}/template/bdw/oldWap/statics/css/saleServiceApply.css" />
    <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/jquery-1.7.1.min.js"></script>

    <script type="text/javascript">
        var webParam = {
            webRoot : '${webRoot}',
            lastPageNumber: '${exchangeOrderPage.lastPageNumber}'
        }
    </script>
</head>
<body>
<div class="main">
    <div class="ser-control">
        <a class="control-item" href="${webRoot}/wap/module/afterSaleService/saleServiceApply.ac">售后申请</a>
        <a class="control-item" href="${webRoot}/wap/module/afterSaleService/returnProcess.ac">退货进度</a>
        <a class="control-item active" href="${webRoot}/wap/module/afterSaleService/exchangeProcess.ac">换货进度</a>
    </div>

    <div class="ser-content" id="exchangeProcess">
        <div class="cont-box2">
            <c:forEach items="${exchangeOrderPage.result}" var="exchangeOrderProxy">
                <c:choose>
                    <c:when test="${exchangeOrderProxy.stat == '同意换货'}">
                        <div class="item">
                            <div class="mt">
                                <span>订单编号</span>
                                <span>${exchangeOrderProxy.orderNum}</span>
                                <i>商家处理中</i>
                            </div>
                            <c:forEach items="${exchangeOrderProxy.orderItemProxyList}" var="exchangeOrderItemProxy">
                                <div class="mc">
                                    <div class="mc-item">
                                        <c:choose>
                                            <c:when test="${not empty exchangeOrderItemProxy.shopType && exchangeOrderItemProxy.shopType == '2'}">
                                                <div class="pic"><a href="${webRoot}/wap/citySend/product.ac?productId=${exchangeOrderItemProxy.productId}"><img src="${exchangeOrderProxy.imageUrl}" alt=""></a></div>
                                                <div class="mrt">
                                                    <a href="${webRoot}/wap/citySend/product.ac?productId=${exchangeOrderItemProxy.productId}" class="title">${exchangeOrderItemProxy.productNm}</a>
                                                    <div class="mrt-bot">
                                                        <span>￥${exchangeOrderItemProxy.unitPrice}</span>
                                                        <em>x${exchangeOrderItemProxy.quantity}</em>
                                                    </div>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="pic"><a href="${webRoot}/wap/product.ac?id=${exchangeOrderItemProxy.productId}"><img src="${exchangeOrderProxy.imageUrl}" alt=""></a></div>
                                                <div class="mrt">
                                                    <a href="${webRoot}/wap/product.ac?id=${exchangeOrderItemProxy.productId}" class="title">${exchangeOrderItemProxy.productNm}</a>
                                                    <div class="mrt-bot">
                                                        <span>￥${exchangeOrderItemProxy.unitPrice}</span>
                                                        <em>x${exchangeOrderItemProxy.quantity}</em>
                                                    </div>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>

                                    </div>
                                </div>
                            </c:forEach>
                            <div class="md">
                                <div class="mb-lt">
                                    <span>申请时间</span><br>
                                    <span>${exchangeOrderProxy.createTimeString}</span>
                                </div>
                                <div class="mb-bt">
                                    <c:if test="${exchangeOrderProxy.stat == '同意换货'&& (empty exchangeOrderProxy.logisticsCompany)}">
                                        <a href="javascript:void(0);" class="log-btn" onclick="fillLogisticsOrder(${exchangeOrderProxy.exchangeOrderId})">填写物流单</a>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </c:when>
                    <c:when test="${exchangeOrderProxy.stat == '换货出库'}">
                        <div class="item">
                            <div class="mt">
                                <span>订单编号</span>
                                <span>${exchangeOrderProxy.orderNum}</span>
                                <i>${exchangeOrderProxy.stat}</i>
                            </div>

                            <c:forEach items="${exchangeOrderProxy.orderItemProxyList}" var="exchangeOrderItemProxy">
                                <div class="mc">
                                    <div class="mc-item">
                                        <c:choose>
                                            <c:when test="${not empty exchangeOrderItemProxy.shopType && exchangeOrderItemProxy.shopType == '2'}">
                                                <div class="pic"><a href="${webRoot}/wap/citySend/product.ac?productId=${exchangeOrderItemProxy.productId}"><img src="${exchangeOrderProxy.imageUrl}" alt=""></a></div>
                                                <div class="mrt">
                                                    <a href="${webRoot}/wap/citySend/product.ac?productId=${exchangeOrderItemProxy.productId}" class="title">${exchangeOrderItemProxy.productNm}</a>
                                                    <div class="mrt-bot">
                                                        <span>￥${exchangeOrderItemProxy.unitPrice}</span>
                                                        <em>x${exchangeOrderItemProxy.quantity}</em>
                                                    </div>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="pic"><a href="${webRoot}/wap/product.ac?id=${exchangeOrderItemProxy.productId}"><img src="${exchangeOrderProxy.imageUrl}" alt=""></a></div>
                                                <div class="mrt">
                                                    <a href="${webRoot}/wap/product.ac?id=${exchangeOrderItemProxy.productId}" class="title">${exchangeOrderItemProxy.productNm}</a>
                                                    <div class="mrt-bot">
                                                        <span>￥${exchangeOrderItemProxy.unitPrice}</span>
                                                        <em>x${exchangeOrderItemProxy.quantity}</em>
                                                    </div>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>

                                    </div>
                                </div>
                            </c:forEach>
                            <div class="md">
                                <div class="mb-lt">
                                    <span>下单时间</span><br>
                                    <span>${exchangeOrderProxy.createTimeString}</span>
                                </div>
                                <div class="mb-bt">
                                    <a href="${webRoot}/wap/module/afterSaleService/logisticsDetail.ac?orderId=${exchangeOrderProxy.orderId}" class="ck-btn">查看物流</a>
                                    <a href="##" class="confirm-btn" onclick="confirmDelivery(${exchangeOrderProxy.exchangeOrderId})">确认收货</a>
                                </div>
                            </div>
                        </div>
                    </c:when>
                    <c:when test="${exchangeOrderProxy.stat == '拒绝换货'}">
                        <div class="item">
                            <div class="mt">
                                <span>订单编号</span>
                                <span>${exchangeOrderProxy.orderNum}</span>
                                <em>${exchangeOrderProxy.stat}</em>
                            </div>
                            <c:forEach items="${exchangeOrderProxy.orderItemProxyList}" var="exchangeOrderItemProxy">
                                <div class="mc">
                                    <div class="mc-item">
                                        <c:choose>
                                            <c:when test="${not empty exchangeOrderItemProxy.shopType && exchangeOrderItemProxy.shopType == '2'}">
                                                <div class="pic"><a href="${webRoot}/wap/citySend/product.ac?productId=${exchangeOrderItemProxy.productId}"><img src="${exchangeOrderProxy.imageUrl}" alt=""></a></div>
                                                <div class="mrt">
                                                    <a href="${webRoot}/wap/citySend/product.ac?productId=${exchangeOrderItemProxy.productId}" class="title">${exchangeOrderItemProxy.productNm}</a>
                                                    <div class="mrt-bot">
                                                        <span>￥${exchangeOrderItemProxy.unitPrice}</span>
                                                        <em>x${exchangeOrderItemProxy.quantity}</em>
                                                    </div>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="pic"><a href="${webRoot}/wap/product.ac?id=${exchangeOrderItemProxy.productId}"><img src="${exchangeOrderProxy.imageUrl}" alt=""></a></div>
                                                <div class="mrt">
                                                    <a href="${webRoot}/wap/product.ac?id=${exchangeOrderItemProxy.productId}" class="title">${exchangeOrderItemProxy.productNm}</a>
                                                    <div class="mrt-bot">
                                                        <span>￥${exchangeOrderItemProxy.unitPrice}</span>
                                                        <em>x${exchangeOrderItemProxy.quantity}</em>
                                                    </div>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>

                                    </div>
                                </div>
                            </c:forEach>
                            <div class="md">
                                <div class="mb-lt">
                                    <span>下单时间</span><br>
                                    <span>${exchangeOrderProxy.createTimeString}</span>
                                </div>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="item">
                            <div class="mt">
                                <span>订单编号</span>
                                <span>${exchangeOrderProxy.orderNum}</span>
                                <i>${exchangeOrderProxy.stat}</i>
                            </div>
                            <c:forEach items="${exchangeOrderProxy.orderItemProxyList}" var="exchangeOrderItemProxy">
                                <div class="mc">
                                    <div class="mc-item">
                                        <c:choose>
                                            <c:when test="${not empty exchangeOrderItemProxy.shopType && exchangeOrderItemProxy.shopType == '2'}">
                                                <div class="pic"><a href="${webRoot}/wap/citySend/product.ac?productId=${exchangeOrderItemProxy.productId}"><img src="${exchangeOrderProxy.imageUrl}" alt=""></a></div>
                                                <div class="mrt">
                                                    <a href="${webRoot}/wap/citySend/product.ac?productId=${exchangeOrderItemProxy.productId}" class="title">${exchangeOrderItemProxy.productNm}</a>
                                                    <div class="mrt-bot">
                                                        <span>￥${exchangeOrderItemProxy.unitPrice}</span>
                                                        <em>x${exchangeOrderItemProxy.quantity}</em>
                                                    </div>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="pic"><a href="${webRoot}/wap/product.ac?id=${exchangeOrderItemProxy.productId}"><img src="${exchangeOrderProxy.imageUrl}" alt=""></a></div>
                                                <div class="mrt">
                                                    <a href="${webRoot}/wap/product.ac?id=${exchangeOrderItemProxy.productId}" class="title">${exchangeOrderItemProxy.productNm}</a>
                                                    <div class="mrt-bot">
                                                        <span>￥${exchangeOrderItemProxy.unitPrice}</span>
                                                        <em>x${exchangeOrderItemProxy.quantity}</em>
                                                    </div>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>

                                    </div>
                                </div>
                            </c:forEach>
                            <div class="md">
                                <div class="mb-lt">
                                    <span>申请时间</span><br>
                                    <span>${exchangeOrderProxy.createTimeString}</span>
                                </div>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </c:forEach>


        </div>
    </div>

    <nav class="ser-content-nav-bar">
        <a href="${webRoot}/wap/module/afterSaleService/loadExchangeProcess.ac?userId=${loginUser.userId}&pageNum=2&pageSize=8"></a>
    </nav>

    <div class="overlay" style="display: none;">
        <div class="lightbox fill-dt">
            <div class="mt">
                <span>填写物流单</span>
                <a href="javascript:void(0);" class="close"></a>
            </div>
            <div class="mc">
                <input type="text" placeholder="请输入物流单号" id="logisticsNum">
                <input type="text" placeholder="请输入物流公司" id="logisticsCompanyNm">
                <input type="hidden" value="N" id="type" />
                <a href="javascript:void(0);" class="confirm color" onclick="submitLogisticOrder(this)">确定</a>
            </div>
        </div>
    </div>

</div>
<script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/base.js"></script>
<script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.infinitescroll.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/salesService.js"></script>
</body>
</html>
