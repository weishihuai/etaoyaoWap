<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<!--品牌大全-->
<div class="all-brand">
    <div class="mt">品牌大全</div>
    <div class="mc">
        <div class="mc-lt frameEdit" frameInfo="sy_brand_logo">
            <c:forEach items="${sdk:findPageModuleProxy('sy_brand_logo').advt.advtProxy}" var="advt" varStatus="s" end="0">
              <%--<img src="${advt.advUrl}">--%>
              <%--<img class="lazy" data-original="${advt.advUrl}">--%>
                ${advt.htmlTemplate}
            </c:forEach>
        </div>
        <div class="mc-rt frameEdit" frameInfo="sy_brands">
            <c:set value="${sdk:findPageModuleProxy('sy_brands').advt.advtProxy}" var="advtBrands"/>
            <c:set value="${fn:length(advtBrands)}" var="brandSize"/>
            <ul brandSize="${brandSize}" id="brandUl">
                <c:forEach items="${advtBrands}" var="advt" varStatus="s">
                  <li <c:if test="${s.count>11}">style="display: none;" </c:if> class="bad brand${s.count}">
                      <%--<a href="${advt.link}" target="_blank">--%>
                          <%--<img src="${advt.advUrl}" alt="${advt.title}">--%>
                      <%--</a>--%>
                              ${advt.htmlTemplate}

                  </li>
                </c:forEach>
                <li class="change"><a href="javascript:void(0);" page="0" onclick="changeBrands(this);" isFirst="true">换一批</a></li>
            </ul>
        </div>
    </div>
</div>
<!--友情链接-->
<div class="f-links">
    <div class="fk-mt">
        <ul id="f-links-mt">
            <li class="cur"><a href="">友情链接</a></li>
        </ul>
    </div>
    <div class="fk-mc frameEdit" frameInfo="sy_friend_links">
        <c:forEach items="${sdk:findPageModuleProxy('sy_friend_links').links}" var="link" varStatus="s">
          <a href="${link.link}" title="${link.title}" target="_blank">${link.title}</a>
          <c:if test="${!s.last}">
            <span>|</span>
          </c:if>
        </c:forEach>
    </div>
</div>