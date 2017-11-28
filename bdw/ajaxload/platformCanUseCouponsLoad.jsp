<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set var="carttype" value="${empty param.carttype ? 'normal' : param.carttype}"/>
<c:set value="${sdk:findUserCouponList(carttype, param.orgId)}" var="userCouponList"/> <%--可以使用的购物劵--%>
<c:set value="${sdk:getCurrSelectCoupons(carttype,param.sysOrgId)}" var="useCoupons"/> <%--已经选择的购物劵--%>
<script type="text/javascript" src="${webRoot}/template/bdw/ajaxload/js/userCouponsListLoad.js"></script>
<select name="couponIds" class="coupon put couponIds" style="border: 1px solid #cccccc; height: 28px; margin-bottom: 5px" carttype="${carttype}" orgId='${param.orgId}'>
    <option value="-1">已使用购物券...</option>
    <option value="0">不使用购物劵</option>
    <c:forEach items="${userCouponList}" var="userCoupon">
        <c:if test="${empty useCoupons}">
            <option value="${userCoupon.couponId}">${userCoupon.batchNm}【${userCoupon.amount}元】</option>
        </c:if>
    </c:forEach>
</select>