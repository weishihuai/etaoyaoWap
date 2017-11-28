<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${empty param.categoryId ? 1 : param.categoryId}" var="categoryId"/>
<%--根据分类查询子分类--%>
<c:set value="${sdk:queryProductCategoryById(categoryId)}" var="category"/>

<!DOCTYPE html>
<html lang="en" style="font-size: 11.71875px;">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, width=device-width">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=no">
    <title>${category.name}-${webName}</title>
    <link rel="stylesheet" href="${webRoot}/template/bdw/wap/statics/css/header2.css">
    <link rel="stylesheet" href="${webRoot}/template/bdw/wap/statics/css/reclassify.css">
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.7.1.min.js"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/category.js"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/reclassify.js" type="text/javascript"></script>
</head>
<body>
    <header class="header">
        <a href="javascript:history.go(-1);" class="back"></a>
        <div class="header-title">${category.name}</div>

    </header>
    <div class="cate-viewport">
        <%--当前是尾节点 直接跳转到商品列表--%>
        <c:if test="${category != null and fn:length(category.children) == 0}">
            <c:redirect url="${webRoot}/wap/productList.ac?category=${categoryId}"/>
        </c:if>
        <div class="cate-tab">
        	<ul style="padding-top: 4.40625rem; ">
                <c:if test="${not empty category.children}">
                    <c:forEach items="${category.children}" var="child" varStatus="i">
                        <li class="${i.first?'cur':''}" onclick="changeHover(${i.index})">
                            <a href="javascript:void(0);">${child.name}</a>
                        </li>
                    </c:forEach>
                </c:if>
        	</ul>
        </div>
		<c:if test="${not empty category.children}">
            <c:forEach items="${category.children}" var="child" varStatus="i">
                <div class="cate-cont" style="display: ${i.first ?'block':'none'}">
                    <ul style="padding-top: 4.40625rem; ">
                        <li>
                            <a href="${webRoot}/wap/productList.ac?category=${child.categoryId}">全部</a>
                        </li>
                        <c:if test="${not empty child.children}">
                            <c:forEach items="${child.children}" var="child3" varStatus="i">
                                <li>
                                    <a href="${webRoot}/wap/productList.ac?category=${child3.categoryId}">${child3.name}</a>
                                </li>
                            </c:forEach>
                        </c:if>
                    </ul>
                </div>
            </c:forEach>
        </c:if>
        <div class="clearfix"></div>
    </div>
</body>
</html>
