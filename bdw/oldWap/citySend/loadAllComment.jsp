<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/1/7
  Time: 10:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<c:set var="commentProxyPage" value="${sdk:findProductComments(param.productId,param.limit)}"/>
<c:set var="commentProxyResult" value="${commentProxyPage.result}"/>

<c:if test="${not empty commentProxyResult}">
    <c:forEach items="${commentProxyResult}" var="commentProxy" varStatus="s">
        <dd class="item">
            <div class="from">
                <span class="fl">${commentProxy.userName}</span>
                <span class="fr">${commentProxy.createTimeString}</span>
            </div>
            <div class="stars">
                <c:forEach begin="1" end="${commentProxy.score}">
                    <span class="active"></span>
                </c:forEach>
                <c:if test="${commentProxy.score < 5}">
                    <c:forEach begin="${commentProxy.score}" end="4">
                        <span></span>
                    </c:forEach>
                </c:if>
            </div>
            <p class="cont">${commentProxy.content}</p>
            <c:if test="${not empty commentProxy.commentReplys}">
                <c:forEach items="${commentProxy.commentReplys}" var="reply">
                    <div class="reply"
                         style="line-height: 2rem; border: 1px solid #666; font-size: 1.2rem; color: #333;">
                        <p>店家回复：${reply.commentCont}</p>
                    </div>
                </c:forEach>
            </c:if>
        </dd>
    </c:forEach>
</c:if>

