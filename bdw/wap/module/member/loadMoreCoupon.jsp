<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<c:set value="${sdk:getEffectiveCouponPage(5)}" var="unusedCoupon"/>  <%--未使用的--%>

<c:forEach items="${invalid.result}" var="invalidProxy">
    <div class="item">
        <div class="item-l">
            <p class="price"><span>¥</span>${invalidProxy.amount}</p>
            <c:forEach items="${invalidProxy.rules}" var="rule">
                <p class="precondition-price">${rule}</p>
            </c:forEach>
        </div>
        <div class="item-r">
            <p class="precondition-name">${invalidProxy.batchNm}</p>
            <p class="date">${invalidProxy.startTimeString}-${invalidProxy.endTimeString}</p>
        </div>
        <c:if test="${invalidProxy.invalidState=='USED'}"><i class="yishiyong"></i></c:if>
        <c:if test="${invalidProxy.invalidState=='expire'}"><i class="guoqi"></i></c:if>

    </div>
</c:forEach>
