<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="userProxy"/>
<c:if test="${empty userProxy}">
    <c:redirect url="${webRoot}/wap/login.ac"></c:redirect>
</c:if>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="utf-8">
    <title>预定清单</title>
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="telephone=no,email=no" name="format-detection">

    <link href="${webRoot}/template/bdw/wap/statics/css/swiper.min.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/cart.css" rel="stylesheet" media="screen">

    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/cart.js" type="text/javascript"></script>
    <script type="text/javascript">
        var webPath = {
            webRoot:"${webRoot}",handler : "${empty param.handler ? 'sku' : param.handler}",carttype : "${empty param.carttype ? 'normal' : param.carttype}"
        };
    </script>
</head>
<c:set var="handler" value="${empty param.handler ? 'sku' : param.handler}"/>
<c:set var="carttype" value="${empty param.carttype ? 'normal' : param.carttype}"/>

<body>
<div class="m-top">
    <div class="toggle-box">
        <p onclick="window.location.href='${webRoot}/wap/shoppingcart/cart.ac?pIndex=cart'">购物车<span id="normalCartTotalNum"></span></p>
        <p class="cur">预定清单<span id="drugCartTotalNum"></span></p>
    </div>
    <a class="bianyi edit" href="javascript:;">编辑</a>
</div>

<div class="cart-main" style="padding-bottom: 3.09375rem;">
    <c:import url="/template/bdw/wap/shoppingcart/cartMainPanel.jsp?handler=${handler}&carttype=${carttype}"/>
</div>
</body>
</html>
