<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<c:set value="${empty param.page ? 1:param.page}" var="pageNum"/> <%--订单翻页数，默认为第一页--%>
<%--退货分页列表--%>
<c:set value="${bdw:getReturnedPurchaseOrderPage(loginUser.userId,pageNum,8)}" var="returnOrderPage"/> <%--获取当前用户退货订单--%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>退货进度-${webName}</title>
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
            lastPageNumber: '${returnOrderPage.lastPageNumber}'
        }
    </script>
</head>
<body>
<div class="main">
    <div class="ser-control">
        <a class="control-item" href="${webRoot}/wap/module/afterSaleService/saleServiceApply.ac">售后申请</a>
        <a class="control-item active" href="${webRoot}/wap/module/afterSaleService/returnProcess.ac">退货进度</a>
        <a class="control-item" href="${webRoot}/wap/module/afterSaleService/exchangeProcess.ac">换货进度</a>
    </div>

    <div class="ser-content" id="returnProcess">
        <div class="cont-box2">
            <c:forEach items="${returnOrderPage.result}" var="returnOrderProxy">
                <c:choose>
                    <c:when test="${returnOrderProxy.stat == '同意退货'}">
                        <div class="item">
                            <div class="mt">
                                <span>订单编号</span>
                                <span>${returnOrderProxy.orderNum}</span>
                                <i>待商家处理</i>
                            </div>
                            <c:forEach items="${returnOrderProxy.returnedPurchaseOrderItemProxyList}" var="returnOrderItemProxy">
                                <div class="mc">
                                    <div class="mc-item">
                                        <c:choose>
                                            <c:when test="${not empty returnOrderItemProxy.shopType && returnOrderItemProxy.shopType == '2'}">
                                                <div class="pic"><a href="${webRoot}/wap/citySend/product.ac?productId=${returnOrderItemProxy.productId}"><img src="${returnOrderProxy.imagesUrl}" alt=""></a></div>
                                                <div class="mrt">
                                                    <a href="${webRoot}/wap/citySend/product.ac?productId=${returnOrderItemProxy.productId}" class="title">${returnOrderItemProxy.productNm}</a>
                                                    <div class="mrt-bot">
                                                        <span>￥${returnOrderItemProxy.unitPrice}</span>
                                                        <em>x${returnOrderItemProxy.quantity}</em>
                                                    </div>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="pic"><a href="${webRoot}/wap/product.ac?id=${returnOrderItemProxy.productId}"><img src="${returnOrderProxy.imagesUrl}" alt=""></a></div>
                                                <div class="mrt">
                                                    <a href="${webRoot}/wap/product.ac?id=${returnOrderItemProxy.productId}" class="title">${returnOrderItemProxy.productNm}</a>
                                                    <div class="mrt-bot">
                                                        <span>￥${returnOrderItemProxy.unitPrice}</span>
                                                        <em>x${returnOrderItemProxy.quantity}</em>
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
                                    <span>${returnOrderProxy.createTimeString}</span>
                                </div>
                                <div class="mb-rt">
                                    共<span>${fn:length(returnOrderProxy.returnedPurchaseOrderItemProxyList)}</span>件 退款金额
                                    <i>￥</i><em>${returnOrderProxy.orderTotalAmount}</em>
                                </div>
                                <div class="mb-bt">
                                    <c:if test="${returnOrderProxy.stat == '同意退货'&& (empty returnOrderProxy.logisticsCompany)}">
                                        <a href="javascript:void(0);" class="log-btn" onclick="fillLogisticsOrder(${returnOrderProxy.returnedPurchaseOrderId})">填写物流单</a>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="item">
                            <div class="mt">
                                <span>订单编号</span>
                                <span>${returnOrderProxy.orderNum}</span>
                                <i>${returnOrderProxy.stat}</i>
                            </div>
                            <c:forEach items="${returnOrderProxy.returnedPurchaseOrderItemProxyList}" var="returnOrderItemProxy">
                                <div class="mc">
                                    <div class="mc-item">
                                        <c:choose>
                                            <c:when test="${not empty returnOrderItemProxy.shopType && returnOrderItemProxy.shopType == '2'}">
                                                <div class="pic"><a href="${webRoot}/wap/citySend/product.ac?productId=${returnOrderItemProxy.productId}"><img src="${returnOrderProxy.imagesUrl}" alt=""></a></div>
                                                <div class="mrt">
                                                    <a href="${webRoot}/wap/citySend/product.ac?productId=${returnOrderItemProxy.productId}" class="title">${returnOrderItemProxy.productNm}</a>
                                                    <div class="mrt-bot">
                                                        <span>￥${returnOrderItemProxy.unitPrice}</span>
                                                        <em>x${returnOrderItemProxy.quantity}</em>
                                                    </div>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="pic"><a href="${webRoot}/wap/product.ac?id=${returnOrderItemProxy.productId}"><img src="${returnOrderProxy.imagesUrl}" alt=""></a></div>
                                                <div class="mrt">
                                                    <a href="${webRoot}/wap/product.ac?id=${returnOrderItemProxy.productId}" class="title">${returnOrderItemProxy.productNm}</a>
                                                    <div class="mrt-bot">
                                                        <span>￥${returnOrderItemProxy.unitPrice}</span>
                                                        <em>x${returnOrderItemProxy.quantity}</em>
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
                                    <span>${returnOrderProxy.createTimeString}</span>
                                </div>
                                <div class="mb-rt">
                                    共<span>${fn:length(returnOrderProxy.returnedPurchaseOrderItemProxyList)}</span>件 退款金额
                                    <i>￥</i><em><fmt:formatNumber value="${returnOrderProxy.orderTotalAmount}" pattern="#,##0.00#"/></em>
                                </div>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </div>
    </div>
    <nav class="ser-content-nav-bar">
        <a href="${webRoot}/wap/module/afterSaleService/loadReturnProcess.ac?userId=${loginUser.userId}&pageNum=2&pageSize=8"></a>
    </nav>
</div>
<div class="overlay" style="display: none;">
    <div class="lightbox fill-dt">
        <div class="mt">
            <span>填写物流单</span>
            <a href="##" class="close"></a>
        </div>
        <div class="mc">
            <input type="text" placeholder="请输入物流单号" id="logisticsNum">
            <input type="text" placeholder="请输入物流公司" id="logisticsCompanyNm">
            <input type="hidden" value="Y" id="type" />
            <a href="javascript:void(0);" class="confirm color" onclick="submitLogisticOrder(this)">确定</a>
        </div>
    </div>
</div>

<script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/base.js"></script>
<script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.infinitescroll.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/salesService.js"></script>

</body>
</html>
