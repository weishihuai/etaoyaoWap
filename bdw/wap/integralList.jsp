<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<%--获取当前用户--%>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<%--如果用户未登录重定向到登录页面--%>
<c:if test="${empty loginUser}">
    <c:redirect url="${webRoot}/wap/login.ac"/>
</c:if>
<c:set var="loginUserIntegral" value="${loginUser.integral}"/>
<c:set value="${empty param.categoryId ? 10 : param.categoryId}" var="categoryId"/>
<%--设置每页显示多少条记录--%>
<c:set value="5" var="limit"/>
<%--根据分类Id查找积分商品--%>
<c:set value="${sdk:findIntegralProductsByCategoryId(categoryId,limit)}" var="integralProducts"/>

<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>积分享-${webName}</title>
    <link href="${webRoot}/template/bdw/wap/statics/css/swiper.min.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/statics/css/integral-enjoy.css" type="text/css" rel="stylesheet" />

    <script type="text/javascript">
        var dataValue = {
            webRoot:"${webRoot}",
            lastPageNumber:"${integralProducts.lastPageNumber}"
        };
    </script>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.7.1.min.js"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery.infinitescroll.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/integralList.js" type="text/javascript"></script>
</head>
<body>
<div class="m-top">
    <a class="back" href="${webRoot}/wap/index.ac"></a>
    <span>积分商城</span>
</div>

    <div class="integral-enjoy-main">
        <div class="dt">当前积分<span><fmt:formatNumber value="${loginUserIntegral}" type="number" pattern="##"/></span></div>
        <div class="dd" id="integralList">
            <c:choose>
                <c:when test="${not empty integralProducts.result}">
                    <c:forEach var="integralProduct" items="${integralProducts.result}" varStatus="i">
                        <%--根据积分商品Id取出积分商品--%>
                        <c:set value="${sdk:getIntegralProduct(integralProduct.integralProductId)}" var="product"/>
                        <div class="item">
                            <c:choose>
                                <c:when test="${integralProduct.type == 0}">
                                    <a class="pic" href="${webRoot}/wap/integralDetail.ac?integralProductId=${integralProduct.integralProductId}">
                                        <img src="${integralProduct.icon['']}" alt=""/>
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <img src="${integralProduct.icon['']}" alt=""/>
                                </c:otherwise>
                            </c:choose>
                            <a <c:if test="${integralProduct.type == 0}">href="${webRoot}/wap/integralDetail.ac?integralProductId=${integralProduct.integralProductId}"</c:if>><p class="name">${integralProduct.integralProductNm}</p></a>
                            <p class="number">剩余 ${product.num}件</p>
                            <p class="integral-number"><span><fmt:formatNumber value="${integralProduct.integral}" type="number"/></span>积分</p>
                            <c:choose>
                                <c:when test="${integralProduct.integral * 1 <= loginUserIntegral * 1}">
                                    <a class="btn01" href="${webRoot}/wap/integralDetail.ac?integralProductId=${integralProduct.integralProductId}">我要兑</a>
                                </c:when>
                                <c:otherwise>
                                    <a class="btn02" href="javascript:void(0);">我要兑</a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <%--暂无数据--%>
                </c:otherwise>
            </c:choose>

            <%--下拉加载更多--%>
            <nav id="page-nav">
                <a href="${webRoot}/wap/loadMoreIntegralList.ac?categoryId=${categoryId}&page=2&limit=${limit}"></a>
            </nav>
        </div>
    </div>
</body>
</html>



