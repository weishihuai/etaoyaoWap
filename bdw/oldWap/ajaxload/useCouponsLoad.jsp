<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set var="carttype" value="${empty param.carttype ? 'normal' : param.carttype}"/>
<c:set value="${sdk:getCurrSelectCoupons(carttype,param.orgId)}" var="useCoupons"/><%--已经选择的购物劵--%>
<script type="text/javascript" src="${webRoot}/template/bdw/wap/ajaxload/js/useCouponsLoad.js"></script>
<c:if test="${not empty useCoupons}">
    <ul class="list-unstyled">
        <c:forEach items="${useCoupons}" var="useCoupon">
            <li style="float:left;background:#61B80D;text-align:center;height:20px;line-height:20px;border-radius:2px;margin:5px;">
                <a style="color:#FFF;" href="javascript:" title="${useCoupon.couponNum}">
                        ${sdk:cutString(useCoupon.couponNum,40,'')}【${useCoupon.amount}元】
                </a>
            </li>
        </c:forEach>
    </ul>
</c:if>