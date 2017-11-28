<%--
  Created by IntelliJ IDEA.
  User: liuray
  Date: 13-11-27
  Time: 下午2:07
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="p" uri="/iMallTag" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<c:set var="_page" value="${empty param.page?1:param.page}"/>  <%--接受页数--%>
<c:set value="${sdk:getProductCollect(5)}" var="userProductPage"/>   <%--获取收藏商品列表--%>
<!DOCTYPE HTML>
<html>
<head>
    <title>商品收藏</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <!-- Bootstrap -->
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.min.css" rel="stylesheet">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/list.css" rel="stylesheet">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/xyPop/xyPop.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/module/member/statics/js/myFavorite.js"></script>
    <script type="text/javascript">
        var dataValue = {webRoot: "${webRoot}"}
    </script>
</head>
<body>
<%--页头开始--%>
<c:import url="/template/bdw/oldWap/module/common/head.jsp?title=商品收藏"/>
<%--页头结束--%>
<div class="container">
    <c:set value="${userProductPage.result}" var="productProxy"/>
    <c:choose>
        <c:when test="${not empty productProxy}">
            <c:forEach items="${userProductPage.result}" var="prdProxy" varStatus="statu">
                <c:if test="${not empty prdProxy}">
                    <div class="row list_rows"style="padding-bottom: 0px;">
                        <div class="col-xs-4">
                            <div class="list_pic">
                                <c:choose>
                                    <c:when test="${not empty prdProxy.shopType && prdProxy.shopType == '2'}">
                                        <a href="${webRoot}/wap/citySend/product.ac?productId=${prdProxy.productId}"><img alt="${prdProxy.name}" src="${prdProxy.defaultImage['100X100']}" width="80" height="80"></a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${webRoot}/wap/product.ac?id=${prdProxy.productId}"><img alt="${prdProxy.name}" src="${prdProxy.defaultImage['100X100']}" width="80" height="80"></a>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="col-xs-8">
                            <div class="list_title">
                                <c:choose>
                                    <c:when test="${not empty prdProxy.shopType && prdProxy.shopType == '2'}">
                                        <a href="${webRoot}/wap/citySend/product.ac?productId=${prdProxy.productId}">${prdProxy.name}<em></em></a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${webRoot}/wap/product.ac?id=${prdProxy.productId}">${prdProxy.name}<em></em></a>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="list_rice">
                                当前售价:<em>¥<fmt:formatNumber value="${prdProxy.price.unitPrice}" type="number" pattern="#0.00#"/></em>
                                <span class="glyphicon glyphicon-trash pull-right delItem" itemkey="04112db0-6c85-4750-bc8e-29d6be583e4e" handler="sku" carttype="normal" style="color:#999;padding-left: 20px;padding-right: 20px; line-height: 22px;" onclick="delCollect(${prdProxy.productId});"></span>
                            </div>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <div class="container">
                <div class="row m_rows1" style="margin:20px 0;padding:10px 0;">
                    <div class="col-xs-12">
                        <%--<span class="glyphicon glyphicon-ok glyphicon-ok2"></span>--%>
                        没有您收藏的商品信息，请您先
                        <a href="${webRoot}/wap/list.ac">浏览商品»</a>
                    </div>
                </div>
                <div class="row m_rows1" style="margin-bottom:38px;padding:10px 0;">
                    <div class="col-xs-12">
                        <button onclick="window.location.href='${webRoot}/wap/index.ac'"  class="btn btn-danger btn-danger2" type="button">返回首页</button>
                    </div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
    <div class="pn-page row">
        <form action="${webRoot}/module/member/productCollection.ac" id="pageForm" method="post" style="display: inline;" totalPages='${userProductPage.lastPageNumber}' currentPage='${_page}' totalRecords='${userProductPage.totalCount}' frontPath='${webRoot}' displayNum='5'>
            <c:if test="${userProductPage.lastPageNumber >1}">
                <c:choose>
                    <c:when test="${userProductPage.firstPage}">
                        <div class="col-xs-2">
                            <a type="button" class="btn btn-sm btn-default" disabled='disabled' href="?page=1">首页</a>
                        </div>
                        <div class="col-xs-3">
                            <a type="button" class="btn btn-sm btn-default" disabled='disabled'
                               href="?page=${_page-1}">上一页</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="col-xs-2">
                            <a type="button" class="btn btn-sm btn-default" href="?page=1">首页</a>
                        </div>
                        <div class="col-xs-3">
                            <a type="button" class="btn btn-sm btn-default" href="?page=${_page-1}">上一页</a>
                        </div>
                    </c:otherwise>
                </c:choose>
                <div class="col-xs-2 dropup">
                    <button class="btn btn-default btn-sm dropdown-toggle btn-block" type="button"
                            data-toggle="dropdown">
                            ${_page}/${userProductPage.lastPageNumber} <span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu" style="min-width:50px;width:50px;height: auto;overflow-y: scroll;">
                        <c:forEach begin="1" end="${userProductPage.lastPageNumber}" varStatus="status">

                            <li><a href="?page=${status.index}">${status.index}</a></li>

                        </c:forEach>
                    </ul>
                </div>
                <c:choose>
                    <c:when test="${userProductPage.lastPage}">
                        <div class="col-xs-3">
                            <a type="button" class="btn btn-sm btn-default" disabled='disabled'>下一页</a>
                        </div>
                        <div class="col-xs-2">
                            <a type="button" class="btn btn-sm btn-default" disabled='disabled'
                               href="?page=${userProductPage.lastPageNumber}">末页</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="col-xs-3">
                            <a type="button" class="btn btn-sm btn-default" href="?page=${_page+1}">下一页</a>
                        </div>
                        <div class="col-xs-2">
                            <a type="button" class="btn btn-sm btn-default"
                               href="?page=${userProductPage.lastPageNumber}">末页</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </c:if>
        </form>
    </div>

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