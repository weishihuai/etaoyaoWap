<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="p" uri="/iMallTag" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${empty param.page?1:param.page}" var="pageNum"/> <%--评论翻页数，默认为第一页--%>
<%--取出商品--%>
<c:set var="otooProductProxy" value="${bdw:getOtooProductById(param.id)}"/>
<%--取分类--%>
<c:set var="otooCategoryProxy" value="${otooProductProxy.otooCategoryProxy}"/>
<%--商品评论--%>
<c:set var="commentProxyPage" value="${bdw:findCommentPageByProductId(param.id,8)}"/>
<c:set var="commentProxyResult" value="${commentProxyPage.result}"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="expires" content="0">
    <title>O2O商品评论页</title>

    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/otoo/statics/css/base.css" rel="stylesheet"  type="text/css" />
    <link href="${webRoot}/template/bdw/otoo/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/otoo/statics/css/group-comment.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        var webPath = {webRoot: "${webRoot}",productId:"${param.id}"};
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.cycle.all.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/otoo/statics/js/productComment.js"></script>
</head>
<body>

<%-- header start --%>
<c:import url="/template/bdw/otoo/common/top.jsp?p=detail"/>
<%-- header end --%>

<div class="main">
        <div class="crumb">
            <a href="${webRoot}/otoo/index.ac" title="首页">首页</a>&gt;
            <c:forEach items="${otooCategoryProxy.categoryTree}" var="category" varStatus="stats" begin="1">
                <a href="${webRoot}/otoo/productList.ac?categoryId=${category.categoryId}" title="${category.categoryName}">${category.categoryName}</a>&gt;
            </c:forEach>
            <span>${otooProductProxy.otooProductNm}</span>
        </div>
    <div class="cont">
        <div class="clt">
            <h4>商品信息</h4>
            <div class="mt">
                <div class="m-pic">
                    <a href="${webRoot}/otoo/product.ac?id=${otooProductProxy.otooProductId}">
                        <img src="${otooProductProxy.defaultImage['270X180']}" alt="${otooProductProxy.otooProductNm}" >
                    </a>
                </div>
                <a href="${webRoot}/otoo/product.ac?id=${otooProductProxy.otooProductId}" class="title">${otooProductProxy.otooProductNm}</a>
                <div class="m-pri">
                    优惠价：
                    <span style="font-size: 16px;">￥</span>
                    <span>${otooProductProxy.otooDiscountPrice}</span>
                </div>
                <div class="m-com">
                    <span>商品评分：</span>
                   <%-- <c:choose>
                        <c:when test="${otooProductProxy.commentStatistics.average > 0}">
                            <c:forEach var="s" begin="1" end="${otooProductProxy.commentStatistics.average}">
                                <i></i>
                            </c:forEach>
                            <c:forEach var="s" begin="1" end="${5-otooProductProxy.commentStatistics.average}">
                                <em></em>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="s" begin="1" end="5">
                                <em></em>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>--%>
                    <c:choose>
                        <c:when test="${otooProductProxy.total>0}">
                            <span class="star-back">
                                <i style="width: ${otooProductProxy.commentStatistics.average/5*100}%"></i>
                            </span>
                        </c:when>
                        <c:otherwise>
                            <span style="color:red;margin-left: 4px;">暂无人评价</span>
                        </c:otherwise>
                    </c:choose>

                </div>
            </div>
            <a href="javascript:void(0);" class="add" id="buyBtn">立即购买</a>
            <div class="mc">
                <p>${otooProductProxy.otooSellingPoint}</p>
            </div>
        </div>
        <div class="crt">
            <div class="mt">
                <h4>商品评价</h4>
                <div class="mtc01">
                    <div class="mtc-lt">
                            <c:choose>
                                <c:when test="${otooProductProxy.total>0}">
                                    <span class="star-back">
                                    <i style="width: ${otooProductProxy.commentStatistics.average/5*100}%"></i>
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span style="color:red;margin-left: 4px;">暂无人评价</span>
                                </c:otherwise>
                            </c:choose>
                       <%-- <c:choose>
                            <c:when test="${otooProductProxy.commentStatistics.average > 0}">
                                <c:forEach var="s" begin="1" end="${otooProductProxy.commentStatistics.average}">
                                    <i></i>
                                </c:forEach>
                                <c:forEach var="s" begin="1" end="${5-otooProductProxy.commentStatistics.average}">
                                    <em></em>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="s" begin="1" end="5">
                                    <em></em>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>--%>
                        <p>用户满意度</p>
                    </div>
                    <ul class="mtc-md">
                        <li>
                            好&nbsp;评
                                <span>
                                    <em style="width: ${otooProductProxy.goodRate};"></em>
                                </span>
                            ${otooProductProxy.goodRate}
                        </li>
                        <li>
                            中&nbsp;评
                                <span>
                                    <em style="width: ${otooProductProxy.normalRate};"></em>
                                </span>
                            ${otooProductProxy.normalRate}
                        </li>
                        <li>
                            差&nbsp;评
                                <span>
                                    <em style="width: ${otooProductProxy.badRate};"></em>
                                </span>
                            ${otooProductProxy.badRate}
                        </li>
                    </ul>
                </div>
            </div>
            <div class="mc">
                <ul class="mc-nav">
                    <li class="${param.status==""||param.status==null?'cur':''}">
                        <a href="${webRoot}/otoo/productComment.ac?id=${param.id}">全部</a>
                    </li>
                    <li class="${param.status == 'good'?'cur':''}">
                        <a href="${webRoot}/otoo/productComment.ac?id=${param.id}&status=good">好评</a>
                    </li>
                    <li class="${param.status == 'normal'?'cur':''}">
                        <a href="${webRoot}/otoo/productComment.ac?id=${param.id}&status=normal">中评</a>
                    </li>
                    <li class="${param.status == 'bad'?'cur':''}">
                        <a href="${webRoot}/otoo/productComment.ac?id=${param.id}&status=bad">差评</a>
                    </li>
                </ul>
                <ul class="mc-cont">
                    <c:forEach items="${commentProxyResult}" var="productComment" varStatus="num">
                        <li class="${num.index%2 != 0 ? 'bg' : ''}">
                            <div class="m-com">
                            <span>
                               ${productComment.userName}
                            </span>
                                <c:set value="${productComment.totalScore+3}" var="score"></c:set>
                                <c:forEach var="s" begin="1" end="${score}">
                                    <i></i>
                                </c:forEach>
                                <c:forEach var="s" begin="1" end="${5-score}">
                                    <em></em>
                                </c:forEach>
                            </div>
                            <p>${productComment.content}</p>
                            <div class="time">${productComment.createTimeString}</div>
                        </li>
                    </c:forEach>
                </ul>
                <div class="pager">
                    <c:if test="${commentProxyPage.lastPageNumber>1}">
                        <div class="page">
                            <div style="float:right">
                                <p:PageTag isDisplayGoToPage="true" isDisplaySelect="false" ajaxUrl="${webRoot}/otoo/productComment.ac" totalPages='${commentProxyPage.lastPageNumber}' currentPage='${pageNum}'  totalRecords='${commentProxyPage.totalCount}' frontPath='${webRoot}' displayNum='8'/>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<!--main end-->
<c:import url="/template/bdw/otoo/common/bottom.jsp?p=index"/>
<!-- footer end-->
</body>
</html>
