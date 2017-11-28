<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="f" uri="/iMallTag" %>

<c:if test="${empty param.shopId}">
    <c:redirect url="/wap/index.ac"></c:redirect>
</c:if>

<%-- 下面这这几个都是和店铺分类有关的 --%>
<%--<c:set value="${sdk:getShopRoot(param.shopId)}" var="shopRoot"/>
<c:set value="${param.shopCategoryId==null ? shopRoot : param.shopCategoryId}" var="categoryId"/>
<c:set value="${sdk:getFacet()}" var="facetProxy"/>
<c:set value="${sdk:getChildren(categoryId,param.shopId)}" var="shopCategory"/>
<c:set value="${sdk:getShopCategoryProxyById(categoryId,param.shopId)}" var="shopCategoryCurrent"/>--%>

<c:set value="${sdk:getShopInfProxyById(param.shopId)}" var="shop"/>
<c:set value="${sdk:getShopCategoryProxy(param.shopId)}" var="shopCategory"/>

<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>商品分类</title>
    <link href="${webRoot}/template/bdw/oldWap/module/shop/statics/css/base.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/module/shop/statics/css/header.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/module/shop/statics/css/category.css" type="text/css" rel="stylesheet" />

    <script src="${webRoot}/template/bdw/oldWap/module/shop/statics/js/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/oldWap/module/shop/statics/js/shopCategory.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(function(){
            if(${isWeixin=="Y"}){
                $(".main").css("padding-top","0px");
            }
        });
    </script>
</head>

<body>
    <!--头部-->
    <c:if test="${isWeixin!='Y'}">
    <header class="header">
        <a onclick="history.go(-1);" href="javascript:void(0);" class="back"></a>
        <span class="title">商品分类</span>
        <a href="javascript:void(0);" class="home" onclick="window.location.href='${webRoot}/wap/index.ac?time='+ new Date().getTime()"></a>
    </header>
    </c:if>
    <!--中间内容-->
    <div class="main">
        <div class="category-tab">
            <ul>
                <c:forEach items="${shopCategory.children}" var="children" varStatus="s">
                    <%--<li id="firstCate${s.count}"><a href="javascript:void(0);" onclick="showSecondCate(${s.count});">${children.name}</a></li>--%>
                    <c:choose>
                        <c:when test="${not empty children.children}">
                            <li id="firstCate${s.count}" class="<c:if test='${count==1}'>cur</c:if>"><a href="javascript:void(0);" onclick="showSecondCate(${s.count});">${children.name}</a></li>
                        </c:when>
                        <c:otherwise>
                            <li><a href="${webRoot}/wap/module/shop/index.ac?shopId=${shop.shopInfId}&shopCategoryId=${children.categoryId}">${children.name}</a></li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </ul>
        </div>
        <div class="category-content">
            <div class="content-wrapper">
                <c:forEach items="${shopCategory.children}" var="children" varStatus="s">
                    <c:set value="${s.count==1?block:none}" var="isDisplay"/>
                    <ul id="secondCate${s.count}" style="display: ${isDisplay}">
                        <c:forEach items="${children.children}" var="childrenC">
                            <li><a href="${webRoot}/wap/module/shop/index.ac?shopId=${shop.shopInfId}&shopCategoryId=${childrenC.categoryId}">${childrenC.name}</a></li>
                        </c:forEach>
                    </ul>
                </c:forEach>
            </div>
        </div>
    </div>
</body>

</html>




