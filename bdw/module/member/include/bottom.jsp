<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getSysParamValue('copyright')}" var="copyright"/> <%--版权--%>
<div id="footer">
    <%--商城信息 start--%>
    <div class="t">
        <div class="IcoList">
            <div class="ico01">400-420-4300</div>
            <div class="ico02">service@meiyungu.com</div>
            <div class="p_s01">15天免费退换货</div>
            <div class="p_s02">100%赠品保证</div>
            <div class="p_s03">满199免运费</div>
            <div class="clear"></div>
        </div>
    </div>
    <%--商城信息 end--%>
    <div class="b">
        <%--底部帮助中心开始--%>
        <div class="doList">
            <c:forEach items="${sdk:getArticleCategoryById(60000).children}" var="articleCategory">
                <dl style="">
                    <dt>${articleCategory.name}</dt>
                    <c:forEach items="${articleCategory.top5}" var="article">
                        <dd >
                            <a target="_blank" class="${param.infArticleId==article.infArticleId?'cur':''}"
                               href="${webRoot}/help-${article.infArticleId}.html" title="${article.title}">
                                    ${article.title}
                            </a>
                        </dd>
                    </c:forEach>
                </dl>
            </c:forEach>
        </div>
        <%--底部帮助中心结束--%>
        <%--底部友情链接开始--%>
        <div class="porduF">
            <div class="ico">
                <c:forEach items="${sdk:findPageModuleProxy('bottomFriendLink').links}" var="pageLinks" varStatus="s" >
                        <a target="_blank" href="${pageLinks.link}" title="${pageLinks.title}"><img alt="${pageLinks.title}" src="${pageLinks.icon}" height="36px" /></a>
                </c:forEach>
            </div>
            <p>
                <c:forEach items="${sdk:findPageModuleProxy('bottomNavLink').links}" var="pageLinks" varStatus="s" >
                        <a target="_blank" href="${pageLinks.link}" title="${pageLinks.title}">${pageLinks.title}</a>${!s.last?' | ':''}
                </c:forEach>
            </p>
            <p>技术支持：<a href="http://www.iloosen.com">乐商软件</a> ${copyright}</p>
        </div>
        <%--底部友情链接结束--%>
    </div>
</div>
