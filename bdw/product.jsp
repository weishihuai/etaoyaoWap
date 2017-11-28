<%@ taglib prefix="p" uri="/iMallTag" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<c:set value="${sdk:getSysParamValue('salePointColor')}" var="salePointColor"/>

<c:set var="productProxy" value="${sdk:getProductById(param.id)}"/>
<c:if test="${empty productProxy}">
    <c:redirect url="/index.ac"></c:redirect>
</c:if>
<%--是否仅在微信展示，若等于Y则返回首页--%>
<c:if test="${productProxy.isWeixinShow eq 'Y'}">
    <c:redirect url="/index.ac"></c:redirect>
</c:if>

<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<jsp:useBean id="systemTime" class="java.util.Date"/>
<fmt:formatDate value="${systemTime}" type="both" dateStyle="long" pattern="yyyy-MM-dd" var="date"/>
<link href="${webRoot}/template/bdw/statics/css/propt.css" rel="stylesheet" type="text/css"/>
<!-- 样式 -->
<link rel='stylesheet' type='text/css' href='http://misc.360buyimg.com/product/skin/2012/pshow.css?t=20120717.css' media='all' />

<c:if test="${!productProxy.onSale}">
    <c:redirect url="/index.jsp"></c:redirect>
</c:if>
<%--取分类--%>
<c:set var="categoryProxy" value="${productProxy.category}"/>
<%--取品牌--%>
<c:set var="brandProxy" value="${productProxy.brand}"/>
<%--取出商品属性--%>
<c:set var="attrDicList" value="${productProxy.dicValues}"/>
<c:set var="attrDicMap" value="${productProxy.dicValueMap}"/>
<c:set var="attrGroupProxyList" value="${productProxy.attrGroupProxyList}"/>
<%--组合套餐--%>
<c:set var="comboList" value="${productProxy.combos}"/>
<%--商品评论统计--%>
<c:set var="commentStatistics" value="${productProxy.commentStatistics}"/>
<c:set value="${empty param.page ? 1 : param.page}" var="_page"/>
<%--商品评论--%>
<c:set var="commentProxyPage" value="${sdk:findProductComments(param.id,5)}"/>
<c:set var="commentProxyResult" value="${commentProxyPage.result}"/>
<%--商品咨询--%>
<c:set var="specList" value="${productProxy.productUserSpecProxyList}"/>
<%--店铺信息--%>
<c:set value="${sdk:getShopInfProxyById(productProxy.shopInfId)}" var="shopInf"/>
<c:set value="${sdk:getShopUser(productProxy.shopInfId)}" var="shopUser"/>
<%--同类商品--%>
<c:set value="${sdk:getSimilarProducts(productProxy.productId,productProxy.categoryId,20)}" var="similarProducts"/>
<c:set value="${productProxy.checkIsGroupBuyProduct}" var="groupBuyId"> </c:set>
<%-- 取得商品溯源 --%>
<c:set value="${bdw:getSyProductSourceProxyById(param.id)}" var="productSourceProxy"> </c:set>

<%--取出在售的门店商品--%>
<c:set value="${bdw:getAllRelProductProxy(20,param.id)}" var="productProxyList"/>

<%--地图--%>
<c:set value="${bdw:searchZones()}" var="zones"/>
<c:set value="${sdk:getSysParamValue('key_tengxunMap')}" var="mapKey"/>

<%--我的足迹--%>
<c:set value="${sdk:getProductFromCookie(pageContext.request,pageContext.response)}" var="productFromCookies"/>

<%--商品咨询--%>
<c:set var="buyConsultProxys" value="${sdk:findBuyConsultByProductId(param.id,10)}"/>

<%--热卖商品--%>
<c:set value="${sdk:getCategoryHotSalesProducts(categoryProxy.categoryId)}" var="categoryHotSalesProducts"/>

<%--保存商品到cookie--%>
<c:set value="${sdk:saveProductToCookie(productProxy.productId,pageContext.request,pageContext.response)}" var="saveProductToCookie"/>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>${webName}-${empty productProxy.metaTitle ? productProxy.name : productProxy.metaTitle}</title>
    <meta name="keywords" content="${productProxy.metaKeywords}-${webName}"/>
    <%--SEO keywords优化--%>
    <meta name="description" content="${productProxy.metaDescr}-${webName}"/>

    <link href="${webRoot}/template/bdw/statics/css/base.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/statics/css/product-detail.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/statics/js/cloud-zoom/css/cloud-zoom.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/statics/css/jquery.jqzoom.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/statics/js/easydialog/easydialog.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/jqGrid/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/module/member/statics/js/plupload/plupload.full.min.js"></script>

    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.cookie.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.jqzoom-core.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/imall-countdown.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/cloud-zoom/js/cloud-zoom.1.0.2.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.jcarousel.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.ld.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/scrollimage.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/hScrollPane.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/imallSlidelf.js"></script>
    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/statics/js/layer-v1.8.4/layer/layer.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/easydialog/easydialog.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script charset="utf-8" src="http://map.qq.com/api/js?v=2.exp&key=IMSBZ-M7ZWU-HCVV7-4FRXE-ESSDS-3OFKL"></script>
    <script type="text/javascript">
        var productId = eval('${productProxy.productId}');
        var webPath = {
            webRoot: "${webRoot}", page: "${param.page}", productId: "${param.id}", productCollectCount: "${loginUser.productCollectCount}", shopCollectCount: "${loginUser.shopCollectCount}", goBox: "${param.goBox}",
            systemTime: "<fmt:formatDate value="${systemTime}" type="both" dateStyle="long" pattern="yyyy/MM/dd HH:mm:ss" />",lat: '${param.lat}', lng: '${param.lng}', mapkey:'${mapKey}',userId:"${loginUser.userId}"
        };
        var imgpathData = {defaultImage: "${productProxy.defaultImage['60X60']}"};

    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/comment.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/shoppingcart.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/product-detail.js"></script>
</head>

<%
    StringBuffer url = request.getRequestURL();
    String tempContextUrl = url.delete(url.length() - request.getRequestURI().length(), url.length()).toString();
    request.setAttribute("tempContextUrl", tempContextUrl);
%>

<body>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp?p=detail"/>
<%--页头结束--%>

<div class="main">
    <!-- 面包屑导航 -->
    <div class="breadcrumb-nav">
        <div><a class="link-index" href="${webRoot}/index.ac">首页</a></div>
        <i></i>
        <c:set value="${categoryProxy.categoryTree}" var="categoryTrees"/>
        <c:set value="" var="lastSecondCategoryId"/>
        <c:forEach items="${categoryTrees}" var="categoryTree">
            <c:if test="${categoryTree.categoryId ne 1}">
                <div>
                    <div class="dt"><a href="javascript:;">${categoryTree.name}<em></em></a></div>
                    <c:set value="${categoryTree.categoryId}" var="lastSecondCategoryId"/>
                    <div class="dd clearfix">
                        <c:forEach items="${categoryTree.sameLevel}" var="catetorySameLevel">
                            <a class="<c:if test="${catetorySameLevel.categoryId eq categoryTree.categoryId}">cur</c:if>" href="${webRoot}/productlist-${catetorySameLevel.categoryId}.html" title="">${catetorySameLevel.name}</a>
                        </c:forEach>
                    </div>
                </div>
                <i></i>
            </c:if>
        </c:forEach>
        <span>${productProxy.name}</span>
    </div>
    <div class="product">
        <div class="product-preview">

            <div class="preview-stage" style="position: relative;">
                <a href='${productProxy.defaultImage['600X600']}' class='cloud-zoom' id='zoom1' rel="adjustX:10,adjustY:-4,softFocus:false,smoothMove:2,zoomWidth:490,zoomHeight:380,showTitle:false,minWidth:383,minHeight:383">
                    <img id="bigsrc" src="${productProxy.defaultImage['420X420']}" alt='' title="${productProxy.name}" border="0" style="width: 420px;height: 420px;"/>
                </a>
            </div>

            <ul class="preview-bar" >
                <c:forEach varStatus="s" items="${productProxy.images}" var="image" end="4">
                    <li class="${s.first?'active':''}" >
                        <a href='${image['']}' picId="${image}" sImg="${image['420X420']}" lImg="${image['']}"
                           class='cloud-zoom-gallery ' rel="useZoom:'zoom1',smallImage:'${image['420X420']}',largeimage: '${image['600X600']}'">
                            <img class="zoom-tiny-image" src="${image['80X80']}" alt="Thumbnail 1" onclick="preview(this)"/>
                        </a>
                    </li>
                </c:forEach>
            </ul>
            <div class="product-code">
                <span>商品编码：${productProxy.productCode}</span>
            </div>
            <div class="share">
                <button class="btn-link" type="button" id="AddTomyLikeBtn" isCollect="${productProxy.collect}">
                    <i class="${productProxy.collect ? "icon-collect-active" : "icon-collect"}"></i>
                    收藏&nbsp;&nbsp;(${productProxy.productCollectCount})
                </button>
                <a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jtico jtico_jiathis" target="_blank"><i class="icon-share"></i>&ensp;分享</a>
            </div>
        </div>
        <div class="product-detail">
            <c:choose>
                <c:when test="${productProxy.medicinalTypeCode eq '0'}">
                    <h1>
                        <c:choose>
                            <c:when test="${productProxy.dicValueMap['prescription_type'].valueString eq '甲类OTC'}"><span class="bg-red">甲OTC</span></c:when>
                            <c:when test="${productProxy.dicValueMap['prescription_type'].valueString eq 'RX'}"><span class="bg-blue">RX</span></c:when>
                            <c:when test="${productProxy.dicValueMap['prescription_type'].valueString eq '乙类OTC'}"><span class="bg-green">乙OTC</span></c:when>
                        </c:choose>
                        ${productProxy.name}
                    </h1>
                    <h2>${productProxy.salePoint}</h2>
                    <h2>易淘药只对药品作信息展示，不提供交易</h2>
                    <div class="price">
                        <em class="fl"><span>销售价</span><small>&yen;&nbsp;</small>${productProxy.priceListStr}</em>
                        <span class="fl">市场价<del>&yen;${productProxy.marketPrice}</del></span>
                        <c:if test="${fn:length(productProxy.skus)==1 && productProxy.price.isSpecialPrice}">
                            <div class="val">
                                <img src="${webRoot}/template/bdw/statics/images/sj.png">
                                <div class="time-box" endDate="${productProxy.price.endTimeStr}">剩余&nbsp;<span>0</span>&nbsp;天&nbsp;<span>00</span>&nbsp;时&nbsp;<span>00</span>&nbsp;分&nbsp;<span>00</span>&nbsp;秒</div>
                            </div>
                        </c:if>
                    </div>
                </c:when>
                <c:otherwise>
                    <h1>${productProxy.name}</h1>
                    <h2>${productProxy.salePoint}</h2>
                    <div class="price">
                        <em class="fl"><span>销售价</span><small>&yen;&nbsp;</small>${productProxy.priceListStr}</em>
                        <span class="fl">市场价<del>&yen;${productProxy.marketPrice}</del></span>
                        <c:if test="${fn:length(productProxy.skus)==1 && productProxy.price.isSpecialPrice}">
                        <div class="val">
                            <img src="${webRoot}/template/bdw/statics/images/sj.png">
                            <div class="time-box" endDate="${productProxy.price.endTimeStr}">剩余&nbsp;<span>0</span>&nbsp;天&nbsp;<span>00</span>&nbsp;时&nbsp;<span>00</span>&nbsp;分&nbsp;<span>00</span>&nbsp;秒</div>
                        </div>
                        </c:if>
                    </div>
                </c:otherwise>
            </c:choose>
            <ul class="info-list">
                <li class="info-item">
                    <span class="lab">评&nbsp;&nbsp;&nbsp;&nbsp;价</span>
                    <div class="val">
                    <span class="star-box">
                         <c:choose>
                             <c:when test="${productProxy.commentStatistics.average > 0}">
                                 <c:forEach begin="1" end="${productProxy.commentStatistics.average}">
                                     <i class="icon-star active"></i>
                                 </c:forEach>
                             </c:when>
                             <c:otherwise>
                                 <i class="icon-star active"></i>
                                 <i class="icon-star active"></i>
                                 <i class="icon-star active"></i>
                                 <i class="icon-star active"></i>
                                 <i class="icon-star active"></i>
                             </c:otherwise>
                         </c:choose>
                    </span>
                        <a class="val-pl" href="javascript:;" onclick="goComment()">(<span>${productProxy.total}</span>条评论)</a>
                    </div>
                </li>

                <li class="info-item">
                    <span class="lab">已&nbsp;&nbsp;&nbsp;&nbsp;售</span>
                    <div class="val"><em>${productProxy.salesVolume}</em>件</div>
                </li>
                <li class="info-item">
                    <span class="lab">服&nbsp;&nbsp;&nbsp;&nbsp;务</span>
                    <div class="val">此商品由&ensp;<a href="${webRoot}/shopTemplate/default/shopIndex.ac?shopId=${shopInf.shopInfId}" target="_blank">${fn:substring(shopInf.shopNm,0,16)}</a>&ensp;提供 </div>
                </li>
                <c:set value="${productProxy.availableBusinessRuleList}"  var="availableBusinessRuleList" />
                <c:if test="${not empty availableBusinessRuleList}">
                    <li class="info-item">
                        <span class="lab">促&nbsp;&nbsp;&nbsp;&nbsp;销</span>
                        <c:choose>
                            <c:when test="${fn:length(availableBusinessRuleList)>3}">
                                <div class="val i_layer" style="height: 80px;">
                                    <c:forEach items="${availableBusinessRuleList}" var="rule" varStatus="i">
                                        <p class="val-cx">
                                                <span>
                                                    <c:choose>
                                                        <c:when test="${rule.ruleTypeCode=='0'||rule.ruleTypeCode=='1'||rule.ruleTypeCode=='2'}">折扣</c:when>
                                                        <c:when test="${rule.ruleTypeCode=='3'||rule.ruleTypeCode=='4'||rule.ruleTypeCode=='5'}">免运</c:when>
                                                        <c:when test="${rule.ruleTypeCode=='6'||rule.ruleTypeCode=='7'||rule.ruleTypeCode=='8'}">赠品</c:when>
                                                        <c:when test="${rule.ruleTypeCode=='9'||rule.ruleTypeCode=='10'||rule.ruleTypeCode=='11'}">换购</c:when>
                                                        <c:when test="${rule.ruleTypeCode=='12'||rule.ruleTypeCode=='13'||rule.ruleTypeCode=='14'||rule.ruleTypeCode=='15'}">送券</c:when>
                                                        <c:when test="${rule.ruleTypeCode=='19'||rule.ruleTypeCode=='20'||rule.ruleTypeCode=='21'}">送积分</c:when>
                                                    </c:choose>
                                                </span>
                                            <a href="javascript:;">${rule.businessRuleNm}&nbsp;</a>
                                        </p>
                                    </c:forEach>
                                </div>
                                <div  style="margin-left: 43px;">
                                    <c:if test="${fn:length(availableBusinessRuleList)>3}">
                                        <span class="more-rule">展开更多活动</span>
                                        <span class="hidden-rule" style="display: none;">收起更多活动</span>
                                    </c:if>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="val">
                                    <c:forEach items="${productProxy.availableBusinessRuleList}" var="rule" varStatus="i">
                                        <p class="val-cx">
                                                <span>
                                                    <c:choose>
                                                        <c:when test="${rule.ruleTypeCode=='0'||rule.ruleTypeCode=='1'||rule.ruleTypeCode=='2'}">折扣</c:when>
                                                        <c:when test="${rule.ruleTypeCode=='3'||rule.ruleTypeCode=='4'||rule.ruleTypeCode=='5'}">免运</c:when>
                                                        <c:when test="${rule.ruleTypeCode=='6'||rule.ruleTypeCode=='7'||rule.ruleTypeCode=='8'}">赠品</c:when>
                                                        <c:when test="${rule.ruleTypeCode=='9'||rule.ruleTypeCode=='10'||rule.ruleTypeCode=='11'}">换购</c:when>
                                                        <c:when test="${rule.ruleTypeCode=='12'||rule.ruleTypeCode=='13'||rule.ruleTypeCode=='14'||rule.ruleTypeCode=='15'}">送券</c:when>
                                                        <c:when test="${rule.ruleTypeCode=='19'||rule.ruleTypeCode=='20'||rule.ruleTypeCode=='21'}">送积分</c:when>
                                                    </c:choose>
                                                </span>
                                            <a href="javascript:;">${rule.businessRuleNm}&nbsp;&nbsp;<c:if test="${not empty rule.descr}">(${rule.descr})</c:if></a>
                                        </p>
                                    </c:forEach>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </li>
                </c:if>
                <%-- <li class="info-item">
                     <span class="lab">领&nbsp;&nbsp;&nbsp;&nbsp;券</span>
                     <div class="val">
                         <a class="val-lq" href="javascript:;"><span>满1000减50</span></a>
                         <a class="val-lq" href="javascript:;"><span>满500减20</span></a>
                         <a class="val-lq" href="javascript:;"><span>满300减10</span></a>
                     </div>
                 </li>--%>
                <%--收藏商品--%>
                <div class="AddTomyLikeLayer" style="display:none;" id="addTomyLikeLayer">
                    <div class="showTip">
                        <div class="close"><a href="javascript:" onclick="$('.AddTomyLikeLayer').hide()"><img src="${webRoot}/template/bdw/statics/images/detail_closeLayer.gif"/> 关闭</a></div>
                        <div class="succe">
                            <h3>商品已成功收藏！</h3>
                            <div class="tip">已收藏 <b id="productCollectCount">${loginUser.productCollectCount}</b> 件商品。
                                <a href="${webRoot}/module/member/productCollection.ac?menuId=51553">查看收藏夹>></a>
                            </div>
                        </div>
                    </div>
                </div>
                <%--收藏店铺--%>
                <div class="AddShopTomyLikeLayer" style="display:none; " id="addShopTomyLikeLayer">
                    <div class="showTip">
                        <div class="close"><a href="javascript:" onclick="$('.AddShopTomyLikeLayer').hide()"><img src="${webRoot}/template/bdw/statics/images/detail_closeLayer.gif"/> 关闭</a></div>
                        <div class="succe">
                            <h3>店铺已成功收藏！</h3>
                            <div class="tip">已收藏 <b id="shopCollectCount">${loginUser.shopCollectCount}</b> 间店铺。
                                <a href="${webRoot}/module/member/shopCollection.ac">查看收藏夹>></a>
                            </div>
                        </div>
                    </div>
                </div>

                <li class="info-item">
                    <span class="lab">数量</span>
                    <div class="val">
                        <div class="amount">
                            <a class="amount-opera disabled prd_subNum" href="javascript:;" >−</a>
                            <input class="amount-inp" id="" type="text" value="1" placeholder="">
                            <a class="amount-opera prd_addNum" href="javascript:;">+</a>
                        </div>
                        <input type="hidden" id="remainStock" value="${productProxy.skus[0].price.remainStock}">
                        <div class="val-kc">（库存${productProxy.skus[0].price.remainStock}件）</div>
                    </div>
                </li>

                <c:choose>
                    <c:when test="${productProxy.medicinalTypeCode eq '0'}">
                        <li class="info-item">
                            <span class="lab">&nbsp;</span>
                            <div class="val">
                                <button class="fl btn-buy addGoCar" id="addDrugCart" skuid="${productProxy.isEnableMultiSpec=='Y' ? '': productProxy.skus[0].skuId}" carttype="drug" handler="drug" num="1" href="javascript:;" type="button" isNormal="${productProxy.isNormal}">立即预定</button>
                                <button class="fl btn-danger addcart sku${productProxy.skus[0].skuId}" srcUrl="${productProxy.defaultImage["60X60"]}"  skuid="${productProxy.isEnableMultiSpec=='Y' ? '': productProxy.skus[0].skuId}"  num="1" carttype="drug" handler="drug" num="1" href="javascript:;" isNormal="${productProxy.isNormal}" type="button">加入需求清单</button>
                            </div>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="info-item">
                            <span class="lab">&nbsp;</span>
                            <div class="val">
                                <button class="fl btn-buy addGoCar" id="addProductCart" skuid="${productProxy.isEnableMultiSpec=='Y' ? '': productProxy.skus[0].skuId}" carttype="normal" handler="sku" num="1" href="javascript:;" type="button">立即购买</button>
                                <button class="fl btn-danger addcart sku${productProxy.skus[0].skuId}" srcUrl="${productProxy.defaultImage["60X60"]}"  skuid="${productProxy.isEnableMultiSpec=='Y' ? '': productProxy.skus[0].skuId}"  num="1" carttype="normal" handler="sku" href="javascript:;" isNormal="${productProxy.isNormal}" type="button">加入购物车</button>
                            </div>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
            <c:choose>
                <c:when test="${productProxy.dicValueMap['prescription_type'].valueString eq '甲类OTC'}">
                    <p class="tips">提示：药品请仔细阅读产品说明书或者在药师指导下购买和使用，可联系在线药师，<br/>“${shopInf.shopNm}”实体店为您服务。</p>
                </c:when>
                <c:when test="${productProxy.dicValueMap['prescription_type'].valueString eq 'RX'}">
                    <p class="tips">提示：该药为处方药，建议你去医院就诊或凭医生的处方到就近的药房选购。<br/>
                        药品监管部门提示：如发现本网站有任何直接或变相销售处方药行为，请保留证据，拨打12331举报，举报查实给予奖励</p>
                </c:when>
                <c:when test="${productProxy.dicValueMap['prescription_type'].valueString eq '乙类OTC'}">
                    <p class="tips">提示：药品请仔细阅读产品说明书或者在药师指导下购买和使用，可联系在线药师，<br/>“${shopInf.shopNm}”实体店为您服务。</p>
                </c:when>
            </c:choose>
        </div>
    </div>
    <div class="store">
        <h2>${shopInf.shopNm}</h2>
        <ul>
            <li>等级：<span class="grade"><img src="${shopInf.shopLevel.levelIcon['']}"/></span></li>
            <li>商品数量：<em>${shopInf.productTotalCount}</em></li>
        </ul>

        <ul>
            <li>描述相符：<strong>${shopInf.shopRatingAvgVo.productDescrSame}分</strong></li>
            <li>服务态度：<strong>${shopInf.shopRatingAvgVo.sellerServiceAttitude}分</strong></li>
            <li>物流速度：<strong>${shopInf.shopRatingAvgVo.sellerSendOutSpeed}分</strong></li>
        </ul>

        <ul class="store-service">
            <li style="position: relative">联系客服：
                <c:choose>
                    <c:when test="${not empty shopInf.companyQqUrl}">
                        <a href="${shopInf.companyQqUrl}" target="_blank" class="qq-service">QQ客服</a>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${shopInf.csadInfList}" var="caadInf" end="0">
                            <a href="http://wpa.qq.com/msgrd?v=3&amp;uin=${caadInf}&amp;site=qq&amp;menu=yes" target="_blank" class="qq-service">QQ客服</a>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </li>
            <li>联系电话：
                <c:choose>
                    <c:when test="${empty shopInf.tel}">
                        <strong>${shopInf.mobile}</strong>
                    </c:when>
                    <c:otherwise>
                        <strong>${shopInf.tel}</strong>
                    </c:otherwise>
                </c:choose>
            </li>
            <li>工作时间：<strong>${shopInf.csadOnlineDescr}</strong></li>
            <li style="line-height: 20px;">认证信息：
                <c:forEach items="${shopInf.shopAttesation}" var="shopAttesations">
                    <img src="${shopAttesations.logo['']}" style="max-height: 16px;"/>
                </c:forEach>
            </li>
        </ul>
        <a class="btn btn-default fl" href="${webRoot}/shopTemplate/default/shopIndex.ac?shopId=${shopInf.shopInfId}" target="_blank">进入店铺</a>
        <a class="btn btn-default fr" id="collectState" href="javascript:;" <c:if test="${shopInf.collect == false}">onClick="CollectShop(${shopInf.shopInfId})"</c:if>>${shopInf.collect ? '已收藏' : '收藏本店'}</a>
    </div>

    <c:if test="${productProxy.medicinalTypeCode eq '0'}">
        <!-- 预定流程 -->
        <div class="reservation-process">
            <div class="dt">
                <p>药品</p>
                <span>预定流程</span>
            </div>
            <div class="dd">
                <div class="item item01">
                    <em></em>
                    <span>提交预定需求</span>
                </div>
                <div class="item item02">
                    <em></em>
                    <span>药师回拨/短信回复</span>
                </div>
                <div class="item item03">
                    <em></em>
                    <span>药房配送/自提</span>
                </div>
                <div class="item item04">
                    <em></em>
                    <span>线下付款</span>
                </div>
            </div>
        </div>
    </c:if>

    <div class="main-content">
        <!-- 同类型商品-->
        <div class="side">
            <div class="fl-item">
                <h4>同类型商品</h4>
                <c:choose>
                <c:when test="${not empty similarProducts}">
                <ul>
                    <c:forEach items="${similarProducts}" var="phoneList" varStatus="s" end="10">
                        <li>
                            <a href="${webRoot}/product-${phoneList.productId}.html" class="pic"><img src="${empty phoneList.images ? phoneList.defaultImage['160X160'] : phoneList.images[0]['160X160']}"></a>
                            <a href="${webRoot}/product-${phoneList.productId}.html" class="title">${phoneList.name}</a>
                            <span class="gl-price">¥<em>${phoneList.price.unitPrice}</em></span>
                        </li>
                    </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div style="margin-top: 16px; margin-bottom: 16px;">
                            <i style="color:#ff6b00; margin-top:5px;font-size: 15px;margin-left: 47px;">暂无同类产品</i>
                        </div>
                    </c:otherwise>
                    </c:choose>
                </ul>
            </div>

            <div class="fl-item">
                <h4>热卖商品</h4>
                <c:choose>
                    <c:when test="${not empty categoryHotSalesProducts}">
                        <ul >
                            <c:forEach items="${categoryHotSalesProducts}" var="phoneList" varStatus="s" end="4">
                                <li>
                                    <a href="${webRoot}/product-${phoneList.productId}.html" class="pic">
                                        <img src="${empty phoneList.images ? phoneList.defaultImage['160X160'] : phoneList.images[0]['160X160']}">
                                    </a>
                                    <a href="${webRoot}/product-${phoneList.productId}.html" class="title">${phoneList.name}</a>
                                    <span class="gl-price">¥<em><fmt:formatNumber value="${phoneList.price.unitPrice}" type="number" pattern="#0.00#"/></em></span>
                                </li>
                            </c:forEach>
                        </ul>
                    </c:when>
                    <c:otherwise>
                        <div style="margin-top: 16px; margin-bottom: 16px;">
                            <i style="color:#ff6b00; margin-top:5px;font-size: 15px;margin-left:47px;">暂无热卖产品</i>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="fl-item">
                <h4>我的足迹<span class="del" onclick="clearHistoryProductsCookie()">清空</span></h4>
                <c:choose>
                    <c:when test="${not empty productFromCookies}">
                        <ul >
                            <c:forEach items="${productFromCookies}" var="proxy" varStatus="s" end="5">
                                <li >
                                    <a href="${webRoot}/product-${proxy.productId}.html" target="_blank" class="pic"><img src="${proxy.defaultImage["160X160"]}" alt="${proxy.name}"/></a>
                                    <a href="${webRoot}/product-${proxy.productId}.html" target="_blank" class="title">${proxy.name}</a>
                                    <span class="gl-price">¥<em><fmt:formatNumber value="${proxy.price.unitPrice}" type="number" pattern="#0.00#"/></em></span>
                                </li>
                            </c:forEach>
                        </ul>
                    </c:when>
                    <c:otherwise>
                        <ul class="row" style="padding-top:15px;font-size: 15px;padding-left:28px;height: 30px;width: 170px;color: #ff6b00;">你还未浏览其他商品</ul>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- 商品 -->
        <div class="body">
            <ul class="minute-menu">
                <li class="active" rel="1"><a href="javascript:;" >商品详情</a></li>
                <li rel="2" id="relComment"><a href="javascript:;">商品评价(${commentStatistics.total})</a></li>
                <li rel="3"><a href="javascript:;">售前咨询</a></li>
                <c:if test="${productProxy.medicinalTypeCode eq '0'}">
                    <li rel="4"><a href="javascript:;">说明书</a></li>
                </c:if>
            </ul>

            <!-- 商品详情 -->
            <div class="minute-cont" style="display: block;">
                <c:choose>
                    <c:when test="${productProxy.jdProductCode != null || !productProxy.jdProductCode  eq 'null'}">
                        <ul class="attributes">
                            <c:forEach items="${fn:split(productProxy.paramHtml, ',')}" var="data">
                                <li>${data}</li>
                            </c:forEach>
                            <div class="clear"></div>
                        </ul>
                    </c:when>
                    <c:otherwise>
                        <c:if test="${not empty attrGroupProxyList}">
                            <c:forEach items="${attrGroupProxyList}" var="attrGroupProxy">
                                <c:if test="${fn:length(attrGroupProxy.dicValues)>0 && attrGroupProxy.attrGroupNm != '通用属性组'}">
                                    <ul class="attributes">
                                        <c:forEach items="${attrGroupProxy.dicValues}" var="attrDict">
                                            <c:if test="${not empty attrGroupProxy.dicValueMap[attrDict.innerCode].valueString}">
                                                <li class="elli" title="${attrGroupProxy.dicValueMap[attrDict.innerCode].valueString}">
                                                        ${attrDict.name}：
                                                    <c:if test="${!empty attrGroupProxy.dicValueMap}">
                                                        ${attrGroupProxy.dicValueMap[attrDict.innerCode].valueString}
                                                    </c:if>
                                                </li>
                                            </c:if>
                                        </c:forEach>
                                        <div class="clear"></div>
                                    </ul>
                                </c:if>
                            </c:forEach>
                        </c:if>
                    </c:otherwise>
                </c:choose>
                <div class="detail-img">
                    ${not empty productProxy.description ? (productProxy.description) : ''}
                </div>
            </div>

            <!-- 商品评价 -->
            <div class="minute-cont">
                <div class="comment">
                    <div class="g-b-l">
                        <h3>${productProxy.commentStatistics.average}</h3>
                        <p>用户满意度</p>
                    </div>
                    <div class="g-b-m">
                        <ul>
                            <li>
                                <span class="txt">好评</span>
                                <span class="bar"><i style="width: ${productProxy.goodRate};"></i></span>
                                <span class="txt">${productProxy.goodRate}</span>
                            </li>
                            <li>
                                <span class="txt">中评</span>
                                <span class="bar"><i style="width: ${productProxy.normalRate};"></i></span>
                                <span class="txt">${productProxy.normalRate}</span>
                            </li>
                            <li>
                                <span class="txt">差评</span>
                                <span class="bar"><i style="width: ${productProxy.badRate};"></i></span>
                                <span class="txt">${productProxy.badRate}</span>
                            </li>
                        </ul>
                    </div>
                    <div class="g-b-r">
                        <a class="btn" href="javascript:;" id="isAllowComment">发表评论</a>
                        <p>写评价，赚积分！已购买过本产品的会员可对商品进行评价，获得积分奖励。</p>
                    </div>
                </div>
                <div class="comment-list">
                </div>
            </div>
            <!-- 售前咨询 -->
            <div class="minute-cont">
                <div class="pre-sale">
                    <div class="form">
                        <div>我要咨询</div>
                        <div class="text-box">
                            <textarea name="" id="consultCont" placeholder="您可在购买前对产品包装、颜色、运输、库存等方面进行咨询，300字以内。" maxlength="300"></textarea>
                        </div>

                        <c:choose>
                            <c:when test="${empty loginUser}">
                                <div>
                                    <a href="${webRoot}/login.ac" title="登录" style="color: #FF6600;">请登陆</a>后提交咨询！
                                    <a href="${webRoot}/register.ac" title="注册新账户">注册新用户</a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <button class="btn" type="button" id="addConsultCont">提交</button>
                                <span class="words" id="consultContLength">0/300</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <ul class="ask-list">
                        <c:forEach items="${buyConsultProxys.result}" var="buyConsultProxy" varStatus="result">
                            <li>
                                <c:set value="${fn:substring(buyConsultProxy.userName, 0,3)}" var="mobileHeader"/><%-- 用户名前3位 --%>
                                <c:set value="${fn:substring(buyConsultProxy.userName, 7,fn:length(buyConsultProxy.userName))}" var="mobileStern"/><%-- 用户名后4位 --%>
                                <p class="from">${mobileHeader}****${mobileStern}</p>
                                <div class="cont">
                                    <p class="ask">${buyConsultProxy.consultCont}</p>
                                    <p class="time"><c:if test="${not empty buyConsultProxy.lastReplyTimeString}">${buyConsultProxy.lastReplyTimeString}</c:if></p>
                                    <c:if test="${not empty buyConsultProxy.consultReplyCont}">
                                        <p class="answer">${buyConsultProxy.consultReplyCont}</p>
                                    </c:if>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
            <%--说明书--%>
            <div class="minute-cont">${productProxy.specification}</div>

            </div>
        <c:choose>
            <c:when test="${productProxy.medicinalTypeCode eq '0'}">
                <!-- 置顶是添加 active -->
                <button class="btn-cart addcart" skuid="${productProxy.isEnableMultiSpec=='Y' ? '': productProxy.skus[0].skuId}"  num="1" carttype="normal" handler="sku" href="javascript:;" isNormal="${productProxy.isNormal}">加入需求清单</button>
            </c:when>
            <c:otherwise>
                <!-- 置顶是添加 active -->
                <button class="btn-cart addcart" skuid="${productProxy.isEnableMultiSpec=='Y' ? '': productProxy.skus[0].skuId}"  num="1" carttype="normal" handler="sku" href="javascript:;" isNormal="${productProxy.isNormal}">加入购物车</button>
            </c:otherwise>
        </c:choose>

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
                    <em>需求单共<span class="cartnum"></span>件商品，合计：<i>¥<span  class="cartprice"></span></i></em>
                    <a href="${webRoot}/shoppingcart/drugCart.ac?carttype=drug&handler=drug&time=<fmt:formatDate value="${systemTime}" type="both" dateStyle="long" pattern="yyyyMMddHHmmss" />" class="pay">去需求单结算</a>
                    <a href="javascript:easyDialog.close();" class="continue">继续购物</a>
                </div>
            </div>
        </div>
    </div>
</div>
<%--加入需求单隐藏域 end--%>

<!--end details_index-->
<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js?uid=1338866268911669" charset="utf-8"></script>
<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>
</body>
</html>
