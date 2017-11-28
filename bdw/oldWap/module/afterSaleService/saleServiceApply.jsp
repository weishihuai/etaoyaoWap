<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<c:set value="${empty param.page ? 1:param.page}" var="pageNum"/>
<c:set value="${sdk:findOrdinaryOrder(loginUser.userId,1,8)}" var="orderProxyPage"/> <%--获取当前用户普通订单--%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>售后服务-${webName}</title>
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
            lastPageNumber : '${orderProxyPage.lastPageNumber}',
            userId :'${loginUser.userId}'
        }
    </script>
</head>
<body>
<div class="main">
    <div class="ser-control">
        <a class="control-item active" href="${webRoot}/wap/module/afterSaleService/saleServiceApply.ac">售后申请</a>
        <a class="control-item" href="${webRoot}/wap/module/afterSaleService/returnProcess.ac">退货进度</a>
        <a class="control-item" href="${webRoot}/wap/module/afterSaleService/exchangeProcess.ac">换货进度</a>
    </div>

    <div class="ser-content" id="saleServiceApply">
        <div class="cont-box1">
            <c:forEach items="${orderProxyPage.result}" var="orderProxy">
                <div class="item">
                    <div class="mt">
                        <span>订单编号</span>
                        <span>${orderProxy.orderNum}</span>
                        <i>${orderProxy.orderStat}</i>
                    </div>
                    <c:forEach items="${orderProxy.orderItemProxyList}" var="orderItemProxy" >
                        <div class="mc">
                            <div class="mc-item">
                                <c:choose>
                                    <c:when test="${not empty orderProxy.sysShopInf.shopType && orderProxy.sysShopInf.shopType == '2'}">
                                        <div class="pic"><a href="${webRoot}/wap/citySend/product.ac?productId=${orderItemProxy.productId}"><img src="${orderItemProxy.productProxy.defaultImage['100X100']}" alt=""></a></div>
                                        <div class="mrt">
                                            <a href="${webRoot}/wap/citySend/product.ac?productId=${orderItemProxy.productId}" class="title">${orderItemProxy.productProxy.name}</a>
                                            <div class="mrt-bot">
                                                <span>x${orderItemProxy.num}</span>
                                            </div>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="pic"><a href="${webRoot}/wap/product.ac?id=${orderItemProxy.productId}"><img src="${orderItemProxy.productProxy.defaultImage['100X100']}" alt=""></a></div>
                                        <div class="mrt">
                                            <a href="${webRoot}/wap/product.ac?id=${orderItemProxy.productId}" class="title">${orderItemProxy.productProxy.name}</a>
                                            <div class="mrt-bot">
                                                <span>x${orderItemProxy.num}</span>
                                            </div>
                                        </div>
                                    </c:otherwise>
                                </c:choose>

                            </div>
                        </div>
                    </c:forEach>
                    <div class="mb">
                        <div class="mb-lt">
                            <span>下单时间</span><br>
                            <span><fmt:formatDate value="${orderProxy.createDate}" pattern="yyyy-MM-dd HH:mm:ss" /></span>
                        </div>
                        <c:if test="${orderProxy.orderStat == '交易完成'}">
                            <a href="javascript:void(0);" onclick="checkAfterSale(1,${orderProxy.orderId})">申请退货</a>
                            <a href="javascript:void(0);" onclick="checkAfterSale(2,${orderProxy.orderId})">申请换货</a>
                        </c:if>

                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    <nav class="ser-content-nav-bar">
        <a href="${webRoot}/wap/module/afterSaleService/loadSaleServiceApply.ac?userId=${loginUser.userId}&pageNum=2&pageSize=8"></a>
    </nav>
</div>
<script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.infinitescroll.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/salesService.js"></script>
<script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/base.js"></script>
</body>
</html>
