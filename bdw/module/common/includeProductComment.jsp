<%@ taglib prefix="p" uri="/iMallTag" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<%--取出商品--%>
<c:set var="productProxy" value="${sdk:getProductById(param.id)}"/>
<%--商品评论统计--%>
<c:set var="commentStatistics" value="${productProxy.commentStatistics}"/>
<%--商品评论--%>
<c:set var="commentProxyPage" value="${sdk:findProductComments(param.id,10)}"/>
<c:set var="commentProxyResult" value="${commentProxyPage.result}"/>

<ul>
    <c:forEach items="${commentProxyResult}" var="commentProxy" varStatus="num">
        <li class="comment-list">
            <p class="time"><fmt:formatDate value="${commentProxy.createTime}" pattern="yyyy-MM-dd HH:mm"/></p>
            <div class="cont">
                <p>
                    <c:set value="${fn:substring(commentProxy.loginId, 0,3)}" var="mobileHeader"/><%-- 用户名前3位 --%>
                    <c:set value="${fn:substring(commentProxy.loginId, 7,fn:length(commentProxy.loginId))}" var="mobileStern"/><%-- 用户名后4位 --%>
                    <span class="txt">${mobileHeader}****${mobileStern}</span>
                    <span class="star-box">
                      <c:forEach begin="1" end="${commentProxy.score}">
                          <i class="icon-star active"></i>
                      </c:forEach>
                </span>
                </p>
                <p>${commentProxy.content}</p>
                <c:if test="${not empty commentProxy.commentReplys}">
                    <c:forEach items="${commentProxy.commentReplys}" var="commentSession">
                        <p class="text-danger">客服回复：${commentSession.commentCont}</p>
                    </c:forEach>
                </c:if>
            </div>
        </li>
    </c:forEach>
</ul>
<c:if test="${commentProxyPage.lastPageNumber>1}">
    <div class="page-footer" style="margin-bottom:0;">
        <ul >
            <li>
                <c:if test='${!commentProxyPage.firstPage}'>
                    <a href="javascript:;" class="upPage" onclick="syncPage(${commentProxyPage.thisPageNumber-1},'${param.id}')">上一页</a>
                </c:if>
                <c:if test='${commentProxyPage.firstPage}'>
                    <span href="javascript:;" class="upPage" >上一页</span>
                </c:if>
            </li>
            <c:forEach var="i" begin="1" end="${commentProxyPage.lastPageNumber}" step="1">
                <c:set var="displayNumber" value="6"/>
                <c:set var="startNumber" value="${(commentProxyPage.thisPageNumber -(commentProxyPage.thisPageNumber mod displayNumber))}"/>
                <c:set var="endNumber" value="${startNumber+displayNumber}"/>
                <c:if test="${(i>=startNumber) && (i<endNumber) }">
                    <c:choose>
                        <c:when test="${i==commentProxyPage.thisPageNumber}">
                            <li><span class="nowPage">${i}</span></li>
                        </c:when>
                        <c:otherwise>
                            <li><a href="javascript:;" class="everyPage" onclick="syncPage(${i},'${param.id}')">${i}</a></li>
                        </c:otherwise>
                    </c:choose>
                </c:if>
            </c:forEach>
            <li>
                <c:if test='${!commentProxyPage.lastPage}'>
                    <a href="javascript:;" class="downPage" onclick="syncPage(${commentProxyPage.thisPageNumber+1},'${param.id}')">下一页</a>
                </c:if>
                <c:if test='${commentProxyPage.lastPage}'>
                    <span href="javascript:;" class="downPage" >下一页</span>
                </c:if>
            </li>
            <li>
                <div class="page-skip" >共${commentProxyPage.lastPageNumber}页&nbsp;&nbsp;&nbsp;&nbsp;到第<input class="inputPage">页<button href="javascript:;" class="goToPage" lastPage="${commentProxyPage.lastPageNumber}" onclick="goToPage(this)">确定</button></div>
            </li>
        </ul>
    </div>
</c:if>

