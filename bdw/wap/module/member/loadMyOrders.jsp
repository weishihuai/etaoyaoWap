<%@ page import="com.iloosen.imall.module.order.domain.code.ProcessStatCodeEnum" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<c:set value="${empty param.page ? 1 : param.page}" var="pageNum"/> <%--订单翻页数，默认为第一页--%>
<c:set value="${sdk:findOrdinaryOrder(loginUser.userId,pageNum,8)}" var="orderProxyPage"/> <%--获取当前用户普通订单--%>
<!--订单状态-->
<%
    request.setAttribute("toConfirm", ProcessStatCodeEnum.TO_CONFIRM.toCode());                  //待确认
    request.setAttribute("confirmed", ProcessStatCodeEnum.CONFIRMED.toCode());                   //已确认
    request.setAttribute("sent", ProcessStatCodeEnum.SENT.toCode());                              //已送货
    request.setAttribute("canceled", ProcessStatCodeEnum.CANCELED.toCode());                     //已取消
%>

<c:if test="${!empty orderProxyPage.result}">
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
            <p class="list-head"><a class="shop-name" href="javascript:;">${shopInf.shopNm}</a>
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
                    <div class="list-item" onclick="window.location.href = '${webRoot}/wap/module/member/orderDetail.ac?id=${orderProxy.orderId}'">
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
                        <a class="zhifu-btn1 countDown" href="javascript:;" id="orderId${orderProxy.orderId}" lastPayTime="${payEndTimeStr}" orderId="${orderProxy.orderId}">立即支付<span>${payEndTimeStr}</span></a>
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
                        <a class="zhifu-btn3" href="${webRoot}/wap/module/member/logisticsDetail.ac?id=${orderProxy.orderId}">查看物流</a>
                        <a class="zhifu-btn2" href="javascript:;" onclick="buyerSigned('${orderProxy.orderId}')">确认收货</a>
                    </div>
                </c:when>
                <c:when test="${orderStatusNm == '已完成'}">
                    <div class="list-zhifu">
                        <p>共<span class="sp-number">${orderProductNum}</span>件  ${isDrug == 'Y' ? '预定金额': '实付款'}:<span class="price">￥<fmt:formatNumber value="${orderProxy.orderTotalAmount}" type="number" pattern="#0.00#" /></span>
                            (含运费:¥<fmt:formatNumber value="${orderProxy.freightAmount}" type="number" pattern="#0.00#"/>)</p>
                        <a class="zhifu-btn3" href="${webRoot}/wap/product.ac?id=${orderProxy.orderItemProxyList[0].productProxy.productId}">${isDrug == 'Y' ? '再次预定': '再次购买'}</a>
                        <a class="zhifu-btn3" href="${webRoot}/wap/module/member/logisticsDetail.ac?id=${orderProxy.orderId}">查看物流</a>
                        <c:if test="${orderProxy.isComment =='Y'}"><a class="zhifu-btn2" href="${webRoot}/wap/module/member/orderComment.ac?id=${orderProxy.orderId}">评价晒单</a></c:if>
                        <c:if test="${orderProxy.isComment =='N'}"><a class="zhifu-btn3" href="${webRoot}/wap/module/member/orderComment.ac?id=${orderProxy.orderId}">查看评价</a></c:if>
                    </div>
                </c:when>
                <c:when test="${orderStatusNm == '待评价'}">
                    <div class="list-zhifu">
                        <p>共<span class="sp-number">${orderProductNum}</span>件  ${isDrug == 'Y' ? '预定金额': '实付款'}:<span class="price">￥<fmt:formatNumber value="${orderProxy.orderTotalAmount}" type="number" pattern="#0.00#" /></span>
                            (含运费:¥<fmt:formatNumber value="${orderProxy.freightAmount}" type="number" pattern="#0.00#"/>)</p>
                        <a class="zhifu-btn2" href="${webRoot}/wap/module/member/orderComment.ac?id=${orderProxy.orderId}">评价晒单</a>
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
</c:if>
