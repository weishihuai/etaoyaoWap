<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<%--商品评论--%>
<c:set var="commentProxyPage" value="${sdk:findProductComments(param.id,6)}"/>
<c:set var="page" value="${empty param.page ? 1 : param.page}"/>
<c:set var="commentProxyResult" value="${commentProxyPage.result}"/>

<c:if test="${not empty commentProxyResult}">
    <c:forEach items="${commentProxyResult}" var="commentProxy" varStatus="s">
      <div class="item">
        <div class="mc-top">
          <div class="pic"><img src="${commentProxy.icon['40X40']}" alt=""></div>
          <div class="user-name">
            <c:set value="${fn:substring(commentProxy.loginId, 0,1)}" var="mobileHeader"/><%-- 用户名第一位 --%>
            <c:set value="${fn:substring(commentProxy.loginId, fn:length(commentProxy.loginId) - 1,fn:length(commentProxy.loginId))}" var="mobileStern"/><%-- 用户名最后一位 --%>
            <span>${mobileHeader}***${mobileStern}</span>
            <i class="comment-item-star"><i class="real-star comment-stars-width${commentProxy.score}"></i></i>
          </div>
          <em>${commentProxy.createTimeString}</em>
        </div>
        <p>${commentProxy.content}</p>
        <c:set var="pics" value="${commentProxy.pics}"/>
        <c:set value="${fn:length(pics)}" var="commentPicsLength"/>
        <c:if test="${not empty pics}">
          <div class="cm-pic <c:if test="${commentPicsLength eq '4'}">four-pic</c:if>">
            <c:forEach var="commentPic" items="${pics}">
              <div class="pic-box"><img src="${commentPic}" alt=""><input class="bigPic" type="hidden" value="${commentPic}"></div>
            </c:forEach>
          </div>
        </c:if>
        <c:if test="${not empty commentProxy.commentReplys}">
          <c:forEach items="${commentProxy.commentReplys}" var="reply">
            <div class="reply">客服回复：${reply.commentCont}</div>
          </c:forEach>
        </c:if>
      </div>
    </c:forEach>
</c:if>


