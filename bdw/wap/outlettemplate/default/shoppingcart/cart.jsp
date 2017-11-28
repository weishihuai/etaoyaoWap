<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="userProxy"/>
<c:if test="${empty userProxy}">
    <c:redirect url="${webRoot}/wap/login.ac"/>
</c:if>
<!DOCTYPE html>
<%
    response.setHeader("Cache-Control","no-store");
    response.setHeader("Pragrma","no-cache");
    response.setDateHeader("Expires",0);
%>
<c:set var="handler" value="${empty param.handler ? 'store' : param.handler}"/>
<c:set var="carttype" value="${empty param.carttype ? 'store' : param.carttype}"/>
<html>
<head lang="en">
    <meta charset="utf-8">
    <title>门店购物车</title>
    <meta HTTP-EQUIV="pragma" CONTENT="no-cache">
    <meta HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
    <meta HTTP-EQUIV="expires" CONTENT="0">
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="telephone=no,email=no" name="format-detection">

    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/outlettemplate/default/statics/css/cart.css" rel="stylesheet" media="screen">

    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/outlettemplate/default/statics/js/cart.js" type="text/javascript"></script>
    <script type="text/javascript">
        var webPath = {
            webRoot:"${webRoot}",
            handler : "${handler}",
            carttype : "${carttype}"
        };
    </script>
</head>


<body>
<div class="m-top">
    <div class="toggle-box">
        <p class="cur">购物车<span id="normalCartTotalNum"></span></p>
        <p onclick="window.location.href='${webRoot}/wap/outlettemplate/default/shoppingcart/drugCart.ac?carttype=store_drug&handler=store_drug'">预定清单<span id="drugCartTotalNum"></span></p>
    </div>
    <a class="bianyi edit" href="javascript:;">编辑</a>
</div>

<div class="cart-main" style="padding-bottom: 3.09375rem;">
    <c:import url="/template/bdw/wap/outlettemplate/default/shoppingcart/cartMainPanel.jsp?handler=${handler}&carttype=${carttype}"/>
</div>
</body>
</html>
