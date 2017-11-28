<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:searchShopInfProxy(10)}" var="shopInfPage"/>
<table>
    <thead>
    <tr>
        <th class="tit-companyNm">企业全称</th>
        <th class="tit-companyContactCeo">运营负责人</th>
        <th class="tit-companyContactPhone">手机号码</th>
    </tr>
    </thead>
    <tbody id="product">
    <c:forEach items="${shopInfPage.result}" var="shopProxy" varStatus="s">
        <tr shopId="${shopProxy.shopInfId}" companyNm="${shopProxy.companyNm}" onclick="getValueToSet(this)">
            <td>${shopProxy.companyNm}</td>
            <td>${shopProxy.companyContactCeo}</td>
            <td>${shopProxy.companyContactPhone}</td>
        </tr>
    </c:forEach>
    <c:if test="${empty shopInfPage.result}">
        <tr >
            <td colspan="6" style="height: 80px;line-height: 80px;font-size: 14px;color: #297ed9;">
                <span style="float: none;">没找到相关的企业哦，要不您换个关键词我帮您再找找看</span>
            </td>
        </tr>
    </c:if>
    </tbody>
</table>
