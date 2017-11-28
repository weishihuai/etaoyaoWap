<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<script type="text/javascript">
    var goToUrl = function(url){
        setTimeout(function(){window.location.href=url},1)
    };
    var Top_Path = {webRoot:"${webRoot}"};
</script>
<div class="shopEdit" shopInfo="shop_logo|980X100">
    <c:forEach items="${sdk:findShopPageModuleProxy(param.shopId, 'shop_logo').advt.advtProxy}" var="adv" end="0" varStatus="s">
        <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="980px" height="100px" /></a>
    </c:forEach>
</div>
<div class="shop_menu">
    <ul>
        <li><a class="${param.p=='index'?'cur':''}" href="${webRoot}/shopTemplate/default/shopIndex.ac?shopId=${param.shopId}">店铺首页</a></li>
        <li><a class="${param.p=='list'?'cur':''}" href="${webRoot}/shopTemplate/default/shopProductList.ac?shopId=${param.shopId}">全部商品</a></li>
        <%--     <li><a href="#">店铺信誉</a></li>
       <li><a href="#">购物指南</a></li>
       <li><a href="#">公司简介</a></li>
       <li><a href="#">购物须知</a></li>
       <li><a href="#">支付流程</a></li>--%>
        <div class="shopEdit" shopInfo="shop_navbar">
            <c:forEach items="${sdk:findShopPageModuleProxy(param.shopId,'shop_navbar').links}" var="pageLinks" end="4" varStatus="s">
                <li><a title="${pageLinks.title}" target="_blank" href="${pageLinks.link}">${pageLinks.title}</a></li>
            </c:forEach>
        </div>
    </ul>
</div>
