<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:findOrdinaryOrder(param.userId,param.pageNum,param.pageSize)}" var="orderProxyPage"/> <%--获取当前用户普通订单--%>
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