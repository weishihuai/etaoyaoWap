<%--
  Created by IntelliJ IDEA.
  User: liuray
  Date: 13-11-28
  Time: 上午10:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<c:set value="${empty param.page?1:param.page}" var="page"/>

<%--根据分类Id查找积分商品--%>
<c:set value="${empty param.categoryId?10:param.categoryId}" var="categoryId"/>
<c:set value="${sdk:findIntegralProductsByCategoryId(categoryId,10)}" var="integralProducts"/>
<!DOCTYPE HTML>
<html>
<head>
    <title>积分兑换</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.min.css" rel="stylesheet">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/list.css" rel="stylesheet">
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/integral.js"></script>
    <script type="text/javascript">
        var webPath = {webRoot: "${webRoot}"};
        var data = {
            page: "${page}",
            lastPageNumber: "${integralProducts.lastPageNumber}",
            webRoot: "${webRoot}",
            min: "${param.min}",
            max: "${param.max}",
            categoryId: "${param.categoryId}"
        }
    </script>
</head>
<body>
<%--页头开始--%>
<c:import url="/template/bdw/oldWap/module/common/head.jsp?title=积分兑换"/>
<%--页头结束--%>
<div class="container">
    <c:choose>
        <c:when test="${empty integralProducts.result}">
            <div class="container">
                <div class="row m_rows1" style="margin:20px 0;padding:10px 0;">
                    <div class="col-xs-12">
                        <%--<span class="glyphicon glyphicon-ok glyphicon-ok2"></span>--%>
                        还没有可以用积分兑换的商品，您可以去
                        <a href="${webRoot}/wap/list.ac">选购商品»</a>
                    </div>
                </div>
                <div class="row m_rows1" style="margin-bottom:38px;padding:10px 0;">
                    <div class="col-xs-12">
                        <button onclick="window.location.href='${webRoot}/wap/index.ac'"
                                class="btn btn-danger btn-danger3" style="width:100%;" type="button">返回首页
                        </button>
                    </div>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <c:forEach items="${integralProducts.result}" var="product" varStatus="s">
                <div class="row list_rows2">
                    <c:choose>
                        <c:when test="${product.type == 0}">
                            <div class="col-xs-4">
                                <div class="list_pic">
                                    <a href="${webRoot}/wap/integralDetails.ac?integralProductId=${product.integralProductId}"> <img width="90" height="90" src="${product.icon['100X100']}"></a></div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="col-xs-4">
                                <div class="list_pic">
                                    <a href="javascript:"><img width="90" height="90" src="${product.icon['100X100']}"></a></div>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <div class="col-xs-8">
                            <a href="${webRoot}/wap/integralDetails.ac?integralProductId=${product.integralProductId}"><div class="list_title" style="color: #666"> ${product.integralProductNm}</div></a>
                                <div class="list_rice"style="margin-top: 2px;">
                                    <c:choose>
                                        <c:when test="${product.paymentConvertTypeCode eq '2'}">
                                            <p >固定积分：<b><fmt:formatNumber value="${product.integral}" type="number" pattern="######.##" /></b></p>
                                            <p >  积分+金额：<b  style="width:170px;"><fmt:formatNumber value="${product.exchangeIntegral}" type="number" pattern="######.##"/>分+<fmt:formatNumber value="${product.exchangeAmount}" type="number"  pattern="######.##"/>元</b></p>
                                        </c:when>
                                        <c:when test="${product.paymentConvertTypeCode eq '1'}">
                                            <p >积分+金额：<b style="width:170px;"><fmt:formatNumber value="${product.exchangeIntegral}" type="number" pattern="######.##" />分+<fmt:formatNumber value="${product.exchangeAmount}" type="number" pattern="######.##" />元</b></p>
                                        </c:when>
                                        <c:when test="${product.paymentConvertTypeCode eq '0'}">
                                            <p>固定积分：<b><fmt:formatNumber value="${product.integral}" type="number" /></b></p>
                                        </c:when>
                                    </c:choose>
                                </div>



                        <div class="row">
                            <div class="col-xs-12">
                                <a type="button" id="btn-exchange${s.index}" class="btn btn-danger btn-danger2" num="1"
                                   objectid="${product.integralProductId}" userIntegral="${loginUser.integral}"
                                   carttype="integral" isLogin="${empty loginUser ? true :false}"
                                   price="${product.integral}"
                                   handler="integral" href="javascript:" protype=$"{product.type}" onclick="">我要兑换</a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>


            <div class="pn-page row">
<%--
                <form action='${webRoot}/integral/integralList.ac' id="pageForm" method="post" style="display: inline;" totalPages='${integralProducts.lastPageNumber}' currentPage='${page}' frontPath='${webRoot}' displayNum='6' totalRecords='${integralProducts.totalCount}'>
--%>
                <form action='${webRoot}/jfhg.ac' id="pageForm" method="post" style="display: inline;" totalPages='${integralProducts.lastPageNumber}' currentPage='${page}' frontPath='${webRoot}' displayNum='6' totalRecords='${integralProducts.totalCount}'>

                <c:if test="${integralProducts.lastPageNumber >1}">
                        <c:choose>
                            <c:when test="${integralProducts.firstPage}">
                                <div class="col-xs-2">
                                    <a type="button" class="btn btn-sm btn-default" disabled='disabled' href="?page=1">首页</a>
                                </div>
                                <div class="col-xs-3">
                                    <a type="button" class="btn btn-sm btn-default" disabled='disabled'
                                       href="?page=${page-1}">上一页</a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="col-xs-2">
                                    <a type="button" class="btn btn-sm btn-default" href="?page=1">首页</a>
                                </div>
                                <div class="col-xs-3">
                                    <a type="button" class="btn btn-sm btn-default" href="?page=${page-1}">上一页</a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                        <div class="col-xs-2">
                            <button class="btn btn-default btn-sm dropdown-toggle btn-block" type="button" data-toggle="dropdown">
                                    ${page}/${integralProducts.lastPageNumber} <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu" style="width:50px">

                                <c:forEach begin="1" end="${integralProducts.lastPageNumber}" varStatus="status">

                                    <li><a href="?page=${status.index}">第${status.index}页</a></li>

                                </c:forEach>
                            </ul>
                        </div>
                        <c:choose>
                            <c:when test="${productProxys.lastPage}">
                                <div class="col-xs-3">

                                    <a type="button" class="btn btn-sm btn-default" disabled='disabled'>下一页</a>
                                </div>
                                <div class="col-xs-2">
                                    <a type="button" class="btn btn-sm btn-default" disabled='disabled' href="?page=${integralProducts.lastPageNumber}">末页</a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="col-xs-3">
                                    <a type="button" class="btn btn-sm btn-default" href="?page=${page+1}">下一页</a>

                                </div>
                                <div class="col-xs-2">
                                    <a type="button" class="btn btn-sm btn-default" href="?page=${integralProducts.lastPageNumber}">末页</a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                </form>
            </div>
        </c:otherwise>
    </c:choose>
</div>
<c:choose>
    <c:when test="${empty loginUser.bytUserId}">
        <%--页脚开始1--%>
        <c:import url="/template/bdw/oldWap/module/common/bottom.jsp"/>
        <%--页脚结束--%>
    </c:when>
</c:choose>
</body>
</html>