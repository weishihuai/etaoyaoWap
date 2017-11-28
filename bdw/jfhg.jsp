<%@ taglib prefix="p" uri="/iMallTag" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${empty param.categoryId ? 10 : param.categoryId}" var="categoryId"/>
<c:set value="${sdk:queryProductCategoryById(categoryId)}" var="category"/>
<c:set value="${empty param.type?'G':param.type}" var="type" />
<c:set value="${empty param.selectId?9:param.selectId }" var="selectId" />
<%--<c:set value="${sdk:getZone(type,selectId)}" var="zoneProxy"/>--%>
<c:set value="${empty param.page ? 1 : param.page}" var="_page"/>
<%--根据分类Id查找积分商品--%>
<c:set value="${sdk:findIntegralProductsByCategoryId(categoryId,20)}" var="integralProducts"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="易淘药积分兑换，易淘药，易淘药集团，易淘药大健康，果维康，溯源商城，药食同源，欧意，欧意和，若舒，恩必普，易淘药电商，安沃勤，纯净冰岛，安蜜乐，易淘药贝贝，易淘药健康城" /> <%--SEO keywords优化--%>
    <meta name="description" content="易淘药健康网，易淘药集团官方网站，易淘药积分兑换，果维康积分兑换" /> <%--SEO description优化--%>
    <title>${sdk:getSysParamValue('index_title')}</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/exchange.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/integralList.js"></script>
    <style type="text/css">
        #lmenu .cur{background: #FF6B05;padding: 3px 10px;}
        #list .l .m1 .box h2 .cur{color: #FFF;}
        #list .l .m1 .box dd .cur{color: #FFF;}
    </style>
    <script type="text/javascript">
        var dataValue={
            webRoot:"${webRoot}",
            type:"${param.type}",
            selectId:"${param.selectId}",
            lastNodeId:"${param.lastNodeId}",
            nodeId:"${param.nodeId}",
            isIntegral:"${param.isIntegral}",
            min:"${param.min}",
            max:"${param.max}",
            page:"${_page}",
            totalPage:"${integralProducts.lastPageNumber}",
            order:"${param.order}",
            categoryId:"${param.categoryId}"
        }
    </script>
</head>

<body>

<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp"/>
<%--页头结束--%>

<div id="position" class="m1-bg"><div class="m1"><a href="${webRoot}/index.html">首页</a> > 积分兑换列表</div></div>

<div id="list">
    <div class="l">
        <%--商品分类开始--%>
        <div class="m1">
            <h1><a href="${webRoot}/jfhg.ac?categoryId=10" title="所有积分商品">积分分类</a></h1>
            <div id="lmenu" class="box">
                <%--列出积分商品分类 开始 --%>
                <c:forEach items="${sdk:queryIntegralCategory()}" var="integralCategory" >
<%--
                    <h2><a href="${webRoot}/integral/integralList.ac?categoryId=${integralCategory.categoryId}" class="<c:if test="${param.categoryId==integralCategory.categoryId}">cur</c:if>">${integralCategory.name}</a></h2>
--%>
                    <h2><a href="${webRoot}/jfhg.ac?categoryId=${integralCategory.categoryId}" class="<c:if test="${param.categoryId==integralCategory.categoryId}">cur</c:if>">${integralCategory.name}</a></h2>
                    <dl>
                        <c:forEach items="${integralCategory.children}" var="children">
<%--
                            <dd><a href="${webRoot}/integral/integralList.ac?categoryId=${children.categoryId}" class="<c:if test="${param.categoryId==children.categoryId}">cur</c:if>">${children.name}</a></dd>
--%>
                            <dd><a href="${webRoot}/jfhg.ac?categoryId=${children.categoryId}" class="<c:if test="${param.categoryId==children.categoryId}">cur</c:if>">${children.name}</a></dd>
                        </c:forEach>
                    </dl>
                </c:forEach>
                <%--列出积分商品分类 结束--%>
            </div>
        </div>
        <%--商品分类结束--%>

        <%--左边广告1--%>
        <div class="banner frameEdit" frameInfo="jvan_integral_left_adv1|210X255">
            <c:forEach items="${sdk:findPageModuleProxy('jvan_integral_left_adv1').advt.advtProxy}" var="adv" end="0" varStatus="s">
                <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="210px" height="255px" /></a>
            </c:forEach>
        </div>

        <%--左边广告2--%>
        <div class="banner frameEdit" frameInfo="jvan_integral_left_adv2|210X255">
            <c:forEach items="${sdk:findPageModuleProxy('jvan_integral_left_adv2').advt.advtProxy}" var="adv" end="0" varStatus="s">
                <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="210px" height="255px" /></a>
            </c:forEach>
        </div>
    </div>
    <div class="r">
        <h6 style="font-size:13px">
            <div class="tipData">为您搜索到的商品共有 <span>${integralProducts.totalCount}</span> 个 共 <span>${integralProducts.lastPageNumber}</span> 页</div>
            <div class="Sort">
                <label>排序：</label>
                <div class="inPrice"><a href="javascript:" onclick="order('integralOrder')" <c:if test="${param.order=='integralPrice,desc'}">class='s_d'</c:if><c:if test="${param.order=='integralPrice,asc'}">class='i_p'</c:if>>积分</a></div>
                <div class="s_Time"><a href="javascript:" onclick="order('timeOrder')"<c:if test="${empty param.order||param.order=='integralProductId,desc'}">class='t_d'</c:if><c:if test="${param.order=='integralProductId,asc'}">class='t_p'</c:if>>时间</a></div>
                <div class="clear"></div>
            </div>
            <div class="trunPage">
                <span style="padding-top: 9px; float: left; margin-right: 10px;">${_page}/${integralProducts.lastPageNumber}</span>
                <a id="pageDown" title="下一页" href="javascript:void(0);"></a>
                <a id="pageUp" title="上一页" href="javascript:void(0);"></a>
            </div>
            <div class="clear"></div>
        </h6>
        <div class="showList">
            <ul>
                <c:forEach items="${integralProducts.result}" var= "product">
                    <li>
                        <div class="pic">
                            <c:choose>
                                <c:when test="${product.type == 0}">
                                    <a href="${webRoot}/integral/integralDetail.ac?integralProductId=${product.integralProductId}" title="${product.integralProductNm}">
                                        <img src="${product.icon['']}" width="160px" height="160px" />
                                    </a>
                                </c:when>
                                <c:otherwise> <img src="${product.icon['']}" width="160px" height="160px" /></c:otherwise>
                            </c:choose>
                        </div>
                        <div class="title"><a <c:if test="${product.type == 0}">href="${webRoot}/integral/integralDetail.ac?integralProductId=${product.integralProductId}"</c:if> title="${product.integralProductNm}">${product.integralProductNm}</a></div>
                            <%--<p>积分：<b><fmt:formatNumber value="${product.integral}" type="number" />${product.paymentConvertTypeCode eq '2'}</b></p>--%>
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
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>
    <div class="clear"></div>
</div>

<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>

</body>
</html>
