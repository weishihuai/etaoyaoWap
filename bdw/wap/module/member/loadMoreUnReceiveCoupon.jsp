<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<%--获取可以领的券--%>
<c:set value="${bdw:pageEffectiveGivenCouponRule(param.limit)}" var="effectiveGivenCouponRule"/>
<c:set value="${effectiveGivenCouponRule.result}" var="effectiveGivenCouponRuleList"/>

<c:forEach items="${effectiveGivenCouponRuleList}" var="sysGivenCouponProxy" varStatus="status">
    <div class="item">
        <div class="item-l">
            <p class="price"><span>¥</span>${sysGivenCouponProxy.amount}</p>
            <c:forEach items="${sysGivenCouponProxy.rules}" var="rule">
                <p class="precondition-price">${rule}</p>
            </c:forEach>
        </div>
        <div class="item-r">
            <p class="precondition-name">
                <c:choose>
                    <c:when test="${fn:length(sysGivenCouponProxy.title) > 34}">
                        ${fn:substring(sysGivenCouponProxy.title,0 , 34)}......
                    </c:when>
                    <c:otherwise>
                        ${sysGivenCouponProxy.title}
                    </c:otherwise>
                </c:choose>
            </p>
            <p class="date">${sysGivenCouponProxy.startTimeString}-${sysGivenCouponProxy.endTimeString}</p>
            <c:choose>
                <c:when test="${ sysGivenCouponProxy.receiveOrNot== true}">
                    <a class="btn2" href="javascript:void(0);"  onclick="window.location.href='${webRoot}/wap/productList.ac'">立即使用</a>
                </c:when>
                <c:otherwise>
                    <a class="btn1" href="javascript:void(0);"
                       onclick="receiveCoupon('${sysGivenCouponProxy.ruleLinke}',this,webPath)">立即领取</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</c:forEach>

