<%@ taglib prefix="p" uri="/iMallTag" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${empty param.page ? 1 : param.page}" var="_page"/>
<c:set value="${sdk:search(20)}" var="productProxys"/>

<%--这段代码主要解决,搜索页面下,热卖推荐等商品显示什么 start--%>
<c:if test="${not empty param.keyword}">
    <c:set value="${sdk:search(1)}" var="productProxysBySearch"/>
    <c:if test="${not empty productProxysBySearch}">
        <c:forEach items="${productProxys.result}" var="productProxy" end="0">
            <c:set value="${productProxy.categoryId}" var="searchCategory"/>
        </c:forEach>
    </c:if>
</c:if>

<c:choose>
    <c:when test="${not empty param.keyword && not empty searchCategory}">
        <c:set value="${searchCategory}" var="categoryId"/>
    </c:when>
    <c:otherwise>
        <c:set value="${param.category==null ? 1 : param.category}" var="categoryId"/>
    </c:otherwise>
</c:choose>
<%--这段代码主要解决,搜索页面下,热卖推荐等商品显示什么 end--%>

<c:set value="${sdk:queryProductCategoryById(categoryId)}" var="category"/>
<c:set value="${sdk:getFacet()}" var="facetProxy"/>
<c:set value="${sdk:getCategoryHotSalesProducts(category.categoryId)}" var="categoryHotSalesProducts"/>
<%--获取当前用户--%>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${category.metaKeywords}-${webName}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${category.metaDescription}-${webName}" /> <%--SEO description优化--%>
    <title>${webName}-${empty category.webTitle ? category.name : category.webTitle}-${param.keyword}</title>


    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/list.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.cookie.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/productlist.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/pop-compare.js"></script>

    <script type="text/javascript">
        var paramData={
            webRoot:"${webRoot}",
            page:"${_page}",
            totalCount:"${productProxys.lastPageNumber}",
            category:"${categoryId}",
            q:"${param.q}",
            keyword:"${param.keyword}",
            order:"${param.order}",
            productCollectCount:"${loginUser.productCollectCount}",
            cookieNum:0,
            sort:"${param.sort}"
        }
    </script>

    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/productlist.js"></script>
    <style type="text/css">
        #list .part1 .r .hot_Selt .hoto_ico{_background:none;    width:67px; height:67px;
            filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='${webRoot}/template/bdw/statics/images/list_fong_Hot.png', sizingMethod='crop')}
    </style>
</head>
<body>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp?p=list"/>
<%--页头结束--%>
<!--main-->
<div class="list-main">

<div id="position" class = "m1-bg">
    <div class = "m1">
        <a href="${webRoot}/index.html" title="首页">首页 &nbsp;>&nbsp;</a>
        <c:choose>
            <c:when test="${empty param.keyword}">
                <c:forEach items="${category.categoryTree}" var="node" varStatus="num">
                    <c:if test="${node.categoryId != 1}">
                        <c:choose>
                            <c:when test="${num.count==2}">
                                <%--<a style="font-size: 16px;" href="${webRoot}/productlist-${node.categoryId}.html" title="${node.name}">${node.name}</a>--%>
                                <a href="${webRoot}/productlist-${node.categoryId}.html" title="${node.name}">${node.name}</a>
                                <c:if test="${!num.last}">&nbsp;>&nbsp;</c:if>
                            </c:when>
                            <c:otherwise>
                                <a href="${webRoot}/productlist-${node.categoryId}.html" title="${node.name}">${node.name}</a>
                                <c:if test="${!num.last}">&nbsp;></c:if>
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <%--<span style="font-family:'宋体';font-weight:bold;">全部结果   >“${param.keyword}”</span>--%>
                您现在的位置：全部结果&nbsp;>&nbsp;${param.keyword}
            </c:otherwise>
        </c:choose>
    </div>
</div>
<div class="m2">
<div class="m2_lt">
    <c:choose>
        <c:when test="${empty param.keyword}">
            <div class="side-nav">
                    <c:choose>
                        <c:when test="${not empty category.children}">
                            <c:forEach items="${category.children}" var="node" varStatus="s">
                                <c:choose>
                                    <c:when test="${not empty node.children}">
                                        </h4>

                                        <h4 <c:if test="${num.last}">style="border-bottom: none;" </c:if>>
                                            <ul class="main-nav">
                                                <li class="item cur">
                                                    <a href="javascript:void(0)" class="m-title" onclick="closeOrOpen(this)">${fn:substring(node.name,0,12)}</a>
                                                    <ul class="submenu" style="display: block" rel = "Y">
                                                        <c:forEach items="${node.childrenOrSameLevel}" var="child">
                                                            <li class="item2"><a href="${webRoot}/productlist-${child.categoryId}.html">${child.name}</a></li>
                                                        </c:forEach>
                                                    </ul>
                                                </li>
                                            </ul>

                                            <div class="clear"></div>
                                        </h4>
                                    </c:when>
                                    <c:otherwise>
                                        <c:if test="${s.count == 1}">
                                            <c:set value="${sdk:queryUpperCategory(category.categoryId)}" var="upperCategory"/>
                                            <c:if test="${not empty upperCategory}">
                                                <c:forEach items="${upperCategory.childrenOrSameLevel}" var="child" varStatus="num">
                                                    <h4 <c:if test="${num.last}">style="border-bottom: none;" </c:if>>
                                                        <ul class="main-nav">
                                                            <li class="item cur">
                                                                <a href="javascript:void(0)" class="m-title" onclick="closeOrOpen(this)">${fn:substring(child.name,0,12)}</a>
                                                                <ul class="submenu" style="display: block" rel = "Y">
                                                                    <c:forEach items="${child.childrenOrSameLevel}" var="child">
                                                                        <li class="item2"><a href="${webRoot}/productlist-${child.categoryId}.html">${child.name}</a></li>
                                                                    </c:forEach>
                                                                </ul>
                                                            </li>
                                                        </ul>

                                                        <div class="clear"></div>
                                                    </h4>
                                                </c:forEach>
                                            </c:if>
                                        </c:if>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <c:set value="${sdk:queryUpperCategory(categoryId)}" var="upperCategory"/>
                            <c:if test="${not empty upperCategory}">
                                <h4>
                                    <ul class="main-nav">
                                        <li class="item cur">
                                            <a href="javascript:void(0)" class="m-title" onclick="closeOrOpen(this)">${fn:substring(upperCategory.name,0,12)}</a>
                                            <ul class="submenu" style="display: block" rel = "Y">
                                                <c:forEach items="${upperCategory.childrenOrSameLevel}" var="node">
                                                    <li class="item2"><a href="${webRoot}/productlist-${node.categoryId}.html">${node.name}</a></li>
                                                </c:forEach>
                                            </ul>
                                        </li>
                                    </ul>

                                    <div class="clear"></div>
                                </h4>
                            </c:if>
                        </c:otherwise>
                    </c:choose>
            </div>
        </c:when>
    </c:choose>

    <c:choose>
        <c:when test="${empty param.keyword}">
            <div class="side-hot">
                <div class="sh-title">品类热卖</div>
                <div class="sh-box">
                    <c:set value="${sdk:findMonthTopProducts(category.categoryId,7)}" var="monthTopProducts"/>
                    <c:if test="${not empty monthTopProducts}">
                        <ul>
                            <c:forEach items="${monthTopProducts}" var="phoneList" varStatus="s">
                                <li >
                                    <div class="b-pic"><a target="_blank" href="${webRoot}/product-${phoneList.productId}.html" title=""><img src="${empty phoneList.images?phoneList.defaultImage['150X150']:phoneList.images[0]['150X150']}" alt="" /></a></div>
                                    <div class="b-title"><a target="_blank" href="${webRoot}/product-${phoneList.productId}.html">${phoneList.name}</a></div>
                                    <div class="b-pri">
                                        <p class="p-new">
                                            <span>￥<em>${phoneList.price.unitPrice}</em></span>
                                        </p>
                                        <p class="p-old">
                                            <span>￥<em>${phoneList.marketPrice}</em></span>
                                        </p>
                                    </div>
                                    <div class="clear"></div>
                                </li>
                            </c:forEach>
                        </ul>
                    </c:if>
                    <c:if test="${empty monthTopProducts}">
                        <i style="color:red; margin-top:5px;font-size: 15px;margin-left:45px">暂无热卖产品</i>
                    </c:if>
                </div>
            </div>
        </c:when>

        <c:otherwise>
            <div class="side-hot">
                <div class="sh-title">销售热卖</div>
                <div class="sh-box">
                    <c:set value="${sdk:findMonthTopProducts(1,7)}" var="monthTopProducts"/>
                    <c:if test="${not empty monthTopProducts}">
                        <ul>
                            <c:forEach items="${monthTopProducts}" var="phoneList" varStatus="s">
                                <li >
                                    <div class="b-pic"><a target="_blank" href="${webRoot}/product-${phoneList.productId}.html" title=""><img src="${empty phoneList.images?phoneList.defaultImage['150X150']:phoneList.images[0]['150X150']}" alt="" /></a></div>
                                    <div class="b-title"><a target="_blank" href="${webRoot}/product-${phoneList.productId}.html">${phoneList.name}</a></div>
                                    <div class="b-pri">
                                        <p class="p-new">
                                            <span>￥<em>${phoneList.price.unitPrice}</em></span>
                                        </p>
                                        <p class="p-old">
                                            <span>￥<em>${phoneList.marketPrice}</em></span>
                                        </p>
                                    </div>
                                    <div class="clear"></div>
                                </li>
                            </c:forEach>
                        </ul>
                    </c:if>
                    <c:if test="${empty monthTopProducts}">
                        <i style="color:red; margin-top:5px;font-size: 15px;margin-left:45px">暂无热卖产品</i>
                    </c:if>
                </div>
            </div>
        </c:otherwise>
    </c:choose>

    <div class="side-history">
        <div class="sh-title">浏览过的商品&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="javascript:;" onclick="clearHistoryProductsCookie()">清空</a></div>
        <div class="clear"></div>
        <div class="sh-box">
            <c:set value="${sdk:getProductFromCookie(pageContext.request,pageContext.response)}" var="productFromCookies"/>
            <c:choose>
                <c:when test="${not empty productFromCookies}">
                        <ul>
                            <c:forEach items="${productFromCookies}" var="proxy" varStatus="s" end="5">
                                <c:if test="${s.count%2==0}">
                                    <li class="mr0">
                                        <a href="${webRoot}/product-${proxy.productId}.html" target="_blank"><img src="${proxy.defaultImage["80X80"]}"  alt="${proxy.name}"/></a>
                                        <i>￥<em><fmt:formatNumber value="${proxy.price.unitPrice}" type="number" pattern="#0.00#" /></em></i>
                                    </li>
                                </c:if>
                                <c:if test="${s.count%2!=0}">
                                    <li>
                                        <a href="${webRoot}/product-${proxy.productId}.html" target="_blank"><img src="${proxy.defaultImage["80X80"]}"  alt="${proxy.name}"/></a>
                                        <i>￥<em><fmt:formatNumber value="${proxy.price.unitPrice}" type="number" pattern="#0.00#" /></em></i>
                                    </li>
                                </c:if>
                            </c:forEach>
                        </ul>
                    </div>
                </c:when>
                <c:otherwise>
                    <div style="color:red; margin-top:5px;font-size: 15px;margin-left:15px">你还未浏览其他商品</div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

<%
    int countCategory = 0;
%>
<div class="m2_rt">
<div class="mr1">
    <c:choose>
        <c:when test="${empty param.keyword}">
            <c:if test="${fn:length(facetProxy.selections) > 0}">
                <div class="m1-select">
                    <i>您选择了：</i>
                    <c:if test="${fn:length(facetProxy.selections) > 0}">

                    </c:if>
                    <ul>
                        <c:forEach items="${facetProxy.selections}" var="selections">
                            <li>
                                <a href="${selections.url}" title="${selections.name}">
                                        ${fn:substring(selections.title,0,6)}(${selections.name})
                                    <i></i>
                                </a>
                            </li>
                        </c:forEach>

                    </ul>
                        <%-- <a href="#" class="reset"></a>--%>
                    <a href="${webRoot}/productlist-${categoryId}.html" class="reset"></a>
                </div>
            </c:if>

            <c:forEach items="${facetProxy.unSelections}" var="unSelections" varStatus="s">
                <c:if test="${fn:length(unSelections.couts) > 0}">
                    <%
                        countCategory++;
                    %>
                    <div ${fn:substring(unSelections.title,0,6)=='品牌'?'class="m1-rows unSelections"':'class="m1-rows m1-rows2 unSelections"'}  style="display: <c:choose><c:when test="${s.count > 4}">none;</c:when><c:otherwise>block;</c:otherwise></c:choose>;">
                        <i>${fn:substring(unSelections.title,0,6)}：</i>
                        <ul>
                            <li  class="first" href="javascript:void(0);" title="全部">
                                <c:if test="${fn:substring(unSelections.title,0,6)=='品牌'}">
                                    <a href="javascript:void(0);">全部品牌(ALL)</a>
                                </c:if>
                                <c:if test="${fn:substring(unSelections.title,0,6)!='品牌'}">
                                    <a href="javascript:void(0);">全部</a>
                                </c:if>
                            </li>
                            <%
                                int count = 0;
                            %>
                            <c:forEach items="${unSelections.couts}" var="count">
                                <c:if test="${not empty count.name}">
                                    <li class="showOrHide">
                                        <a href="${webRoot}/productlist.ac${count.url}" title="${count.name}">${fn:substring(count.name,0,10)}(${count.count})</a>
                                    </li>
                                    <%
                                        count++;
                                    %>
                                </c:if>
                            </c:forEach>
                        </ul>
                        <%
                            if(count>4) {

                            %>
                            <a href="javascript:void(0);" class="more" onclick="showThis(this)" style="display: none">更多</a>
                            <a href="javascript:void(0);" class="collapse" onclick="hideThis(this)">收起</a>
                            <%
                                }
                        %>
                       <%-- <a href="javascript:void(0);" class="more" onclick="showThis(this)" style="display: none">更多</a>
                        <a href="javascript:void(0);" class="collapse" onclick="hideThis(this)">收起</a>--%>
                    </div>
                </c:if>
            </c:forEach>
               <%-- ${facetProxy.unSelections.productProxys!=null}--%>
            <%
                if(countCategory>1) {
            %>
                <div class="m1-more" style="display: none;"><a href="javascript:void(0);" id="showUnSelections" onclick="showUnSelections();">更多属性筛选<i></i></a></div>
                <div class="m1-coll"><a href="javascript:void(0);" id="hideUnSelections" onclick="hideUnSelections();" >收起<i></i></a></div>
            <%
                }
            %>
        </c:when>
    </c:choose>
</div>

    <%
        if(countCategory>1) {
    %>
        <div class="mr2" >
    <%
        } else {


    %>
        <div class="mr2"style="margin-top:8px;">
    <%
        }
    %>

    <div class="sort">
        <ul class="s-lt">
            <li  ${param.order==""||param.order==null||param.order=='salesVolume,desc'?'class="cur"':'item'}  ><a href="${webRoot}/productlist.ac?category=${categoryId}&q=${param.q}&keyword=${param.keyword}&order=salesVolume,desc&sort=none">销量</a></li>
            <li  ${param.order=='minPrice,desc'||param.order=='minPrice,asc'?'class="cur"':'item'}><a  href="javascript:void(0)" onclick="chageSortByPrice(this)">价格<i class="${param.sort}"></i></a></li>
            <li  ${param.order=='commentQuantity,desc'?'class="cur"':'item'}><a  href="${webRoot}/productlist.ac?category=${categoryId}&q=${param.q}&keyword=${param.keyword}&order=commentQuantity,desc&sort=none">评论数</a></li>
            <li  ${param.order=='lastOnSaleDate,desc'?'class="cur"':''}><a  href="${webRoot}/productlist.ac?category=${categoryId}&q=${param.q}&keyword=${param.keyword}&order=lastOnSaleDate,desc&sort=none">上架时间</a></li>
        </ul>
        <div class="s-pages">
            <div class="prev"><a href="javascript:void(0)" id="pageUp"></a></div>
            <div class="next"><a href="javascript:void(0)" id="pageDown"></a></div>
        </div>
        <div class="s-all">
            <c:if test="${not empty param.keyword}">
                <span style="font-family:'宋体';font-weight:bold;color: #333333;"><span style="color: #CC0000;">“${param.keyword}”</span></span>找到的商品共有
            </c:if>
            <c:if test="${empty param.keyword}">
                为您搜索到的商品共有
            </c:if>
            ${productProxys.totalCount} 个
        </div>
    </div>
    <div class="listbox">
        <ul>
             <c:choose>
                 <c:when test="${productProxys.totalCount == 0}">
                     <li class="e-none" style="padding-left:268px;width:709px;height: 160px;padding-top: 50px;"><!--，没有搜到商品-->
                         <p><i>没有搜到宝贝？</i></p>
                         <p><em>换个关键字试试，或者去首页逛逛吧！</em></p>
                         <a href="${webRoot}/index.html">返回首页>></a>
                     </li>
                 </c:when>
                 <c:otherwise>

                         <c:forEach items="${productProxys.result}" var="productProxy" varStatus="s">
                             <c:if test="${s.count%4==0}">
                                 <li class="mr0">
                                     <div class="l-pic"><a href="${webRoot}/product-${productProxy.productId}.html" title="${productProxy.name}" target="_blank"><img src="${productProxy.defaultImage["220X220"]}" alt="${productProxy.name}" onload="adapt(this)" /></a></div>
                                     <div class="l-title"><a href="${webRoot}/product-${productProxy.productId}.html" title="${productProxy.name}" target="_blank">${productProxy.name}<span>${productProxy.salePoint}</span></a></div>
                                     <div class="l-pri">
                                         <span class="new">￥<em> <fmt:formatNumber value="${productProxy.price.unitPrice}" type="number"  pattern="#0.00#" /></em></span>
                                         <span class="old">￥<i> <fmt:formatNumber value="${productProxy.marketPrice}" type="number"  pattern="#0.00#" /></i></span>
                                     </div>
                                 </li>
                             </c:if>

                             <c:if test="${s.count%4!=0}">
                                 <li>
                                     <div class="l-pic"><a href="${webRoot}/product-${productProxy.productId}.html" title="${productProxy.name}" target="_blank"><img src="${productProxy.defaultImage["220X220"]}" alt="${productProxy.name}" onload="adapt(this)"/></a></div>
                                     <div class="l-title"><a href="${webRoot}/product-${productProxy.productId}.html" title="${productProxy.name}" target="_blank">${productProxy.name}<span>${productProxy.salePoint}</span></a></div>
                                     <div class="l-pri">
                                         <span class="new">￥<i> <fmt:formatNumber value="${productProxy.price.unitPrice}" type="number"  pattern="#0.00#" /></i></span>
                                         <span class="old">￥<em> <fmt:formatNumber value="${productProxy.marketPrice}" type="number"  pattern="#0.00#" /></em></span>
                                     </div>
                                 </li>
                             </c:if>
                         </c:forEach>

                 </c:otherwise>
             </c:choose>
        </ul>
    </div>
    <div class="page">
        <div style="float: right;">
            <c:if test="${productProxys.lastPageNumber>1}">
                <p:PageTag isDisplayGoToPage="true" isDisplaySelect="false" totalPages='${productProxys.lastPageNumber}' currentPage='${_page}'  totalRecords='${productProxys.totalCount}' ajaxUrl='${webRoot}/productlist.ac' frontPath='${webRoot}' displayNum='6' />
            </c:if>
        </div>
    </div>
</div>
</div>
<div class="clear"></div>
</div>

<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>

</body>
</html>
