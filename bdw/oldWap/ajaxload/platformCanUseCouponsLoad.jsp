<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set var="carttype" value="${empty param.carttype ? 'normal' : param.carttype}"/>
<c:set value="${sdk:findUserCouponList(carttype, param.orgId)}" var="userCouponList"/>
<script type="text/javascript" src="${webRoot}/template/bdw/wap/ajaxload/js/useCouponsLoad.js"></script>
<em>优惠券：</em>
<select class="coupon" carttype="${carttype}" orgId='${param.orgId}'>
    <option value="-1">请选择购物券...</option>
    <option value="0">不使用购物劵</option>
    <c:forEach items="${userCouponList}" var="userCoupon">
        <option value="${userCoupon.couponId}">【${userCoupon.amount}元】${userCoupon.couponNum}</option>
    </c:forEach>
</select>