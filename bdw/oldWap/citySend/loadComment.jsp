<%--
  Created by IntelliJ IDEA.
  User: zxh
  Date: 2016/12/30
  Time: 9:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set var="commentProxyResult" value="${bdw:findAllCommentProxy(param.limit, param.orgId, param.stat)}"/>

<c:choose>
    <c:when test="${commentProxyResult.totalCount !=0}">
        <ul class="eval-list commentList">
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
                    <div class="cont" style="word-wrap:break-word;">
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
    </c:when>
    <c:otherwise>
        <ul class="eval-list commentList noComment">
            <li class="eval-item">
                查询不到相关数据
            </li>
        </ul>
    </c:otherwise>
</c:choose>
