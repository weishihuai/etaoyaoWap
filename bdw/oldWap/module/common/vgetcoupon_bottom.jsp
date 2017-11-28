<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://www.iloosen.com/weixinSdk" prefix="vsdk" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${vsdk:getCurrentActivityProxy()}" var="vcouponActivityProxy"/>
<div class="row">
    <div class="col-xs-12"><a role="button" class="btn btn-block b_btn" href="${webRoot}/wap/module/member/myCoupon.ac">查看我的购物券</a></div>
</div>
<c:if test="${not empty vcouponActivityProxy.vcouponActivityVoList[0].description}">
<div class="row">
    <div class="col-xs-12"><i class="b_icon">购物券须知：</i></div>
</div>
<div class="row">
    <pre class="col-xs-12 b_text">
        ${vcouponActivityProxy.vcouponActivityVoList[0].description}
    </pre>
</div>
</c:if>
