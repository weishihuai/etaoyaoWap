<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="p" uri="/iMallTag" %><%--分页引用--%>
<c:set value="${empty param.page ? 1 : param.page}" var="_page"/>
<c:set value="${bdw:search(21)}" var="productProxys"/>
<c:set value="${bdw:findAllCategory()}" var="allCategory"></c:set> <%--全部分类--%>
<%--搜索页面--%>
<c:if test="${not empty param.keyword}">
    <c:set value="${bdw:search(1)}" var="productProxysBySearch"/>
    <c:if test="${not empty productProxysBySearch}">
        <c:forEach items="${productProxys.result}" var="productProxy" end="0">
            <c:set value="${productProxy.otooCategoryId}" var="searchCategory"/>
        </c:forEach>
    </c:if>
</c:if>
<c:choose>
    <c:when test="${not empty param.keyword && not empty searchCategory}">
        <c:set value="${searchCategory}" var="categoryId"/>
    </c:when>
    <c:otherwise>
        <c:set value="${param.categoryId==null ? 1 : param.categoryId}" var="categoryId"/>
    </c:otherwise>
</c:choose>

<%--当前分类--%>
<c:set value="${bdw:queryProductCategoryById(categoryId)}" var="category"/>
<%--获取当前分类的子分类--%>
<c:set value="${bdw:queryChildren(category.categoryId)}" var="childCategory"/>
<c:choose>
    <c:when test="${categoryId != 1}">
        <%--上级分类--%>
        <c:set value="${bdw:queryUpperCategory(category.categoryId)}" var="upperCategory"/>
        <%--上级分类的子分类--%>
        <c:set value="${bdw:queryChildren(upperCategory.categoryId)}" var="categoryList"/>
    </c:when>
    <c:otherwise>
        <c:set value="${bdw:queryChildren(categoryId)}" var="categoryList"/>
    </c:otherwise>
</c:choose>

<c:set value="${bdw:getFacet()}" var="facetProxy"/>
<c:set value="${bdw:getTreeAreas()}" var="treeAreaList"/><%--地区--%>
<c:set value="${bdw:getBusinessAreas(param.district)}" var="businessAreaList"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta charset="utf-8">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}-${webName}"/>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}-${webName}"/><%--SEO keywords优化--%>
    <title>${webName}-${sdk:getSysParamValue('index_title')}</title><%--SEO description优化--%>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css"/>
	<link href="${webRoot}/template/bdw/otoo/statics/css/header.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/otoo/statics/css/base.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/otoo/statics/css/list.css" rel="stylesheet" type="text/css"/>

    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript">
    var webPath = {webRoot: "${webRoot}"};
    var paramData={
        categoryId:"${categoryId}",
        q:"${param.q}",
        keyword:"${param.keyword}",
        order:"${param.order}",
        totalCount:"${productProxys.lastPageNumber}",
        page:"${_page}",
        sort:"${param.sort}",
        district:"${param.district}",
        areaId:"${param.areaId}"
    }
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/otoo/statics/js/productList.js"></script>
<body>
<%-- header start --%>
<c:import url="/template/bdw/otoo/common/top.jsp?p=index"/>
<%-- header end --%>

<div class="main">
    <div class="s-tit">
        <dl>
            <c:forEach items="${sdk:findPageModuleProxy('O2O_topCenter_linkTitle_1').links}" var="link" varStatus="s" end="1">
                <dt>${link.title}</dt>
            </c:forEach>
            <dd>
                <c:forEach items="${sdk:findPageModuleProxy('O2O_topCenter_link_1').links}" var="link" varStatus="s">
                    <%--如果该链接的标题中包含#,说明该链接是热门的--%>
                    <c:choose>
                        <c:when test="${fn:contains(link.title,'#')}">
                            <a class="hot" href="${link.link}" title="${link.title}">${fn:replace(link.title,'#','')}</a>
                        </c:when>
                        <c:otherwise>
                            <a href="${link.link}" title="${link.title}">${link.title}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </dd>
        </dl>
    </div>

    <div class="crumb">
        <a href="${webRoot}/otoo/index.ac" title="首页">首页</a><c:if test="${param.categoryId!=1 && param.categoryId !=null}">&gt;</c:if>
            <c:forEach items="${category.categoryTree}" var="node" varStatus="num">
                <c:if test="${node.categoryId != 1}">
                    <c:choose>
                      <c:when test="${!num.last}">
                            <div class="cr-nav cur">
                                <a  href="${webRoot}/otoo/productList.ac?categoryId=${node.categoryId}" class="firstCategory"  title="${node.categoryName}">${node.categoryName}
                                    <c:if test="${node.categoryId == upperCategory.categoryId}"><i></i></c:if>
                                </a>
                                <div class="cr-cont" style="display:none;">
                                    <c:forEach items="${allCategory}" var="category" varStatus="s">
                                        <a href="${webRoot}/otoo/productList.ac?categoryId=${category.categoryId}">${category.categoryName}</a>
                                        <span>|</span>
                                    </c:forEach>
                                </div>
                            </div>
                                &gt;
                      </c:when>
                      <c:otherwise>
                          <div class="sec-nav cur">
                              <a  href="javascript:void(0);" class="seCategory"  title="${node.categoryName}">${node.categoryName}
                                  <c:if test="${node.categoryId == upperCategory.categoryId}"></c:if><b onclick="deleteCategory();"></b>
                              </a>
                              <div class="sec-cont" style="display:none;">
                                  <c:forEach items="${categoryList}" var="sameCategory" varStatus="s">
                                      <a href="${webRoot}/otoo/productList.ac?categoryId=${sameCategory.categoryId}">${sameCategory.categoryName}</a>
                                      <span>|</span>
                                  </c:forEach>
                              </div>
                          </div>
                      </c:otherwise>
                    </c:choose>
                </c:if>
            </c:forEach>
    </div>

    <div class="filter">
        <dl>
            <dt>分类：</dt>
            <c:if test="${fn:length(categoryList) > 0}">
                <dd>
                    <div class="con">
                        <c:choose>
                            <c:when test="${fn:length(childCategory)>0}">
                                <c:choose>
                                    <c:when test="${categoryId != 1}">
                                        <a class="cur" href="${webRoot}/otoo/productList.ac?categoryId=${categoryId}&p=${param.p}&q=${param.q}&otooIsAvoidSubscribe=${param.otooIsAvoidSubscribe}&otooIsCoupon=${param.otooIsCoupon}&district=${param.district}&areaId=${param.areaId}">全部</a>
                                    </c:when>
                                    <c:otherwise>
                                        <a class="cur" href="${webRoot}/otoo/productList.ac?categoryId=1&p=${param.p}&q=${param.q}&otooIsAvoidSubscribe=${param.otooIsAvoidSubscribe}&otooIsCoupon=${param.otooIsCoupon}&district=${param.district}&areaId=${param.areaId}">全部</a>
                                    </c:otherwise>
                                </c:choose>

                                <c:forEach items="${childCategory}" var="cCategory" varStatus="k">
                                    <a class="<c:if test='${cCategory.categoryId == param.categoryId}'>cur</c:if> ${k.count>15?' extraAttr':''}"  style="display:${k.count>15?'none':'inline-block'};"
                                       href="${webRoot}/otoo/productList.ac?categoryId=${cCategory.categoryId}&p=${param.p}&q=${param.q}&otooIsAvoidSubscribe=${param.otooIsAvoidSubscribe}&otooIsCoupon=${param.otooIsCoupon}&district=${param.district}&areaId=${param.areaId}">${cCategory.categoryName}</a>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <a href="${webRoot}/otoo/productList.ac?categoryId=${upperCategory.categoryId}&p=${param.p}&q=${param.q}&otooIsAvoidSubscribe=${param.otooIsAvoidSubscribe}&otooIsCoupon=${param.otooIsCoupon}&district=${param.district}&areaId=${param.areaId}">全部</a>
                                <c:forEach items="${categoryList}" var="sCategory" varStatus="s">
                                    <a class="<c:if test='${sCategory.categoryId == param.categoryId}'>cur</c:if> ${s.count>15?' extraAttr':''}"  style="display:${s.count>15?'none':'inline-block'};"
                                       href="${webRoot}/otoo/productList.ac?categoryId=${sCategory.categoryId}&p=${param.p}&q=${param.q}&otooIsAvoidSubscribe=${param.otooIsAvoidSubscribe}&otooIsCoupon=${param.otooIsCoupon}&district=${param.district}&areaId=${param.areaId}">${sCategory.categoryName}</a>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <c:if test="${fn:length(categoryList) > 15}">
                        <c:choose>
                            <c:when test="${fn:length(childCategory)>0}">
                                <c:choose>
                                    <c:when test="${fn:length(childCategory)>15}">
                                        <a class="more" href="javascript:;" id="showMore" onclick="showMoreCategory()">更多</a>
                                        <a class="pup" href="javascript:void(0)" id="hideMore" onclick="hideTheCategory()" style="display: none">收起</a>
                                    </c:when>
                                    <c:otherwise>
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                            <c:otherwise>
                                <a class="more" href="javascript:;" id="showMore" onclick="showMoreCategory()">更多</a>
                                <a class="pup" href="javascript:void(0)" id="hideMore" onclick="hideTheCategory()" style="display: none">收起</a>
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                </dd>
            </c:if>
        </dl>
        <%--显示临汾所有的区域--%>
        <dl class="dl-district">
            <dt>区域：</dt>
            <c:if test="${fn:length(treeAreaList) > 0}">
                <dd>
                    <div class="con" id="district">
                        <a href="${webRoot}/otoo/productList.ac?categoryId=${param.categoryId==null ? 1 : param.categoryId}&p=${param.p}&q=${param.q}&otooIsAvoidSubscribe=${param.otooIsAvoidSubscribe}&otooIsCoupon=${param.otooIsCoupon}" class="<c:if test="${empty param.district}">cur</c:if>" id="allTree">全部</a>
                        <c:forEach items="${treeAreaList}" var="chlid" varStatus="k">
                            <a class="<c:if test="${param.district == chlid.sysTreeNodeId}">cur</c:if>" href="${webRoot}/otoo/productList.ac?categoryId=${param.categoryId==null ? 1 : param.categoryId}&district=${chlid.sysTreeNodeId}&p=${param.p}&q=${param.q}&otooIsAvoidSubscribe=${param.otooIsAvoidSubscribe}&otooIsCoupon=${param.otooIsCoupon}">${chlid.sysTreeNodeNm}</a>
                        </c:forEach>
                    </div>
                </dd>
            </c:if>
        </dl>
        <%--显示某一个区域下的所有商圈--%>
        <c:if test="${!empty param.district && !empty businessAreaList}">
            <dl class="dl-area">
                <dt>商圈：</dt>
                <c:if test="${fn:length(businessAreaList) > 0}">
                    <dd>
                        <div class="con" id="businessArea">
                            <a href="${webRoot}/otoo/productList.ac?district=${param.district}&categoryId=${param.categoryId==null ? 1 : param.categoryId}&p=${param.p}&q=${param.q}&otooIsAvoidSubscribe=${param.otooIsAvoidSubscribe}&otooIsCoupon=${param.otooIsCoupon}" class="<c:if test="${empty param.areaId}">cur</c:if>" id="allArea">全部</a>
                            <c:forEach items="${businessAreaList}" var="chlid" varStatus="k">
                                <a class="<c:if test="${param.areaId == chlid.otooAreaId}">cur</c:if>" href="${webRoot}/otoo/productList.ac?district=${param.district}&areaId=${chlid.otooAreaId}&categoryId=${param.categoryId==null ? 1 : param.categoryId}&p=${param.p}&q=${param.q}&otooIsAvoidSubscribe=${param.otooIsAvoidSubscribe}&otooIsCoupon=${param.otooIsCoupon}">${chlid.otooAreaName}</a>
                            </c:forEach>
                        </div>
                    </dd>
                </c:if>
            </dl>
        </c:if>

        <%--筛选条件--%>
        <c:if test="${(not empty facetProxy && empty param.keyword) || not empty param.district}">
            <div class="list_m1bg">
                <div class="list_m1">
                    <c:if test="${not empty facetProxy.selections || not empty param.district}">
                        <div class="cont-nav-show">
                            <div class="item show1">
                                <div class="item-left">已选：</div>
                                <div class="sel-area">
                                    <c:forEach items="${facetProxy.selections}" var="selections">
                                        <a href="${selections.url}" title="${selections.name}">
                                            <em>${fn:substring(selections.title,0,4)}：${sdk:cutString(selections.name,16,"...")}</em><i></i>
                                        </a>
                                    </c:forEach>
                                    <%--地区--%>
                                    <c:if test="${not empty param.district}">
                                        <a href="${webRoot}/otoo/productList.ac?categoryId=${param.categoryId==null ? 1 : param.categoryId}&p=${param.p}&q=${param.q}&otooIsAvoidSubscribe=${param.otooIsAvoidSubscribe}&otooIsCoupon=${param.otooIsCoupon}" class="district"></a>
                                    </c:if>
                                    <%--商圈--%>
                                    <c:if test="${not empty param.areaId}">
                                        <a href="${webRoot}/otoo/productList.ac?district=${param.district}&categoryId=${param.categoryId==null ? 1 : param.categoryId}&p=${param.p}&q=${param.q}&otooIsAvoidSubscribe=${param.otooIsAvoidSubscribe}&otooIsCoupon=${param.otooIsCoupon}" class="b-area"></a>
                                    </c:if>
                                </div>
                                <div class="clear"></div>
                            </div>
                        </div>
                    </c:if>
                    <c:forEach items="${facetProxy.unSelections}" var="unSelections" varStatus="s">
                        <c:if test="${fn:length(unSelections.couts) > 0}">
                            <div class="${s.count > 3 ?'m1_rows_e ':''}m1_rows" style="display: ${s.count > 3 ?'none':'block'};">
                                <div class="rows_l">${fn:substring(unSelections.title,0,6)}：</div>
                                <div class="rows_right">
                                    <div class="rows_m rows${s.index}">
                                        <c:forEach items="${unSelections.couts}" var="count" varStatus="k">
                                            <c:if test="${not empty count.name}">
                                                <a class="${k.count > 10 ? 'extraAttr':''}" style="display:${k.count > 10?'none':'inline-block'};" href="${webRoot}/otoo/productList.ac${count.url}" title="${count.name}">${fn:substring(count.name,0,10)}</a>
                                            </c:if>
                                        </c:forEach>
                                    </div>
                                    <c:if test="${fn:length(unSelections.couts) > 10}">
                                        <div class="rows_r row_m${s.index}"><a class="cur" href="javascript:;" id="showAttrs" onclick="showMoreAttrs(${s.index})">更多</a></div>
                                        <div class="rows_r_e row_h${s.index}" style="display:none;"><a class="cur" href="javascript:;"  id="hideAttrs" onclick="hideTheAttr(${s.index})">收起</a></div>
                                    </c:if>
                                </div>
                                <div class="clear"></div>
                            </div>
                        </c:if>
                    </c:forEach>
                    <c:if test="${fn:length(facetProxy.unSelections)>3}">
                        <div class="m1_more" style="height: 30px;"><a href="javascript:;" id="showUnSelections" onclick="showUnSelections();">更多筛选选项</a></div>
                        <div class="m1_coll" style="display:none;height: 30px;"><a href="javascript:void(0);" id="hideUnSelections" onclick="hideUnSelections();" >收起<i></i></a></div>
                    </c:if>
                </div>
            </div>
        </c:if>

    </div>

    <div class="left">
        <div class="sort">
            <div class="fl" id="toggleTab">
                <a class="li01${param.order==""||param.order==null?' li01-cur':''}" href="javascript:void(0)" id="defaultSort">默认</a>
                <a class="li02${param.order=='otooLastOnSaleTime,desc'?' li02-cur':''}" href="javascript:void(0)" id="newProduct">新品<i></i></a>
                <a class="li03${param.order=='otooSalesVolume,desc'?' li03-cur':''}" href="javascript:void(0)" id="sale">销售<i></i></a>
                <a class="li04${fn:contains(param.order,'otooDiscountPrice') ?' li04-cur':''}" href="javascript:void(0)" onclick="changeSortByPrice(this)">价格<i></i></a>
                <input type="checkbox" style="vertical-align: middle;margin-left: 20px;" name="otooIsAvoidSubscribe" id="otooIsAvoidSubscribe" <c:if test="${param.otooIsAvoidSubscribe == 'Y'}">checked="checked"</c:if>/><label style="vertical-align: middle;margin-left: 4px;">免预约</label>
                <input type="checkbox" style="vertical-align: middle;margin-left: 8px;" name="otooIsCoupon" id="otooIsCoupon" <c:if test="${param.otooIsCoupon == 'Y'}">checked="checked"</c:if>/><label style="vertical-align: middle;margin-left: 4px;">代金券</label>
            </div>
            <div class="fr">
                <span><em>${productProxys.thisPageNumber}</em>/${productProxys.lastPageNumber}</span>
                <a class="pre" href="javascript:void(0)" title="上一页"></a>
                <a class="next" href="javascript:void(0)" title="下一页"></a>
            </div>
        </div>
        <div class="pros">
            <ul>
                <c:forEach items="${productProxys.result}" var="product">
                    <li>
                        <a class="p-img" href="${webRoot}/otoo/product.ac?id=${product.otooProductId}" target="_blank" title="${product.otooProductNm}"><img src="${empty product.images ? product.defaultImage['300X200'] : product.images[0]['300X200']}"  alt="${product.otooProductNm}"></a>
                        <a class="p-name" href="${webRoot}/otoo/product.ac?id=${product.otooProductId}" target="_blank" title="${product.otooProductNm}">${product.otooProductNm}</a>
                        <span class="c-price"><i>&yen;</i>${product.otooDiscountPrice}</span>
                        <span class="o-price"><del>&yen;${product.otooMarketPrice}</del></span>
                    </li>
                </c:forEach>
            </ul>
        </div>
        <%--分页 start--%>
        <div class="num page">
            <div style="float: right;">
                <c:if test="${productProxys.lastPageNumber>1}">
                    <p:PageTag isDisplayGoToPage="true" isDisplaySelect="false" totalPages='${productProxys.lastPageNumber}' currentPage='${_page}' totalRecords='${productProxys.totalCount}' ajaxUrl='${webRoot}/otoo/productList.ac' frontPath='${webRoot}' displayNum='6'/>
                </c:if>
            </div>
        </div>
        <div class="clear"></div>
    </div>

    <div class="right" id="topMenu" style="z-index: 1">
        <h3>最近浏览<a href="javascript:;" class="fr" style="font-size: 12px;color:red;margin-right: 4px;" onclick="clearHistoryProductsCookie()"><img src="${webRoot}/template/bdw/otoo/statics/images/rubbish.png" title="清空" style="margin-top: 20px; margin-right: 20px;"></a></h3>
        <c:set value="${bdw:getProductFromCookie(pageContext.request,pageContext.response)}" var="productFromCookies"/>
        <c:choose>
            <c:when test="${not empty productFromCookies}">
                <ul>
                    <c:forEach items="${productFromCookies}" var="product" end="5">
                        <li>
                            <a class="p-img" href="${webRoot}/otoo/product.ac?id=${product.otooProductId}" target="_blank" title="${product.otooProductNm}"><img src="${product.defaultImage['120X80']}" alt="${product.otooProductNm}"></a>
                            <div class="p-info">
                                <a class="p-name" href="${webRoot}/otoo/product.ac?id=${product.otooProductId}" target="_blank" title="${product.otooProductNm}">${product.otooProductNm}</a>
                                <p>${product.otooSellingPoint}</p>
                                <span class="c-price">&yen;${product.otooDiscountPrice}</span>
                                <span class="o-price"><del>&yen;${product.otooMarketPrice}</del></span>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
            </c:when>
            <c:otherwise>
                <div style="margin-top: 16px; margin-bottom: 16px;text-align: center;color:red">你还未浏览其他商品</div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<%@ taglib prefix="f" uri="/iMallTag" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<f:FrameEditTag />     <%--页面装修专用标签--%>

<div class="clear"></div>
<!--main end-->
<c:import url="/template/bdw/otoo/common/bottom.jsp?p=index"/>
<!-- footer end-->
</body>
</html>
