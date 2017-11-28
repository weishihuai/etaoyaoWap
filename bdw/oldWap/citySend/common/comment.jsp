<%--
  Created by IntelliJ IDEA.
  User: lhw
  Date: 2016/12/26
  Time: 8:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%--获取状态--%>
<c:set value="${param.stat == null || param.stat == '' ? 'all' : param.stat}" var="status"/>
<%--取出所有评论--%>
<c:set var="commentProxyResult" value="${bdw:findAllCommentProxy(1, param.orgId,status)}"/>

<c:forEach items="${commentProxyResult.result}" var="comentProxy">
  <li class="eval-item">
    <c:set value="${fn:substring(comentProxy.loginId, 0,3)}" var="mobileHeader"/><%-- 用户名前3位 --%>
    <c:set value="${fn:substring(comentProxy.loginId, 7,fn:length(comentProxy.loginId))}" var="mobileStern"/><%-- 用户名后4位 --%>
    <div class="from">
      <span>${mobileHeader}****${mobileStern}</span>
      <span><fmt:formatDate value="${comentProxy.createTime}" pattern="yyyy-MM-dd hh:mm"></fmt:formatDate></span>
    </div>
    <div class="stars">
      <c:set value="${5-comentProxy.score}" var="notActive"/>
      <c:forEach begin="1" end="${comentProxy.score}">
        <span class="active"></span>
      </c:forEach>
      <c:forEach begin="1" end="${notActive}">
        <span></span>
      </c:forEach>
    </div>
    <div class="cont">
      <p>${comentProxy.content}</p>
    </div>
    <c:if test="${not empty comentProxy.commentReplys}">
      <c:forEach items="${comentProxy.commentReplys}" var="reply">
        <div class="reply">
          <p>管理员回复:${reply.commentCont}</p>
        </div>
      </c:forEach>
    </c:if>
  </li>
</c:forEach>
