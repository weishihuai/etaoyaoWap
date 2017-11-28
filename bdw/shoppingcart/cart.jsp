<%@ page import="com.iloosen.imall.commons.web.WebContextFactory" %>
<%@ page import="com.iloosen.imall.commons.helper.ServiceManagerSafemall" %>
<%@ page import="com.iloosen.imall.client.constant.bdw.IBdwShoppingCart" %>
<%@ page import="com.iloosen.imall.module.shoppingcart.domain.BdwShoppingCart" %>
<%@ page import="java.util.List" %>
<%@ page import="com.iloosen.imall.module.shoppingcart.domain.code.CartTypeEnum" %>
<%@ page import="com.iloosen.imall.module.shoppingcart.domain.UserCartList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>          <%--获取当前用户--%>
<c:if test="${empty loginUser}">
    <c:redirect url="/login.ac"></c:redirect>
</c:if>
<!DOCTYPE html>
<html>
<head>
    <script type="text/javascript">
        var webPath = {
            webRoot:"${webRoot}",
            handler : "${empty param.handler ? 'sku' : param.handler}",
            carttype : "${empty param.carttype ? 'normal' : param.carttype}",
            orgid : "${empty param.orgid ? '' : param.orgid}"
        };
    </script>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>购物车-${webName}</title>
    <link href="${webRoot}/template/bdw/statics/css/base.css" rel="stylesheet" type="text/css">
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/shopping-cart.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/jqGrid/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
</head>
<c:set var="handler" value="${empty param.handler ? 'sku' : param.handler}"/>
<c:set var="carttype" value="${empty param.carttype ? 'normal' : param.carttype}"/>
<%--页头logo--%>
<body>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/cartTop.jsp?p=cart&sta=1"/>
<%--页头结束--%>

<div class="main">
    <!--主体-->
    <div class="main-top">
        <div class="main-top-link cur">购物车<span id="normalCartTotalNum"></span></div>
        <div class="main-top-link"><a href="${webRoot}/shoppingcart/drugCart.ac?carttype=drug&handler=drug">需求清单<span id="drugCartTotalNum"></span></a></div>
        <div class="icon-bg"></div>
    </div>
    <c:import url="/template/bdw/shoppingcart/cartMainPanel.jsp?handler=${handler}&carttype=${carttype}" />
</div>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页头结束--%>
</body>
</html>