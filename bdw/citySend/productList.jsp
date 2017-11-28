<%@ page import="com.iloosen.imall.commons.web.WebContextFactory" %>
<%--
  Created by IntelliJ IDEA.
  User: lhw
  Date: 2016/11/17
  Time: 8:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="p" uri="/iMallTag" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>

<c:set value="${empty param.page ? 1 : param.page}" var="_page"/>
<c:set value="${bdw:searchProductInCitySend(20)}" var="productProxys"/>
<%--搜索页面--%>
<c:if test="${not empty param.keyword}">
  <c:set value="${bdw:searchProductInCitySend(1)}" var="productProxysBySearch"/>
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
    <c:set value="${param.categoryId==null ? 1 : param.categoryId}" var="categoryId"/>
  </c:otherwise>
</c:choose>

<%--当前分类--%>
<c:set value="${sdk:queryProductCategoryById(categoryId)}" var="category"/>
<%--获取当前分类的子分类--%>
<c:set value="${sdk:queryChildren(category.categoryId)}" var="childCategory"/>

<c:set value="${sdk:getFacet()}" var="facetProxy"/>
<%
  Cookie latC = WebContextFactory.getWebContext().getCookie("lat");
  Cookie lngC = WebContextFactory.getWebContext().getCookie("lng");
  if (latC != null && lngC != null){
    request.setAttribute("lng", lngC.getValue());
    request.setAttribute("lat", latC.getValue());
  }
%>
<html>
<head>
  <meta charset="utf-8">
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-COMPATIBLE" content="IE=edge,chrome=1"/>
  <title>淘药店-${webName}-商品列表</title>
  <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/base.css">
  <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/header.css">
  <link rel="stylesheet" href="${webRoot}/template/bdw/citySend/statics/css/allStoreCarts.css">
  <link rel="stylesheet" href="${webRoot}/template/bdw/citySend/statics/css/productlist.css">
  <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css" />

  <script type="text/javascript" src="${webRoot}/iMall/admin/commons/jqGrid/js/jquery-1.7.2.min.js"></script>
  <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
  <script type="text/javascript">
    var paramData={
      webRoot:"${webRoot}",
      categoryId:"${categoryId}",
      q:"${param.q}",
      keyword:"${param.keyword}",
      order:"${param.order}",
      totalCount:"${productProxys.lastPageNumber}",
      page:"${_page}",
      cookieNum:0,
      sort:"${param.sort}",
      lat:"${lat}",
      lng:"${lng}",
      orgIds:'${param.orgIds}'
    }

  </script>
  <script type="text/javascript" src="${webRoot}/template/bdw/citySend/statics/js/productlist.js"></script>

<body>
<%--同城送头部--%>
<c:import url="/template/bdw/citySend/common/citySendTop.jsp?p=productList"/>

<!--主体-->

<div class="main">
  <!-- 筛选 -->
  <div class="filter">
    <div class="form fl">
      <div class="select">
        <span class="select-tit sProduct" id="search">搜商品</span>
        <div class="select-cont">
          <a href="javascript:void(0);" id="searchShop">搜门店</a>
          <a href="javascript:void(0);" id="searchProduct">搜商品</a>
        </div>
      </div>
      <input class="inp-txt" id="productKeyWord" type="text" placeholder="请输入搜索关键字" value="${param.keyword}">
      <button class="btn" type="button" id="searchProductBtn">搜索</button>
    </div>
  </div>
  <div class="past">
    <a href="${webRoot}/index.ac" class="home">首页</a>
    <i></i>
    <a href="${webRoot}/citySend/index.ac" class="home">淘药店</a>
    <i></i>
    <c:choose>
      <c:when test="${categoryId eq 1}">
        <a class="elli" href="${webRoot}/citySend/productList.ac?orgIds=${param.orgIds}&lat=${param.lat}&lng=${param.lng}&categoryId=1">全部分类</a>
      </c:when>
      <c:otherwise>
        <c:forEach items="${category.categoryTree}" var="node" varStatus="num">
          <c:if test="${node.categoryId != 1}">
            <c:choose>
              <c:when test="${!num.last}">
                <div class="menu-drop">
                  <a  class="trigger firstCategory${num.index}" href="${webRoot}/citySend/productList.ac?orgIds=${param.orgIds}&lat=${param.lat}&lng=${param.lng}&categoryId=${node.categoryId}" title="${node.name}">${node.name}</a>
                  <div class="drop-main-bd">
                    <c:forEach items="${sdk:queryChildren(node.categoryId)}" var="category" varStatus="s">
                      <a class="elli" href="${webRoot}/citySend/productList.ac?orgIds=${param.orgIds}&lat=${param.lat}&lng=${param.lng}&categoryId=${category.categoryId}">${category.name}</a>
                    </c:forEach>
                  </div>
                </div>
                <i></i>
              </c:when>
              <c:otherwise>
                <a class="sel-btn" href="javascript:void(0);" onclick="deleteCategory('${num.index}');">${node.name}</a>
              </c:otherwise>
            </c:choose>
          </c:if>
        </c:forEach>
      </c:otherwise>
    </c:choose>
  </div>

  <%--筛选--%>
  <c:if test="${not empty facetProxy && empty param.keyword}">
    <div class="selector">
      <c:if test="${fn:length(childCategory) > 0}">
      <div class="item">
        <div class="mlt">分类：</div>
        <div class="mmt" style="max-height: inherit;">
          <c:forEach items="${childCategory}" var="cCategory" varStatus="k">
            <a class="${k.count>8?' extraAttr':''}" style="display:${k.count>8?'none':'inline-block'};" href="${webRoot}/citySend/productList.ac?&orgIds=${param.orgIds}&lat=${param.lat}&lng=${param.lng}&categoryId=${cCategory.categoryId}&p=${param.p}&q=${param.q}">${cCategory.name}</a>
          </c:forEach>
        </div>
       <c:if test="${fn:length(childCategory) > 8}">
         <div class="mrt">
           <a href="javascript:void(0);" class="more" id="showMoreCategory" onclick="showMoreCategory();">更多</a>
           <a href="javascript:void(0);" style="display: none;" class="pack-up" id="packUpCategory" onclick="hideTheCategory();">收起</a>
         </div>
       </c:if>
       </div>
    </c:if>
      <%--已选--%>
      <c:if test="${not empty facetProxy.selections}">
        <div class="item">
          <div class="mlt">已选：</div>
          <!--点击 更多 时，mmt这里新增样式 max-height: inherit;-->
          <div class="mmt" style="max-height: inherit;">
            <c:forEach items="${facetProxy.selections}" var="selections">
              <a href="${selections.url}" title="${selections.name}">
                <em>${fn:substring(selections.title,0,4)}：${sdk:cutString(selections.name,16,"...")}</em><i></i>
              </a>
            </c:forEach>
          </div>
        </div>
      </c:if>
      <%--未选--%>
      <c:forEach items="${facetProxy.unSelections}" var="unSelections" varStatus="s">
        <c:if test="${fn:length(unSelections.couts) > 0}">
          <div class="item">
            <div class="mlt">${fn:substring(unSelections.title,0,6)}：</div>
            <!--点击 更多 时，mmt这里新增样式 max-height: inherit;-->
            <div class="mmt" style="max-height: inherit;">
              <c:forEach items="${unSelections.couts}" var="count" varStatus="kk">
                <c:if test="${not empty count.name}">
                  <a class="${k.count > 8 ? 'extraAttr':''}" style="display:${kk.count > 8?'none':'inline-block'};" href="${webRoot}/citySend/productList.ac?category=${categoryId}&q=${param.q};${unSelections.field}:${count.value}&keyword=${param.keyword}" title="${count.name}">${fn:substring(count.name,0,10)}</a>
                </c:if>
              </c:forEach>
            </div>
            <c:if test="${fn:length(unSelections.couts) > 8}">
              <div class="mrt row_m${kk.index}">
                <a href="javascript:" id="showAttrs" onclick="showMoreAttrs(${kk.index})" class="more">更多</a>
              </div>
              <div class="mrt row_h${kk.index}" style="display:none;">
                <a href="javascript:" id="hideAttrs" onclick="hideTheAttr(${kk.index})" class="pack-up">收起</a>
              </div>
            </c:if>
          </div>
        </c:if>
      </c:forEach>
    </div>
  </c:if>
  <div class="cont">
    <div class="cont-top">
      <div class="top-lt">
        <c:choose>
          <c:when test="${not empty param.keyword}">
            <a href="${webRoot}/citySend/productList.ac?&orgIds=${param.orgIds}&q=${param.q}&lat=${param.lat}&lng=${param.lng}&categoryId=${param.categoryId}&keyword=${param.keyword}" class="<c:if test="${empty param.order}">cur</c:if>">默认排序</a>
            <a href="${webRoot}/citySend/productList.ac?&orgIds=${param.orgIds}&q=${param.q}&lat=${param.lat}&lng=${param.lng}&categoryId=${param.categoryId}&keyword=${param.keyword}&order=lastOnSaleDate,desc" class="<c:if test="${param.order=='lastOnSaleDate,desc'}">cur</c:if>">新品</a>
            <a href="javascript:void(0);" class="<c:if test="${param.order=='salesVolume,asc'}">down</c:if><c:if test="${param.order=='salesVolume,desc'}">up</c:if>" onclick="chageSortBySalesVolumn(this);" >销量</a>
            <a href="javascript:void(0);" class="<c:if test="${param.order=='minPrice,asc'}">down</c:if><c:if test="${param.order=='minPrice,desc'}">up</c:if>" onclick="chageSortByPrice(this);">价格</a>
          </c:when>
          <c:otherwise>
            <a href="${webRoot}/citySend/productList.ac?&orgIds=${param.orgIds}&q=${param.q}&lat=${param.lat}&lng=${param.lng}&categoryId=${param.categoryId}" class="<c:if test="${empty param.order}">cur</c:if>">默认排序</a>
            <a href="${webRoot}/citySend/productList.ac?&orgIds=${param.orgIds}&q=${param.q}&lat=${param.lat}&lng=${param.lng}&categoryId=${param.categoryId}&order=lastOnSaleDate,desc" class="<c:if test="${param.order=='lastOnSaleDate,desc'}">cur</c:if>">新品</a>
            <a href="javascript:void(0);" class="<c:if test="${param.order=='salesVolume,asc'}">down</c:if><c:if test="${param.order=='salesVolume,desc'}">up</c:if>" onclick="chageSortBySalesVolumn2(this);">销量</a>
            <a href="javascript:void(0);" class="<c:if test="${param.order=='minPrice,asc'}">down</c:if><c:if test="${param.order=='minPrice,desc'}">up</c:if>" onclick="chageSortByPrice2(this);">价格</a>
          </c:otherwise>
        </c:choose>
      </div>
      <div class="top-rt">
        <span>共${productProxys.totalCount}件商品</span>
        <a href="javascript:" class="prev" id="pageUp" title="上一页"></a>
        <em><i>${productProxys.thisPageNumber}</i>/${productProxys.lastPageNumber}</em>
        <a href="javascript:" class="next" id="pageDown" title="下一页"></a>
      </div>
    </div>
    <div class="cont-bot">
     <c:choose>
       <c:when test="${empty productProxys.result}">
         <div class="notice-search">
           <span class="ns-icon"></span>
           <c:choose>
             <c:when test="${empty param.keyword}">
               <span class="ns-content">抱歉，没有找到相关的商品</span>
             </c:when>
             <c:otherwise>
               <span class="ns-content">抱歉，没有找到与“<em>${param.keyword}</em>”相关的商品</span>
             </c:otherwise>
           </c:choose>
         </div>
       </c:when>
       <c:otherwise>
         <ul class="bot-box clearfix">
           <c:forEach items="${productProxys.result}" var="productProxy">
             <li>
               <div class="pic"><a  href="${webRoot}/product-${productProxy.productId}.html" title="${productProxy.name}" target="_blank"><img src="${productProxy.defaultImage["200X200"]}" alt="${productProxy.name}" width="210" height="210"></a></div>
               <div class="price"><span>￥</span><fmt:formatNumber value="${productProxy.price.unitPrice}" type="number"  pattern="#0.00#" /></div>
               <a href="${webRoot}/product-${productProxy.productId}.html" class="title">${productProxy.name}</a>
               <div class="record">
                 <div class="wk-of">${productProxy.salesVolume}</div>
                 <div class="comment">${productProxy.commentQuantity}</div>
               </div>
               <a target="_blank" class="seller" href="${webRoot}/citySend/storeDetail.ac?orgId=${productProxy.shopInfProxy.sysOrgId}">${productProxy.shopInfProxy.shopNm}</a>
               <div class="bot-sc">
                 <c:choose>
                   <c:when test="${productProxy.collect}">
                     <a href="javascript:void(0);" class="sc-btn ${productProxy.collect ? "selected" :""} AddTomyLikeBtn"  title="取消关注" productId="${productProxy.productId}" value="${productProxy.collect}">取消</a>
                   </c:when>
                   <c:otherwise>
                     <a href="javascript:void(0);" class="sc-btn ${productProxy.collect ? "selected" : ""} AddTomyLikeBtn" productId="${productProxy.productId}" value="${productProxy.collect}">收藏</a>
                   </c:otherwise>
                 </c:choose>
                 <c:choose>
                   <c:when test="${productProxy.isCanBuy}">
                      <c:choose>
                      <c:when test="${fn:length(productProxy.skus)>1}">
                        <%--多规格，弹出规格选择框--%>
                        <a href="javascript:void(0);" class="car-btn">加入购物车</a>
                      </c:when>
                      <c:otherwise>
                        <%--单规格--%>
                        <a href="javascript:void(0);" class="car-btn addCartBtn" skuid="${productProxy.skus[0].skuId}" carttype="store" handler="sku" num="1">加入购物车</a>
                      </c:otherwise>
                      </c:choose>
                    </c:when>
                    <c:otherwise>
                      <a href="${webRoot}/product-${productProxy.productId}.html" class="car-btn">查看详情</a>
                    </c:otherwise>
                   </c:choose>

               </div>
             </li>
           </c:forEach>
         </ul>
         <!-- 分页 -->
         <div class="pager">
           <div id="infoPage">
             <c:if test="${productProxys.lastPageNumber>1}">
               <p:PageTag isDisplayGoToPage="true" isDisplaySelect="false" totalPages='${productProxys.lastPageNumber}' currentPage='${_page}' totalRecords='${productProxys.totalCount}' ajaxUrl='${webRoot}/citySend/productList.ac' frontPath='${webRoot}' displayNum='6'/>
             </c:if>
           </div>
         </div>
       </c:otherwise>
     </c:choose>
    </div>
  </div>
</div>
<c:import url="/template/bdw/module/common/bottom.jsp"/>

</body>
</html>
