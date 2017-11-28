<%--
  Created by IntelliJ IDEA.
  User: liuray
  Date: 13-11-27
  Time: 上午10:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<c:set value="${sdk:findAllProductCategory()}" var="allProductCategory"/>
<!DOCTYPE HTML>
<html>
<head>
    <title>类目导航-${webName}触屏版</title>
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
<c:import url="/template/bdw/oldWap/module/common/head.jsp?title=类目浏览"/>
<%--页头结束--%>
<div class="panel-group" id="accordion" style="padding-bottom:100px;">
    <c:forEach items="${allProductCategory}" var="category" varStatus="s">
        <div class="panel panel-default" style="border:none;">
            <div class="panel-heading10">
                <c:choose>
                    <c:when test="${not empty category.children}">
                        <a data-toggle="collapse" data-toggle="collapse" data-parent="#accordion"
                           href="#${category.categoryId}" class="spfl_btn">
                            <img src="${category.icon['100X100']}" width="30" height="30" style="margin-right:5px;"/>
                                ${category.name}<span
                                class="glyphicon glyphicon-chevron-down pull-right" style="margin-top: 10px"></span>
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="${webRoot}/wap/list.ac?category=${category.categoryId}"> ${category.name}</a>
                    </c:otherwise>
                </c:choose>
            </div>
            <div id="${category.categoryId}" class="panel-collapse collapse">
                <div class="s_info">
                    <c:forEach items="${category.children}" var="child" varStatus="c">
                        <c:choose>
                            <c:when test="${not empty child.children}">
                                <a href="${webRoot}/wap/categoryThirdStage.ac?category=${child.categoryId}">${child.name}</a><i>|</i>
                            </c:when>
                            <c:otherwise>
                                <a href="${webRoot}/wap/list.ac?category=${child.categoryId}"> ${child.name}</a>
                            </c:otherwise>
                        </c:choose>

                    </c:forEach>
                </div>
            </div>
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
<script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/category.js"></script>
</body>
</html>