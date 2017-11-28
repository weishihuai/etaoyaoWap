<%--
  Created by IntelliJ IDEA.
  User: lhw
  Date: 2016/12/24
  Time: 16:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${empty param.page ? 1 : param.page}" var="_page"/>
<%--获取状态--%>
<c:set value="${param.stat == null || param.stat == '' ? 'all' : param.stat}" var="status"/>
<script type="text/javascript">
  var webPath = {webRoot:"${webRoot}",orgId:'${param.orgId}',status:'${status}'};
</script>

<%--取出所有评论--%>
<c:set var="commentProxyResult" value="${bdw:findAllCommentProxy(1, param.orgId,status)}"/>

<%--总评数--%>
<c:set var="allCommentCount" value="${bdw:getAllCommentCountByOrgId(param.orgId)}"/>
<%--好评数--%>
<c:set var="goodCommentCount" value="${bdw:getGoodCommentCountByOrgId(param.orgId)}"/>
<%--中评数--%>
<c:set var="normalCommentCount" value="${bdw:getNormalCommentCountByOrgId(param.orgId)}"/>
<%--差评数--%>
<c:set var="badCommentCount" value="${bdw:getBadCommentCountByOrgId(param.orgId)}"/>

<ul class="tab-nav" id="com_tab">
  <li class="all <c:if test="${status eq 'all'}">active</c:if>" orgid="${param.orgId}" rel="all">全部评价<span>${allCommentCount}</span></li>
  <li class="good <c:if test="${status eq 'good'}">active</c:if>" orgid="${param.orgId}" rel="good">好评<span>${goodCommentCount}</span></li>
  <li class="normal <c:if test="${status eq 'normal'}">active</c:if>" orgid="${param.orgId}" rel="normal">中评<span>${normalCommentCount}</span></li>
  <li class="bad <c:if test="${status eq 'bad'}">active</c:if>" orgid="${param.orgId}" rel="bad">差评<span>${badCommentCount}</span></li>
</ul>

<ul class="eval-list" id="commentList">
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
</ul>

<c:if test="${!commentProxyResult.lastPage}">
  <div class="more" style="height: 40px;line-height: 40px;text-align: center;margin-bottom: 40px;"><a href="javascript:void(0);" id="moreLoad" style="display: inline-block;width: 40%;margin-top: 10px;background-color:#fff; color:#e7141a;border-radius: 48px;">点击加载更多</a></div>
</c:if>