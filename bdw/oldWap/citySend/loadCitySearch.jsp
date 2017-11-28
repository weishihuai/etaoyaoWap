<%--
  Created by IntelliJ IDEA.
  User: zxh
  Date: 2016/12/30
  Time: 9:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${bdw:findWapCitySendProductPage(param.limit)}" var="productProxys"/>

<c:if test="${productProxys.totalCount !=0}">
    <ul class="search-list">
        <c:forEach items="${productProxys.result}" var="productProxy">
            <li>
                <div class="prdItem">
                    <%-- 获取商家 --%>
                    <c:set value="${bdw:getShopInfProxyByOrgId(productProxy.sysOrgId)}" var="store"/>
                    <a href="javascript:" orgId="${store.sysOrgId}" isSupportBuy="${store.isSupportBuy}" onclick="gotoStore(this);">
                        <span class="img fl">
                            <img src="${productProxy.defaultImage["60X60"]}" alt="${productProxy.name}" style="width:100%;height: 100%;">
                        </span>
                        <span class="val fl" style="max-width: 85%;white-space: normal;">${productProxy.name}</span>
                            <%--<span class="fr">配送费￥10</span>--%>
                    </a>
                </div>
                <div class="prdItem">
                    <span class="shopNm" style="white-space: normal;font-size: 1.2rem;">(${productProxy.shopInfProxy.shopNm})</span>
                </div>
            </li>
        </c:forEach>
    </ul>
</c:if>