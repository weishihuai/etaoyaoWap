<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<jsp:useBean id="now" class="java.util.Date"/>
<!DOCTYPE html>
<html>

<c:set value="${empty param.firstLogin ? 0 : 1}" var="newComer"/>
<c:set var="defaultProductProxy" value="${bdw:getFirstPromotionProductProxy()}"/>
<c:set var="promotionProductProxies" value="${sdk:findPageModuleProxy('sy_panic_buy').recommendPromotionProducts}"/>
<c:set value="${empty promotionProductProxies ? 1:fn:length(sdk:findPageModuleProxy('sy_panic_buy').recommendPromotionProducts)}" var="promotionAmount"/>
<c:set value="${sdk:getLoginUser()}" var="userProxy"/>

<head>
    <meta property="qc:admins" content="3553273717624751446375" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}-${webName}"/>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}-${webName}"/>
    <title>${sdk:getSysParamValue('index_title')}</title>

    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css" />
    <%--<link href="${webRoot}/template/bdw/statics/css/base.css" rel="stylesheet" type="text/css"/>--%>
    <%--<link href="${webRoot}/template/bdw/statics/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>--%>
    <link href="${webRoot}/template/bdw/statics/js/easydialog/easydialog.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/new-index.css" rel="stylesheet" type="text/css"/>

    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/jqGrid/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.ld.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/easydialog/easydialog.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.lazyload.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.cycle.all.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/new-index.js"></script>

    <script type="text/javascript">
        var newComer = ${newComer};
        <%--var promotionAmount = ${fn:length(sdk:findPageModuleProxy('sy_panic_buy').recommendPromotionProducts)};--%>
        var promotionAmount = ${promotionAmount};
    </script>
</head>
<body>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp?p=index"/>
<!--页头结束-->

<!--主体-->
<div class="main-bg">
    <div class="main">
        <div class="main-top">
            <div class="mt-slider">
                <div class="slider-cont frameEdit" frameInfo="sy_main_banner">
                    <c:set value="${sdk:findPageModuleProxy('sy_main_banner').advt.advtProxy}" var="sy_main_banner"/>
                    <div class="slider-list">
                        <ul>
                            <c:forEach items="${sy_main_banner}" var="banner" varStatus="s">
                                <c:choose>
                                    <c:when test="${s.index == 0}">
                                        <li id="${s.count}">
                                                ${banner.htmlTemplate}
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                        <li id="${s.count}">
                                                ${banner.htmlTemplate}
                                        </li>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </ul>
                    </div>
                    <div class="slider-indicator">
                        <c:forEach items="${sy_main_banner}" var="banner" varStatus="s">
                            <span class="<c:if test="${s.index == 0}">cur</c:if>"></span>
                        </c:forEach>
                    </div>
                    <a href="javascript:;" class="slider-control-prev"></a>
                    <a href="javascript:;" class="slider-control-next"></a>
                </div>
                <div class="slider-extend frameEdit" frameInfo="sy_gg_banner_down">
                    <c:forEach items="${sdk:findPageModuleProxy('sy_gg_banner_down').advt.advtProxy}" var="advt" varStatus="s" end="3">
                        <div class="box">
                                ${advt.htmlTemplate}
                        </div>
                    </c:forEach>
                </div>
            </div>
            <div class="mt-rt">
                <c:choose>
                    <c:when test="${empty userProxy}">
                        <div class="rt-top">
                            <div class="pic"><img src="${webRoot}/template/bdw/statics/images/mrtx.png" ></div>
                            <p>Hi，欢迎来到易淘药</p>
                            <div class="btn-box">
                                <input class="btn1" type="button" value="登录" onclick="window.location.href='${webRoot}/login.ac';">
                                <input class="btn2" type="button" value="注册" onclick="window.location.href='${webRoot}/register.ac';">
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="mt-pr">
                            <div class="pic"><img src="${userProxy.icon['80X80']}" alt=""></div>
                            <p class="p-name">Hi，${userProxy.userName}</p>
                            <div class="fsp-box">
                                <div class="mt-pr-f">
                                    <a href="${webRoot}/module/member/orderList.ac?pitchOnRow=11">
                                        <p>${userProxy.unPayOrderCount}</p>
                                        <span>待付款</span>
                                    </a>
                                </div>
                                <div class="mt-pr-s">
                                    <a href="${webRoot}/module/member/orderList.ac?pitchOnRow=11">
                                        <p>${userProxy.confirmedOrderCount}</p>
                                        <span>待收货</span>
                                    </a>
                                </div>
                                <div class="mt-pr-p">
                                    <a href="${webRoot}/module/member/orderList.ac?pitchOnRow=11">
                                        <p>${userProxy.commentOrderCount}</p>
                                        <span>待评价</span>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>

                <div class="rt-info">
                    <div class="info-nav frameEdit" frameInfo="sy_link1_banner_right">
                        <a class="info-nav-l" href="javascript:;">
                            <c:forEach items="${sdk:findPageModuleProxy('sy_link1_banner_right').links}" var="link" varStatus="s" end="0">
                                ${fn:substring(link.title, 0, 7)}
                            </c:forEach>
                        </a>
                        <a class="info-nav-r" href="${webRoot}/newsList-54981.html" target="_blank">更多</a>
                    </div>
                    <div class="tabpane frameEdit" frameInfo="sy_link_panel1_banner_right">
                        <div class="info-cont">
                           <c:set value="${sdk:getArticleCategoryById(54981)}" var="articleCategory"/>
                           <c:forEach items="${articleCategory.top10}" var="article" end="4">
                               <c:choose>
                                   <c:when test="${not empty article.externalLink}">
                                       <a href="${article.externalLink}" class="item elli" title="${article.title}" target="_blank">${article.title}</a>
                                   </c:when>
                                   <c:otherwise>
                                       <a href="${webRoot}/newsDetails-${article.categoryId}-${article.infArticleId}.html" class="item elli" target="_blank" title="${article.title}" ><span></span>${article.title}</a>
                                   </c:otherwise>
                               </c:choose>
                           </c:forEach>
                        </div>
                    </div>
                </div>
                <div class="fc-tion frameEdit" frameInfo="sy_gg_banner_right">
                    <c:forEach items="${sdk:findPageModuleProxy('sy_gg_banner_right').advt.advtProxy}" var="advt" varStatus="s" end="5" >
                        <div class="item">
                            <a href="${advt.link}" target="_blank">
                                <img src="${advt.advUrl}">
                                <p>${advt.title}</p>
                            </a>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>

        <!--限时特价-->
        <c:choose>
            <c:when test="${empty defaultProductProxy}">
                <%--没有促销商品此时促销div不要显示--%>
            </c:when>
            <c:when test="${!empty defaultProductProxy && fn:length(promotionProductProxies) == 0}">
                <div class="recommend-box">
                    <div class="recommend">
                        <div class="time-box">距离本场结束还有：<span>0</span>天<span>00</span>时<span>00</span>分<span>00</span>秒</div>
                        <div class="goods-box">
                            <!-- ul宽度为 li个数乘以238px -->
                            <ul class="in-time-goods frameEdit" frameInfo="sy_panic_buy"  style="width: 300%;" >
                                <c:set value="${defaultProductProxy.marketingActivity.activityEndTimeString}" var="endDate"/>
                                <li endDate="${endDate}" id="promotion1">
                                    <a href="${webRoot}/product-${defaultProductProxy.productId}.html" target="_blank" title="${defaultProductProxy.name}">
                                        <div class="g-pic">
                                            <img src="${defaultProductProxy.images[0]['160X160']}"  alt="${defaultProductProxy.name}">
                                        </div>
                                        <div class="g-title elli">${defaultProductProxy.name}</div>
                                        <div class="g-price"><span class="num"><i>￥</i>${defaultProductProxy.price.unitPrice}</span>
                                            <span class="zhe"><i><fmt:formatNumber  value="${defaultProductProxy.price.unitPrice/defaultProductProxy.price.originalUnitPrice*10}" type="number" pattern="#.#" minFractionDigits="1" /><b>折</b></i></span></div>
                                    </a>
                                    <a href="${webRoot}/product-${defaultProductProxy.productId}.html" class="get-now" target="_blank">立即抢购</a>
                                </li>
                            </ul>
                            <c:if test="${fn:length(promotionProductProxies) > 5}">
                                <a href="javascript:;" class="slider-control-prev"></a>
                                <a href="javascript:;" class="slider-control-next"></a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="recommend-box">
                    <div class="recommend">
                        <div class="time-box">距离本场结束还有：<span>0</span>天<span>00</span>时<span>00</span>分<span>00</span>秒</div>
                        <div class="goods-box">
                            <!-- ul宽度为 li个数乘以238px -->
                            <ul class="in-time-goods frameEdit"  frameInfo="sy_panic_buy" style="width: 300%;">
                                <c:forEach items="${promotionProductProxies}" var="productProxy" varStatus="s">
                                    <c:set value="${productProxy.marketingActivity.activityEndTimeString}" var="endDate"/>
                                    <li endDate="${endDate}" id="promotion${s.count}" >
                                        <a href="${webRoot}/product-${productProxy.productId}.html" target="_blank"  title="${productProxy.name}">
                                            <div class="g-pic">
                                                <img src="${productProxy.images[0]['160X160']}" alt="${productProxy.name}">
                                            </div>
                                            <div class="g-title elli">${productProxy.name}</div>
                                            <div class="g-price">
                                                <span class="num"><i>￥</i>${productProxy.price.unitPrice}</span>
                                                <span class="zhe"><i><fmt:formatNumber  value="${productProxy.price.unitPrice/productProxy.marketPrice*10}" type="number" pattern="#.#" minFractionDigits="1" /><b>折</b></i></span>
                                            </div>
                                        </a>
                                        <a href="${webRoot}/product-${productProxy.productId}.html" target="_blank" class="get-now">立即抢购</a>
                                    </li>
                                </c:forEach>
                            </ul>
                            <c:if test="${fn:length(promotionProductProxies) > 5}">
                                <a href="javascript:;" class="slider-control-prev"></a>
                                <a href="javascript:;" class="slider-control-next"></a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>

        <div class="main-rec frameEdit" frameInfo="sy_middle_top_gg">
            <c:forEach items="${sdk:findPageModuleProxy('sy_middle_top_gg').advt.advtProxy}" var="advt" varStatus="s" end="1">
                <div <c:if test="${s.index==0}">class="rec-lt"</c:if> <c:if test="${s.index==1}">class="rec-rt"</c:if>>
                        ${advt.htmlTemplate}
                </div>
            </c:forEach>
        </div>
        <div class="main-common">
            <c:forEach begin="1" end="3" varStatus="s">
                <c:set var="sy_middle_down_gg" value="sy_middle_down_gg${s.index}" />
                <c:set var="sy_middle_down_link" value="sy_middle_down_link${s.index}" />
                <div class="item">
                    <div class="pic frameEdit" frameInfo="${sy_middle_down_gg}">
                        <c:forEach items="${sdk:findPageModuleProxy(sy_middle_down_gg).advt.advtProxy}" var="advt" varStatus="s" end="0">
                            <h5>${advt.title}</h5>
                            <p>${advt.advtHint}</p>
                            <img src="${advt.advUrl}" alt="">
                        </c:forEach>
                    </div>
                    <ul class="cont frameEdit" frameInfo="${sy_middle_down_link}">
                        <c:forEach items="${sdk:findPageModuleProxy(sy_middle_down_link).links}" var="link" end="11">
                            <li><a href="${link.link}" <c:if test="${link.newWin}">target="_blank" </c:if> >${link.title}</a></li>
                        </c:forEach>
                    </ul>
                </div>
            </c:forEach>
        </div>

        <!--楼层广告-->
        <c:set value="${5}" var="floorAmount"/>  <%-- 这里定义楼层的数量，以后如果石药觉得楼层多了或者少了直接来这里修改就行了，默认5层 --%>

        <c:forEach begin="1" end="${floorAmount}" varStatus="s">
            <c:set var="sy_floor_title" value="sy_floor${s.index}_title" />
            <c:set var="sy_floor_quickSearch" value="sy_floor${s.index}_quickSearch" />
            <c:set var="sy_floor_pic" value="sy_floor${s.index}_pic" />
            <c:set var="sy_gg_floor" value="sy_gg_floor${s.index}" />
            <c:set var="sy_gg2_floor" value="sy_gg2_floor${s.index}" />
            <c:set var="sy_floor_recommend" value="sy_floor${s.index}_recommend" />
            <c:set var="sy_floor_hotSaleWeek" value="sy_floor${s.index}_hotSaleWeek" />
            <c:set var="sy_floor_brand" value="sy_floor${s.index}_brand" />
            <c:set var="sy_floor_hotSaleCate" value="sy_floor${s.index}_hotSaleCate" />
            <div class="floor fl-m${s.index}" id="floor${s.index}">
                <div class="mt">
                    <span>${s.index}F</span>
                    <h5 class="frameEdit" frameInfo="${sy_floor_title}">
                        <c:forEach items="${sdk:findPageModuleProxy(sy_floor_title).links}" var="link" end="0">
                            ${link.title}
                        </c:forEach>
                    </h5>
                    <div style="float: right;height: 21px;margin-top: 20px;width:255px;" class="frameEdit" frameInfo="${sy_floor_quickSearch}">
                        <ul >
                            <c:forEach items="${sdk:findPageModuleProxy(sy_floor_quickSearch).links}" var="link" end="4" varStatus="status">
                                <li><a href="${link.link}" <c:if test="${link.newWin}">target="_blank" </c:if> >${link.title}</a></li>
                                <c:if test="${!status.last}">
                                    <li>|</li>
                                </c:if>
                            </c:forEach>
                        </ul>
                    </div>

                </div>
                <div class="mc">
                    <c:set value="${sdk:findPageModuleProxy(sy_floor_pic).advt.advtProxy}" var="floorPic"/>
                        <%--<c:set value="${(fn:length(floorPic))>0 ? floorPic[0].advtHint:''}" var="back"/>--%>
                    <div class="mc-lt">
                        <div class="pic frameEdit" frameInfo="${sy_floor_pic}">
                            <c:forEach items="${floorPic}" var="advt" end="0">
                                ${advt.htmlTemplate}
                            </c:forEach>
                        </div>
                        <div class="hot frameEdit" frameInfo="${sy_floor_hotSaleCate}">
                            <c:forEach items="${sdk:findPageModuleProxy(sy_floor_hotSaleCate).links}" var="link">
                                <a href="${link.link}" title="${link.title}"  <c:if test="${link.newWin}">target="_blank" </c:if> >${link.title}</a>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="mc-md">
                        <div class="item item-style1 frameEdit" frameInfo="${sy_gg_floor}">
                            <c:forEach items="${sdk:findPageModuleProxy(sy_gg_floor).advt.advtProxy}" var="advt" end="0">
                                <a href="${advt.link}">
                                    <p class="p-title">${advt.title}</p>
                                    <p class="p-class">${advt.advtHint}</p>
                                    <img src="${advt.advUrl}" alt="${advt.title}">
                                </a>
                            </c:forEach>
                        </div>
                        <div class="frameEdit" frameInfo="${sy_gg2_floor}" style="width:354px;height: 250px; float: left; background: #fff; position: relative; margin-right: 1px; margin-bottom: 1px;">
                            <c:forEach items="${sdk:findPageModuleProxy(sy_gg2_floor).advt.advtProxy}" var="advt" end="1">
                                <div class="item item-style2">
                                    <a href="${advt.link}">
                                        <p class="p-title">${advt.title}</p>
                                        <p class="p-class">${advt.advtHint}</p>
                                        <img src="${advt.advUrl}" alt="${advt.title}">
                                    </a>
                                </div>
                            </c:forEach>
                        </div>
                        <div class="frameEdit"  frameInfo="${sy_floor_recommend}" style="width:708px;height: 250px; float: left; background: #fff; position: relative; margin-right: 1px; margin-bottom: 1px;">
                            <c:forEach items="${sdk:findPageModuleProxy(sy_floor_recommend).recommendProducts}" var="productProxy" end="3">
                                <div class="item item-style3 frameEdit"  frameInfo="${sy_floor_recommend}">
                                    <a href="${webRoot}/product-${productProxy.productId}.html" target="_blank">
                                        <img src="${productProxy.images[0]['120X120']}" alt="${productProxy.name}">
                                        <p class="p-name">${productProxy.name}</p>
                                        <p class="p-price">&yen;${productProxy.price.unitPrice}</p>
                                    </a>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="mc-rt">
                        <div class="rt-dt">热销推荐</div>
                        <div class="rt-dd">
                            <c:set value="${fn:length(sdk:findPageModuleProxy(sy_floor_hotSaleWeek).recommendProducts)}" var="productAmount"/>
                            <c:set value="${(productAmount-1)/4}" var="bannerAmount" />
                            <div style="width:240px;height: 420px;" class="frameEdit editDiv" frameInfo="${sy_floor_hotSaleWeek}">
                                <div class="dd-cont ">
                                    <c:forEach begin="0" end="${bannerAmount}" varStatus="sta">
                                        <ul>
                                            <c:forEach items="${sdk:findPageModuleProxy(sy_floor_hotSaleWeek).recommendProducts}" var="productProxy" begin="${(sta.count-1)*4}" end="${(sta.count-1)*4+3}">
                                                <li>
                                                    <div class="cont-box">
                                                        <div class="pic"><a href="${webRoot}/product-${productProxy.productId}.html" target="_blank"><img src="${productProxy.images[0]['80X80']}" alt="${productProxy.name}"></a></div>
                                                        <div class="box-rt">
                                                            <a href="${webRoot}/product-${productProxy.productId}.html" target="_blank" class="title elli">${productProxy.name}</a>
                                                            <div class="price"><span>￥</span>${productProxy.price.unitPrice}</div>
                                                        </div>
                                                    </div>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </c:forEach>
                                </div>
                            </div>
                            <div class="dd-control">
                                <c:if test="${bannerAmount != 0}">
                                    <c:forEach begin="0" end="${bannerAmount}" varStatus="stu" var="s">
                                        <c:choose>
                                            <c:when test="${stu.index==1}">
                                                <a href="javascript:void(0);" class="cur " ></a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="javascript:void(0);"></a>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!--楼层品牌-->
            <div class="main-brand frameEdit" frameInfo="${sy_floor_brand}">
                <ul>
                    <c:forEach items="${sdk:findPageModuleProxy(sy_floor_brand).advt.advtProxy}" var="advt" varStatus="s" end="8">
                        <li>
                                ${advt.htmlTemplate}
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </c:forEach>

        <!-- 人气店铺 -->
        <div class="popular-shops">
            <div class="mt frameEdit" frameInfo="sy_index_shop_recommend">
                人气店铺
            </div>
            <div class="mc">
                <c:set value="${sdk:findPageModuleProxy('sy_index_shop_recommend').recommendShops}" var="recomShops"/>
                <c:forEach items="${recomShops}" var="shop" varStatus="s" end="4">
                    <div class="item">
                        <div class="item-l">
                            <a href="${webRoot}/shopTemplate/default/shopIndex.ac?shopId=${shop.shopInfId}" target="_blank">
                                <c:set value="sy_index_shop_recommend_adv${s.count}" var="sy_index_shop_recommend_adv"/>
                                <div class="frameEdit" frameInfo="${sy_index_shop_recommend_adv}" style="width: 237px;height: 340px;">
                                    <c:forEach items="${sdk:findPageModuleProxy(sy_index_shop_recommend_adv).advt.advtProxy}" var="advt" end="0">
                                        <img src="${advt.advUrl}" width="237" height="340" alt="" >
                                    </c:forEach>
                                </div>
                                <p class="shops-name">${shop.shopNm}</p>
                                <p class="cj-sc">成交量${shop.orderTotalCount}件 / ${shop.collectdByUserNum}人已收藏</p>
                            </a>
                        </div>
                        <div class="item-r">
                            <c:forEach items="${shop.shopProductList}" var="prd">
                                <div class="item-r-li">
                                    <a href="${webRoot}/product-${prd.productId}.html" target="_blank">
                                        <img src="${prd.defaultImage["120X120"]}" alt="">
                                        <p class="shops-name">${prd.name}</p>
                                        <p class="price"><span>&yen;</span>${prd.price.unitPrice}</p>
                                    </a>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </c:forEach>
                <div class="mc-mask"></div>
            </div>
        </div>

        <!--友情链接-->
        <div class="f-links">
            <div class="fk-mt">
                <ul id="f-links-mt">
                    <li class="cur"><a href="">友情链接</a></li>
                </ul>
            </div>
            <div class="fk-mc frameEdit" frameInfo="sy_friend_links">
                <c:forEach items="${sdk:findPageModuleProxy('sy_friend_links').links}" var="link" varStatus="s">
                    <a href="${link.link}" title="${link.title}" target="_blank">${link.title}</a>
                    <c:if test="${!s.last}">
                        <span>|</span>
                    </c:if>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

<!--底部-->
<c:import url="/template/bdw/module/common/bottom.jsp?p=index"/>


</body>
</html>
