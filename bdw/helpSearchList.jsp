<%@ taglib prefix="p" uri="/iMallTag" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%--一级分类--%>
<c:set value="${sdk:getArticleCategoryById(60000)}" var="mainCategory"/>
<%--页码--%>
<c:set value="${empty param.page?1:param.page}" var="page"/>
<%--搜索文章--%>
<c:set value="${sdk:findArticlePageByKeyword(page,5,param.searchField)}" var="searchResult"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}" /> <%--SEO description优化--%>
    <title>${empty param.searchField?'':param.searchField}-${webName}-${sdk:getSysParamValue('index_title')}</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/help.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>

    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/help.js"></script>
    <script type="text/javascript">
        var valueData={
            webRoot:"${webRoot}"
        }
    </script>
</head>

<body>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp"/>
<%--页头结束--%>

<div id="position" class="m1-bg">
    <div class="m1">
        <a href="${webRoot}/index.html">首页</a> >  <a href="${webRoot}/help.html">${mainCategory.name}</a>
    </div>
</div>

<div id="help">
    <%--左边菜单 start--%>
    <div class="lBox">
        <div class="m1">
            <h1>帮助分类</h1>
            <div class="box">
                <c:forEach items="${mainCategory.children}" var="firstCategory" varStatus="status">
                    <div>
                        <h4>
                            <div class="tit"><a href="javascript:void(0);">${firstCategory.name}</a></div>
                            <div class="ico"><a href="javascript:void(0);" class="stretch ${status.first?'open':''}" ><img  src="${webRoot}${status.first?'/template/bdw/statics/images/list_mIco.gif':'/template/bdw/statics/images/list_eIco.gif'}"></a></div>
                            <div class="clear"></div>
                        </h4>
                        <ul class="categorylist ${status.first?'showList':''}">
                            <c:forEach items="${sdk:getArticleCategoryById(firstCategory.categoryId).top5}" var="secCategory">
                                <li><a title="${secCategory.title}" href="${webRoot}/help-${secCategory.infArticleId}.html">·${secCategory.title}</a></li>
                            </c:forEach>
                        </ul>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
    <%--左边菜单 end--%>
    <%--右边菜单 start--%>
    <div class="rBox">
        <%--搜索框 start--%>
        <div class="search_box">
            <label>查找帮助信息</label>
            <div class="put">
                <input type="text" id="searchField" value="${empty param.searchField?'':param.searchField}"/>
            </div>
            <div class="btn"><a title="搜索" id="search" href="javascript:void(0);">搜索</a></div>
            <div class="clear"></div>
        </div>
        <%--搜索框 end--%>
        <%--搜索结果 start--%>
        <div class="result">
            <h2>找到与“<span>${empty param.searchField?'':param.searchField}</span>”相关的结果<span>${searchResult.totalCount}</span>个</h2>
            <div class="list">
                <ul>
                    <c:forEach items="${searchResult.result}" var="searchList">
                    <li>
                        <div class="title"><a href="${webRoot}/help.ac?infArticleId=${searchList.infArticleId}">${fn:substring(searchList.title,0,60)}</a></div>
                        <div class="text">${sdk:cutString(sdk:cleanHTML(searchList.articleCont, ""), 300, "........")}</div>
                    </li>
                        </c:forEach>
                </ul>
            </div>
            <div class="page" style="margin-bottom: 10px;">
                <div style="float: right;">
                    <c:if test="${searchResult.lastPageNumber!=0}">
                    <p:PageTag isDisplayGoToPage="true" isDisplaySelect="false" totalPages='${searchResult.lastPageNumber}' currentPage='${page}'  totalRecords='${searchResult.totalCount}' ajaxUrl='${webRoot}/helpSearchList.ac' frontPath='${webRoot}' displayNum='6' />
                    </c:if>
                </div>
            </div>
        </div>
        <%--搜索结果 end--%>
    </div>
    <%--右边菜单 end--%>
    <div class="clear"></div>
</div>

<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>
</body>
</html>
