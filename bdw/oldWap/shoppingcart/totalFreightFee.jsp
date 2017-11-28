<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set var="carttype" value="${empty param.carttype ? 'normal' : param.carttype}"/>
<c:set value="${sdk:getUserCartListProxy(carttype)}" var="userCartListProxy"/>

${userCartListProxy.freightTotalAmount}

<script>
    alert("${userCartListProxy.freightTotalAmount}");
</script>




