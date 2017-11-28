<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>

<c:if test="${isWeixin eq 'Y' && !(not empty loginUser  &&  loginUser.isAttentionWechat == 'Y')}">
    <%@ include file="/template/bdw/wap/wechatAttention.jsp" %>
</c:if>
<%@ taglib prefix="f" uri="/iMallTag" %>
<!DOCTYPE html>
<html>
<c:set var="promotionProductProxies" value="${sdk:findPageModuleProxy('wap_index_panic_buy').recommendPromotionProducts}"/>
<c:set var="defaultProductProxy" value="${bdw:getFirstPromotionProductProxy()}"/>
<head lang="en">
    <meta charset="utf-8">
    <title>${webName}</title>
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="telephone=no,email=no" name="format-detection">

    <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js" type="text/javascript"></script>
    <link href="${webRoot}/template/bdw/wap/statics/css/swiper.min.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/index.css" rel="stylesheet" media="screen">

    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}"};
    </script>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/swiper.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/index.js" type="text/javascript"></script>

</head>

<body>
<header class="header-wrapper">
    <div class="sc-box1">
        <div class="logo frameEdit" frameInfo="wap_index_logo1">
            <c:forEach items="${sdk:findPageModuleProxy('wap_index_logo1').advt.advtProxy}" var="logo" end="0">
                <a href="${logo.link}"><img src="${logo.advUrl}" alt="${logo.title}"></a>
            </c:forEach>
        </div>
        <div class="search-form-box" onclick="window.location.href='${webRoot}/wap/newSearch.ac'">
            <span class="search-form-icon"></span>
            <div class="search-form-input">
                <input type="text" placeholder="搜索商品" readonly>
            </div>
        </div>
        <div class="news"><a href="${webRoot}/wap/module/member/myMessage.ac"></a></div>
        <%--<div class="news"><a href="${webRoot}/wap/module/member/myMessage.ac"><span></span></a></div>--%>
    </div>
    <div class="sc-box2" style="display: none;">
        <div class="logo frameEdit" frameInfo="wap_index_logo2">
            <c:forEach items="${sdk:findPageModuleProxy('wap_index_logo1').advt.advtProxy}" var="logo" end="0">
                <a href="${logo.link}"><img src="${logo.advUrl}" alt="${logo.title}"></a>
            </c:forEach>
        </div>
        <div class="search-form-box" onclick="window.location.href='${webRoot}/wap/newSearch.ac'">
            <span class="search-form-icon"></span>
            <div class="search-form-input">
                <input type="text" placeholder="搜索商品" readonly>
            </div>
        </div>
        <div class="message"><a href="${webRoot}/wap/module/member/myMessage.ac"></a></div>
        <%--<div class="news"><a href="${webRoot}/wap/module/member/myMessage.ac"><span></span></a></div>--%>
    </div>
</header>
<div class="index-main">

    <!-- 商品图片 -->
    <div class="swiper-container m-pic frameEdit" frameInfo="wap_index_roteAdv">
        <div class="swiper-wrapper" style="height: auto;" >
            <c:forEach items="${sdk:findPageModuleProxy('wap_index_roteAdv').advt.advtProxy}" var="advtProxys" varStatus="s">
                <div class="swiper-slide">
                    <a href="${advtProxys.link}"><img src="${advtProxys.advUrl}" alt=""></a>
                </div>
            </c:forEach>
        </div>
        <div class="swiper-pagination"></div>
    </div>

    <div class="box-enter frameEdit" frameInfo="wap_index_entry_nav">
        <c:forEach items="${sdk:findPageModuleProxy('wap_index_entry_nav').advt.advtProxy}" var="advtProxys" varStatus="s" end="9">
            <a href="${advtProxys.link}" class="quick-entry-link">
                <span class="pic"><img src="${advtProxys.advUrl}"></span>
                <i>${fn:substring(advtProxys.title,0,4)}</i>
            </a>
        </c:forEach>
    </div>
    <c:choose>
        <c:when test="${empty defaultProductProxy}">
            <%--没有促销商品此时促销div不要显示--%>
        </c:when>
        <c:otherwise>
            <div class="time-limit frameEdit" frameInfo="wap_index_panic_buy">
                <div class="mt">
                    <span>限时抢购</span>
                    <div class="time">
                        <i>${defaultProductProxy.marketingActivity.discountRequirement}折起</i>
                        <em endDate="${defaultProductProxy.marketingActivity.activityEndTimeString}" id="promotionDate">0天00:00:00</em>
                    </div>
                    <a href="${webRoot}/wap/activityIndex.ac" class="more">更多</a>
                </div>
                <div class="mc">
                    <c:forEach items="${promotionProductProxies}" var="prd" varStatus="s" end="2">
                        <div class="item">
                            <a href="${webRoot}/wap/product.ac?id=${prd.productId}">
                                <div class="pic"><a href="${webRoot}/wap/product.ac?id=${prd.productId}"><img src="${empty prd.images ? prd.defaultImage['320X320'] : prd.images[0]['320X320']}" alt=""></a></div>
                                <fmt:formatNumber value="${prd.price.unitPrice}" pattern="#0.00" type="number" var="price"/>
                                <div class="price"><i>￥</i>${fn:substring(price, 0, fn:indexOf(price,'.'))}<span>${fn:substring(price, fn:indexOf(price,'.'), fn:length(price))}</span></div>
                                <fmt:formatNumber value="${prd.marketPrice}" pattern="#0.00" type="number" var="marketPrice"/>
                                <div class="od-price">¥${marketPrice}</div>
                            </a>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:otherwise>
    </c:choose>

    <div class="popularity">
        <div class="mt frameEdit" frameInfo="wap_index_shop_recommend_title">
            <c:forEach items="${sdk:findPageModuleProxy('wap_index_shop_recommend_title').links}" var="link" end="0">
                <a href="${link.link}"><img style="display: block; width: 100%;" src="${link.icon}" alt="${link.title}"></a>
            </c:forEach>
        </div>
        <div class="mc frameEdit" frameInfo="wap_index_shop_recommend_content">
            <c:set value="${sdk:findPageModuleProxy('wap_index_shop_recommend_content').recommendShops}" var="recomShops"/>
            <ul class="find-similar-ul">
                <c:forEach items="${recomShops}" var="shop" varStatus="s" end="4">
                    <li class="similar-li">
                        <a href="javascript:;">
                            <div class="li-mt"  onclick="window.location.href='${webRoot}/wap/shop/shopIndex.ac?shopId=${shop.shopInfId}'">
                                <div class="pic01"><img src="${shop.images[0]['']}" alt=""></div>
                                <h5>${shop.shopNm}</h5>
                                <span>全部商品</span>
                                <span>${shop.productTotalCount}</span>
                            </div>
                            <div class="li-mc">
                                <c:forEach items="${shop.shopProductList}" var="prd" varStatus="p" end="2">
                                    <div class="${p.index == 0 ? 'pic02' : 'pic03'}">
                                        <img src="${prd.defaultImage["320X320"]}" alt="" onclick="window.location.href='${webRoot}/product-${prd.productId}.html'"/>
                                    </div>
                                </c:forEach>
                            </div>
                        </a>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>
    <div class="choiceness orange">
        <div class="mt frameEdit" frameInfo="wap_index_area_title">
            <c:forEach items="${sdk:findPageModuleProxy('wap_index_area_title').links}" var="link" end="0">
                <a href="${link.link}"><img style="display: block; width: 100%;" src="${link.icon}" alt="${link.title}"></a>
            </c:forEach>
        </div>
        <div class="mc">
            <div class="mc-item01 frameEdit" frameInfo="wap_index_area_adv1">
                <c:forEach items="${sdk:findPageModuleProxy('wap_index_area_adv1').advt.advtProxy}" var="advtProxys" varStatus="s" end="0">
                    <a href="${advtProxys.link}">
                        <h5>${advtProxys.title}</h5>
                        <p>${advtProxys.advtHint}</p>
                        <div class="pic"><img src="${advtProxys.advUrl}" alt=""></div>
                    </a>
                </c:forEach>
            </div>
            <div class="mc-item01 frameEdit" frameInfo="wap_index_area_adv2">
                <c:forEach items="${sdk:findPageModuleProxy('wap_index_area_adv2').advt.advtProxy}" var="advtProxys" varStatus="s" end="0">
                    <a href="${advtProxys.link}">
                        <h5>${advtProxys.title}</h5>
                        <p>${advtProxys.advtHint}</p>
                        <div class="pic"><img src="${advtProxys.advUrl}" alt=""></div>
                    </a>
                </c:forEach>
            </div>
            <div class="frameEdit"  frameInfo="wap_index_area_adv3" style="clear:both;">
                <c:forEach items="${sdk:findPageModuleProxy('wap_index_area_adv3').advt.advtProxy}" var="advtProxys" varStatus="s" end="3">
                <div class="mc-item02">
                    <a href="${advtProxys.link}">
                        <h5>${advtProxys.title}</h5>
                        <p>${advtProxys.advtHint}</p>
                        <div class="pic"><img src="${advtProxys.advUrl}" alt=""></div>
                    </a>
                 </div>
                </c:forEach>
            </div>
        </div>
    </div>

    <%--楼层1--%>
    <div class="choiceness cyan">
        <div class="mt frameEdit" frameInfo="wap_index_F1_title">
            <c:forEach items="${sdk:findPageModuleProxy('wap_index_F1_title').links}" var="link" end="0">
                <a href="${link.link}"><img style="display: block; width: 100%;" src="${link.icon}" alt="${link.title}"></a>
            </c:forEach>
        </div>
        <div class="mc">
            <div class="mc-item01 frameEdit" frameInfo="wap_index_F1_adv1">
                <c:forEach items="${sdk:findPageModuleProxy('wap_index_F1_adv1').advt.advtProxy}" var="advtProxys" varStatus="s" end="0">
                <a href="${advtProxys.link}">
                    <h5>${advtProxys.title}</h5>
                    <p>${advtProxys.advtHint}</p>
                    <div class="pic"><img src="${advtProxys.advUrl}" alt=""></div>
                </a>
                </c:forEach>
            </div>
            <div class="adv2 frameEdit" frameInfo="wap_index_F1_adv2">
                <c:forEach items="${sdk:findPageModuleProxy('wap_index_F1_adv2').advt.advtProxy}" var="advtProxys" varStatus="s" end="1">
                    <div class="mc-item02 adv2">
                        <a href="${advtProxys.link}">
                            <h5>${advtProxys.title}</h5>
                            <p>${advtProxys.advtHint}</p>
                            <div class="pic"><img src="${advtProxys.advUrl}" alt=""></div>
                        </a>
                    </div>
                </c:forEach>
            </div>
            <div class="frameEdit" frameInfo="wap_index_F1_adv3" style="clear: both">
                <c:forEach items="${sdk:findPageModuleProxy('wap_index_F1_adv3').advt.advtProxy}" var="advtProxys" varStatus="s" end="3">
                    <div class="mc-item02" >
                        <a href="${advtProxys.link}">
                            <h5>${advtProxys.title}</h5>
                            <h6>${advtProxys.advtHint}</h6>
                            <div class="pic"><img src="${advtProxys.advUrl}" alt=""></div>
                        </a>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
    <div class="fl-adv frameEdit" frameInfo="wap_index_F1_bottom_banner">
        <c:forEach items="${sdk:findPageModuleProxy('wap_index_F1_bottom_banner').advt.advtProxy}" var="advtProxys" varStatus="s" end="0">
            <a href="${advtProxys.link}"><img src="${advtProxys.advUrl}" alt=""></a>
        </c:forEach>
    </div>

    <%--楼层2--%>
    <div class="choiceness yellow">
        <div class="mt frameEdit" frameInfo="wap_index_F2_title">
            <c:forEach items="${sdk:findPageModuleProxy('wap_index_F2_title').links}" var="link" end="0">
                <a href="${link.link}"><img style="display: block; width: 100%;" src="${link.icon}" alt="${link.title}"></a>
            </c:forEach>
        </div>
        <div class="mc">
            <div class="mc-item01 frameEdit" frameInfo="wap_index_F2_adv1">
                <c:forEach items="${sdk:findPageModuleProxy('wap_index_F2_adv1').advt.advtProxy}" var="advtProxys" varStatus="s" end="0">
                    <a href="${advtProxys.link}">
                        <h5>${advtProxys.title}</h5>
                        <p>${advtProxys.advtHint}</p>
                        <div class="pic"><img src="${advtProxys.advUrl}" alt=""></div>
                    </a>
                </c:forEach>
            </div>
            <div class="adv2 frameEdit" frameInfo="wap_index_F2_adv2">
                <c:forEach items="${sdk:findPageModuleProxy('wap_index_F2_adv2').advt.advtProxy}" var="advtProxys" varStatus="s" end="1">
                    <div class="adv2 mc-item02" >
                        <a href="${advtProxys.link}">
                            <h5>${advtProxys.title}</h5>
                            <p>${advtProxys.advtHint}</p>
                            <div class="pic"><img src="${advtProxys.advUrl}" alt=""></div>
                        </a>
                    </div>
                </c:forEach>
            </div>
            <div class="frameEdit" frameInfo="wap_index_F2_adv3" style="clear: both">
                <c:forEach items="${sdk:findPageModuleProxy('wap_index_F2_adv3').advt.advtProxy}" var="advtProxys" varStatus="s" end="3">
                    <div class="mc-item02" >
                        <a href="${advtProxys.link}">
                            <h5>${advtProxys.title}</h5>
                            <h6>${advtProxys.advtHint}</h6>
                            <div class="pic"><img src="${advtProxys.advUrl}" alt=""></div>
                        </a>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
    <div class="fl-adv frameEdit" frameInfo="wap_index_F2_bottom_banner">
        <c:forEach items="${sdk:findPageModuleProxy('wap_index_F2_bottom_banner').advt.advtProxy}" var="advtProxys" varStatus="s" end="0">
            <a href="${advtProxys.link}"><img src="${advtProxys.advUrl}" alt=""></a>
        </c:forEach>
    </div>

    <%--楼层3--%>
    <div class="choiceness green">
        <div class="mt frameEdit" frameInfo="wap_index_F3_title">
            <c:forEach items="${sdk:findPageModuleProxy('wap_index_F3_title').links}" var="link" end="0">
                <a href="${link.link}"><img style="display: block; width: 100%;" src="${link.icon}" alt="${link.title}"></a>
            </c:forEach>
        </div>
        <div class="mc">
            <div class="mc-item01 frameEdit" frameInfo="wap_index_F3_adv1">
                <c:forEach items="${sdk:findPageModuleProxy('wap_index_F3_adv1').advt.advtProxy}" var="advtProxys" varStatus="s" end="0">
                    <a href="${advtProxys.link}">
                        <h5>${advtProxys.title}</h5>
                        <p>${advtProxys.advtHint}</p>
                        <div class="pic"><img src="${advtProxys.advUrl}" alt=""></div>
                    </a>
                </c:forEach>
            </div>
            <div class="adv2 frameEdit" frameInfo="wap_index_F3_adv2">
                <c:forEach items="${sdk:findPageModuleProxy('wap_index_F3_adv2').advt.advtProxy}" var="advtProxys" varStatus="s" end="1">
                    <div class="adv2 mc-item02">
                        <a href="${advtProxys.link}">
                            <h5>${advtProxys.title}</h5>
                            <p>${advtProxys.advtHint}</p>
                            <div class="pic"><img src="${advtProxys.advUrl}" alt=""></div>
                        </a>
                    </div>
                </c:forEach>
            </div>
            <div class="frameEdit" frameInfo="wap_index_F3_adv3" style="clear: both">
                <c:forEach items="${sdk:findPageModuleProxy('wap_index_F3_adv3').advt.advtProxy}" var="advtProxys" varStatus="s" end="3">
                    <div class="mc-item02" >
                        <a href="${advtProxys.link}">
                            <h5>${advtProxys.title}</h5>
                            <h6>${advtProxys.advtHint}</h6>
                            <div class="pic"><img src="${advtProxys.advUrl}" alt=""></div>
                        </a>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
    <div class="fl-adv frameEdit" frameInfo="wap_index_F3_bottom_banner">
        <c:forEach items="${sdk:findPageModuleProxy('wap_index_F3_bottom_banner').advt.advtProxy}" var="advtProxys" varStatus="s" end="0">
            <a href="${advtProxys.link}"><img src="${advtProxys.advUrl}" alt=""></a>
        </c:forEach>
    </div>


    <div class="recommend">
        <div class="mt frameEdit" frameInfo="wap_index_recommend_title">
            <c:forEach items="${sdk:findPageModuleProxy('wap_index_recommend_title').links}" var="link" end="0">
                <a href="${link.link}"><img style="display: block; width: 100%;" src="${link.icon}" alt="${link.title}"></a>
            </c:forEach>
        </div>
        <div class="mc frameEdit" frameInfo="wap_index_recommend_content">
            <ul class="rec-ul">
                <c:forEach items="${sdk:findPageModuleProxy('wap_index_recommend_content').recommendProducts}" var="productProxy">
                    <li class="rec-li"><a href="${webRoot}/wap/product.ac?id=${productProxy.productId}">
                        <div class="pic"><img src="${empty productProxy.images ? productProxy.defaultImage['320X320'] : productProxy.images[0]['320X320']}" alt=""></div>
                        <div class="li-bot">
                            <h5>${productProxy.name}</h5>
                            <div class="price">
                                <fmt:formatNumber value="${productProxy.price.unitPrice}" pattern="#0.00" type="number" var="price"/>
                                <span>￥</span>${fn:substring(price, 0, fn:indexOf(price,'.'))}<i>${fn:substring(price, fn:indexOf(price,'.'), fn:length(price))}</i>
                            </div>
                        </div>
                    </a></li>
                </c:forEach>
            </ul>
        </div>
    </div>

    <div class="copyright frameEdit" frameInfo="wap_member_index_copyright">
        <c:if test="${not empty sdk:findPageModuleProxy('wap_member_index_copyright').pageModuleObjects[0]}">
            ${sdk:findPageModuleProxy('wap_member_index_copyright').pageModuleObjects[0].userDefinedContStr}
        </c:if>
    </div>
</div>
<div class="back-top" style="display: none;"><a href="javascript:;" onclick="scrollToTop()"><img src="${webRoot}/template/bdw/wap/statics/images/zhiding.png" alt=""></a></div>

<%--底部导航--%>
<%--<c:import url="footer.jsp"/>--%>
<c:import url="/wap/footer.ac"/>

<script type="text/javascript">
    $(document).ready(function () {
      //限时抢购倒计时
        if(${not empty defaultProductProxy}){
            var today = new Date();
            var promotionDate = $("#promotionDate");
            var endTime = new Date(Date.parse(promotionDate.attr("endDate").replace(/-/g,"/"))).getTime();
            var totalSecond = (endTime - today.getTime()) / 1000;
            timer(totalSecond);
        }
    });
</script>

</body>
<f:FrameEditTag />
</html>

