<%--
  Created by IntelliJ IDEA.
  User: GJS
  Date: 2016/3/17
  Time: 下午 4:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%--一级分类--%>
<c:set value="${sdk:getArticleCategoryById(54980)}" var="mainCategory"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="keywords" content="医药资讯,药品资讯,医药新闻" /> <%--SEO keywords优化--%>
  <meta name="description" content="${webName}提供 <c:forEach items="${mainCategory.children}" var="oneCategory">${oneCategory.name},</c:forEach>有关新闻资讯，同时为医药企业提供医药展会，医药招标查询，医药中标查询，医药资讯，药品数据库等资讯信息。${sdk:getSysParamValue('index_description')}" /> <%--SEO description优化--%>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-COMPATIBLE" content="IE=edge,chrome=1"/>
  <title>医药资讯_药品资讯_医药新闻_${webName}资讯首页<%---${sdk:getSysParamValue('index_title')}-${webName}--%></title>
  <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/base.css">
  <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/header.css">
  <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/news-index.css">
  <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.8.3.min.js"></script>
  <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/common-func.js"></script>
  <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/newsIndex.js"></script>
  <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/newsSearch.js"></script>
  <script type="text/javascript">
    var webPath = {webRoot:"${webRoot}"}
  </script>
</head>
<body>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp?p=newIndex&bar=Y&t=news"/>
<%--页头结束--%>

<!--主体-->
<div class="main">
  <div class="top-nav">
    <div class="mt-cont">
      <div class="nav">
        <a class="cur" href="${webRoot}/newsIndex.ac">资讯首页<span></span></a>
        <c:forEach items="${mainCategory.children}" var="oneCategory">
          <a href="${webRoot}/newsList-${oneCategory.categoryId}.html">${oneCategory.name}<span></span></a>
        </c:forEach>
      </div>
      <div class="search">
        <a href="javascript:;" class="search-btn"></a>
        <input id="newsKeyword" type="text" placeholder="请输入关键字" onclick="edit(this)">
        <a id="confirmBtn" class="btn btn-submit" onclick="searchNews()" href="javascript:;" title="">确定</a>
        <a id="cancelBtn" class="btn" onclick="removeEdit(this)" href="javascript:;" title="">取消</a>
      </div>
    </div>
  </div>
  <div class="cont">
    <div class="mt">
      <div class="mt-pic">
        <div class="slider-body">
          <ul class="slider-main frameEdit" frameInfo="news_adv|570X320" id="focus-cont">
            <c:set value="${sdk:findPageModuleProxy('news_adv').advt.advtProxy}" var="advtVar"/>
            <c:forEach items="${advtVar}" var="advtProxys" varStatus="s" end="4">
              <c:choose>
                <c:when test="${s.first}">
                  <li style="display: block; position: absolute; opacity:1; z-index: 1;">
                    <div class="cont-box">
                      <a href="${advtProxys.link}" title="${advtProxys.title}" target="_blank"><img src="${advtProxys.advUrl}" height="320" width="570"></a>
                    </div>
                  </li>
                </c:when>
                <c:otherwise>
                  <li style="display: block; position: absolute; opacity:0; z-index: 0;">
                    <div class="cont-box">
                      <a href="${advtProxys.link}" title="${advtProxys.title}" target="_blank"><img src="${advtProxys.advUrl}" height="320" width="570"></a>
                    </div>
                  </li>
                </c:otherwise>
              </c:choose>
            </c:forEach>
          </ul>
        </div>
        <c:if test="${fn:length(advtVar) >= 1}">
          <div class="slider-nav" id="focus-slider" style=" background-color: rgba(0,0,0,0.6); display: block;width: 569px;height: 50px;line-height: 50px;text-align: left;overflow: hidden;font-size: 18px;float: left;filter: alpha(Opacity=60);-moz-opacity: 0.6;opacity: 0.6;z-index: 1;">


            <%--<span>--%>
              <c:forEach items="${advtVar}" var="advtProxys" varStatus="s">
                  <b class="<c:if test="${s.first}">cur</c:if>">
                     <a  style="color: #fff;margin-left: 15px" href="${advtProxys.link}" class="title">${advtProxys.title}</a>
                   <%--   <a  style="margin-left: 300px" href="javascript:void(0);" class="pointer <c:if test="${s.first}">cur</c:if>" title=""></a>--%>
                  </b>
              </c:forEach>
            <%--</span>--%>
          </div>
          <div class="slider-page" style="display: block;">
            <a href="javascript:;" class="slider-prev" id="focus-prev"><</a>
            <a href="javascript:;" class="slider-next" id="focus-next">></a>
          </div>
        </c:if>

      </div>
      <div class="fl frameEdit" frameInfo="information_recommend">
        <c:forEach items="${sdk:findPageModuleProxy('information_recommend').recommendArticles}" var="recommendArticles1" end="0">
          <c:choose>
            <c:when test="${not empty recommendArticles1.externalLink}">
              <a href="${recommendArticles1.externalLink}" class="title elli" target="_blank">${recommendArticles1.title}</a>
            </c:when>
            <c:otherwise>
              <a href="${webRoot}/newsDetails-${recommendArticles1.categoryId}-${recommendArticles1.infArticleId}.html" class="title elli" ${recommendArticles1.newWindow ? ' target="_blank"' : ''}>${recommendArticles1.title}</a>
            </c:otherwise>
          </c:choose>

          <p>${sdk:cleanHTML(recommendArticles1.articleCont,"")}</p>
        </c:forEach>

        <div class="fl-news">
          <ul>
            <c:forEach items="${sdk:findPageModuleProxy('information_recommend').recommendArticles}" var="recommendArticles2" end="7" varStatus="s">
              <c:if test="${s.count != 1}">
                <li>
                  <c:choose>
                    <c:when test="${not empty recommendArticles2.externalLink}">
                      <a href="${recommendArticles2.externalLink}" target="_blank">
                    </c:when>
                    <c:otherwise>
                      <a href="${webRoot}/newsDetails-${recommendArticles2.categoryId}-${recommendArticles2.infArticleId}.html"  ${recommendArticles2.newWindow ? ' target="_blank"' : ''}>
                    </c:otherwise>
                  </c:choose>
                    <i>${sdk:getArticleCategoryById(recommendArticles2.categoryId).name} |</i>
                    <span class="elli">${recommendArticles2.title}</span>
                    <em><fmt:formatDate value="${recommendArticles2.createTime}" type="both" dateStyle="long" pattern="yyyy.MM.dd" /></em>
                  </a>
                </li>
              </c:if>
            </c:forEach>
          </ul>
        </div>
      </div>
    </div>
    <div class="n-ad frameEdit" frameInfo="midAdv">
      <c:forEach items="${sdk:findPageModuleProxy('midAdv').advt.advtProxy}" var="advtProxys" end="0">
        <a target="_blank" href="${advtProxys.link}" title="${advtProxys.title}"><img src="${advtProxys.advUrl}" width="1190px" height="90px" /></a>
      </c:forEach>
    </div>
    <div class="mc">
      <ul>
        <c:forEach items="${mainCategory.children}" var="oneCategory">
          <li>
            <div class="mc-top">
              <span>${oneCategory.name}</span>
              <a href="${webRoot}/newsList-${oneCategory.categoryId}.html">更多&nbsp;<i>></i></a>
            </div>
            <div class="mc-mid">
              <div class="pic"><a href="javascript:;"><img src="${oneCategory.icon['']}" alt="" width="120px" height="80px"></a></div>
              <c:forEach items="${oneCategory.top10}" var="article1" end="0">
                <c:choose>
                  <c:when test="${not empty article1.externalLink}">
                    <a href="${article1.externalLink}" class="title elli" target="_blank">${article1.title}</a>
                  </c:when>
                  <c:otherwise>
                    <a href="${webRoot}/newsDetails-${article1.categoryId}-${article1.infArticleId}.html" class="title elli"  ${article1.newWindow ? ' target="_blank"' : ''}>${article1.title}</a>
                  </c:otherwise>
                </c:choose>
                <p>${sdk:cleanHTML(article1.articleCont,"")}</p>
              </c:forEach>
            </div>
            <div class="mc-bot">
              <c:forEach items="${oneCategory.top10}" var="article2" end="7" varStatus="s">
                <c:if test="${s.count != 1}">
                  <div class="bot-item">
                    <c:choose>
                      <c:when test="${not empty article2.externalLink}">
                        <a target="_blank" class="elli" href="${article2.externalLink}">
                            ${article2.title}
                        </a>
                      </c:when>
                      <c:otherwise>
                        <a ${article2.newWindow ? ' target="_blank"' : ''} class="elli" href="${webRoot}/newsDetails-${article2.categoryId}-${article2.infArticleId}.html">
                            ${article2.title}
                        </a>
                      </c:otherwise>
                    </c:choose>

                    <span><fmt:formatDate value="${article2.createTime}" type="both" dateStyle="long" pattern="yyyy.MM.dd" /></span></div>
                </c:if>
              </c:forEach>
            </div>
          </li>
        </c:forEach>
      </ul>
    </div>
  </div>

</div>
<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>
</body>
</html>

