<%@ taglib prefix="p" uri="/iMallTag" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${empty param.page ? 1 : param.page}" var="_page"/>
<c:set value="${bdw:searchProductByType(25,'N')}" var="productProxys"/>
<%--这段代码主要解决,搜索页面下,热卖推荐等商品显示什么 start--%>
<c:if test="${not empty param.keyword}">
    <c:set value="${sdk:getSearchCategory(1)}" var="productProxysBySearch"/>
    <c:if test="${not empty productProxysBySearch}">
        <c:forEach items="${productProxys.result}" var="productProxy" end="0">
            <c:set value="${productProxy.categoryId}" var="searchCategory"/>
        </c:forEach>
    </c:if>
</c:if>
<c:choose>
    <c:when test="${empty param.keyword && not empty searchCategory}">
        <c:set value="${searchCategory}" var="categoryId"/>
    </c:when>
    <c:otherwise>
        <c:set value="${param.category==null ? 1 : param.category}" var="categoryId"/>
    </c:otherwise>
</c:choose>
<%--这段代码主要解决,搜索页面下,热卖推荐等商品显示什么 end--%>
<c:set value="${sdk:queryProductCategoryById(categoryId)}" var="category"/>
<c:set value="${sdk:queryCategoryPath(categoryId)}" var="categoryPath"/>
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
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/base.css" rel="stylesheet" type="text/css"/>

    <link href="${webRoot}/template/bdw/statics/css/list.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/productlist.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/jqGrid/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/easydialog/easydialog.min.js"></script>
    <script type="text/javascript">
        var paramData={
            category:"${categoryId}",
            q:"${param.q}",
            keyword:"${param.keyword}",
            order:"${param.order}",
            totalCount:"${productProxys.lastPageNumber}",
            page:"${_page}",
            webRoot:"${webRoot}",
            sort:"${param.sort}",
            startPrice:"${param.startPrice}",
            endPrice:"${param.endPrice}",
            isInStore:"${param.isInStore}",
        };
        var imgpathData = {defaultImage: "${productProxy.defaultImage['60X60']}"};
        var webPath = {
            webRoot: "${webRoot}"
        }
    </script>

    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/list.js"></script>
</head>
<body>

<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp?p=list"/>
<%--页头结束--%>

<!--主体-->
<div class="main">

    <!-- 面包屑导航 -->
    <div class="breadcrumb-nav">
        <div><a class="link-index" href="${webRoot}/index.ac">首页</a></div>
        <c:forEach items="${categoryPath}" var="categoryTree" varStatus="s">
            <c:if test="${categoryTree.categoryId ne 1}">
                <c:set value="${categoryTree.children}" var="children" />
                <div >
                    <div class="dt">
                         <a <c:if test="${ empty children}">style="border: 0;margin-top: 1px;padding-right:1px"  </c:if> href="${webRoot}/productlist-${categoryPath[s.index-1].categoryId}.html?keyword=${param.keyword}&category=${categoryId}&q=${param.q}&order=${param.order}&isInStore=${param.isInStore}" title="">${categoryTree.name}  <c:if test="${not empty children}"><em></em></c:if> </a>   <i></i>
                    </div>

                    <c:if test="${not empty children}">
                            <div class="dd clearfix">
                                <c:forEach items="${categoryTree.sameLevel}" var="catetorySameLevel">
                                    <a href="${webRoot}/productlist-${catetorySameLevel.categoryId}.html?keyword=${param.keyword}&category=${categoryId}&q=${param.q}&order=${param.order}&isInStore=${param.isInStore}" title="">${catetorySameLevel.name}</a>
                                </c:forEach>
                            </div>
                    </c:if>
                </div>
            </c:if>
        </c:forEach>

        <c:forEach items="${facetProxy.selectionsWithField}" var="selections">
             <div class="last">
               <i></i> <a style="z-index: 2" href="${selections.url}&row=y" class="">${selections.name}</a> <em style="z-index: 0"></em>
             </div>
        </c:forEach>
        <c:if test="${not empty param.keyword}">
            <div class="last">
                <i></i><a class=""href="${webRoot}/productlist.ac?category=${categoryId}&q=${param.q}&keyword=&order=${param.order}" >${param.keyword}<em style="z-index: 0"></em></a>
            </div>
        </c:if>
    </div>


    <div class="screen-class">
    <c:forEach items="${facetProxy.unSelections}" var="unSelections" varStatus="s">
        <c:if test="${fn:length(unSelections.couts) > 0}">
            <c:if test="${not empty unSelections.couts[0].name}">
                <div class="item">
                    <div class="dt">${fn:substring(unSelections.title,0,6)}：</div>


                        <ul class="dd" data-target="${s.count}" style="height: 30px" >
                            <%--<ul  style="width: 905px; overflow: hidden;" data-target="zone" class="valList">--%>
                                <c:forEach items="${unSelections.couts}" var="count">
                                    <c:if test="${not empty count.name and unSelections.title ne '分类'}">
                                        <li class="single"><a href="${count.url}&row=y"
                                                        title=""><i></i>${count.name}</a></li>
                                        <li ><a style="display: none;z-index: 2" class="multiple multiSelect" href="#"  data-checked="true"  field="${count.field}" title="${count.value}"><label   style="z-index:0;" class="checkbox-box"><em style="z-index:0;"></em></label>${count.name}</a></li>
                                        </a></li>
                                    </c:if>
                                    <c:if test="${not empty count.name and unSelections.title eq '分类'}">
                                        <li class=""><a href="${webRoot}/productlist-${count.value}.html?keyword=${param.keyword}&category=${categoryId}&q=${param.q}&order=${param.order}&isInStore=${param.isInStore}"
                                                              title=""><i></i>${count.name}</a></li>
                                    </c:if>
                                </c:forEach>
                           <%-- </ul>--%>
                        </ul>
                    <div class="footer-btn-box">
                        <a href="javascript:void(0);"
                           class="confirm" onclick="multipleConfirm(this)">确定</a>
                        <a href="javascript:void(0);"
                           class="cancel">取消<i></i></a>
                    </div>

                        <c:if test="${fn:length(unSelections.couts) > 1 && unSelections.title ne '分类'}">
                            <a href="javascript:void(0);" class="multiselect-btn" style="z-index:2;">多选<em style="z-index: 1"></em></a>
                        </c:if>
                     <c:if test="${fn:length(unSelections.couts)>9}">
                         <a class="more-btn moreBtn" data-onoff="true" href="javascript:;">更多<em></em></a>
                     </c:if>
                </div>
            </c:if>
        </c:if>
    </c:forEach>
    </div>


    <c:choose>
        <c:when test="${productProxys.totalCount != 0}">
            <!-- 商品排序 -->
            <div class="product-sort">
                <div class="product-sort-t">
                    <ul class="sorts">

                        <li class="${param.order==""||param.order==null?' cur':''}"><a href="${webRoot}/productlist.ac?category=${categoryId}&q=${param.q}&keyword=${param.keyword}&isInStore=${param.isInStore}" class="<c:if test="${empty param.order}">cur</c:if>">综合</a></li>
                        <li ><a class="${param.order=='lastOnSaleDate,desc'?' cur':''}" href="${webRoot}/productlist.ac?category=${categoryId}&q=${param.q}&keyword=${param.keyword}&order=lastOnSaleDate,desc&isInStore=${param.isInStore}">新品</a></li>
                        <li><a href="javascript:" onclick="chageSortBySaleVolumn(this)"  class="<c:if test="${param.order=='salesVolume,asc'||param.order=='salesVolume,desc'}"> cur</c:if>" >销售</a></li>
                            <%--  <li><a href="#">评论数</a></li>--%>
                        <li ><a href="javascript:" onclick="chageSortByPrice(this)" class="<c:if test="${param.order=='minPrice,asc'||param.order=='minPrice,desc'}"> cur</c:if>">价格</a></li>


                    </ul>
                    <div class="price-range">
                        <div class="price-range-inner price-range-inner2">
                            <input type="text" placeholder="¥"  id="minSearchPrice"  oninput="checkTheValue(this)" >
                            <span>-</span>
                            <input type="text" placeholder="¥"   id="maxSearchPrice"  oninput="checkTheValue(this)" >
                            <a class="confirm" href="javascript:;" onclick="makeSureThePriceRange()">确定</a>
                            <a class="empty" href="javascript:;">清空</a>
                        </div>
                    </div>
                    <div class="search">
                        <div class="search-inner search-inner2">
                            <input type="text" placeholder="商品" id="searchKeyword" value="${empty param.keyword ? "":param.keyword}">
                            <a class="confirm" id="confirmBtn" href="javascript:;">确定</a>
                            <a class="cancel" href="javascript:;">取消</a>
                        </div>
                    </div>
                    <div class="pages">
                        <p class="product-number">共<span>${productProxys.totalCount}</span>个商品</p>

                        <a class="prev-btn"  id="pageUp" title="上一页" href="javascript:void(0);"></a>
                        <p class="pages-number"><span>${productProxys.thisPageNumber}</span>/${productProxys.lastPageNumber}</p>
                        <a class="next-btn" id="pageDown" title="下一页" href="javascript:void(0);"></a>
                    </div>
                </div>
                <div class="product-sort-b">
                    <p id="isInStore">
                        <label class="checkbox-box"><input type="checkbox" checked="checked"><em data-checked="${ param.isInStore == "Y"? "true":""}"></em></label>
                        <span>仅显示有货</span>
                    </p>
                </div>
            </div>
        </c:when>
    </c:choose>

    <div class="product-list clearfix">
        <c:choose>
            <c:when test="${productProxys.totalCount == 0}">
                <ul class="b_info">
                    <!-- 无商品 -->
                    <div class="null-product">
                        <p>很抱歉，没有找到关于“<span>${empty param.keyword ? "":param.keyword}</span>”相关的商品!<br> 您可以换个关键词试试。  </p>
                        <a class="return-index" href="${webRoot}/index.ac">返回首页</a>
                        <div class="uggest">
                            <p>建议您：</p>
                            <p>1. 看看输入的文字是否有误</p>
                            <p>2. 调整关键字，如 ＂阿莫西林颗粒＂ 改为 ＂阿莫西林＂</p>
                        </div>
                    </div>
                </ul>
            </c:when>
            <c:otherwise>
                <c:forEach items="${productProxys.result}" var="productProxy" varStatus="s">
                        <div class="item">
                            <a  href="${webRoot}/product-${productProxy.productId}.html" title="${productProxy.name}" target="_blank">
                                <div style="width: 200px;height: 200px">
                                   <img src="${productProxy.defaultImage["200X200"]}" alt="${productProxy.name}" width="200" height="200"<%-- onload="adapt(this)"--%> />
                                </div>
                            </a>
                            <p class="price"><span>￥</span><fmt:formatNumber value="${productProxy.price.unitPrice}" type="number"  pattern="#0.00#" /> </p>
                            <a href="${webRoot}/product-${productProxy.productId}.html" title="${productProxy.name}" target="_blank"><p class="name">${productProxy.name}<span>${productProxy.salePoint}</span></p></a>
                            <div class="product-character">
                                <c:choose>
                                    <c:when test="${productProxy.prescriptionTypeCode eq '甲类OTC'}"><span class="bg-red">甲OTC</span></c:when>
                                    <c:when test="${productProxy.prescriptionTypeCode eq 'RX'}"><span class="bg-blue">RX</span></c:when>
                                    <c:when test="${productProxy.prescriptionTypeCode eq '乙类OTC'}"><span class="bg-green">乙OTC</span></c:when>
                                </c:choose>
                                <c:forEach items="${productProxy.availableBusinessRuleList}" var="rule" varStatus="i" >
                                        <span  class="${i.index%2 ==0 ? "bg-orange" : "bg-blue"}">
                                            <c:choose>
                                                <c:when test="${rule.ruleTypeCode=='0'||rule.ruleTypeCode=='1'||rule.ruleTypeCode=='2'}">折扣</c:when>
                                                <c:when test="${rule.ruleTypeCode=='3'||rule.ruleTypeCode=='4'||rule.ruleTypeCode=='5'}">免运</c:when>
                                                <c:when test="${rule.ruleTypeCode=='6'||rule.ruleTypeCode=='7'||rule.ruleTypeCode=='8'}">赠品</c:when>
                                                <c:when test="${rule.ruleTypeCode=='9'||rule.ruleTypeCode=='10'||rule.ruleTypeCode=='11'}">换购</c:when>
                                                <c:when test="${rule.ruleTypeCode=='12'||rule.ruleTypeCode=='13'||rule.ruleTypeCode=='14'||rule.ruleTypeCode=='15'}">送券</c:when>
                                                <%--<c:when test="${rule.ruleTypeCode=='16'||rule.ruleTypeCode=='17'||rule.ruleTypeCode=='18'}">用券</c:when>--%>
                                                <c:when test="${rule.ruleTypeCode=='19'||rule.ruleTypeCode=='20'||rule.ruleTypeCode=='21'}">送积分</c:when>
                                            </c:choose>
                                        </span>
                                </c:forEach>
                            </div>

                            <a target="_blank" href="${webRoot}/shopTemplate/default/shopIndex.ac?shopId=${productProxy.shopInfProxy.shopInfId}"><p class="shop"> ${productProxy.shopInfProxy.shopNm}</p></a>
                            <div class="btn-box">
                                <a class="collect-btn ${productProxy.collect ? "collect-btn-hove" : ""}" href="javascript:void(0);" productId="${productProxy.productId}">收藏</a>
                                <div class="n_box">
                                    <input class="prdNumber" style="display: none" type="text" value="1">
                                </div>
                                <a class="join-requirements-btn addCartBtn sku${productProxy.skus[0].skuId}" srcUrl="${productProxy.defaultImage["60X60"]}" skuid="${productProxy.skus[0].skuId}" num="1" carttype=${productProxy.isNormal =="Y" ? "drug":"normal"} handler=${productProxy.isNormal =="Y" ? "drug" : "sku"}  href="javascript:" isNormal="${productProxy.isNormal}">${productProxy.isNormal == "Y" ? "加入需求单" : "加入购物车"}</a>
                            </div>
                        <li class="i_rows">
                            <c:choose>
                                <c:when test="${productProxy.isCanBuy}">
                                    <c:choose>
                                        <c:when test="${productProxy.isEnableMultiSpec == 'Y'}">
                                        </c:when>
                                        <c:otherwise>

                                        </c:otherwise>
                                    </c:choose>
                                </c:when>
                            </c:choose>
                        </li>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
        <%--分页 start--%>
        <div class="clear"></div>
    </div>
    <div class="page-footer">
        <div style="float: right;">
            <c:if test="${productProxys.lastPageNumber>1}">
                <p:PageTag isDisplayGoToPage="true" isDisplaySelect="false" totalPages='${productProxys.lastPageNumber}' currentPage='${_page}' totalRecords='${productProxys.totalCount}' ajaxUrl='${webRoot}/productlist.ac' frontPath='${webRoot}' displayNum='6'/>
            </c:if>
        </div>
    </div>

</div>





<%--加入购物车隐藏域 start--%>
<div class="wxts-bg" id="addToBuyCarLayer"  style="display: none;">
    <div class="wxts" >
        <div class="w-top">
            <i>温馨提示</i><a href="javascript:easyDialog.close();"><img src="${webRoot}/template/bdw/statics/images/wxts-btn.png" /></a>
        </div>
        <div class="w-bottom">
            <div class="bottom1">
                <div class="bot-left"><img src="${webRoot}/template/bdw/statics/images/wxts-img1.png" /></div>
                <div class="bot-right">
                    <div class="span">商品已成功添加到购物车！</div>
                    <em>购物车共<span class="cartnum"></span>件商品，合计：<i>¥<span  class="cartprice"></span></i></em>
                    <a href="${webRoot}/shoppingcart/cart.ac?time=<fmt:formatDate value="${systemTime}" type="both" dateStyle="long" pattern="yyyyMMddHHmmss" />" class="pay">去购物车结算</a>
                    <a href="javascript:easyDialog.close();" class="continue">继续购物</a>
                </div>
            </div>
        </div>
    </div>
</div>
<%--加入购物车隐藏域 end--%>

<%--加入需求单隐藏域 start--%>
<div class="wxts-bg" id="addToBuyListLayer"  style="display: none;">
    <div class="wxts" >
        <div class="w-top">
            <i>温馨提示</i><a href="javascript:easyDialog.close();"><img src="${webRoot}/template/bdw/statics/images/wxts-btn.png" /></a>
        </div>
        <div class="w-bottom">
            <div class="bottom1">
                <div class="bot-left"><img src="${webRoot}/template/bdw/statics/images/wxts-img1.png" /></div>
                <div class="bot-right">
                    <div class="span">商品已成功添加到需求单！</div>
                    <%--<em>需求单共<span class="cartnum"></span>件商品，合计：<i>¥<span  class="cartprice"></span></i></em>--%>
                    <a href="${webRoot}/shoppingcart/drugCart.ac?carttype=drug&handler=drug&time=<fmt:formatDate value="${systemTime}" type="both" dateStyle="long" pattern="yyyyMMddHHmmss" />" class="pay">去需求单结算</a>
                    <a href="javascript:easyDialog.close();" class="continue">继续购物</a>
                </div>
            </div>
        </div>
    </div>
</div>
<%--加入需求单隐藏域 end--%>

<br><br><br><br><br><br><br>

<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>

</body>
</html>
