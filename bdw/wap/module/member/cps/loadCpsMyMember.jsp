<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<!DOCTYPE html>
<html>

<c:set value="${empty param.page ? 1 : param.page}" var="page"/>
<c:set value="${sdk:findOfflineMember(page,10)}" var="myOfflinePage"/>

<c:if test="${myOfflinePage.totalCount > 0}">
<ul class="member-list">
    <c:forEach items="${myOfflinePage.result}" var="offLine" varStatus="s">
        <li class="${offLine.isExpiration eq "Y" ? "disabled" : "new"}">
            <div class="entry-block">
                <a href="${webRoot}/wap/module/member/cps/cpsMyMemberDrawal.ac?sysUserId=${offLine.sysUserId}">
                    <i class="icon icon-angle-right"></i>
                                        <span class="img">
                                            <img src="${offLine.icon["150X150"]}" alt=""><%--原设计是60X60，暂时150X150，待调整--%>
                                        </span>
                    <span class="lab">${offLine.userNm}</span>
                    <span class="val">
                        <c:choose>
                            <c:when test="${offLine.isExpiration == 'Y'}">
                                已过期
                            </c:when>
                            <c:otherwise>剩余&nbsp;${offLine.cpsEndDate}&nbsp;天</c:otherwise>
                        </c:choose>
                    </span>
                </a>
            </div>
        </li>
    </c:forEach>
</ul>
</c:if>
