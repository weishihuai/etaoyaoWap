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
            handler : "${empty param.handler ? 'drug' : param.handler}",
            carttype : "${empty param.carttype ? 'drug' : param.carttype}",
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
    <%--页头logo--%>
    <%
        String carttype = (String)request.getParameter("carttype") ==null?"drug":(String)request.getParameter("carttype");
        //2015-11-30 lhw 因购物车只有在登录的时候才填充，为了避免不同浏览器购物车不同步的情况，当刷新页面时需要重新加载购物车
        Integer loginUserId = WebContextFactory.getWebContext().getFrontEndUserId();
        if(loginUserId != null){
            List<BdwShoppingCart> bdwShoppingCartList = ServiceManagerSafemall.bdwShoppingCartService.findByKey(IBdwShoppingCart.USER_ID, loginUserId);
            if(CartTypeEnum.NORMAL.toCode().equals(carttype)){
                UserCartList userCartList = ServiceManager.shoppingCartStoreService.getUserCartList(CartTypeEnum.fromCode(carttype), loginUserId);
                ServiceManager.shoppingCartStoreService.removeUserCartList(userCartList);
                if(!bdwShoppingCartList.isEmpty()){
                    ServiceManagerSafemall.bdwShoppingCartService.addCart(CartTypeEnum.NORMAL.toCode());
                }
            }else if(CartTypeEnum.DRUG.toCode().equals(carttype)){
                UserCartList userCartList = ServiceManager.shoppingCartStoreService.getUserCartList(CartTypeEnum.fromCode(carttype), loginUserId);
                ServiceManager.shoppingCartStoreService.removeUserCartList(userCartList);
                if(!bdwShoppingCartList.isEmpty()){
                    ServiceManagerSafemall.bdwShoppingCartService.addCart(CartTypeEnum.DRUG.toCode());
                }
            }
        }
    %>
</head>
<c:set var="handler" value="${empty param.handler ? 'drug' : param.handler}"/>
<c:set var="carttype" value="${empty param.carttype ? 'drug' : param.carttype}"/>
<%--页头logo--%>

<c:set value="${sdk:getUserCartListProxy('normal')}" var="userCartListProxy"/>      <!--普通购物车-->
<c:set value="${sdk:getUserCartListProxy('drug')}" var="userDrugCartListProxy"/>  <!--药品购物车-->

<c:set value="${userCartListProxy.allDiscount}" var="allDiscount" />
<c:set value="${userCartListProxy.allDeliveryDiscount}" var="allDeliveryDiscount" />
<c:set var="noProductPic50" value="${webRoot}/template/bdw/statics/images/noPic_50X50.jpg"/>
<body>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/cartTop.jsp?p=drug&sta=1"/>
<%--页头结束--%>

<div class="main">
    <!--主体-->
    <div class="main-top">
        <div class="main-top-link"><a href="${webRoot}/shoppingcart/cart.ac">购物车<span id="normalCartTotalNum">${userCartListProxy.allCartNum == 0 ?'':userCartListProxy.allCartNum }</span></a></div>
        <div class="main-top-link cur">需求清单<span id="drugCartTotalNum">${userDrugCartListProxy.allCartNum == 0 ?'':userDrugCartListProxy.allCartNum}</span></div>
        <div class="icon-bg icon-bg2"></div>
    </div>
    <c:choose>
        <c:when test="${userDrugCartListProxy.allCartNum <= 0}">
            <div class="main-shopping-cart" id="cart">
                <div class="null-cart">
                    <div class="icon"></div>
                    <div class="null-cart-txt">
                        <p>购物车还是空空的呢，</p>
                        <p>前往<a href="${webRoot}/index.ac">首页</a>逛逛~~</p>
                    </div>
                </div>
            </div>
        </c:when>
        <c:otherwise>
                <div class="main-shopping-cart" id="cart">
                    <c:import url="/template/bdw/shoppingcart/cartMainPanel.jsp?handler=${handler}&carttype=${carttype}" />
                </div>
        </c:otherwise>
    </c:choose>
</div>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页头结束--%>
</body>
</html>