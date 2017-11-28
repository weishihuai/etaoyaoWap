<%@ taglib prefix="p" uri="/iMallTag" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<%--商品咨询--%>
<c:set var="buyConsultProxys" value="${sdk:findBuyConsultByProductId(param.id,10)}"/>

<c:forEach items="${buyConsultProxys.result}" var="buyConsultProxy" varStatus="result">
    <div class="ad-b-rows ${result.count%2==0?'ad-b-rows2':''}">
        <div class="name"><span>${buyConsultProxy.userName}</span> <c:if test="${not empty buyConsultProxy.lastReplyTimeString}">(${buyConsultProxy.lastReplyTimeString})</c:if></div>
        <div class="text">咨询内容： ${buyConsultProxy.consultCont}</div>
        <c:if test="${not empty buyConsultProxy.consultReplyCont}"> <div class="hf">客服回复： ${buyConsultProxy.consultReplyCont}</div></c:if>
    </div>
</c:forEach>

<c:if test="${buyConsultProxys.lastPageNumber>1}">
    <div class="page num">
        <div id="infoPage" style="margin-bottom:0;">
            <ul>
                <c:if test='${!buyConsultProxys.firstPage}'>
                    <li><a title="<c:choose><c:when test='${buyConsultProxys.firstPage}'>目前已是第一页</c:when><c:otherwise>上一页</c:otherwise> </c:choose> " <c:if test='${!buyConsultProxys.firstPage}'> onclick="syncBuyConsultPage(${buyConsultProxys.thisPageNumber-1},'${param.id}')" </c:if> class="upPage">上一页</a></li>
                </c:if>
                <c:forEach var="i" begin="1" end="${buyConsultProxys.lastPageNumber}" step="1">
                    <c:set var="displayNumber" value="6"/>
                    <c:set var="startNumber" value="${(buyConsultProxys.thisPageNumber -(buyConsultProxys.thisPageNumber mod displayNumber))}"/>
                    <c:set var="endNumber" value="${startNumber+displayNumber}"/>
                    <c:if test="${(i>=startNumber) && (i<endNumber) }">
                        <c:choose>
                            <c:when test="${i==buyConsultProxys.thisPageNumber}">
                                <li><a class="nowPage">${i}</a></li>
                            </c:when>
                            <c:otherwise>
                                <li><a class="everyPage" onclick="syncBuyConsultPage(${i},'${param.id}')">${i}</a></li>
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                </c:forEach>
                <c:if test='${!buyConsultProxys.lastPage}'>
                    <li><a title="<c:choose> <c:when test='${buyConsultProxys.lastPage}'>目前已是最后一页</c:when> <c:otherwise>下一页</c:otherwise> </c:choose> " class="downPage" <c:if test='${!buyConsultProxys.lastPage}'> onclick="syncBuyConsultPage(${buyConsultProxys.thisPageNumber+1},'${param.id}')" </c:if> >下一页</a></li>
                </c:if>
            </ul>
        </div>
    </div>
</c:if>
<div class="clear"></div>
