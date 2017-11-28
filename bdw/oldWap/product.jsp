<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<%--取出商品--%>
<c:set var="productProxy" value="${sdk:getProductById(param.id)}"/>

<c:if test="${empty productProxy}">
    <c:redirect url="/wap/index.ac"></c:redirect>
</c:if>

<%--不是微信，商品仅在微信显示则返回首页--%>
<c:if test="${isWeixin!='Y'}">
    <c:if test="${productProxy.isWeixinShow eq 'Y'}">
        <c:redirect url="/wap/index.ac"></c:redirect>
    </c:if>
</c:if>

<c:set value="${sdk:getShopInfProxyById(productProxy.shopInfId)}" var="shop"/>

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
<%--&lt;%&ndash;相关商品&ndash;%&gt;--%>
<%--<c:set var="refProductList" value="${productProxy.refProducts}"/>--%>
<%--商品评论统计--%>
<c:set var="commentStatistics" value="${productProxy.commentStatistics}"/>
<%--商品评论--%>
<c:set var="commentProxyPage" value="${sdk:findProductComments(param.id,10)}"/>
<c:set var="commentProxyResult" value="${commentProxyPage.result}"/>
<%--商品咨询--%>
<c:set var="buyConsultProxys" value="${sdk:findBuyConsultByProductId(param.id,10)}"/>
<%--获取当前用户--%>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<c:set var="specList" value="${productProxy.productUserSpecProxyList}"/>
<%-- 获取当前商家 --%>
<c:set value="${sdk:getShopInfProxyById(productProxy.shopInfId)}" var="shopInf"/>

<%-- 获取店铺促销商品的数量 --%>
<c:set value="${bdw:getDiscountProductNum(shopInf.sysOrgId)}" var="discountProductNum"/>
<%-- 获取店铺新上架商品的数量 --%>
<c:set value="${bdw:getNewProductNum(shopInf.sysOrgId)}" var="newProductNum"/>
<%-- 获取店铺所有商品的数量 --%>
<c:set value="${bdw:getTotalProductNum(shopInf.sysOrgId)}" var="totalProductNum"/>

<%-- 商家正在进行的优惠(赠品，包邮这些) --%>
<c:set value="${productProxy.availableBusinessRuleList}"  var="availableBusinessRuleList" />

<%-- 如果商品没有促销信息就不要显示促销那个div --%>
<c:set value="${empty availableBusinessRuleList?'none':'block'}" var="isDisplayPromotion"/>

<c:if test="${!productProxy.onSale}">
    <c:redirect url="/index.jsp"></c:redirect>
</c:if>

<c:set value="${sdk:saveProductToCookie(productProxy.productId,pageContext.request,pageContext.response)}" var="saveProductToCookie"/>
<jsp:useBean id="systemTime" class="java.util.Date" />

<!DOCTYPE html>
<html>
<head lang="en">
    <title>${empty productProxy.metaTitle ? productProxy.name : productProxy.metaTitle}</title>
    <meta name="keywords" content="${productProxy.metaKeywords}-${webName}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${productProxy.metaDescr}-${webName}" /> <%--SEO description优化--%>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1" name="viewport">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.min.css" rel="stylesheet" >
    <link href="${webRoot}/template/bdw/oldWap/statics/css/productBase.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/statics/css/productHeader.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/statics/css/swiper.min.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/detail.css" type="text/css" rel="stylesheet" />
    <style>
        #productDescription img{
            width: 100%;
            height: 100%;
        }
    </style>

    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery-1.7.1.min.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        var isCollect = '${productProxy.collect}';
        var skuData = eval('${productProxy.skuJsonData}');
        var userSpecData = eval('${productProxy.userSpecJsonData}');
        var isCanBuy = eval('${productProxy.isCanBuy}');
        var webPath = {webRoot:"${webRoot}",productId:"${param.id}",productCollectCount:"${loginUser.productCollectCount}",collectSize:"${collectSize}",page:"${page}",href:"${param.href}",
            systemTime:"<fmt:formatDate value="${systemTime}" type="both" dateStyle="long" pattern="yyyy/MM/dd HH:mm:ss" />"};

    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/xyPop/xyPop.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/wap-countdown.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/swiper.min.js" ></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/shoppingcart.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/product.js" ></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/checkwifi.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/common.js"></script>

    <script type="text/javascript">
        $(function(){
            if(${isWeixin=="Y"}){
                //$(".header").css("display","none");
                $(".main").css("padding-top","40px");
                $(".tab-nav").css("margin-top","-45px");
            }
        });
    </script>

    <script>
        window._bd_share_config = {
            common : {
                bdText : '自定义分享内容',
                bdDesc : '自定义分享摘要',
                bdUrl : '自定义分享url地址',
                bdPic : '自定义分享图片'
            },
            share : [{
                "bdSize" : 32
            }],
            /*slide : [{
                bdImg : 0,
                bdPos : "right",
                bdTop : 100
            }],*/
            image : [{
                viewType : 'list',
                viewPos : 'top',
                viewColor : 'black',
                viewSize : '32',
                viewList : ['qzone','tsina','huaban','tqq','renren']
            }],
            selectShare : [{
                "bdselectMiniList" : ['qzone','tqq','kaixin001','bdxc','tqf']
            }]
        };
        with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?cdnversion='+~(-new Date()/36e5)];
    </script>

</head>

<body>

<c:if test="${isWeixin!='Y'}">
    <header class="header">
        <a onclick="history.go(-1);" href="javascript:void(0);" class="back"></a>
        <span class="title">商品详情</span>
        <a href="javascript:void(0);" class="home" onclick="window.location.href='${webRoot}/wap/index.ac?time='+ new Date().getTime()"></a>
    </header>
</c:if>

<div class="main">
    <div class="tab-nav">
        <span class="tab-nav-item active"><a href="javascript:void(0);" onclick="showTab('default',this)">商品简介</a></span>
        <span class="tab-nav-item"><a href="javascript:void(0);" onclick="showTab('sell',this)">商品详情</a></span>
        <span class="tab-nav-item"><a href="javascript:void(0);" onclick="showTab('sell2',this)">商品属性</a></span>
        <span class="tab-nav-item"><a href="javascript:void(0);" onclick="showTab('priceM',this)">用户评价</a></span>
    </div>
    <input type="hidden" id="productcookie" value="${param.id}"/>
    <div class="tab-cont">
        <div class="cont-m1" id="default">
            <div style=" background-color: #fff;">
                <div class="swiper-container m-pic">
                    <c:if test="${productProxy.isJoinActivity && not empty productProxy.activityPlateImageUrl}">
                        <div class="ac_image"><img src="${webRoot}/upload/${productProxy.activityPlateImageUrl}" alt=""/></div>
                    </c:if>
                    <div class="swiper-wrapper" style="height: 250px;">
                        <c:forEach varStatus="s" items="${productProxy.images}" var="image">
                            <div class="swiper-slide">
                                <a href="">
                                    <img src="${image['420X420']}" style="height:320px"/>
                                </a>
                            </div>
                        </c:forEach>
                    </div>
                    <!-- Add Pagination -->
                    <div class="swiper-pagination swiper-pagination-fraction"></div>
                </div>
            </div>
            <div class="m-step1">
                <div class="title">${productProxy.name}</div>
                <div class="provide-srv"><span>${productProxy.salePoint}</span></div>

                <div class="price">
                    <c:if test="${productProxy.price.isSpecialPrice}">
                        <span style=" display: inline-block; font-size: 0.8rem; color:#f37913 ">特价</span>
                    </c:if>
                    <span id="price">¥${productProxy.priceListStr}</span ">
                    <c:choose>
                        <c:when test="${productProxy.price.discountType eq 'PLATFORM_DISCOUNT'}">
                           <span style="font-size: 15px;"> (活动库存${productProxy.price.remainStock}件)</span>
                        </c:when>
                        <c:otherwise>
                            <c:choose>
                                <c:when test="${(productProxy.skus[0].price.remainStock)<=0}">
                                    <span id="stock" style="font-size: 15px;">(库存0件)</span>
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${sdk:getIsPlatformDiscount(param.id)&&!productProxy.price.isSpecialPrice}">
                                            <span  style="font-size: 15px;">  (活动库存0件)</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span id="stock" style="font-size: 15px;">(库存${(productProxy.skus[0].price.remainStock)}件)</span>
                                        </c:otherwise>
                                    </c:choose>
                                </c:otherwise>
                            </c:choose>
                        </c:otherwise>
                    </c:choose>
                    <input type="hidden" id="priceListStr" priceNm="${productProxy.price.amountNm}" value="${productProxy.priceListStr}">

                    <c:if test="${isWeixin!='Y'}">
                        <%-- 分享按钮,如果是微信内显示的话就隐藏，因为微信有自己的分享按钮 ，2017年1月11日有缺陷暂时隐藏--%>
                        <%--<a href="#" data-toggle="modal" data-target="#share" class="share" onclick="$('.baiduShare').css('display','block')"></a>--%>
                    </c:if>
                </div>
                <div class="old-price">
                    价格：<del id="marketPrice">¥${productProxy.marketPrice}</del>
                </div>

                <!-- 分享的div -->
                <c:if test="${isWeixin!='Y'}">
                    <%--<div class="modal fade" id="share" tabindex="-1" role="dialog"
                         aria-labelledby="myModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-body">
                                    <div class="jiathis_style_m"></div>
                                    <script type="text/javascript" src="http://v3.jiathis.com/code/jiathis_m.js" charset="utf-8"></script>
                                    &nbsp;
                                </div>
                            </div>
                        </div>
                    </div>--%>
                </c:if>
                <div class="promotion" style="display: ${isDisplayPromotion}">
                    <span >促 &nbsp; 销：</span>
                    <div class="promotion-content ruleDown" >
                        <div class="pro-item firstBenifit">
                            <c:forEach items="${availableBusinessRuleList}" var="rule" varStatus="i">
                                <c:choose>
                                    <c:when test="${rule.ruleTypeCode=='0'||rule.ruleTypeCode=='1'||rule.ruleTypeCode=='2'}">
                                        <i class="label-icon-div">折扣</i>
                                    </c:when>
                                    <c:when test="${rule.ruleTypeCode=='3'||rule.ruleTypeCode=='4'||rule.ruleTypeCode=='5'}">
                                        <i class="label-icon-div">包邮</i>
                                    </c:when>
                                    <c:when test="${rule.ruleTypeCode=='6'||rule.ruleTypeCode=='7'||rule.ruleTypeCode=='8'}">
                                        <i class="label-icon-div">赠品</i>
                                    </c:when>
                                    <c:when test="${rule.ruleTypeCode=='12'||rule.ruleTypeCode=='13'||rule.ruleTypeCode=='14'||rule.ruleTypeCode=='15'}">
                                        <i class="label-icon-div">送券</i>
                                    </c:when>
                                </c:choose>
                                <%--<c:when test="${rule.ruleTypeCode=='9'||rule.ruleTypeCode=='10'||rule.ruleTypeCode=='11'}">换购</c:when>--%>
                                <%--<c:when test="${rule.ruleTypeCode=='16'||rule.ruleTypeCode=='17'||rule.ruleTypeCode=='18'}">用券</c:when>--%>
                                <%--<c:when test="${rule.ruleTypeCode=='19'||rule.ruleTypeCode=='20'||rule.ruleTypeCode=='21'}">送积分</c:when>--%>
                            </c:forEach>
                        </div>
                        <%-- 这个地方暂时不启用，因为单品赠品显示图片比较简单，订单赠品现实很麻烦；而且订单赠品需要说明获取条件，不能只是简单地显示赠品的 --%>
                        <%-- 只考虑单品赠品的情况 --%>
                        <%--<c:if test="${not empty productProxy.presentProductList}">
                            <div class="pro-item">
                                <i class="label-icon-div">赠品</i>
                                <c:forEach items="${productProxy.presentProductList}" var="present">
                                    <em class="dt-div">
                                        <div class="pic"><a href="${webRoot}/wap/product.ac?id=${present.productId}"><img src="${bdw:getProductImageUrl(present.productId)}" style="height: 100%;width:100%"></a></div>
                                        <a href="${webRoot}/wap/product.ac?id=${present.productId}" class="gift-name elli">${present.productNm}</a>
                                    </em>
                                </c:forEach>
                            </div>
                        </c:if>--%>

                    </div>
                    <div class="promotion-content1" style="display: none" >
                        <c:forEach items="${availableBusinessRuleList}" var="rule" varStatus="i">
                            <c:choose>
                                <c:when test="${rule.ruleTypeCode=='0'||rule.ruleTypeCode=='1'||rule.ruleTypeCode=='2'}">
                                    <div class="pro-item1 notFirst" >
                                        <i class="label-icon-div">折扣</i>
                                        <em class="dt-div">${rule.businessRuleNm}&nbsp;
                                            <%--<c:if test="${not empty rule.descr}">--%>
                                                <%--(${rule.descr})--%>
                                            <%--</c:if>--%>
                                        </em>
                                    </div>
                                </c:when>
                                <c:when test="${rule.ruleTypeCode=='3'||rule.ruleTypeCode=='4'||rule.ruleTypeCode=='5'}">
                                    <div class="pro-item1 notFirst" >
                                        <i class="label-icon-div">包邮</i>
                                        <em class="dt-div">${rule.businessRuleNm}&nbsp;
                                            <%--<c:if test="${not empty rule.descr}">--%>
                                                <%--(${rule.descr})--%>
                                            <%--</c:if>--%>
                                        </em>
                                    </div>
                                </c:when>
                                <c:when test="${rule.ruleTypeCode=='6'||rule.ruleTypeCode=='7'||rule.ruleTypeCode=='8'}">
                                    <div class="pro-item1 notFirst" >
                                        <i class="label-icon-div">赠品</i>
                                        <em class="dt-div">${rule.businessRuleNm}&nbsp;
                                            <%--<c:if test="${not empty rule.descr}">--%>
                                                <%--(${rule.descr})--%>
                                            <%--</c:if>--%>
                                        </em>

                                    </div>
                                </c:when>
                                <c:when test="${rule.ruleTypeCode=='12'||rule.ruleTypeCode=='13'||rule.ruleTypeCode=='14'||rule.ruleTypeCode=='15'}">
                                    <div class="pro-item1 notFirst" >
                                        <i class="label-icon-div">送券</i>
                                        <em class="dt-div">${rule.businessRuleNm}&nbsp;
                                            <%--<c:if test="${not empty rule.descr}">--%>
                                                <%--(${rule.descr})--%>
                                            <%--</c:if>--%>
                                        </em>
                                    </div>
                                </c:when>
                            </c:choose>
                        </c:forEach>

                        <%-- 这个地方暂时不启用，因为单品赠品显示图片比较简单，订单赠品现实很麻烦；而且订单赠品需要说明获取条件，不能只是简单地显示赠品的 --%>
                        <%-- 只考虑单品赠品的情况 --%>
                        <%--<c:if test="${not empty productProxy.presentProductList}">
                            <div class="pro-item">
                                <i class="label-icon-div">赠品</i>
                                <c:forEach items="${productProxy.presentProductList}" var="present">
                                    <em class="dt-div">
                                        <div class="pic"><a href="${webRoot}/wap/product.ac?id=${present.productId}"><img src="${bdw:getProductImageUrl(present.productId)}" style="height: 100%;width:100%"></a></div>
                                        <a href="${webRoot}/wap/product.ac?id=${present.productId}" class="gift-name elli">${present.productNm}</a>
                                    </em>
                                </c:forEach>
                            </div>
                        </c:if>--%>

                    </div>
                </div>

            </div>
            <div class="m-step2-box">
                <div class="m-step2 specSelect">
                    <c:if test="${productProxy.isEnableMultiSpec=='Y'}">
                        <c:forEach items="${specList}" var="spec">
                            <div class="mp2-item">
                                <span>${spec.name}：</span>
                                <c:forEach items="${spec.specValueProxyList}" var="specValue">
                                    <c:if test="${spec.specType eq '0'}">
                                        <a title="${specValue.name}" href="javascript:" data-value="${spec.specId}:${specValue.specValueId}" class="gg_btn">
                                            ${specValue.value}
                                            <%--<c:if test="${spec.specType eq '1'}"><img width='30' height='30' src="${specValue.value}" style="width: 100%;height: 100%"/></c:if>--%>
                                        </a>
                                    </c:if>
                                    <c:if test="${spec.specType eq '1'}">
                                        <a title="${specValue.name}" href="javascript:" data-value="${spec.specId}:${specValue.specValueId}" class="gg_btn" style="width: 30px;height: 30px;padding: 0;">
                                            <%--<c:if test="${spec.specType eq '0'}">${specValue.value}</c:if>--%>
                                            <img width='30' height='30' src="${specValue.value}" style="width: 100%;height: 100%"/>
                                        </a>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </c:forEach>
                    </c:if>

                    <div class="quantity">
                        <span class="before">数量：</span>
                        <a href="javascript:" class="quantity-decrease prd_subNum">-</a>
                        <input type="num" value="1" class="prd_num" maxlength="4">
                        <a href="javascript:" class="quantity-increase prd_addNum">+</a>
                        <%--<span class="quehuoNotify after" style="display:none">(缺货)</span>--%>
                    </div>
                </div>
            </div>


            <%--<div class="package">
            </div>--%>

            <!--店铺-->
            <div class="store">
                <div class="s-logo"><img src="${shopInf.images[0]["100X100"]}" style="height: 100%;width:100%"></div>
                <span class="name">${shopInf.shopNm}</span>
                <div class="st-mc">
                    <div class="st-item">
                        <span>${totalProductNum}</span><br>
                        <em>全部商品</em>
                    </div>
                    <div class="st-item">
                        <span>${newProductNum}</span><br>
                        <em>新品上架</em>
                    </div>
                    <div class="st-item">
                        <span>${discountProductNum}</span><br>
                        <em>促销商品</em>
                    </div>
                </div>
                <div class="st-mb">
                    <a href="javascript:void(0);" id="shopCollect" class="shopCollect ${shop.collect ? 'cur' : ''}" shopId="${shop.shopInfId}" isCollect="${shop.collect}">${shop.collect ? '已收藏' : '收藏店铺'}</a>
                    <a href="${webRoot}/wap/module/shop/index.ac?shopId=${shopInf.shopInfId}">进店逛逛</a>
                </div>
            </div>

            <!--搭配推荐-->
            <c:set value="${productProxy.referSkuList}" var="referProductList"></c:set>
            <c:if test="${not empty referProductList}">
                <div class="recommend">
                    <input type="hidden" id="dapei_skuId" value="<c:if test="${productProxy.isEnableMultiSpec=='N'}">${productProxy.skus[0].skuId}</c:if>">
                    <input type="hidden" id="dapei_skuprice" value="<c:if test="${productProxy.isEnableMultiSpec=='N'}">${productProxy.price.unitPrice}</c:if>">
                    <div class="mt"><span>推荐搭配</span></div>
                    <div class="mc" id="refer">
                        <div class="mc-top" id="dapei">
                            <c:set value="${fn:length(referProductList)*105+105}" var="divWidth"/>
                            <c:set value="${productProxy.priceListStr}" var="priceStr"/>
                            <ul style="width: ${divWidth}px"><!-- ul的宽度为动态 等于li 的个数乘以 105px -->
                                <li>
                                    <a href="${webRoot}/wap/product.ac?id=${productProxy.productId}" class="pic"><img src="${productProxy.defaultImage["80X80"]}" style="width: 80px;height: 80px"></a>
                                    <div class="title"><a href="${webRoot}/wap/product.ac?id=${productProxy.productId}">${productProxy.name}</a></div>
                                        <%--<c:choose>
                                            <c:when test="${fn:indexOf(priceStr,'-')>0}">
                                                <span id="packagePrice">¥${fn:substringBefore(priceStr,"-")}起</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span id="packagePrice">¥${productProxy.priceListStr}</span>
                                            </c:otherwise>
                                        </c:choose>--%>
                                    <span id="packagePrice">¥${productProxy.priceListStr}</span>
                                </li>
                                <c:forEach items="${referProductList}" var="refPrd" varStatus="num">
                                    <li>
                                        <a href="${webRoot}/wap/product.ac?id=${refPrd.productId}" class="pic"><img src="${refPrd.defaultImage["80X80"]}" style="width: 80px;height: 80px"></a>
                                        <div class="title"><a href="${webRoot}/wap/product.ac?id=${refPrd.productId}">${refPrd.name}</a></div>
                                        <span>¥${refPrd.price.unitPrice}</span>
                                        <input type="checkbox" class="sel" name="packageItem" skuid="${refPrd.skus[0].skuId}" value="${refPrd.price.unitPrice}"></input>
                                    </li>
                                </c:forEach>
                            </ul>
                            <script type="text/javascript">
                                var referProductListNoCheck = function () {
                                    $("#refer input[type='checkbox']").each(function () {
                                        $(this).attr("checked", false);
                                    });
                                }();
                            </script>
                        </div>
                        <div class="mc-bot">
                                    <a href="javascript:" class="batch_addcart enable" id="dapeiCart" carttype="normal" handler="sku">购买搭配套餐</a>
                            <p>您已购买<i id="selectNum">0</i>个自由搭配组合</p>
                            <p>搭配价：<span><em id="dapeiprice">0.0</em></span></p>
                        </div>
                    </div>
                </div>
            </c:if>

            <%-- 组合商品 --%>
            <c:set value="${productProxy.combos}" var="combos"/>
            <c:if test="${not empty combos}">
                <div class="recommend">
                    <div class="mt"><span>组合套餐</span></div>
                    <c:set value="${fn:length(combos)*105+105}" var="divWidth"/>
                    <div class="mc">
                            <%--<ul class="nav nav-tabs nav-justified">
                                <c:forEach items="${combos}" var="combo" varStatus="s">
                                    <li <c:if test="${s.index == 0}">class="active"</c:if>><a href="javascript:void(0);" data-toggle="tab" class="text-danger" comboid="${combo.comboId}" onclick="triggerComboTab(${combo.comboId})"><strong>${combo.title}</strong></a></li>
                                </c:forEach>
                            </ul>--%>
                        <c:forEach items="${combos}" var="cont_combo" varStatus="cs">
                            <div class="mc-top">
                                <div id="${cont_combo.comboId}" <%--class="tab-pane fade <c:if test="${cs.index eq 0}">in active</c:if>"--%>>
                                    <ul style="width: ${divWidth}px;">
                                          <c:forEach items="${cont_combo.skus}" var="sku" varStatus="ss">
                                            <li>
                                                <a href="${webRoot}/wap/product.ac?id=${sku.productProxy.productId}" class="pic"><img src="${sku.productProxy.defaultImage["120X120"]}" style="width: 80px;height: 80px;"/></a>
                                                <div class="title"><a href="${webRoot}/wap/product.ac?id=${sku.productProxy.productId}">${sku.productProxy.name}</a></div>
                                                <span class="comboPrice">￥${sku.price.unitPrice} × ${sku.amountNum}</span>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </div>
                            <%--组合商品总价计算--%>
                            <div class="mc-bot">
                                <c:choose>
                                    <c:when test="${'false' eq cont_combo.isBuy }">
                                        <a href="javascript:" class=" noenable" disabled="disabled">缺货</a>

                                    </c:when>
                                    <c:otherwise>
                                        <a href="javascript:" class="combo_addcart enable" id="comboAddCart${cs.count}" skuid="${cont_combo.comboId}" handler="combo" carttype="normal" num="1" count="${cs.count}">购买组合套餐</a>
                                    </c:otherwise>
                                </c:choose>

                                <p>套餐价格：<span><i>￥</i>${cont_combo.price}</span></p>
                                <p>为您节省：<span><i>￥</i>${cont_combo.saveMoney}</span></p>
                            </div>
                            <hr>
                        </c:forEach>
                    </div>
                </div>
            </c:if>

        </div>

        <!--商品详情-->
        <div class="cont-m2" id="sell" style="display: none">
            <div class="alert alert-danger fade in" id="descriptionAlert">
                <h4 style="font-size: 18px;">温馨提示!</h4>
                <p style="font-size: 16px;">浏览商品详情会产生较大的流量，建议您在Wifi网络中使用.</p>
                <p>
                    <button type="button" class="btn btn-danger btn-sm" id="openDescription"><span class="glyphicon glyphicon-ok"/> 继续查看</button>
                </p>
            </div>
            <div style="display: none; word-wrap: break-word;" id="productDescription"></div>
        </div>

        <!--商品属性-->
        <div class="cont-m3" id="sell2" style="display: none;font-size: 13px;">
        <c:choose>
            <c:when test="${productProxy.jdProductCode != null || !productProxy.jdProductCode  eq 'null'}">
                <ul class="b_info">
                    <table class="table size" style="margin-top: 0px;margin-bottom: 0px;">
                        <tbody>

                        </tbody>
                    </table>
                    <div class="clear"></div>
                </ul>
                <!-- 这是威榕大佬让我这样写的,不美观不要怪我 -->
                <script type="text/javascript">
                    var dataParam = [];
                    var paramHtml = "${productProxy.paramHtml}";
                    if(paramHtml) {
                        var data = paramHtml.split(",");
                        for (var index in data) {
                            var param = {};
                            param.name = data[index].split("：")[0];
                            param.value = data[index].split("：")[1];
                            dataParam.push(param);
                        }
                        for (var i = 0; i < dataParam.length; i++) {
                            $(".b_info table tbody").append('<tr><td class="size_td" style="text-align:right; padding-right:13px; width:45%;" >' + dataParam[i].name + '</td> <td style="width:55%;">' + dataParam[i].value + '</td> </tr>');
                        }
                    }
                </script>
            </c:when>
            <c:otherwise>
                <c:if test="${not empty attrGroupProxyList}">
                    <c:forEach items="${attrGroupProxyList}" var="attrGroupProxy" >
                        <c:if test="${not empty attrGroupProxy.dicValues}">
                            <table class="table size" style="margin-top: 0px;margin-bottom: 0px;">
                                    <%--<thead>
                                    <tr>
                                    <td colspan="2" class="size-title" >${attrGroupProxy.attrGroupNm}</td>
                                    </tr>
                                    </thead>--%>
                                <tbody>
                                <c:forEach items="${attrGroupProxy.dicValues}" var="attrDict">
                                    <c:if test="${not empty attrGroupProxy.dicValueMap[attrDict.innerCode].valueString}">
                                        <tr>
                                            <td class="size_td" style="text-align:right; padding-right:13px; width:45%;" >${attrDict.name}</td>
                                            <td style="width:55%;">
                                                <c:if test="${!empty attrGroupProxy.dicValueMap}">
                                                    ${attrGroupProxy.dicValueMap[attrDict.innerCode].valueString}
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                                </tbody>
                            </table>
                        </c:if>
                    </c:forEach>
                </c:if>
            </c:otherwise>
        </c:choose>


        </div>

        <!--用户评价-->
        <div class="cont-m4" id="priceM" style="display: none"></div>
    </div>
</div>

<div class="popup baiduShare"  style="display:none" >
    <div class="select-layer">
        <div class="mt"><div class="div_l"></div><div class="div_c">分享推广到</div><div class="div_r"></div></div>
        <div class="mc">
            <ul>
                <li><label class="checkbox">
                    <div class="bdsharebuttonbox" data-tag="share_1">
                        <a class="bds_weixin" data-cmd="weixin"></a>
                        <a class="bds_sqq" data-cmd="sqq" href="#"></a>
                        <a class="bds_qzone" data-cmd="qzone" href="#"></a>
                        <a class="bds_tsina" data-cmd="tsina"></a>
                        <a class="bds_tqq" data-cmd="tqq"></a>
                        <%--<a class="bds_more" data-cmd="more">更多</a>--%>
                    </div>
                </label></li>
            </ul>
        </div>
        <a href="javascript:void(0);" class="confirm">取消</a>
    </div>
</div>

<!--底部导航-->
<c:choose>
    <c:when test="${not empty loginUser}">
        <!-- 用户已登录 -->
        <div class="dt-bottom">
            <a href="javascript:void(0);" id="AddTomyLikeBtn" class="collect">收藏</a>
            <c:choose>
                <c:when test="${not empty shop.tel}">
                    <a href="tel:${shop.tel}" class="service">客服</a>
                </c:when>
                <c:otherwise>
                    <c:choose>
                        <c:when test="${not empty shop.mobile}">
                            <a href="tel:${shop.mobile}" class="service" >客服</a>
                        </c:when>
                        <c:otherwise>
                            <a href="javascript:void(0);" class="service" onclick="noCustomService()">客服</a>
                        </c:otherwise>
                    </c:choose>
                </c:otherwise>
            </c:choose>
            <a href="javascript:void(0);" class="my-cart" onclick="window.location.href='${webRoot}/wap/shoppingcart/cart.ac?time='+ new Date().getTime()">购物车</a>
            <div class="quehuo" style="${productProxy.isCanBuy ? 'display:none':''}" >
                <c:choose>
                    <c:when test="${isWeixin == 'Y'}">
                        <a href="javascript:void(0);" class="quehuobtnWeixin" skuid="${productProxy.isEnableMultiSpec=='Y' ?  '': productProxy.skus[0].skuId}" style="background-color: #8a8a8a;color:#fff">缺货</a>
                    </c:when>
                    <c:otherwise>
                        <c:choose>
                            <c:when test="${empty loginUser.mobile || empty loginUser.email}">
                                <a href="javascript:void(0);" class="mobileMessageBtn" id="withoutMobile">短信通知</a>
                                <a href="javascript:void(0);" class="quehuobtn buy-btn" id="withoutEmail">邮件通知</a>
                            </c:when>
                            <c:otherwise>
                                <a href="javascript:void(0);" class="mobileMessageBtn" id="mobileMessageBtn" type="submit" skuid="${productProxy.isEnableMultiSpec=='Y' ?  '': productProxy.skus[0].skuId}">短信通知</a>
                                <a href="javascript:void(0);" class="quehuobtn buy-btn" id="quehuobtn" type="submit" skuid="${productProxy.isEnableMultiSpec=='Y' ?  '': productProxy.skus[0].skuId}">邮件通知</a>
                            </c:otherwise>
                        </c:choose>
                    </c:otherwise>
                </c:choose>
            </div>
            <div style="${productProxy.isCanBuy ? '':"display:none"}">
                <a href="javascript:void(0);" id="addcart2" class="buy-btn addcart2" skuid="${productProxy.isEnableMultiSpec=='Y' ?  '': productProxy.skus[0].skuId}"  num="1" carttype="normal" handler="sku">立即购买</a>
            </div>
            <div class="addTobuyCar" style="${productProxy.isCanBuy ? '':"display:none"}">
                <a href="javascript:void(0);" id="addcartButton" class="cart-btn addcart addTobuyCar" skuid="${productProxy.isEnableMultiSpec=='Y' ?  '': productProxy.skus[0].skuId}"  num="1" carttype="normal" handler="sku">加入购物车</a>
            </div>
        </div>
    </c:when>
    <c:otherwise>
        <!-- 用户未登录 -->
        <div class="dt-bottom">
            <a href="javascript:void(0);" class="collect" onclick="window.location.href='${webRoot}/wap/login.ac';">收藏</a>
            <c:choose>
                <c:when test="${not empty shop.tel}">
                    <a href="tel:${shop.tel}" class="service">客服</a>
                </c:when>
                <c:otherwise>
                    <c:choose>
                        <c:when test="${not empty shop.mobile}">
                            <a href="tel:${shop.mobile}" class="service" >客服</a>
                        </c:when>
                        <c:otherwise>
                            <a href="javascript:void(0);" class="service" onclick="noCustomService()">客服</a>
                        </c:otherwise>
                    </c:choose>
                </c:otherwise>
            </c:choose>
            <a href="javascript:void(0);" class="my-cart" onclick="window.location.href='${webRoot}/wap/login.ac';">购物车</a>
            <c:choose>
                <c:when test="${productProxy.isCanBuy}">
                    <a href="javascript:void(0);" id="addcart2" class="buy-btn addcart2" >立即购买</a>
                    <a href="javascript:void(0);" id="addcartButton" class="cart-btn addcart addTobuyCar" style="${productProxy.isCanBuy ? '':"display:none"}" >加入购物车</a>
                </c:when>
                <c:otherwise>
                    <a href="${webRoot}/wap/login.ac" class="mobileMessageBtn">短信通知</a>
                    <a href="${webRoot}/wap/login.ac" class="quehuobtn buy-btn">邮件通知</a>
                </c:otherwise>
            </c:choose>
        </div>
    </c:otherwise>
</c:choose>
</body>
<%--<div style='margin:0 auto;width:0px;height:0px;overflow:hidden;'>
    <img src="http://www.pptbz.com/pptpic/UploadFiles_6909/201110/20111014111307895.jpg" width='700'>
</div>--%>
</html>
<script type="text/javascript">
    /*轮播图*/
    var swiper01 = new Swiper('.m-pic', {
        pagination: '.swiper-pagination',/*分页器*/
        slidesPerView: 1,
        paginationClickable: true,/*点击那几个小点*/
        autoplay : 2000,
        loop : true,
        paginationType: 'fraction'
    });
</script>


