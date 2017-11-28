<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set var="productProxy" value="${sdk:getProductById(param.id)}"/>
<%-- 如果商品没有促销信息就不要显示促销那个div --%>
<c:set value="${empty productProxy.price.discountType && empty productProxy.presentProductList?'none':'block'}" var="isDisplayPromotion"/>
<div class="title">${productProxy.name}</div>
<div class="provide-srv"><span>${productProxy.salePoint}</span></div>
<div class="price"><span id="price">￥${productProxy.priceListStr}</span>
    <input type="hidden" id="priceListStr" priceNm="${productProxy.price.amountNm}" value="${productProxy.priceListStr}">

    <%-- 分享按钮在这里 --%>
    <c:if test="${isWeixin!='Y'}">
        <a href="#" data-toggle="modal" data-target="#share" class="share" onclick="centerJiaThis()"></a>
    </c:if>
</div>
<c:if test="${isWeixin!='Y'}">
<!-- 分享的div -->
<div class="modal fade" id="share" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="jiathis_style_m"></div>
                <script type="text/javascript" src="http://v3.jiathis.com/code/jiathis_m.js" charset="utf-8"></script>
                &nbsp;
            </div>
        </div>
    </div>
</div>
</c:if>
<div class="promotion" style="display: ${isDisplayPromotion}">
    <span>促销：</span>
    <div class="promotion-content">
        <%-- 限时抢貌似已经被删掉了，不过取数据和折扣一样 --%>
        <c:if test="${'PANIC_BUY' == productProxy.price.discountType}">
            <div class="pro-item">
                <i class="label-icon-div">限时抢</i>
                <em class="dt-div">此商品正参与平台"限时抢"优惠活动</em>
            </div>
        </c:if>

        <%-- 总平台定义，商家参加的活动 --%>
        <c:if test="${'PLATFORM_DISCOUNT' == productProxy.price.discountType}">
            <div class="pro-item">
                <i class="label-icon-div">活动</i>
                <em class="dt-div">此商品正参与平台优惠活动</em>
            </div>
        </c:if>

        <%-- 商家自己定义的直降活动,分两种情况:0代表直接降价N元，1代表打N折 --%>
        <c:if test="${'SPECIAL_PRICE' == productProxy.price.discountType}">
            <c:choose>
                <c:when test="${productProxy.panicBuyProductProxy.discountWayType == '0'}">
                    <div class="pro-item">
                        <i class="label-icon-div">折扣</i>
                        <em class="dt-div">直降减${productProxy.panicBuyProductProxy.saveMoney}元</em>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="pro-item">
                        <i class="label-icon-div">折扣</i>
                        <em class="dt-div">直降打${productProxy.panicBuyProductProxy.discount}折</em>
                    </div>
                </c:otherwise>
            </c:choose>
        </c:if>

        <%-- 只考虑单品赠品的情况 --%>
        <c:if test="${not empty productProxy.presentProductList}">
            <div class="pro-item">
                <i class="label-icon-div">赠品</i>
                <c:forEach items="${productProxy.presentProductList}" var="present">
                    <em class="dt-div">
                        <div class="pic"><a href="${webRoot}/wap/product.ac?id=${present.productId}"><img src="${bdw:getProductImageUrl(present.productId)}" style="height: 100%;width:100%"></a></div>
                        <a href="${webRoot}/wap/product.ac?id=${present.productId}" class="gift-name elli">${present.productNm}</a>
                    </em>
                </c:forEach>
            </div>
        </c:if>
    </div>
</div>


