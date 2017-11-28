<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%--取出商品--%>
<c:set var="productProxy" value="${sdk:getProductById(param.id)}"/>
<%-- 获取当前商家 --%>
<c:set value="${sdk:getShopInfProxyById(productProxy.shopInfId)}" var="shopInf"/>
<%-- 获取店铺促销商品的数量 --%>
<c:set value="${bdw:getDiscountProductNum(shopInf.sysOrgId)}" var="discountProductNum"/>
<%-- 获取店铺新上架商品的数量 --%>
<c:set value="${bdw:getNewProductNum(shopInf.sysOrgId)}" var="newProductNum"/>
<%-- 获取店铺所有商品的数量 --%>
<c:set value="${bdw:getTotalProductNum(shopInf.sysOrgId)}" var="totalProductNum"/>
<div class="s-logo"><img src="${shopInf.images[0]["100X100"]}" style="height: 100%;width:100%"></div>
<span class="name">${shopInf.shopNm}</span>
<div class="st-mc">
    <div class="st-item">
        <span>${totalProductNum}</span><br>
        <em>全部商品</em>
    </div>
    <div class="st-item">
        <span>${newProductNum}</span><br>
        <em>新品上架</em>
    </div>
    <div class="st-item">
        <span>${discountProductNum}</span><br>
        <em>促销商品</em>
    </div>
</div>
<div class="st-mb">
    <a href="#">收藏店铺</a>
    <a href="#">进店逛逛</a>
</div>



