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

<c:forEach items="${commentProxyResult}" var="commentProxy" varStatus="num">
<li>
    <p class="time">${commentProxy.createTimeString}</p>
    <div class="cont">
        <p>
            <c:set value="${fn:substring(commentProxy.loginId, 0,3)}" var="mobileHeader"/><%-- 用户名前3位 --%>
            <c:set value="${fn:substring(commentProxy.loginId, 7,fn:length(commentProxy.loginId))}" var="mobileStern"/><%-- 用户名后4位 --%>
            <span class="txt">${mobileHeader}****${mobileStern} </span>
            <span class="star-box">
                <c:forEach begin="1" end="${commentProxy.score}">
                    <i class="icon-star active"></i>
                </c:forEach>
            </span>
        </p>
        <p>${commentProxy.content}</p>
        <div class="pro-show">
            <ul class="mpic-box">
                <c:forEach items="${commentProxy.commentPics}" var="pic" end="4" varStatus="s">
                    <li><a href="javascript:;">
                        <img src="${pic}" width="50" height="50" onclick="slideShow(this)">
                        <i onclick="slideShow(this)" imageIndex="${s.index}"></i>
                    </a></li>
                </c:forEach>
            </ul>
            <div class="lpic-box" style="display: none" imageIndex="-1">

                <div class="pic shareOrder">
                    <ul>
                        <c:forEach items="${commentProxy.commentPics}" var="pic" varStatus="s">
                            <li index="${s.index}"><img src="${pic}" width="430" height="300"></li>
                        </c:forEach>
                    </ul>
                        <%--<a href="javascript:;" style="left: 20px; top: 20px;"><img src="images/zoom2.png"></a> <!--a位置就是鼠标位置，参照一号店效果-->--%>
                </div>
            </div>
        </div>
    <c:forEach items="${commentProxy.commentReplys}" var="commentSession">
        <p class="text-danger">客服回复：${commentSession.commentCont}</p>
    </c:forEach>
    </div>
</li>
</c:forEach>

<c:if test="${commentProxyPage.lastPageNumber>1}">
    <div class="pager">
        <div id="infoPage">
            <ul>
                <c:if test='${!commentProxyPage.firstPage}'>
                    <li><a title="<c:choose><c:when test='${commentProxyPage.firstPage}'>目前已是第一页</c:when><c:otherwise>上一页</c:otherwise> </c:choose> " <c:if test='${!commentProxyPage.firstPage}'> onclick="syncPage(${commentProxyPage.thisPageNumber-1},'${param.id}')" </c:if> class="upPage">上一页</a></li>
                </c:if>
                <c:forEach var="i" begin="1" end="${commentProxyPage.lastPageNumber}" step="1">
                    <c:set var="displayNumber" value="6"/>
                    <c:set var="startNumber" value="${(commentProxyPage.thisPageNumber -(commentProxyPage.thisPageNumber mod displayNumber))}"/>
                    <c:set var="endNumber" value="${startNumber+displayNumber}"/>
                    <c:if test="${(i>=startNumber) && (i<endNumber) }">
                        <c:choose>
                            <c:when test="${i==commentProxyPage.thisPageNumber}">
                                <li><a class="nowPage">${i}</a></li>
                            </c:when>
                            <c:otherwise>
                                <li><a class="everyPage" onclick="syncPage(${i},'${param.id}')">${i}</a></li>
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                </c:forEach>
                <c:if test='${!commentProxyPage.lastPage}'>
                    <li><a title="<c:choose> <c:when test='${commentProxyPage.lastPage}'>目前已是最后一页</c:when> <c:otherwise>下一页</c:otherwise> </c:choose> " class="downPage" <c:if test='${!commentProxyPage.lastPage}'> onclick="syncPage(${commentProxyPage.thisPageNumber+1},'${param.id}')" </c:if> >下一页</a></li>
                </c:if>
                <li>
                    <div id="page-skip">&nbsp;&nbsp;第&nbsp;<input value="3" id="inputPage">&nbsp;页/${commentProxyPage.pageSize}页
                        <button class="goToPage" onclick="" href="javascript:;">确定</button>
                        <div></div>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</c:if>