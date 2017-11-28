<%@ page import="com.iloosen.imall.module.article.domain.InfArticle" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getArticleCategoryById(param.categoryId)}" var="category"/>
<c:set value="${sdk:getArticleById(param.infArticleId)}" var="infArticle"/>
<%
    InfArticle infArticle = ServiceManager.infArticleService.getById(Integer.parseInt(request.getParameter("infArticleId")));
    request.setAttribute("keywords",infArticle.getSeoKeywords());
    request.setAttribute("metaDescr",infArticle.getMetaDescr());
    request.setAttribute("metaTitle",infArticle.getMetaTitle());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${empty keywords ? sdk:getSysParamValue('index_keywords') : keywords}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${empty metaDescr ? sdk:getSysParamValue('index_description') : metaDescr}" /> <%--SEO description优化--%>
    <title>${webName}-${category.name}-${empty metaTitle ? sdk:getSysParamValue('index_title') : metaTitle}</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/announcement.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>

    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
</head>



<body>

<c:import url="/template/bdw/module/common/top.jsp"/>


<div id="announcement">
    <div class="announcement_Box">
        <div class="position">您现在的位置：<a href="${webRoot}/">首页</a> > ${category.name} </div>
        <div class="rBox">
            <div class="lBox">
                <div class="t2">

                    <h2>${category.name}</h2>

                    <ul style="overflow-y:auto;height: 400px ">
                        <c:forEach items="${category.top50}" var="article">
                            <li><a class="<c:if test='${param.infArticleId==article.infArticleId}'>cur</c:if>" href="${webRoot}/mallNotice-${article.infArticleId}-${article.categoryId}.html">·${article.title}</a></li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
            <div class="t1">
                <h2>${category.name}</h2>
                <div class="box">
                    <c:if test="${not empty infArticle}">
                        <h3>
                            <div class="title">${infArticle.title}</div>

                            <div class="from">发布时间：<fmt:formatDate value="${infArticle.createTime}" pattern="yyyy-MM-dd HH:mm:ss" />  &nbsp;&nbsp;&nbsp;&nbsp; 信息源：${infArticle.source}</div>
                        </h3>
                      <div style="line-height:22px;margin:10px 10px;"> ${infArticle.articleCont} </div>
                    </c:if>
                </div>
            </div>
        </div>
        <div class="clear"></div>
    </div>
</div>


<c:import url="/template/bdw/module/common/bottom.jsp"/>


</body>
</html>
