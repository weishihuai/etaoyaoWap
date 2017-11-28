<%--
  Created by IntelliJ IDEA.
  User: ljt
  Date: 13-12-5
  Time: 下午5:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%--商品评论--%>
<c:set var="commentProxyPage" value="${sdk:findProductComments(param.id,10)}"/>
<c:set var="commentProxyResult" value="${commentProxyPage.result}"/>

    <c:forEach items="${commentProxyResult}" var="commentProxy" varStatus="s">
        <div class="row ${(s.count +1)%2 == 0 ? 'd_rows1' : 'd_rows2'}">
            <div class="col-xs-12 i_text">${commentProxy.content}</div>
            <div class="col-xs-2">
                <label class="control-label pf">评分：</label>
            </div>
            <div class="col-xs-10">
                <c:forEach begin="1" end="${commentProxy.score}">
                    <span class="glyphicon glyphicon-star xingxing"></span>
                </c:forEach>
                <c:if test="${commentProxy.score < 5}">
                    <c:forEach begin="${commentProxy.score}" end="4">
                        <span class="glyphicon glyphicon-star xingxing2"></span>
                    </c:forEach>
                </c:if>
            </div>
            <div class="col-xs-6">
                <c:set value="${fn:substring(commentProxy.loginId, 0,3)}" var="mobileHeader"/><%-- 用户名前3位 --%>
                <c:set value="${fn:substring(commentProxy.loginId, 7,fn:length(commentProxy.loginId))}" var="mobileStern"/><%-- 用户名后4位 --%>
                <label class="control-label yh">用户：${mobileHeader}****${mobileStern}</label>
            </div>
            <div class="col-xs-6">
                <div class="sj"><fmt:formatDate value="${commentProxy.createTime}" /> </div>
            </div>
        </div>
    </c:forEach>

        <c:if test="${commentProxyPage.lastPageNumber!=1}">
        <div class="pn-page">
            <c:choose>
                <c:when test="${commentProxyPage.firstPage}">
                    <a href="javascript:void(0);" class="btn btn-default btn-sm" role="button" disabled="disabled">首页</a>
                    <a href="javascript:void(0);" class="btn btn-default btn-sm" role="button" disabled="disabled">上一页</a>
                </c:when>
                <c:otherwise>
                    <a href="javascript:void(0);" onclick="toCompage(1)" class="btn btn-default btn-sm" role="button">首页</a>
                    <a href="javascript:void(0);" onclick="toCompage(${commentProxyPage.thisPageNumber-1})" class="btn btn-default btn-sm" role="button">上一页</a>
                </c:otherwise>
            </c:choose>
            <div class="btn-group">
                <button class="btn btn-default btn-sm dropdown-toggle btn-to" type="button" data-toggle="dropdown">
                        ${commentProxyPage.thisPageNumber}/${commentProxyPage.lastPageNumber} <span class="caret"></span>
                </button>

                <ul class="dropdown-menu" style="width:50px">
                    <c:forEach begin="1" varStatus="n" end="${commentProxyPage.lastPageNumber}">
                        <li><a href="javascript:void(0);" onclick="toCompage(${n.index});">第${n.index}页</a></li>
                    </c:forEach>
                </ul>
            </div>
            <c:choose>
                <c:when test="${commentProxyPage.lastPage}">
                    <a href="javascript:void(0);" class="btn btn-default btn-sm" role="button" disabled="disabled">下一页</a>
                    <a href="javascript:void(0);" class="btn btn-default btn-sm" role="button" disabled="disabled">末页</a>
                </c:when>
                <c:otherwise>
                    <a href="javascript:void(0);" onclick="toCompage(${commentProxyPage.thisPageNumber+1})" class="btn btn-default btn-sm" role="button">下一页</a>
                    <a href="javascript:void(0);"  onclick="toCompage(${commentProxyPage.lastPageNumber})" class="btn btn-default btn-sm" role="button">末页</a>
                </c:otherwise>
            </c:choose>
        </div>
        </c:if>
