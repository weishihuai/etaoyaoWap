<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set var="carttype" value="${empty param.carttype ? 'normal' : param.carttype}"/>
<c:set value="${sdk:getCurrSelectCoupons(carttype,param.orgId)}" var="useCoupons"/> <%--已经选择的购物劵--%>
<script type="text/javascript" src="${webRoot}/template/bdw/ajaxload/js/useCouponsLoad.js"></script>
<c:if test="${not empty useCoupons}">
    <div style="float:left;font-weight:bold;margin-top:5px;margin-left:5px;">
        使用的购物劵：
    </div>
    <ul>
        <c:forEach items="${useCoupons}" var="useCoupon">
            <li style="float:left;background:#61B80D;text-align:center;height:20px;line-height:20px;border-radius:2px;margin:5px;margin-left:0px;">
                <a style="color:#FFF;" href="javascript:void(0);" title="${useCoupon.couponNum}">${sdk:cutString(useCoupon.couponNum,40,'')}【${useCoupon.amount}元】</a>
                <%--<a class="cancelUseCoupon cp1${param.orgId}" style="float:right;font-weight:bold;font-size:16px;width:20px;background:#EEBD11;color:#FFF;" href="javascript:" couponId="${useCoupon.couponId}"  carttype="${carttype}" orgId="${param.orgId}">X</a>--%>
            </li>
        </c:forEach>
    </ul>
</c:if>