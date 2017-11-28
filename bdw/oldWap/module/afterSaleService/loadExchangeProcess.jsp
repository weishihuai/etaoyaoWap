<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${bdw:getExchangedPurchaseOrderPage(param.userId,param.pageNum,param.pageSize)}" var="exchangeOrderPage"/> <%--获取当前用户普通订单--%>
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
                            <a href="##" class="ck-btn">查看物流</a>
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