<%--
  Created by IntelliJ IDEA.
  User: liuray
  Date: 13-11-27
  Time: 上午11:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<c:set value="${sdk:queryChildren(param.category)}" var="thirdStageCategory"/>
<c:set value="${sdk:queryProductCategoryById(param.category)}" var="category"/>
<!DOCTYPE HTML>
<html>
<head>
    <title>类目导航-${category.name}-${webName}触屏版</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

    <!-- Bootstrap -->
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.min.css" rel="stylesheet">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/buycar.css" rel="stylesheet">
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
</head>
<body>
<%--页头开始--%>
<c:import url="/template/bdw/oldWap/module/common/head.jsp?title=${category.name}"/>
<%--页头结束--%>

<div class="row" style="padding-bottom:100px;">
    <c:forEach items="${thirdStageCategory}" var="threeChild">
        <div class="col-xs-12">
            <a href="${webRoot}/wap/list.ac?category=${threeChild.categoryId}"
               class="panel-body3">${threeChild.name}
                <span class="glyphicon glyphicon-chevron-right pull-right"></span>
            </a>
        </div>
    </c:forEach>
</div>

<c:choose>
    <c:when test="${empty loginUser.bytUserId}">
        <%--页脚开始--%>
        <c:import url="/template/bdw/oldWap/module/common/bottom.jsp"/>
        <%--页脚结束--%>
    </c:when>
</c:choose>
</body>
</html>