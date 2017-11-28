<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="p" uri="/iMallTag" %>
<c:set value="${param.tabSelect}"  var="tabSelect"/>
<c:set value="${empty param.page ? 1 : param.page}" var="_page"/>  <%--获取页码--%>
<c:set value="${sdk:getMarketingActivityById(param.activityId)}" var="marketActivity"/>
<c:set value="${sdk:getMarketingActivitySignUpProxyList(_page,12,param.activityId)}" var="marketActivityProduct"/>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}" /> <%--SEO description优化--%>
    <title>${webName}-活动列表-${sdk:getSysParamValue('index_title')}</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/activityIndex.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>

    <!--[if IE 6]>
    <script type="text/javascript" src="script/DD_belatedPNG_0.0.8a-min.js"></script>
    <script>DD_belatedPNG.fix('div,ul,li,a,h1,h2,h3,input,img,span,dl, background');</script><![endif]-->
    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/jqGrid/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.cycle.all.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.jcarousel.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/activityList.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            tabSelect("${param.at}","${tabSelect}");
        });
    </script>
</head>

<body>
<%--页脚开始--%>
<c:import url="/template/bdw/module/common/top.jsp?p=activityIndex"/>
<%--页脚结束--%>

<div id="main">
    <%--列表 banner 开始--%>
    <%--<div class="layer">
        <img src="${sdk:getAdvtUrlByMarketingActivityIdSpec(marketActivity.marketingActivityId,'980X100')}" width="980px" height="100px"/>
    </div>--%>
    <%--列表 banner 结束--%>

    <%--导航栏 开始--%>
   <%-- <div class="menu">
       &lt;%&ndash; <a class="cur" href="${webRoot}/activityIndex.ac?at=fTab">品牌折扣特卖</a>&ndash;%&gt;
        <a class="process" href="${webRoot}/activityIndex.ac?tabSelect=process">正在进行</a>
        <a class="last" href="${webRoot}/activityIndex.ac?tabSelect=last">最后一天</a>
        <a class="already" href="${webRoot}/activityIndex.ac?tabSelect=already&at=fTab">即将开始</a>
    </div>--%>
    <%--导航栏结束--%>

    <%--列表 BigBanner 开始--%>
    <div class="banner" style="position: relative;width: 1190px;height: 290px;">
        <div class="pic">
            <img src="${sdk:getAdvtUrlByMarketingActivityIdSpec(marketActivity.marketingActivityId,'1190X290')}" width="1190px" height="290px"/>
        </div>
    </div>
    <%--列表 BigBanner 结束--%>

    <div class="countdown">
        <input type="hidden"  value="${marketActivity.activityEndTimeStr}" name="listPageTime"/>
        <a class="listPageTime"></a>
    </div>
    <div class="clear"></div>
    <div class="sort-box">
        <c:forEach items="${marketActivityProduct.result}" var="activity" varStatus="num">
            <c:set var="productProxy" value="${sdk:getProductById(activity.productId)}"/>
            <ul>
                <h2><a href="${webRoot}/product-${productProxy.productId}.html"><img src="${productProxy.defaultImage['360X360']}" width="270" height="270" /></a></h2>
                <c:choose>
                    <c:when test="${fn:length(productProxy.name)>20}">
                        <h3><a href="${webRoot}/product-${productProxy.productId}.html">${fn:substring(productProxy.name, 0, 20)}... </a></h3>
                    </c:when>
                    <c:otherwise>
                        <h3><a href="${webRoot}/product-${productProxy.productId}.html">${productProxy.name}</a></h3>
                    </c:otherwise>
                </c:choose>
                <li>
                    <div class="left"><span class="discountSpan">￥<span>${activity.price}</span></span></div>
                    <div class="center"><span class="discountSpan">市场价：<span>${productProxy.marketPrice}</span></span></div>
                    <div class="right">
                        <span class="discountSpan">${activity.discount}折</span>
                    </div>
                </li>
            </ul>
        </c:forEach>
        <div class="clear"></div>
    </div>
     <div class="page" style="height: 60px; line-height: 60px;">
         <div style="float: right;">
              <c:if test="${marketActivityProduct.lastPageNumber>1}">
                 <p:PageTag isDisplayGoToPage="true" isDisplaySelect="false" totalPages='${marketActivityProduct.lastPageNumber}' currentPage='${_page}'  totalRecords='${marketActivityProduct.totalCount}' ajaxUrl='${webRoot}/activityList.ac' frontPath='${webRoot}' displayNum='6' />
              </c:if>
          </div>
     </div>
</div>


<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>
</body>
</html>
