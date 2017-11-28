<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<%--一级分类categoryId--%>
<c:set var="mainCategoryId" value="${empty param.mainCategoryId ? 54980:param.mainCategoryId}"/><%--主分类ID--%>
<c:set var="title" value="${empty param.title ? '资讯中心':param.title}"/><%--标题--%>
<c:set value="${sdk:getArticleCategoryById(mainCategoryId)}" var="mainCategory"/>
<c:set var="page" value="${empty param.page ? 1 : param.page}"/>
<c:set var="categoryId" value="${empty param.categoryId ? mainCategory.children[0].categoryId : param.categoryId}"/><%--当前选中的子分类ID--%>
<c:set value="${sdk:findArticlePageByCategoryId(page,5,categoryId)}" var="categoryArticle"/>

<!DOCTYPE HTML>
<html>
<head lang="en">
    <meta charset="utf-8">
    <title>${webName}-${title}</title>
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="telephone=no,email=no" name="format-detection">

    <link href="${webRoot}/template/bdw/wap/statics/css/swiper.min.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/newsList.css" rel="stylesheet" media="screen">

    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-2.1.4.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/swiper.min.js"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery.infinitescroll.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/newsList.js" type="text/javascript"></script>
    <script type="text/javascript">
        var webPath = {
            webRoot:"${webRoot}",
            lastPageNumber: ${categoryArticle.lastPageNumber},
            mainCategoryId:${mainCategoryId},
            title:'${title}',
            categoryId:${categoryId}
        };
    </script>
</head>
<body>
<c:if test="${isWeixin ne 'Y'}">
<div class="m-top">
    <a class="back" href="${webRoot}/wap/index.ac"></a>
    <div class="toggle-box">${webName}${title}</div>
</div>
</c:if>

<div class="health-information-main" id="commentDiv" <c:if test="${isWeixin eq 'Y'}">style='margin-top: 0.31rem;'</c:if>>
    <div class="health-information-toggle" <c:if test="${isWeixin eq 'Y'}">style='margin-top: 0rem;'</c:if>>
        <div>
            <div class="swiper-container dt">
                <ul class="swiper-wrapper">
                    <c:forEach items="${mainCategory.children}" var="oneCategory">
                        <li class="swiper-slide">
                            <a ${oneCategory.categoryId eq categoryId ? 'class="cur"' : ''} rel="${oneCategory.categoryId}">
                                ${oneCategory.name}
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
        <div class="dd">
            <div class="dd-title">${title}</div>
            <ul class="dd-inner">
                <c:forEach items="${mainCategory.children}" var="oneCategory" varStatus="i">
                    <li rel="${oneCategory.categoryId}" <c:if test="${oneCategory.categoryId eq categoryId}">class="cur"</c:if>>
                       ${oneCategory.name}
                    </li>
                </c:forEach>
            </ul>

        </div>
        <em id="iconXiaLa" onclick="xiala()" class="icon-xiala"></em>
    </div>
    <div id="newsList">
        <c:choose>
            <c:when test="${not empty categoryArticle.result}">
                <c:forEach items="${categoryArticle.result}" var="article">
                    <div class="item" onclick="window.location.href='${webRoot}/wap/newsDetail.ac?infArticleId=${article.infArticleId}'">
                        <h3 class="title">${article.title}</h3>
                        <p>${sdk:cleanHTML(article.articleCont,"")}</p>
                        <span class="date"><fmt:formatDate value="${article.createTime}" type="both" dateStyle="long" pattern="yyyy.MM.dd" /></span>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <%--暂无记录时显示--%>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<nav id="page-nav">
    <a href="${webRoot}/wap/newsList.ac?mainCategoryId=${mainCategoryId}&categoryId=${categoryId}&page=2"></a>
</nav>
<script>
    var swiper04 = new Swiper('.health-information-toggle .dt',{
        freeMode : true,
        slidesPerView : 'auto'
    });
</script>
</body>
</html>

