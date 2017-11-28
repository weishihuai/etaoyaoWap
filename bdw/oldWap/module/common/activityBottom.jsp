
<%--
  Created by IntelliJ IDEA.
  User: lhw
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<%--取出活动主题--%>
<c:set value="${bdw:getAllMarketingSubjectSection()}" var="marketingSubjectSectionList"/>

<c:choose>
    <c:when test="${not empty param.subjectSectionId}">
        <c:set value="${param.subjectSectionId}" var="subjectSectionId"/>
    </c:when>
    <c:otherwise>
        <%--默认选中第一个主题--%>
        <c:if test="${not empty marketingSubjectSectionList}">
            <c:forEach items="${marketingSubjectSectionList}" var="marketingSubjectSection" varStatus="status" end="0">
                <c:set value="${marketingSubjectSection.marketingSubjectSectionId}" var="subjectSectionId"/>
            </c:forEach>
        </c:if>
    </c:otherwise>
</c:choose>

<c:if test="${not empty marketingSubjectSectionList}">
    <div class="bottom-item">
        <nav class="bottom-nav">
            <c:forEach items="${marketingSubjectSectionList}" var="subjectSection" varStatus="status" end="2">
                <c:set value="${bdw:getMarketingSubjectSectionById(subjectSection.marketingSubjectSectionId)}" var="subjectSection"/>
                <a class="bottom-link <c:if test="${subjectSection.marketingSubjectSectionId eq subjectSectionId}">cur</c:if>" href="${webRoot}/wap/limitActivity.ac?subjectSectionId=${subjectSection.marketingSubjectSectionId}">
                    <c:if test="${status.index eq 0}">
                        <i class="icon-ms"></i>
                    </c:if>
                    <c:if test="${status.index eq 1}">
                        <i class="icon-lmt"></i>
                    </c:if>
                    <c:if test="${status.index eq 2}">
                        <i class="icon-pft"></i>
                    </c:if>
                    <span>${fn:substring(subjectSection.sectionNm, 0, 6)}</span>
                </a>
            </c:forEach>
        </nav>
    </div>
</c:if>