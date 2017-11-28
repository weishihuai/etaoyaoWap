<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%--退货分页列表--%>
<c:set value="${bdw:getReturnedPurchaseOrderPage(param.userId,param.pageNum,param.pageSize)}" var="returnOrderPage"/> <%--获取当前用户退货订单--%>

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
