<%@ taglib prefix="p" uri="/iMallTag" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<c:set value="${sdk:getLoginUser()}" var="loginUser"/><%--当前用户资料--%>
<c:if test="${empty loginUser}">
    <c:redirect url="/login.ac"></c:redirect>
</c:if>


<c:set var="_page" value="${empty param.page?1:param.page}"/>  <%--接受页数--%>
<c:set value="${bdw:getOtooProductCollect(9)}" var="userProductPage"/>   <%--获取收藏O2O商品列表--%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}" /> <%--SEO description优化--%>
    <title>收藏O2O商品-${webName}-${sdk:getSysParamValue('index_title')}</title> <%--SEO title优化--%>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/module/member/statics/css/member.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/module/member/statics/css/border.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/module/member/statics/css/layer.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/module/member/otoo/statics/css/collect.css" rel="stylesheet" type="text/css" />

    <link href="${webRoot}/template/bdw/statics/js/easydialog/news_html.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.DOMWindow.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.cycle.all.min.js"></script>

    <script type="text/javascript">
        var webPath = {webRoot: "${webRoot}"};
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/module/member/otoo/statics/js/otooCollection.js"></script>
</head>
<body>

<%--头部 start--%>
<c:import url="/template/bdw/module/common/top.jsp?p=member"/>
<%--头部 end--%>

<%--面包屑导航 start--%>
<div id="position" class="m1-bg"><div class="m1">您现在的位置：<a href="${webRoot}/index.html" title="首页">首页</a> >  <a href="${webRoot}/module/member/index.ac" title="会员中心">会员中心</a> >  O2O商品收藏 </div></div>
<%--面包屑导航 end--%>

<div id="member">
    <%--左边菜单栏 start--%>
    <c:import url="/template/bdw/module/member/include/leftMenu.jsp"/>
    <%--左边菜单栏 end--%>
        <%--收藏商品列表 start--%>
        <div class="right">
            <div class="tit">
                我的收藏
            </div>
            <c:choose>
                <c:when test="${empty userProductPage.result}">
                    <div class="b_info">
                        <li class="e-none" style="padding-left:277px;width:502px;height: 160px;padding-top: 50px;"><!--，没有搜到商品-->
                            <p><i>没有收藏商品？</i></p>
                            <p><em>赶紧去首页逛逛吧！</em></p>
                            <a href="${webRoot}/index.html">返回首页>></a>
                        </li>
                    </div>
                </c:when>
                <c:otherwise>
                    <ul>
                        <c:forEach items="${userProductPage.result}" var="prdProxy" varStatus="statu">
                            <li>
                                <a class="p-img" href="${webRoot}/otoo/product.ac?id=${prdProxy.otooProductId}" target="_blank" title="${prdProxy.otooProductNm}">
                                    <img src="${prdProxy.images[0]['240X160']}"  alt="${prdProxy.otooProductNm}">
                                </a>
                                <a class="p-name" href="${webRoot}/otoo/product.ac?id=${prdProxy.otooProductId}" target="_blank" title="${prdProxy.otooProductNm}">${prdProxy.otooProductNm}</a>
                                <span class="c-price">&yen;<fmt:formatNumber value="${prdProxy.otooDiscountPrice}" type="number" pattern="#0.00#" /></span>
                                <span class="o-price">价值<del>&yen;<fmt:formatNumber value="${prdProxy.otooMarketPrice}" type="number" pattern="#0.00#" /></del></span>
                                <a href="javascript:;" class="del" onclick="deleteSingCollection('${prdProxy.otooProductId}')"></a>
                            </li>
                        </c:forEach>
                    </ul>
                </c:otherwise>
            </c:choose>
            <div class="clearfix"></div>
        </div>
        <%--收藏商品列表 end--%>
        <%--分页 start--%>
        <c:if test="${userProductPage.lastPageNumber > 1}">
             <div style="float:right">
                <p:PageTag isDisplayGoToPage="true" isDisplaySelect="false" ajaxUrl="${webRoot}/module/member/otoo/otooCollection.ac?pitchOnRow=49" totalPages='${userProductPage.lastPageNumber}' currentPage='${_page}'  totalRecords='${userProductPage.totalCount}' frontPath='${webRoot}' displayNum='6'/>
            </div>
        </c:if>
        <%--分页 end--%>
        <div class="clear"></div>
</div>

<%--底部 start--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--底部 end--%>
</body>
</html>
