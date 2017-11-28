<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%--取出商品--%>
<c:set var="productProxy" value="${sdk:getProductById(param.id)}"/>

<%--获取当前用户--%>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>

<%--门店关注提示layer--%>
<c:if test="${isWeixin eq 'Y' && !(not empty loginUser  &&  loginUser.isAttentionWechat == 'Y')}">>
    <%@ include file="/template/bdw/wap/wechatAttention.jsp" %>
</c:if>

<c:if test="${empty productProxy}">
    <c:redirect url="/wap/index.ac"></c:redirect>
</c:if>

<%--不是微信，商品仅在微信显示则返回首页--%>
<c:if test="${isWeixin!='Y'}">
    <c:if test="${productProxy.isWeixinShow eq 'Y'}">
        <c:redirect url="/wap/index.ac"></c:redirect>
    </c:if>
</c:if>

<c:set value="4" var="limit"/>
<%--商品评论统计信息--%>
<c:set var="commentStatistics" value="${productProxy.commentStatistics}"/>
<%--商品评论--%>
<c:set var="commentProxyPage" value="${sdk:findProductComments(param.id,6)}"/>
<c:set var="commentProxyResult" value="${commentProxyPage.result}"/>
<c:set var="limit" value="6"/>

<%-- 商家正在进行的优惠(赠品，包邮这些) --%>
<c:set value="${productProxy.availableBusinessRuleList}"  var="availableBusinessRuleList" />

<%-- 获取当前商家 --%>
<c:set value="${sdk:getShopInfProxyById(productProxy.shopInfId)}" var="shopInf"/>
<%-- 获取店铺所有商品的数量 --%>
<c:set value="${bdw:getTotalProductNum(shopInf.sysOrgId)}" var="totalProductNum"/>

<%--获取可以领的券--%>
<c:set value="${bdw:listEffectiveGivenCouponRule()}" var="effectiveGivenCouponRuleList"/>
<!--普通购物车-->
<c:set value="${sdk:getUserCartListProxy('normal')}" var="normalProxy"/>
<!--药品购物车-->
<c:set value="${sdk:getUserCartListProxy('drug')}" var="drugProxy"/>

<c:choose>
    <c:when test="${empty param.cps}">
        <c:set value="${wapUrl}/wap/product-${param.id}.html" var="signUrl"/>
    </c:when>
    <c:otherwise>
        <c:set value="${wapUrl}/wap/product-${param.id}.html?cps=${param.cps}" var="signUrl"/>
    </c:otherwise>
</c:choose>

<c:choose>
    <c:when test="${not empty loginUser}">
        <c:set value="${sdk:getPromoteMemberByUserId()}" var="promoteMember"/>
        <c:choose>
            <c:when test="${not empty promoteMember and not empty param.cps}">
                <c:set value="${wapUrl}/cps/cpsPromote.ac?unid=${promoteMember.id}&target=${wapUrl}/wap/product-${param.id}.html?1=1" var="shareUrl"/>
            </c:when>
            <c:otherwise>
                <c:set value="${signUrl}" var="shareUrl"/>
            </c:otherwise>
        </c:choose>
    </c:when>
    <c:otherwise>
        <c:set value="${signUrl}" var="shareUrl"/>
    </c:otherwise>
</c:choose>

<!DOCTYPE html>
<html>
    <head lang="en">
        <meta charset="utf-8">
        <title>${productProxy.name}-${webName}</title>
        <meta content="yes" name="apple-mobile-web-app-capable">
        <meta content="yes" name="apple-touch-fullscreen">
        <meta content="telephone=no,email=no" name="format-detection">
        <script src="${webRoot}/template/bdw/wap/statics/js/jquery-2.1.4.min.js"></script>
        <script type="text/javascript" src="${webRoot}/template/bdw/wap/module/member/statics/js/detail.js"></script>

        <link href="${webRoot}/template/bdw/wap/statics/css/detail.css" type="text/css" rel="stylesheet" />
        <link href="${webRoot}/template/bdw/wap/statics/css/swiper.min.css" type="text/css" rel="stylesheet" />
        <link href="${webRoot}/template/bdw/wap/statics/css/base.css" type="text/css" rel="stylesheet" />
        <link href="${webRoot}/template/bdw/wap/statics/css/header.css" type="text/css" rel="stylesheet" />
        <c:if test="${isWeixin!='Y'}">
            <link href="${webRoot}/template/bdw/wap/statics/css/product-detail-share.css" type="text/css" rel="stylesheet" />
        </c:if>
    </head>

    <body>
        <c:if test="${empty param.cps}">
            <div class="m-top">
                <a href="javascript:history.go(-1);" class="back"></a>
                <span>商品详情</span>
            </div>
        </c:if>
        <c:if test="${!empty param.cps}">
            <div class="m-top">
                <a href="javascript:history.go(-1);" class="back"></a>
                <span>商品详情</span>
                <c:if test="${not empty promoteMember}">
                    <c:set var="earnMin" value="${productProxy.rebateRate * productProxy.price.unitPrice / 100}"/>
                    <a class="share-toggle" href="javascript:;" id="cpsShare" shareId="${productProxy.productId}" cps="${param.cps}">分享赚&yen;<fmt:formatNumber value="${earnMin}" type="number" pattern="#0.00" /></a>
                </c:if>
            </div>
        </c:if>
        <div class="dt-main">
            <div class="swiper-container product-tab">
                <div class="swiper-wrapper">
                    <c:choose>
                        <c:when test="${empty productProxy.images}">
                            <div class="swiper-slide">
                                <a href=""><img src="${webRoot}/template/bdw/wap/statics/images/pic460x460.jpg" alt=""></a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach varStatus="s" items="${productProxy.images}" var="image">
                                <div class="swiper-slide">
                                    <a href="javascript:void(0);"><img src="${image['']}" alt=""></a>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
                <!-- Add Pagination -->
                <div class="swiper-pagination"></div>
            </div>

            <c:if test="${fn:length(productProxy.skus)==1 && productProxy.price.isSpecialPrice}">
                <c:set value="${productProxy.priceListStr}" var="unitPrice"/>
                <%
                    String priceStr = (String) pageContext.getAttribute("unitPrice");
                    String[] price = priceStr.split("[.]");
                    String integerPrice = price[0];
                    String decimalPrice = price[1];
                    if (StringUtils.isBlank(decimalPrice)) {
                    decimalPrice = "00";
                    } else if (decimalPrice.length() < 2) {
                    decimalPrice += "0";
                    }
                    pageContext.setAttribute("integerPrice", integerPrice);
                    pageContext.setAttribute("decimalPrice", decimalPrice);
                %>
                <div class="time-box" style="display: none;" id="remTime" endTimeStr="${productProxy.price.endTimeStr}">
                    <div class="time-box-l">
                        <em>限时购</em>
                        <p class="price">￥<span>${integerPrice}</span>.${decimalPrice}</p>
                        <p class="old-price">¥${productProxy.marketPrice}</p>
                    </div>
                    <div class="time-box-r" id="timeBox">距结束剩余<br><span>00</span><i>天</i><span>00</span><i>:</i><span>00</span><i>:</i><span>00</span></div>
                </div>
            </c:if>

            <div class="product-info">
                <c:if test="${fn:length(productProxy.skus) != 1 || !productProxy.price.isSpecialPrice}">
                    <p class="price">￥<span>${productProxy.priceListStr}</span></p>
                    <p class="market-price"><span>市场价:</span>${productProxy.marketPrice}</p>
                </c:if>
                <a class="name" href="javascript:void(0);">
                    <c:if test="${productProxy.isNormal=='Y'}"><span>${productProxy.prescriptionTypeCode}</span></c:if>
                    ${productProxy.name}
                </a>
                <p class="action">${productProxy.salePoint}</p>
                <c:choose>
                    <c:when test="${empty loginUser}">
                        <a class="collect" href="javascript:void(0);" onclick="window.location.href='${webRoot}/wap/login.ac';"><em></em>收藏</a>
                    </c:when>
                    <c:otherwise>
                        <a id="collect" class="${productProxy.collect=='true' ? 'collect collect-active' : 'collect'}" href="javascript:void(0);"><em></em>收藏</a>
                    </c:otherwise>
                </c:choose>
            </div>
            <ul class="slogen">
                <li>畅选无忧</li>
                <li>正品保证</li>
                <li>隐私配送</li>
                <li>精致服务</li>
            </ul>
            <c:if test="${not empty effectiveGivenCouponRuleList}">
                <div class="coupon-box ">
                    <span class="title swiper-slide">领券</span>
                    <div class="swiper-container coupon-redemption">
                        <div class="swiper-wrapper">
                            <c:forEach items="${effectiveGivenCouponRuleList}" var="rule" varStatus="status">
                                <c:choose>
                                    <c:when test="${empty loginUser}">
                                        <a class="swiper-slide" href="javascript:void(0);" onclick="window.location.href='${webRoot}/wap/login.ac'">${rule.title}</a>
                                    </c:when>
                                    <c:otherwise>
                                        <a class="swiper-slide" href="javascript:void(0);" onclick="receiveCoupon('${rule.ruleLinke}')">${rule.title}</a>
                                    </c:otherwise>
                                </c:choose>

                            </c:forEach>
                        </div>
                    </div>
                </div>
            </c:if>
            <c:if test="${not empty availableBusinessRuleList}">
                <div class="promotion">
                    <span class="title">促销</span>
                    <c:forEach items="${availableBusinessRuleList}" var="rule" varStatus="status">
                        <c:choose>
                            <c:when test="${(rule.ruleTypeCode=='1'||rule.ruleTypeCode=='2'||rule.ruleTypeCode=='3')}">
                                <p><span>折扣</span>${rule.businessRuleNm}</p>
                            </c:when>
                            <c:when test="${(rule.ruleTypeCode=='4'||rule.ruleTypeCode=='5'||rule.ruleTypeCode=='6')}">
                                <p><span>包邮</span>${rule.businessRuleNm}</p>
                            </c:when>
                            <c:when test="${(rule.ruleTypeCode=='7'||rule.ruleTypeCode=='8'||rule.ruleTypeCode=='9')}">
                                <p><span>赠品</span>${rule.businessRuleNm}</p>
                            </c:when>
                            <c:when test="${(rule.ruleTypeCode=='13'||rule.ruleTypeCode=='14'||rule.ruleTypeCode=='15'||rule.ruleTypeCode=='16')}">
                                <p><span>送券</span>${rule.businessRuleNm}</p>
                            </c:when>
                        </c:choose>
                    </c:forEach>
                    <c:set value="${fn:length(availableBusinessRuleList)}" var="availableBusinessRuleListLength"/>
                    <c:if test="${availableBusinessRuleListLength > 1}"><a class="more" href="javascript:void(0);"></a></c:if>
                </div>
            </c:if>

            <div class="goods-part">
                <div class="mt">
                    <div class="pic">
                        <a href="${webRoot}/wap/shop/shopIndex.ac?shopId=${shopInf.shopInfId}">
                            <c:choose>
                                <c:when test="${empty shopInf.images[0]['100X100']}">
                                    <img src="${webRoot}/template/bdw/wap/statics/images/pic70x70.jpg" alt="">
                                </c:when>
                                <c:otherwise>
                                    <img src="${shopInf.images[0]["100X100"]}" alt="">
                                </c:otherwise>
                            </c:choose>
                        </a>
                    </div>
                    <a href="${webRoot}/wap/shop/shopIndex.ac?shopId=${shopInf.shopInfId}" class="name">${shopInf.shopNm}</a>
                </div>
                <div class="mc">
                    <div class="item">
                        <i>${totalProductNum}</i>
                        <span>全部商品</span>
                    </div>
                    <div class="item">
                        <i>${shopInf.collectdByUserNum}</i>
                        <span>收藏人数</span>
                    </div>
                    <div class="item">
                        <i>${shopInf.orderTotalCount}</i>
                        <span>成交笔数</span>
                    </div>
                    <div class="gmk">
                        <span>描述相符 <i><fmt:formatNumber value="${shopInf.shopRatingAvgVo.productDescrSame}" type="number" pattern="#0.0"/></i></span>
                        <span>服务态度 <i><fmt:formatNumber value="${shopInf.shopRatingAvgVo.sellerServiceAttitude}" type="number" pattern="#0.0"/></i></span>
                        <span>物流速度 <i><fmt:formatNumber value="${shopInf.shopRatingAvgVo.sellerSendOutSpeed}" type="number" pattern="#0.0"/></i></span>
                    </div>
                </div>
                <div class="md">
                    <c:choose>
                        <c:when test="${empty loginUser}">
                            <a href="javascript:void(0);" onclick="window.location.href='${webRoot}/wap/login.ac';">收藏店铺</a>
                        </c:when>
                        <c:otherwise>
                            <a href="javascript:void(0);" class="${productProxy.shopCollect=='true' ? 'selected shopCollect' : 'shopCollect'}" shopId="${shopInf.shopInfId}" isCollect="${shopInf.collect}">${productProxy.shopCollect=='true' ? '已收藏' : '收藏店铺'}</a>
                        </c:otherwise>
                    </c:choose>

                    <a href="${webRoot}/wap/shop/shopIndex.ac?shopId=${shopInf.shopInfId}" class="">进店逛逛</a>
                </div>
            </div>
            <div class="dt-tabs">
                <div class="mt">
                    <ul>
                        <li style="width: 25%;" onclick="showTab('productGraphicDetail',this)" class="cur"><a href="javascript:void(0);">图文详情</a></li>
                        <li style="width: 25%;" onclick="showTab('productParams',this)"><a href="javascript:void(0);">产品参数</a></li>
                        <li style="width: 25%;" onclick="showTab('productSpecification',this)"><a href="javascript:void(0);">说明书</a></li>
                        <li style="width: 25%;" onclick="showTab('productComment',this)"><a href="javascript:void(0);">评价</a>
                            <c:if test="${commentStatistics.total > 0}">
                                <span>${commentStatistics.total}</span>
                            </c:if>
                        </li>
                    </ul>
                </div>
                <div class="mc" style="min-height: 3rem;">
                    <div class="pic-box" id="productGraphicDetail">
                        <c:if test="${not empty productProxy.description}">
                            ${productProxy.description}
                        </c:if>
                    </div>
                    <div class="parameter-box" id="productParams" style="display: none">
                        <c:if test="${not empty productProxy.attrGroupProxyList}">
                            <c:forEach items="${productProxy.attrGroupProxyList}" var="attrGroupProxy">
                                <c:if test="${fn:length(attrGroupProxy.dicValues)>0 && attrGroupProxy.attrGroupNm != '通用属性组'}">
                                    <c:forEach items="${attrGroupProxy.dicValues}" var="attrDict">
                                        <div class="item">
                                            <c:if test="${not empty attrGroupProxy.dicValueMap[attrDict.innerCode].valueString}">
                                                <span>
                                                        ${attrDict.name}
                                                </span>
                                                <p>
                                                    <c:if test="${!empty attrGroupProxy.dicValueMap}">
                                                        ${attrGroupProxy.dicValueMap[attrDict.innerCode].valueString}
                                                    </c:if>
                                                </p>
                                            </c:if>
                                        </div>
                                    </c:forEach>
                                </c:if>
                            </c:forEach>
                        </c:if>
                    </div>
                    <div class="shuoms-box" id="productSpecification" style="display: none">
                        <c:if test="${not empty productProxy.specification}">
                            ${productProxy.specification}
                        </c:if>
                    </div>
                    <div class="pingjia-box" style="display: none" id="productComment">
                        <div class="mt">
                            <a rel="" href="javascript:void(0);" class="cur">全部(${commentStatistics.total > 0 ?commentStatistics.total : 0})</a>
                            <a rel="good" href="javascript:void(0);">好评(${commentStatistics.good > 0 ? commentStatistics.good : 0})</a>
                            <a rel="normal" href="javascript:void(0);">中评(${commentStatistics.normal > 0 ? commentStatistics.normal : 0})</a>
                            <a rel="bad" href="javascript:void(0);">差评(${commentStatistics.bad > 0 ? commentStatistics.bad : 0})</a>
                        </div>
                        <div class="mc" id="commentDiv">
                            <c:choose>
                                <c:when test="${not empty commentProxyResult}">
                                    <c:forEach items="${commentProxyResult}" var="commentProxy" varStatus="status">
                                        <div class="item" commentIndex='${status.index}'>
                                            <div class="mc-top">
                                                <div class="pic"><img src="${commentProxy.icon['40X40']}" alt=""></div>
                                                <div class="user-name">
                                                    <c:set value="${fn:substring(commentProxy.loginId, 0,1)}" var="mobileHeader"/><%-- 用户名第一位 --%>
                                                    <c:set value="${fn:substring(commentProxy.loginId, fn:length(commentProxy.loginId) - 1,fn:length(commentProxy.loginId))}" var="mobileStern"/><%-- 用户名最后一位 --%>
                                                    <span>${mobileHeader}***${mobileStern}</span>
                                                    <i class="comment-item-star"><i class="real-star comment-stars-width${commentProxy.score}"></i></i>
                                                </div>
                                                <em>${commentProxy.createTimeString}</em>
                                            </div>
                                            <p>${commentProxy.content}</p>
                                            <c:set var="pics" value="${commentProxy.pics}"/>
                                            <c:set value="${fn:length(pics)}" var="commentPicsLength"/>
                                            <c:if test="${not empty pics}">
                                                <div class="cm-pic <c:if test="${commentPicsLength eq '4'}">four-pic</c:if>">
                                                    <c:forEach var="commentPic" items="${pics}">
                                                        <div class="pic-box">
                                                            <img src="${commentPic}" alt=""><input class="bigPic" type="hidden" value="${commentPic}">
                                                        </div>
                                                    </c:forEach>
                                                </div>
                                            </c:if>
                                            <c:if test="${not empty commentProxy.commentReplys}">
                                                <c:forEach items="${commentProxy.commentReplys}" var="reply">
                                                    <div class="reply">客服回复：${reply.commentCont}</div>
                                                </c:forEach>
                                            </c:if>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <%-- <c:otherwise>
                                     <div style="padding-top:1.8rem; text-align: center; font-size: 1.5rem; color:#666; ">
                                         暂无评价
                                     </div>
                                 </c:otherwise>--%>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div id="tipsDiv" class="rem-get" style="display: none;" ><span id="tipsSpan"></span></div>
        <div class="qk-nav">
            <div class="mask-layer nav-block" style="display: none;"></div>
            <span id="navBtn">快速<br/>导航</span>
            <div class="qk-box nav-block" style="display: none;">
                <a href="${webRoot}/wap/index.ac" class="m-index"><img src="${webRoot}/template/bdw/wap/statics/images/shouye.png" alt=""></a>
                <a href="${webRoot}/wap/newSearch.ac" class="m-search"><img src="${webRoot}/template/bdw/wap/statics/images/sousuo2.png" alt=""></a>
                <c:choose>
                    <c:when test="${empty loginUser}">
                        <a href="${webRoot}/wap/login.ac" class="m-my"><img src="${webRoot}/template/bdw/wap/statics/images/wode.png" alt=""></a>
                    </c:when>
                    <c:otherwise>
                        <a href="javascript:void(0);" class="m-my" onclick="window.location.href='${webRoot}/wap/module/member/index.ac?time='+ new Date().getTime();"><img src="${webRoot}/template/bdw/wap/statics/images/wode.png" alt=""></a>
                    </c:otherwise>
                </c:choose>
                <a href="javascript:void(0);" class="m-share" onclick="showOrHideShare()"><img src="${webRoot}/template/bdw/wap/statics/images/fenxiang.png" alt=""></a>
            </div>
        </div>
        <c:choose>
            <c:when test="${isWeixin=='Y'}">
                <div class="share-layer"  style="display: none;" id="share" onclick="showOrHideShare()">
                    <div class="share-box"><img src="${webRoot}/template/bdw/wap/statics/images/share390x186.png" alt=""></div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="copy-modal copy-fade copy-in" id="sysMsg" style="display: none;">
                    <div class="copy-modal-dropback"></div>
                    <div class="copy-modal-dialog">
                        <div class="copy-modal-content">
                            <div class="copy-modal-header">
                                <h4 class="copy-modal-title">长按复制链接</h4>
                            </div>
                            <div class="copy-modal-body" id="shareUrl">${shareUrl}</div>
                            <div class="copy-modal-footer">
                                <a class="copy-btn-link" href="javascript:$('#sysMsg').hide();">关闭</a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>

        <div class="dt-bot">
            <c:choose>
                <c:when test="${empty loginUser}">
                    <a href="${webRoot}/wap/login.ac" class="zx-btn">售前咨询</a>
                    <a href="${webRoot}/wap/login.ac" class="my-cart"><c:if test="${productProxy.isNormal!='Y'}">购物车</c:if><c:if test="${productProxy.isNormal=='Y'}">预定单</c:if></a>
                    <a href="${webRoot}/wap/login.ac" class="cart"><c:if test="${productProxy.isNormal!='Y'}">加入购物车</c:if><c:if test="${productProxy.isNormal=='Y'}">加入预定单</c:if></a>
                    <a href="${webRoot}/wap/login.ac" class="buy"><c:if test="${productProxy.isNormal!='Y'}">立即购买</c:if><c:if test="${productProxy.isNormal=='Y'}">立即预定</c:if></a>
                </c:when>
                <c:otherwise>
                    <c:choose>
                        <c:when test="${productProxy.isNormal == 'Y'}">
                            <a href="${webRoot}/wap/presale/preSaleList.ac?productId=${param.id}" class="zx-btn">售前咨询</a>
                            <a href="javascript:void(0);" class="my-cart" onclick="window.location.href='${webRoot}/wap/shoppingcart/drugCart.ac?carttype=drug&handler=drug&pIndex=cart&time='+ new Date().getTime()">预定单<span class="cartNum">${drugProxy.allCartNum}</span></a>
                            <a href="javascript:void(0);" class="cart" skuid="${productProxy.isEnableMultiSpec=='Y' ?  '': productProxy.skus[0].skuId}"  num="1" carttype="drug" handler="drug" onclick="addToCartOrBuyNow(this, false)">加入预定单</a>
                            <a href="javascript:void(0);" class="buy" skuid="${productProxy.isEnableMultiSpec=='Y' ?  '': productProxy.skus[0].skuId}"  num="1" carttype="drug" handler="drug" onclick="addToCartOrBuyNow(this, true)">立即预定</a>
                        </c:when>
                        <c:otherwise>
                            <a href="${webRoot}/wap/presale/preSaleList.ac?productId=${param.id}" class="zx-btn">售前咨询</a>
                            <a href="javascript:void(0);" class="my-cart" onclick="window.location.href='${webRoot}/wap/shoppingcart/cart.ac?pIndex=cart&time='+ new Date().getTime()">购物车<span class="cartNum">${normalProxy.allCartNum}</span></a>
                            <a href="javascript:void(0);" class="cart" skuid="${productProxy.isEnableMultiSpec=='Y' ?  '': productProxy.skus[0].skuId}"  num="1" carttype="normal" handler="sku" onclick="addToCartOrBuyNow(this, false)">加入购物车</a>
                            <a href="javascript:void(0);" class="buy" skuid="${productProxy.isEnableMultiSpec=='Y' ?  '': productProxy.skus[0].skuId}"  num="1" carttype="normal" handler="sku" onclick="addToCartOrBuyNow(this, true)">立即购买</a>
                        </c:otherwise>
                    </c:choose>
                </c:otherwise>
            </c:choose>
        </div>

        <nav id="page-nav">
            <a href="${webRoot}/wap/loadProductComments.ac?id=${param.id}"></a>
        </nav>
        <!-- 评论查看大图 -->
        <div id="bigPicLayer" class="big-pic-layer" style="display: none">
            <div class="swiper-container big-pic-box">
                <div class="swiper-wrapper" id="wrapperId" >
                    <%--此处自动加载图片详情--%>
                </div>
                <div class="swiper-pagination swiper-pagination3"></div>
            </div>
        </div>
        <div id="loadDiv" >  </div>

        <c:choose>
            <c:when test="${empty shopInf.images[0]['']}">
                <c:set var="imgUrl" value="${wapUrl}/template/bdw/wap/statics/images/pic460x460.jpg"/>
            </c:when>
            <c:otherwise>
                <c:set var="imgUrl" value="${shopInf.images[0]['']}"/>
            </c:otherwise>
        </c:choose>
        <script type="text/javascript">
            var desc = "${productProxy.salePoint}";
            if(!desc){
                desc = "商品名称：${productProxy.name},生产厂家：${productProxy.factory}，规格：${productProxy.specNm}，单位：${productProxy.productUnit}"
            }
            var webPath = {
                isCollect: '${productProxy.collect}',
                isSpecialPrice: '${productProxy.price.isSpecialPrice}',
                productId: "${param.id}",
                webRoot: "${webRoot}",
                wapUrl: "${wapUrl}",
                isWeixin: "${isWeixin}",
                shareUrl: "${shareUrl}",
                title: '${productProxy.name}',
                desc: desc,
                imgUrl: '${productProxy.defaultImage['100X100']}',
                lastPageNumber: ${commentProxyPage.lastPageNumber},
                cps:'${empty param.cps ? 0:1}',
                commentProxys:'${commentProxyPage.result}',

                weixinJsConfig: {
                    jsApiList: [
                        'onMenuShareTimeline',      //分享到朋友圈
                        'onMenuShareAppMessage',    //发送给朋友
                        'onMenuShareQQ',            //分享到QQ
                        'onMenuShareQZone'          //分享到 QQ 空间
                    ]
                }
            }
        </script>

        <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js"></script>
        <script src="${webRoot}/template/bdw/wap/statics/js/swiper.min.js"></script>
        <script src="${webRoot}/template/bdw/wap/statics/js/jquery.infinitescroll.min.js" type="text/javascript"></script>
        <c:if test="${isWeixin=='Y'}">
            <script src="${webRoot}/template/bdw/wap/statics/js/jweixin-1.2.0.js"></script>
            <script src="${webRoot}/template/bdw/wap/statics/js/weixinJsConfigInit.js"></script>
            <script src="${webRoot}/template/bdw/wap/statics/js/productShare.js"></script>
        </c:if>
        <script src="${webRoot}/template/bdw/wap/statics/js/product.js"></script>

    <script>
        $(document).ready(function () {
            //抢购倒计时
            var today = new Date();
            var timeBox = $("#remTime");
            if(webPath.isSpecialPrice == "true"){
                //倒计时总秒数量
                var endTime = new Date(Date.parse(timeBox.attr("endTimeStr").replace(/-/g,"/"))).getTime();
                var totalSecond = (endTime - today.getTime())/1000;
                timer(totalSecond);
                timeBox.show();
            }
        });
    </script>

    </body>
</html>

