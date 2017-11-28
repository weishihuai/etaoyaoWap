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
    <link href="${webRoot}/template/bdw/statics/css/newList.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/pop-compare.css" rel="stylesheet" type="text/css" />
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
            cookieNum:0
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

<div id="position">
    <%--<a href="${webRoot}/index.html" title="首页">首页</a>--%>
    <c:choose>
        <c:when test="${empty param.keyword}">
            <c:forEach items="${category.categoryTree}" var="node" varStatus="num">
                <c:if test="${node.categoryId != 1}">
                    <c:choose>
                        <c:when test="${num.count==2}">
                            <%--<a style="font-size: 16px;" href="${webRoot}/productlist-${node.categoryId}.html" title="${node.name}">${node.name}</a>--%>
                            您现在的位置：<a href="${webRoot}/productlist-${node.categoryId}.html" title="${node.name}">${node.name}</a>
                            <c:if test="${!num.last}">></c:if>
                        </c:when>
                        <c:otherwise>
                            <a href="${webRoot}/productlist-${node.categoryId}.html" title="${node.name}">${node.name}</a>
                            <c:if test="${!num.last}">></c:if>
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


<div id="list">
<div class="part1">
<div class="l">
    <c:choose>
        <c:when test="${empty param.keyword}">
            <div class="m1">
                <div class="box">
                    <c:choose>
                        <c:when test="${not empty category.children}">
                            <c:forEach items="${category.children}" var="node" varStatus="s">
                                <c:choose>
                                    <c:when test="${not empty node.children}">
                                        <h4 <c:if test="${s.last}">style="border-bottom: none;" </c:if>>
                                            <div class="tit"><a href="${webRoot}/productlist-${node.categoryId}.html">${fn:substring(node.name,0,12)}</a></div>
                                            <div class="closeOrOpen" onclick="closeOrOpen(this)"><a href="javascript:void(0);"><img rel="N"  src="${webRoot}/template/bdw/statics/images/list_mIco.gif" /></a></div>
                                            <div class="clear"></div>
                                        </h4>
                                        <ul style="display: block;">
                                            <c:forEach items="${node.childrenOrSameLevel}" var="child">
                                                <li><a href="${webRoot}/productlist-${child.categoryId}.html">${child.name}</a></li>
                                            </c:forEach>
                                        </ul>
                                    </c:when>
                                    <c:otherwise>
                                        <c:if test="${s.count == 1}">
                                            <c:set value="${sdk:queryUpperCategory(category.categoryId)}" var="upperCategory"/>
                                            <c:if test="${not empty upperCategory}">
                                                <c:forEach items="${upperCategory.childrenOrSameLevel}" var="child" varStatus="num">
                                                    <h4 <c:if test="${num.last}">style="border-bottom: none;" </c:if>>
                                                        <div class="tit"><a href="${webRoot}/productlist-${child.categoryId}.html">${fn:substring(child.name,0,12)}</a></div>
                                                        <div class="ico" onclick="closeOrOpen(this)"><a href="javascript:void(0);;">
                                                            <c:choose>
                                                                <c:when test="${child.categoryId eq category.categoryId}">
                                                                    <img rel="N"  src="${webRoot}/template/bdw/statics/images/list_mIco.gif" />
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <img rel="Y"  src="${webRoot}/template/bdw/statics/images/list_eIco.gif" />
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </a></div>
                                                        <div class="clear"></div>
                                                    </h4>
                                                    <ul style="<c:choose><c:when test="${child.categoryId eq category.categoryId}">display: block;</c:when><c:otherwise>display: none;</c:otherwise></c:choose><c:if test="${num.last}">border-bottom: none;</c:if>">
                                                        <c:forEach items="${child.childrenOrSameLevel}" var="child">
                                                            <li><a href="${webRoot}/productlist-${child.categoryId}.html">${child.name}</a></li>
                                                        </c:forEach>
                                                    </ul>
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
                                    <div class="tit"><a href="${webRoot}/productlist-${upperCategory.categoryId}.html">${fn:substring(upperCategory.name,0,12)}</a></div>
                                    <div class="ico"></div>
                                    <div class="clear"></div>
                                </h4>
                                <ul style="display: block;">
                                    <c:forEach items="${upperCategory.childrenOrSameLevel}" var="node" >
                                        <li><a href="${webRoot}/productlist-${node.categoryId}.html">${node.name}</a></li>
                                    </c:forEach>
                                </ul>
                            </c:if>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </c:when>
    </c:choose>

    <div class="m3">
        <h1>销量排行榜</h1>
        <div class="box" id="hotTopPro1">
            <%--当前分类排行榜--%>
            <c:set value="${sdk:findMonthTopProducts(1,7)}" var="monthTopProducts"/>
            <c:if test="${not empty monthTopProducts}">
                <ul>
                    <c:forEach items="${monthTopProducts}" var="phoneList" varStatus="s">
                        <li class="hover">
                            <div class="mB">${s.count}</div>
                            <div class="tit"><a target="_blank" href="${webRoot}/product-${phoneList.productId}.html" title="">${phoneList.name}</a></div>
                            <div class="detaiF" style="display:none;">

                                <div class="pic">
                                    <a target="_blank" href="${webRoot}/product-${phoneList.productId}.html"><img src="${empty phoneList.images?phoneList.defaultImage['52X52']:phoneList.images[0]['52X52']}" alt="" /></a>
                                </div>
                                <div class="title"><a target="_blank" href="${webRoot}/product-${phoneList.productId}.html">${phoneList.name}</a></div>
                                <div class="price">￥${phoneList.price.unitPrice}</div>
                                <div class="clear"></div>
                            </div>
                            <div class="clear"></div>
                        </li>
                    </c:forEach>
                </ul>
            </c:if>
        </div>

    </div>
    <div class="m3">
        <h1>分类热销排行榜</h1>
        <%--全部的排行榜--%>
        <div class="box" id="hotTopPro">
            <c:set value="${sdk:findMonthTopProducts(category.categoryId,7)}" var="monthTopProducts"/>
            <c:if test="${not empty monthTopProducts}">
                <ul>
                    <c:forEach items="${monthTopProducts}" var="phoneList" varStatus="s">
                        <li class="hover">
                            <div class="mB">${s.count}</div>
                            <div class="tit"><a target="_blank" href="${webRoot}/product-${phoneList.productId}.html" title="">${phoneList.name}</a></div>
                            <div class="detaiF" style="display:none;">

                                <div class="pic">
                                    <a target="_blank" href="${webRoot}/product-${phoneList.productId}.html"><img src="${empty phoneList.images?phoneList.defaultImage['52X52']:phoneList.images[0]['52X52']}" alt="" /></a>
                                </div>
                                <div class="title"><a target="_blank" href="${webRoot}/product-${phoneList.productId}.html">${phoneList.name}</a></div>
                                <div class="price">￥${phoneList.price.unitPrice}</div>
                                <div class="clear"></div>
                            </div>
                            <div class="clear"></div>
                        </li>
                    </c:forEach>
                </ul>
            </c:if>
        </div>
    </div>
    <div class="banner frameEdit" frameInfo="adv8|200X300">
        <c:forEach items="${sdk:findPageModuleProxy('adv8').advt.advtProxy}" var="adv" end="0" varStatus="s">
            <a href="${adv.link}"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="200px" height="300px" /></a>
        </c:forEach>
    </div>
    <div class="banner frameEdit" frameInfo="adv9|200X300">
        <c:forEach items="${sdk:findPageModuleProxy('adv9').advt.advtProxy}" var="adv" end="0" varStatus="s">
            <a href="${adv.link}"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="200px" height="300px" /></a>
        </c:forEach>
    </div>
    <div class="banner frameEdit" frameInfo="adv10|200X300">
        <c:forEach items="${sdk:findPageModuleProxy('adv10').advt.advtProxy}" var="adv" end="0" varStatus="s">
            <a href="${adv.link}"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="200px" height="300px" /></a>
        </c:forEach>
    </div>
</div>
<div class="r">

<c:if test="${not empty categoryHotSalesProducts}">
<div class="hot_Selt">
    <c:choose>
        <c:when test="${not empty categoryHotSalesProducts}">
            <div class="hoto_ico"></div>
            <div class="hot_list">
                <h2>热卖推荐</h2>
                <div class="box">
                    <ul>
                        <c:forEach items="${categoryHotSalesProducts}" var="productProxy" end="2">
                            <li>
                                <div class="pic">
                                    <a class="cur" href="${webRoot}/product-${productProxy.productId}.html" title="${productProxy.name}" target="_blank">
                                        <img src="${productProxy.defaultImage["200X120"]}" alt="${productProxy.name}"/>
                                    </a>
                                </div>
                                <div class="title">
                                    <a href="${webRoot}/product-${productProxy.productId}.html" title="${productProxy.name}" target="_blank">${productProxy.name}<span>${productProxy.salePoint}</span></a>
                                </div>
                                <p>商城价：<b>¥ <fmt:formatNumber value="${productProxy.price.unitPrice}" type="number" pattern="#0.00#" /></b><a href="${webRoot}/product-${productProxy.productId}.html"><img src="${webRoot}/template/bdw/statics/images/list_btn001.gif" /></a></p>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <c:set value="${sdk:getCategoryHotSalesProducts(10014)}" var="categoryHotSalesProducts"/>
            <div class="hoto_ico"></div>
            <div class="hot_list">
                <h2>热卖推荐</h2>
                <div class="box">
                    <ul>
                        <c:forEach items="${categoryHotSalesProducts}" var="productProxy">
                            <li>
                                <div class="pic">
                                    <a class="cur" href="${webRoot}/product-${productProxy.productId}.html" title="${productProxy.name}" target="_blank">
                                        <img src="${productProxy.defaultImage["200X120"]}" alt="${productProxy.name}"/>
                                    </a>
                                </div>
                                <div class="title">
                                    <a href="${webRoot}/product-${productProxy.productId}.html" title="${productProxy.name}" target="_blank">${productProxy.name}<span>${productProxy.salePoint}</span></a>
                                </div>
                                <p>商城价：<b>¥ <fmt:formatNumber value="${productProxy.price.unitPrice}" type="number" pattern="#0.00#" /></b></p>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
    <div class="funnews">
        <h2>促销活动</h2>
        <div class="box">
            <ul>
                <c:forEach items="${sdk:getArticleCategoryById(11).top10}" var="article" end="7" >
                    <c:choose>
                        <c:when test="${not empty article.externalLink}">
                            <li><a target="_blank" href="${article.externalLink}" title="${article.title}">·${fn:substring(article.title,0,30)}</a></li>
                        </c:when>
                        <c:otherwise>
                            <li><a target="_blank" href="${webRoot}/mallNotice-${article.infArticleId}-${article.categoryId}.html" title="${article.title}">·${fn:substring(article.title,0,30)}</a></li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </ul>
        </div>
    </div>
    <div class="clear"></div>
</div>
</c:if>


<div class="searchIf">
    <c:choose>
        <c:when test="${empty param.keyword}">
            <h5>
                <div class="tit">${category.name}筛选</div>
                <div class="reSel"><a href="${webRoot}/productlist-${categoryId}.html">重置筛选条件</a></div>
                <div class="clear"></div>
            </h5>
            <div class="callShow">
                <div class="callShow">
                    <c:if test="${fn:length(facetProxy.selections) > 0}">
                        <div class="fixBox">
                            <label>已选择：</label>
                            <div class="titList">
                                <c:forEach items="${facetProxy.selections}" var="selections">
                                    <a href="${selections.url}" title="${selections.name}"><span>
                                       <span><strong> ${fn:substring(selections.title,0,6)}：</strong>${selections.name}&nbsp;</span>
                                </span></a>
                                </c:forEach>
                            </div>
                        </div>
                    </c:if>
                    <c:forEach items="${facetProxy.unSelections}" var="unSelections" varStatus="s">
                        <c:if test="${fn:length(unSelections.couts) > 0}">
                            <div class="fixBox unSelections" style="display: <c:choose><c:when test="${s.count > 4}">none;</c:when><c:otherwise>block;</c:otherwise></c:choose>;">
                                <div class="lable">${fn:substring(unSelections.title,0,6)}：</div>
                                <div class="attrInfo info">
                                    <a <c:if test="${fn:length(facetProxy.selections) == 0}"> class="cur"</c:if> href="javascript:void(0);" title="不限">不限</a>
                                    <c:forEach items="${unSelections.couts}" var="count">
                                        <c:if test="${not empty count.name}">
                                            <a href="${webRoot}/productlist.ac${count.url}" title="${count.name}">${fn:substring(count.name,0,10)}<span>(${count.count})</span></a>
                                        </c:if>
                                    </c:forEach>
                                </div>
                                <div class="more moreShow" style="display: none;"><a href="javascript:;" class="moreAttr"></a></div>
                                <div class="more2 moreHide" style="display: none;"><a href="javascript:;" class="moreAttrShou"></a></div>
                                <div class="clear"></div>
                            </div>
                            <script type="text/javascript">
                                $(".attrInfo").each(function(){
                                    if($(".attrInfo").height()>23){
                                        $(this).css("height","23px");
                                        $(this).parent().find(".moreShow").css("display","block");
                                    }
                                });
                            </script>
                        </c:if>
                    </c:forEach>
                    <p>
                        <c:if test="${(fn:length(facetProxy.unSelections) > 4)}">
                            <a href="javascript:void(0);" id="showUnSelections" onclick="showUnSelections();">查看全部属性</a>
                            <a href="javascript:void(0);" id="hideUnSelections" onclick="hideUnSelections();" style="display: none;">收起部分属性</a>
                        </c:if>
                    </p>
                </div>
                <div class="clear"></div>
            </div>
        </c:when>
    </c:choose>
    <h6>
        <div class="tipData">
            <c:if test="${not empty param.keyword}">
                <span style="font-family:'宋体';font-weight:bold;color: #333333;">“<span style="color: #CC0000;">${param.keyword}</span>”</span>找到
            </c:if>
            <c:if test="${empty param.keyword}">
                为您搜索到的商品共有
            </c:if>
            <span>${productProxys.totalCount}</span> 个 共 <span>${productProxys.lastPageNumber}</span> 页
        </div>
        <div class="trunPage">${productProxys.thisPageNumber}/${productProxys.lastPageNumber}
            <a id="pageUp" href="javascript:void(0)"><img src="${webRoot}/template/bdw/statics/images/list_turnP_inF01.gif" /></a>
            <a id="pageDown" href="javascript:void(0)"><img src="${webRoot}/template/bdw/statics/images/list_turnP_inB02.gif" /></a>
        </div>
    </h6>
    <div id="Sort">
        <label>排序：</label>
        <div class="s_Time">
            <div class="cur"><a ${param.order=='salesVolume,desc'?'class="cur"':''} ${param.order==null?'class="cur"':''} href="${webRoot}/productlist.ac?category=${categoryId}&q=${param.q}&keyword=${param.keyword}&order=salesVolume,desc">销量</a></div>
            <div class="cur"><a ${param.order=='minPrice,desc'?'class="cur"':''} href="${webRoot}/productlist.ac?category=${categoryId}&q=${param.q}&keyword=${param.keyword}&order=minPrice,desc">价格</a></div>
            <div class="cur"><a ${param.order=='commentQuantity,desc'?'class="cur"':''} href="${webRoot}/productlist.ac?category=${categoryId}&q=${param.q}&keyword=${param.keyword}&order=commentQuantity,desc">评论数</a></div>
            <div class="cur"><a ${param.order=='lastOnSaleDate,desc'?'class="cur"':''} href="${webRoot}/productlist.ac?category=${categoryId}&q=${param.q}&keyword=${param.keyword}&order=lastOnSaleDate,desc">上架时间</a></div>

        </div>
        <div class="clear"></div>
    </div>
    <div class="showlist">
        <ul>
            <c:forEach items="${productProxys.result}" var="productProxy">
                <li class="">
                   <%-- <c:choose>
                        <c:when test="${productProxy.tagList != null && fn:startWith('productProxy.tagList[0]','*')&& productProxy.tagList[0] != '热卖'}">
                            <em style="display:block;">${fn:substring(productProxy.tagList[0],"1",fn:length(productProxy.tagList[0]))}</em>
                        </c:when>
                        <c:when test="${productProxy.tagList != null && productProxy.tagList[0] != '热卖'&& fn:startWith('productProxy.tagList[0]','*')}">
                            <i style="display:block;">${fn:substring(productProxy.tagList[0],"1",fn:length(productProxy.tagList[0]))}</i>
                        </c:when>
                    </c:choose>--%>
                       <c:set value="0" var="tagnum"/>
                       <c:if test="${not empty productProxy.tagList}">
                           <c:forEach items="${productProxy.tagList}" var="tag" varStatus="s">
                               <c:choose>
                                   <c:when test="${fn:startsWith(tag,'*')&& tag == '热卖'&&tagnum==0}">
                                       <em style="display:block;">${fn:substring(tag,1,fn:length(tag))}</em>
                                       <c:set value="1" var="tagnum"/>
                                   </c:when>
                                   <c:when test="${fn:startsWith(tag,'*')&& tag != '热卖'&&tagnum==0}">
                                       <i style="display:block;">${fn:substring(tag,1,fn:length(tag))}</i>
                                       <c:set value="1" var="tagnum"/>
                                   </c:when>
                               </c:choose>
                           </c:forEach>
                       </c:if>
                    <div class="pic">
                        <a class="cur" href="${webRoot}/product-${productProxy.productId}.html" title="${productProxy.name}" target="_blank"  >
                            <img src="${productProxy.defaultImage["200X200"]}" alt="${productProxy.name}"/>
                        </a>
                    </div>
                    <div class="title">
                        <a href="${webRoot}/product-${productProxy.productId}.html" title="${productProxy.name}" target="_blank">${productProxy.name}<span>${productProxy.salePoint}</span></a>
                    </div>
                    <div class="price"><b>¥ <fmt:formatNumber value="${productProxy.price.unitPrice}" type="number"  pattern="#0.00#" /></b></div>
                    <p class="startComment">
                        <c:choose>
                            <c:when test="${productProxy.commentStatistics.average!=0}">
                                <c:forEach begin="1" end="${productProxy.commentStatistics.average}">
                                    <img src="${webRoot}/template/bdw/statics/images/list_starImg01.gif" />
                                </c:forEach>
                                <c:forEach begin="1" end="${5.0-productProxy.commentStatistics.average}">
                                    <img src="${webRoot}/template/bdw/statics/images/list_starImg02.gif" />
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <c:forEach begin="1" end="5">
                                    <img src="${webRoot}/template/bdw/statics/images/list_starImg01.gif" />
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                        <a href="${webRoot}/product-${productProxy.productId}.html?goBox=commentBox">已有${productProxy.commentQuantity}条评论</a>
                    </p>
                    <p class="btn">
                        <a href="${webRoot}/product-${productProxy.productId}.html" style="padding-left: 0px;">购买</a>
                        <a href="javascript:AddTomyLikeBtn('${productProxy.productId}')" style="padding-left: 0px;">收藏</a>
                        <a style="padding-left: 0px;" href="javascript:void(0);" onclick="addBox(this)" picUrl="${productProxy.defaultImage["50X50"]}" unitPrice="<fmt:formatNumber value="${productProxy.price.unitPrice}" type="number"  pattern="#0.00#" />" productId="${productProxy.productId}" productNm="${productProxy.name}">对比</a>
                    </p>
                </li>
            </c:forEach>
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
<div class="clear"></div>
</div>
<div class="part2">
    <h2>
        <div class="tit">最近浏览</div>
        <div class="clearOut"><a href="javascript:;" onclick="clearHistoryProductsCookie()">清空</a></div>
        <div class="clear"></div>
    </h2>
    <div class="box">
        <c:set value="${sdk:getProductFromCookie(pageContext.request,pageContext.response)}" var="productFromCookies"/>
        <c:choose>
            <c:when test="${not empty productFromCookies}">
                <div class="sorll_Box">
                    <ul style="width:3000px;">
                        <c:forEach items="${productFromCookies}" var="proxy">
                            <li>
                                <div class="pic">
                                    <a class="cur" href="${webRoot}/product-${proxy.productId}.html" title="${proxy.name}" target="_blank">
                                        <img src="${proxy.defaultImage["150X150"]}" alt="${proxy.name}"/>
                                    </a>
                                </div>
                                <div class="title">
                                    <a href="${webRoot}/product-${proxy.productId}.html" title="${productProxy.name}" target="_blank">${proxy.name}<span>${proxy.salePoint}</span></a>
                                </div>
                                <p>
                                    <c:choose>
                                        <c:when test="${proxy.commentStatistics.average!=0}">
                                            <c:forEach begin="1" end="${proxy.commentStatistics.average}">
                                                <img src="${webRoot}/template/bdw/statics/images/list_starImg01.gif" />
                                            </c:forEach>
                                            <c:forEach begin="1" end="${5.0-proxy.commentStatistics.average}">
                                                <img src="${webRoot}/template/bdw/statics/images/list_starImg02.gif" />
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach begin="1" end="5">
                                                <img src="${webRoot}/template/bdw/statics/images/list_starImg01.gif" />
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                                <p>
                                    已有${proxy.commentQuantity}条评论
                                </p>
                                <div class="price"><b>¥ <fmt:formatNumber value="${proxy.price.unitPrice}" type="number" pattern="#0.00#" /></b></div>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </c:when>
            <c:otherwise>
                <ul><li style="text-align: center;padding-top: 110px;font-size: 14px;">您还未浏览其它商品</li></ul>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</div>

<div class="pop-compare" data-load="true" id="pop-compare" style="display: none; bottom: 0px;">
    <div class="pop-wrap"><p class="pop-compare-tips"></p>

        <div data-widget="tabs" class="pop-inner">
            <div class="diff-hd">
                <ul class="tab-btns clearfix">
                    <li data-widget="tab-item" class="current"><a href="javascript:;">对比栏</a></li>
                    <%--<li data-widget="tab-item"><a href="javascript:;">最近浏览</a></li>--%>
                </ul>
                <div class="operate"><a class="hide-me" href="javascript:;">隐藏</a></div>
            </div>
            <div class="diff-bd tab-cons">
                <div data-widget="tab-content" class="tab-con">
                    <div class="diff-items clearfix" id="diff-items">
                        <dl fore="0" id="cmp_item_722075" class="item-empty item-empty1 item-empty-box">
                            <dt>1</dt>
                            <dd>您还可以继续添加</dd>
                        </dl>
                        <dl class="item-empty item-empty2 item-empty-box">
                            <dt>2</dt>
                            <dd>您还可以继续添加</dd>
                        </dl>
                        <dl class="item-empty item-empty3 item-empty-box">
                            <dt>3</dt>
                            <dd>您还可以继续添加</dd>
                        </dl>
                        <dl class="item-empty item-empty4 item-empty-box">
                            <dt>4</dt>
                            <dd>您还可以继续添加</dd>
                        </dl>
                    </div>
                    <div class="diff-operate"><a class="btn-compare-b" href="javascript:void(0);" onclick="toSubmitComp()" id="goto-contrast" >对比</a>
                        <a class="del-items" onclick="cleanAllCookie()">清空对比栏</a></div>
                </div>
                <%--<div data-widget="tab-content" style="display:none;" class="tab-con">--%>
                <%--<div class="scroll-item clearfix"><span class="scroll-btn sb-prev disabled" id="sc-prev">&lt;</span><span--%>
                <%--class="scroll-btn sb-next disabled" id="sc-next">&gt;</span>--%>

                <%--<div class="scroll-con clearfix">--%>
                <%--<ul id="scroll-con-inner"><p class="scroll-loading center">载入中...</p></ul>--%>
                <%--</div>--%>
                <%--</div>--%>
                <%--</div>--%>
            </div>
        </div>
    </div>
</div>

<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>
</body>
</html>
