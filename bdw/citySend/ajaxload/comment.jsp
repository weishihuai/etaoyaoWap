<%--
  Created by IntelliJ IDEA.
  User: lhw
  Date: 2016/11/23
  Time: 20:38
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="p" uri="/iMallTag" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%--获取状态--%>
<c:set value="${param.stat == null || param.stat == '' ? 'all' : param.stat}" var="status"/>
<%--取出所有评论--%>
<c:set var="commentProxyResult" value="${bdw:findAllCommentProxy(10, param.orgId,status)}"/>

<%--总评数--%>
<c:set var="allCommentCount" value="${bdw:getAllCommentCountByOrgId(param.orgId)}"/>
<%--好评数--%>
<c:set var="goodCommentCount" value="${bdw:getGoodCommentCountByOrgId(param.orgId)}"/>
<%--中评数--%>
<c:set var="normalCommentCount" value="${bdw:getNormalCommentCountByOrgId(param.orgId)}"/>
<%--差评数--%>
<c:set var="badCommentCount" value="${bdw:getBadCommentCountByOrgId(param.orgId)}"/>

<div class="evaluate">
  <ul class="tab-nav" id="commentNav">
    <li class="tabComment all <c:if test="${status eq 'all'}">active</c:if>" orgid="${param.orgId}" rel="all"><a href="javascript:">全部评价(${allCommentCount})</a></li>
    <li class="tabComment good <c:if test="${status eq 'good'}">active</c:if>" orgid="${param.orgId}" rel="good"><a href="javascript:">好评(${goodCommentCount})</a></li>
    <li class="tabComment normal <c:if test="${status eq 'normal'}">active</c:if>" orgid="${param.orgId}" rel="normal"><a href="javascript:">中评(${normalCommentCount})</a></li>
    <li class="tabComment bad <c:if test="${status eq 'bad'}">active</c:if>" orgid="${param.orgId}" rel="bad"><a href="javascript:">差评(${badCommentCount})</a></li>
  </ul>
  <div id="commentContent">
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
              <c:if test="${not empty commentProxy.commentReplys}">
                <c:forEach items="${commentProxy.commentReplys}" var="commentSession">
                  <div class="service-rp">
                    <span>客服回复：</span>
                    <div class="rp-cont">${commentSession.commentCont}</div>
                  </div>
                </c:forEach>
              </c:if>
            </div>
            <div class="item-rgt">
              <p>评论时间：<em>${commentProxy.createTimeString}</em></p>
              <a href="javascript:" id="${commentProxy.sysCommentId}_Enable" class="zan addHelpful" commentId="${commentProxy.sysCommentId}" onclick="enableComment('${commentProxy.sysCommentId}','#${commentProxy.sysCommentId}_Enable');">有用(<span class="helpful${commentProxy.sysCommentId}">${commentProxy.helpful}</span>)</a>
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
              <li><div id="page-skip">&nbsp;&nbsp;第&nbsp;<input value="${commentProxyResult.thisPageNumber}" id="inputPage">&nbsp;页/${commentProxyResult.lastPageNumber}页<button class="goToPage" onclick="syncGoToCommentPage('${commentProxyResult.lastPageNumber}','${param.orgId}','${status}')" href="javascript:">确定</button></div></li>
            </ul>
          </div>
        </div>
      </c:if>
    </c:if>
  </div>
</div>


