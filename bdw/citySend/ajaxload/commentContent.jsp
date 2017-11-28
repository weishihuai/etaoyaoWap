<%--
  Created by IntelliJ IDEA.
  User: lhw
  Date: 2016/11/24
  Time: 13:41
  To change this template use File | Settings | File Templates.
  已经没用了
--%>
<%@ taglib prefix="p" uri="/iMallTag" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${param.stat == null || param.stat == '' ? 'all' : param.stat}" var="status"/>
<%--取出所有评论--%>
<c:set var="commentProxyResult" value="${bdw:findAllCommentProxy(4, param.orgId,status)}"/>
<c:if test="${commentProxyResult.totalCount>0}">
  <c:if test="${commentProxyResult.totalCount>0}">
    <ul class="list">
      <c:forEach items="${commentProxyResult.result}" var="commentProxy">
        <c:set value="${fn:substring(commentProxy.loginId, 0,3)}" var="mobileHeader"/><%-- 用户名前3位 --%>
        <c:set value="${fn:substring(commentProxy.loginId, 7,fn:length(commentProxy.loginId))}" var="mobileStern"/><%-- 用户名后4位 --%>
        <li class="item">
          <div class="item-lft">
            <div class="grade-wrap">
              <span class="text">${mobileHeader}***${mobileStern}</span>
                  <span class="grade">
                      <span style="width: ${(commentProxy.score/5)*100}%;"></span>
                  </span>
            </div>
            <p>${commentProxy.content}</p>
          </div>
          <div class="item-rgt">
            <p>评论时间：<em>${commentProxy.createTimeString}</em></p>
            <a href="javascript:" class="zan">有用（${commentProxy.helpful}）</a>
          </div>
        </li>
      </c:forEach>
    </ul>

    <c:if test="${commentProxyResult.lastPageNumber>1}">
      <div class="pager">
        <div id="infoPage">
          <ul>
            <c:if test='${!commentProxyResult.firstPage}'>
              <li><a title="<c:choose><c:when test='${commentProxyResult.firstPage}'>目前已是第一页</c:when><c:otherwise>上一页</c:otherwise> </c:choose> " <c:if test='${!commentProxyResult.firstPage}'> onclick="syncCommentPage(${commentProxyResult.thisPageNumber-1},'${param.orgId}','${status}')" </c:if> class="upPage">上一页</a></li>
            </c:if>
            <c:forEach var="i" begin="1" end="${commentProxyResult.lastPageNumber}" step="1">
              <c:set var="displayNumber" value="6"/>
              <c:set var="startNumber" value="${(commentProxyResult.thisPageNumber -(commentProxyResult.thisPageNumber mod displayNumber))}"/>
              <c:set var="endNumber" value="${startNumber+displayNumber}"/>
              <c:if test="${(i>=startNumber) && (i<endNumber) }">
                <c:choose>
                  <c:when test="${i==commentProxyResult.thisPageNumber}">
                    <li><a class="nowPage">${i}</a></li>
                  </c:when>
                  <c:otherwise>
                    <li><a class="everyPage" onclick="syncCommentPage(${i},'${param.orgId}','${status}')">${i}</a></li>
                  </c:otherwise>
                </c:choose>
              </c:if>
            </c:forEach>
            <c:if test='${!commentProxyResult.lastPage}'>
              <li><a title="<c:choose> <c:when test='${commentProxyResult.lastPage}'>目前已是最后一页</c:when> <c:otherwise>下一页</c:otherwise> </c:choose> " class="downPage" <c:if test='${!commentProxyResult.lastPage}'> onclick="syncCommentPage(${commentProxyResult.thisPageNumber+1},'${param.orgId}','${status}')" </c:if> >下一页</a></li>
            </c:if>
            <li><div id="page-skip">&nbsp;&nbsp;第&nbsp;<input value="${commentProxyResult.thisPageNumber}" id="inputPage">&nbsp;页/${commentProxyResult.lastPageNumber}页<button class="goToPage" onclick="syncGoToCommentPage('${commentProxyResult.lastPageNumber}',${param.orgId}','${status}')" href="javascript:">确定</button></div></li>
          </ul>
        </div>
      </div>
    </c:if>
  </c:if>
</c:if>
