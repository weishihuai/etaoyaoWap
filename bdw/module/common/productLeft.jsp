<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="f" uri="/iMallTag" %>
<c:set var="productProxy" value="${sdk:getProductById(param.id)}"/>
<c:set var="categoryProxy" value="${productProxy.category}"/>
<c:set value="${sdk:getCategoryHotSalesProducts(categoryProxy.categoryId)}" var="categoryHotSalesProducts"/>
<c:set value="${sdk:getProductFromCookie(pageContext.request,pageContext.response)}" var="productFromCookies"/>
<div class="l_box01">
    <div class="b_layer">热卖推荐</div>
    <c:choose>
        <c:when test="${not empty categoryHotSalesProducts}">
            <div class="b_list">
                <c:forEach items="${categoryHotSalesProducts}" var="phoneList" varStatus="s" end="4">
                    <ul class="l_info">
                        <li class="i_pic">
                            <a target="_blank" href="${webRoot}/product-${phoneList.productId}.html" title="${phoneList.name}">
                                <img src="${empty phoneList.images ? phoneList.defaultImage['160X160'] : phoneList.images[0]['160X160']}" alt="${phoneList.name}" />
                            </a>
                        </li>
                        <li class="i_title"><a target="_blank" href="${webRoot}/product-${phoneList.productId}.html" title="">${phoneList.name}</a></li>
                        <li class="i_price"><i>￥</i><fmt:formatNumber value="${phoneList.price.unitPrice}" type="number" pattern="#0.00#" /></li>
                    </ul>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="b_list" style="margin-top: 16px; margin-bottom: 16px;">
                <i style="color:red; margin-top:5px;font-size: 15px;margin-left:47px;">暂无热卖产品</i>
            </div>
        </c:otherwise>
    </c:choose>

</div>
<c:if test="${param.p=='list'}">
    <div class="l_box01">
        <div class="b_title">品类热卖排行</div>
        <div class="b_list">
            <c:set value="${sdk:findMonthTopProducts(param.categoryId,9)}" var="hotsales"/>
            <c:forEach items="${hotsales}" var="phoneList" varStatus="s" end="10">
                <div class="l_rows cur categorySelling">
                    <div class="r_pic">
                        <a target="_blank" href="${webRoot}/product-${phoneList.productId}.html" title="${phoneList.name}">
                            <img src="${empty phoneList.images ? phoneList.defaultImage['120X120'] : phoneList.images[0]['120X120']}" alt="${phoneList.name}" />
                        </a>
                    </div>
                    <div class="r_icon">${s.count}</div>
                    <div class="r_popup" style="display: none;">
                        <div class="p_title"><a target="_blank" href="${webRoot}/product-${phoneList.productId}.html" title="">${phoneList.name}</a></div>
                        <div class="p_price"><i>￥</i><fmt:formatNumber value="${phoneList.price.unitPrice}" type="number" pattern="#0.00#" /></div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</c:if>

<div class="l_adv frameEdit" frameInfo="product_adv|200X300">
    <c:forEach items="${sdk:findPageModuleProxy('product_adv').advt.advtProxy}" var="advtProxys" varStatus="s" end="0">
        ${advtProxys.htmlTemplate}
    </c:forEach>
</div>

<div class="l_box02">
    <div class="b_layer">
        <i>我的足迹</i>
        <a href="javascript:;" onclick="clearHistoryProductsCookie()">清空</a>
    </div>
    <div class="b_info">
        <c:choose>
            <c:when test="${not empty productFromCookies}">
                <c:forEach items="${productFromCookies}" var="proxy" varStatus="s" end="5">
                    <ul class="row">
                        <li class="pic">
                            <a href="${webRoot}/product-${proxy.productId}.html" target="_blank"><img src="${proxy.defaultImage["60X60"]}" alt="${proxy.name}"/></a>
                        </li>
                        <li class="in">
                            <div class="title"><a href="${webRoot}/product-${proxy.productId}.html" target="_blank">${proxy.name}</a></div>
                            <div class="price"><i>￥</i><fmt:formatNumber value="${proxy.price.unitPrice}" type="number" pattern="#0.00#"/></div>
                        </li>
                    </ul>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <ul class="row" style="padding-top:15px;font-size: 15px;padding-left:28px;height: 30px;width: 170px;color: #666666;">你还未浏览其他商品</ul>
            </c:otherwise>
        </c:choose>
    </div>
</div>
