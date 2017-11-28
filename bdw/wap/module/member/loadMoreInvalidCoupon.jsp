<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<c:set value="${sdk:getEffectiveCouponPage(param.limit)}" var="unusedCoupon"/>  <%--未使用的--%>

<%--获取当前用户--%>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>

    <c:forEach items="${unusedCoupon.result}" var="unusedProxy">
        <div class="item">
            <div class="item-l">
                <p class="price"><span>¥</span>${unusedProxy.amount}</p>
                <c:forEach items="${unusedProxy.rules}" var="sysGivenCouponProxy">
                    <p class="precondition-price">${sysGivenCouponProxy}</p>
                </c:forEach>
            </div>
            <div class="item-r">
                <p class="precondition-name">${unusedProxy.batchNm}</p>
                <p class="date">${unusedProxy.startTimeString}-${unusedProxy.endTimeString}</p>
                <a class="user-btn" href="javascript:void(0);"   onclick="window.location.href='${webRoot}/wap/productList.ac'">立即使用</a>
            </div>
            <c:if test="${unusedProxy.willExpire==true}"><i class="item-tips"></i></c:if>

        </div>
    </c:forEach>
