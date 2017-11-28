<%--
  Created by IntelliJ IDEA.
  User: zxh
  Date: 2016/12/30
  Time: 9:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="10" var="limit"/>
<c:set value="${bdw:findWapCitySendProductAndShopPage(limit)}" var="productProxys"/>
<c:set value="${webRoot}/template/bdw/statics/images/noPic_100X100.jpg" var="defaultImage"/>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>搜索-${webName}</title>
    <meta content="yes" name="apple-mobile-web-app-capable" />
    <meta content="yes" name="apple-touch-fullscreen" />
    <meta content="telephone=no,email=no" name="format-detection" />
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>

    <link href="${webRoot}/template/bdw/wap/citySend/statics/css/base.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/citySend/statics/css/city.css" type="text/css" rel="stylesheet" />
    <style type="text/css">
        .search.active:before {left:0rem;top:0;background:none;}
        .search .btnBack{ display: block;content: ''; position: absolute; left: 0.5rem; top: 50%; width: 2.5rem; height: 2.5rem; font-size: 0; -webkit-transform: translateY(-50%); transform: translateY(-50%); background: url(${webRoot}/template/bdw/wap/statics/images/icon-back-outline.png) no-repeat center center / 100% auto;}
    </style>

    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.7.1.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/main.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery.infinitescroll.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        var dataValue={
            webRoot:"${webRoot}", //当前路径
            lastPageNumber: "${productProxys.lastPageNumber}",
            orgIds: "${param.orgIds}",
            keyword: "${param.keyword}",
            limit: "${limit}"
        };
    </script>
    <script src="${webRoot}/template/bdw/wap/citySend/statics/js/citySearch.js" type="text/javascript"></script>
</head>
<body>
<div class="main m-search">
    <div class="search-box" style="padding-right: 7rem;">
      <form action="" method="get" id="searchForm">
          <a class="btnSearch" href="javascript:" id="searchBtn">搜索</a>
          <a class="clear" style="right: 3.5rem;z-index: 11;" href="javascript:" title="清除">清除</a>
          <div class="search search-light active">
              <a class="btnBack" href="javascript:" onclick="history.go(-1);" title="返回">返回</a>
              <input class="search-inp" style="margin-left: 3.5rem;padding-right: 3.2rem;padding-left: 1.5rem;" type="text" placeholder="搜索" id="searchTxt" name="keyword" value="${param.keyword}"/>
              <input type="hidden" name="orgIds" value="${param.orgIds}"/>
              <input type="hidden" name="limit" value="${limit}"/>
          </div>
      </form>
    </div>

    <div id="mainList">
        <c:if test="${productProxys.totalCount != 0}">
            <ul class="search-list">
                <c:forEach items="${productProxys.result}" var="productProxy">
                    <%-- 获取商家 --%>
                    <c:set value="${bdw:getShopInfProxyByOrgId(productProxy.sysOrgId)}" var="store"/>
                    <c:choose>
                        <c:when test="${productProxy.isShopSearch eq 'N'}">
                            <li>
                                <div class="prdItem">
                                    <a href="javascript:" orgId="${store.sysOrgId}" isSupportBuy="${store.isSupportBuy}" onclick="gotoStore(this);">
                                        <span class="img fl">
                                            <c:choose>
                                                <c:when test="${fn:length(productProxy.images)>0}">
                                                    <img src="${productProxy.defaultImage["60X60"]}" alt="${productProxy.name}" style="width:100%;height: 100%;">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${defaultImage}" alt="${productProxy.shopName}" style="width:60px;height: 60px;">
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                        <span class="val fl" style="max-width: 75%;">${productProxy.name}</span>
                                    </a>
                                </div>
                                <div class="prdItem">
                                    <span class="shopNm" style="white-space: normal;font-size: 1.2rem;">(${productProxy.shopName})</span>
                                </div>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li>
                                <div class="prdItem">
                                    <a href="javascript:" orgId="${store.sysOrgId}" isSupportBuy="${store.isSupportBuy}" onclick="gotoStore(this);">
                                        <span class="img fl">
                                            <c:choose>
                                                <c:when test="${fn:length(productProxy.images)>0}">
                                                    <img src="${productProxy.defaultImage["100X100"]}" alt="${productProxy.shopName}" style="width:60px;height: 60px;">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${defaultImage}" alt="${productProxy.shopName}" style="width:60px;height: 60px;">
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                        <span class="val fl" style="max-width: 85%;">${productProxy.shopName}</span>
                                    </a>

                                </div>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </ul>
        </c:if>
    </div>
</div>

<!-- 搜索-无 -->
<div class="search-null" style="${not empty param.keyword && productProxys.totalCount == 0 ? 'display:block;' : 'display: none;'}">
    <img src="${webRoot}/template/bdw/wap/citySend/statics/images/search-null.png" alt="">
    <p>查询不到相关数据</p>
</div>

<nav id="page-nav">
    <a href="${webRoot}/wap/citySend/loadCitySearch.ac?orgIds=${param.orgIds}&keyword=${param.keyword}&page=2&limit=${limit}"></a>
</nav>
<script src="${webRoot}/template/bdw/wap/citySend/statics/js/base.js"></script>
</body>
</html>
