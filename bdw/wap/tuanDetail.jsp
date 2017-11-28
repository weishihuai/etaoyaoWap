<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<c:set value="${sdk:findGroupBuyProxy(param.id)}" var="groupBuy"/>
<c:set value="${groupBuy.groupBuySkuProxyListJson}" var="skuIds"/>
<c:set var="productProxy" value="${sdk:getProductById(groupBuy.productId)}"/>

<c:if test="${empty productProxy}">
    <c:redirect url="/wap/index.ac"></c:redirect>
</c:if>

<%--获取当前用户--%>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>

<c:set value="4" var="limit"/>
<%--商品评论统计信息--%>
<c:set var="commentStatistics" value="${productProxy.commentStatistics}"/>
<%--商品评论--%>
<c:set var="commentProxyPage" value="${sdk:findProductComments(param.id,6)}"/>
<c:set var="commentProxyResult" value="${commentProxyPage.result}"/>
<c:set var="limit" value="6"/>

<%-- 获取当前商家 --%>
<c:set value="${sdk:getShopInfProxyById(productProxy.shopInfId)}" var="shopInf"/>
<%-- 获取店铺所有商品的数量 --%>
<c:set value="${bdw:getTotalProductNum(shopInf.sysOrgId)}" var="totalProductNum"/>
<c:set value="${webUrl}/wap/tuanDetail.ac?id=${param.id}" var="signUrl"/>

<jsp:useBean id="systemTime" class="java.util.Date" />

<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="utf-8">
    <title>团购详情-${webName}</title>
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="telephone=no,email=no" name="format-detection">
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-2.1.4.min.js"></script>

    <link href="${webRoot}/template/bdw/wap/statics/css/swiper.min.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/statics/css/tuanDetail.css" type="text/css" rel="stylesheet" />
    <c:if test="${isWeixin!='Y'}">
        <link href="${webRoot}/template/bdw/wap/statics/css/product-detail-share.css" type="text/css" rel="stylesheet" />
    </c:if>
</head>

<body>
<div class="m-top">
    <a href="javascript:history.go(-1);" class="back"></a>
    <span>团购详情</span>
</div>
<div class="dt-main">
    <div class="swiper-container product-tab">
        <div class="swiper-wrapper">
            <div class="swiper-slide">
                <a href="javascript:void(0);"><img src="${groupBuy.pic['']}" alt=""></a>
            </div>
        </div>
    </div>
    <c:set value="${groupBuy.price.unitPrice}" var="unitPrice"/>
    <%
        Double doublePrice = (Double) pageContext.getAttribute("unitPrice");
        String priceStr = String.valueOf(doublePrice);
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
        <%--未开始、进行中的团购显示倒计时--%>
        <c:choose>
            <c:when test="${systemTime.time - groupBuy.startTime.time >= 0 && systemTime.time - groupBuy.endTime.time < 0}"><%--正在进行的团购--%>
                <div class="time-box" style="display: none;" id="remTime" countDownStr="${groupBuy.endTimeString}">
                    <div class="time-box-l">
                        <em>限时购</em>
                        <p class="price">￥<span>${integerPrice}</span>.${decimalPrice}</p>
                        <p class="old-price">¥${groupBuy.orgPrice}</p>
                    </div>
                    <div class="time-box-r" id="timeBox1">距团购结束剩余<br><span>00</span><i>天</i><span>00</span><i>:</i><span>00</span><i>:</i><span>00</span></div>
                </div>
            </c:when>
            <c:when test="${systemTime.time - groupBuy.startTime.time < 0 }"><%--未开始的团购--%>
                <div class="time-box" style="display: none;" id="remTime" countDownStr="${groupBuy.startTimeString}">
                    <div class="time-box-l">
                        <em>限时购</em>
                        <p class="price">￥<span>${integerPrice}</span>.${decimalPrice}</p>
                        <p class="old-price">¥${groupBuy.orgPrice}</p>
                    </div>
                    <div class="time-box-r" id="timeBox2">距团购开始剩余<br><span>00</span><i>天</i><span>00</span><i>:</i><span>00</span><i>:</i><span>00</span></div>
                </div>
            </c:when>
        </c:choose>
    <div class="product-info">
        <%--<p class="price">￥<span>${groupBuy.price.unitPrice}</span></p>--%>
        <%--<p class="market-price"><span>市场价:</span>${groupBuy.orgPrice}</p>--%>
        <a class="name" href="javascript:void(0);">${groupBuy.title}</a>
    </div>

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
                <span>描述相符 <i>${shopInf.shopRatingAvgVo.productDescrSame}</i></span>
                <span>服务态度 <i>${shopInf.shopRatingAvgVo.sellerServiceAttitude}</i></span>
                <span>物流速度 <i>${shopInf.shopRatingAvgVo.sellerSendOutSpeed}</i></span>
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
                <li style="width: 33%;" onclick="showTab('productGraphicDetail',this)" class="cur"><a href="javascript:void(0);">图文详情</a></li>
                <li style="width: 33%;" onclick="showTab('productParams',this)"><a href="javascript:void(0);">产品参数</a></li>
                <li style="width: 33%;" onclick="showTab('productComment',this)"><a href="javascript:void(0);">评价</a>
                    <c:if test="${commentStatistics.total > 0}">
                        <span>${commentStatistics.total}</span>
                    </c:if>
                </li>
            </ul>
        </div>
        <div class="mc" style="min-height: 3rem;">
            <div class="pic-box" id="productGraphicDetail">
                <c:if test="${not empty groupBuy.description}">
                    ${groupBuy.description}
                </c:if>
            </div>
            <div class="parameter-box" id="productParams" style="display: none">
                <c:if test="${not empty productProxy.attrGroupProxyList}">
                    <c:forEach items="${productProxy.attrGroupProxyList}" var="attrGroupProxy">
                        <c:if test="${fn:length(attrGroupProxy.dicValues)>0 && attrGroupProxy.attrGroupNm != '通用属性组'}">
                            <c:forEach items="${attrGroupProxy.dicValues}" var="attrDict">
                                <div class="item">
                                    <c:if test="${not empty attrGroupProxy.dicValueMap[attrDict.innerCode].valueString}">
                                        <span>${attrDict.name}</span>
                                        <p><c:if test="${!empty attrGroupProxy.dicValueMap}">${attrGroupProxy.dicValueMap[attrDict.innerCode].valueString}</c:if></p>
                                    </c:if>
                                </div>
                            </c:forEach>
                        </c:if>
                    </c:forEach>
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
                            <c:forEach items="${commentProxyResult}" var="commentProxy" varStatus="s">
                                <div class="item">
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
                                    <c:set var="commentPics" value="${commentProxy.commentPics}"/>
                                    <c:set value="${fn:length(commentPics)}" var="commentPicsLength"/>
                                    <c:if test="${not empty commentPics}">
                                        <div class="cm-pic <c:if test="${commentPicsLength eq '4'}">four-pic</c:if>">
                                            <c:forEach var="commentPic" items="${commentPics}">
                                                <div class="pic-box"><img src="${commentPic}" alt=""></div>
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
                    <div class="copy-modal-body" id="shareUrl"></div>
                    <div class="copy-modal-footer">
                        <a class="copy-btn-link" href="javascript:$('#sysMsg').hide();">关闭</a>
                    </div>
                </div>
            </div>
        </div>
    </c:otherwise>
</c:choose>

<div class="dt-bot group-buy">
    <c:choose>
        <c:when test="${systemTime.time >= groupBuy.startTime.time && systemTime.time < groupBuy.endTime.time}"><%--正在进行的团购--%>
            <a id="buy-now"  class="group-buy-btn" href="javascript:;" carttype="groupBuy" handler="groupBuy" objectid="">立即团购</a>
        </c:when>
        <c:when test="${systemTime.time < groupBuy.startTime.time}"><%--未开始的团购--%>
            <a href="javascript:;" class="group-buy-btn">团购即将开始</a>
        </c:when>
        <c:otherwise>
            <a href="javascript:;" class="group-buy-btn">团购已结束</a>
        </c:otherwise>
    </c:choose>
</div>

<nav id="page-nav">
    <a href="${webRoot}/wap/loadProductComments.ac?id=${productProxy.productId}"></a>
</nav>

<c:choose>
    <c:when test="${empty shopInf.images[0]['']}">
        <c:set var="imgUrl" value="${webUrl}/template/bdw/wap/statics/images/pic460x460.jpg"/>
    </c:when>
    <c:otherwise>
        <c:set var="imgUrl" value="${shopInf.images[0]['']}"/>
    </c:otherwise>
</c:choose>
<script type="text/javascript">
    var webPath = {
        skuIds : '${skuIds}',
        productId: "${productProxy.productId}",
        groupBuyId: "${param.id}",
        webRoot: "${webRoot}",
        webUrl: "${webUrl}",
        isWeixin: "${isWeixin}",
        shareUrl: '${signUrl}',
        imgUrl: '${imgUrl}',
        lastPageNumber: ${commentProxyPage.lastPageNumber},
        endTimeStr : '${groupBuy.endTimeString}',
        startTimeStr : '${groupBuy.startTimeString}',
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
<script src="${webRoot}/template/bdw/wap/statics/js/tuanDetail.js"></script>

<script type="text/javascript">
    $(document).ready(function () {
        //团购倒计时
        var remTime = $("#remTime");
        var today = new Date();
        var startTime = new Date(Date.parse(webPath.startTimeStr.replace(/-/g,"/"))).getTime();
        var endTime = new Date(Date.parse(webPath.endTimeStr.replace(/-/g,"/"))).getTime();
        var nowTime = today.getTime();
        var countDownTime = new Date(Date.parse(remTime.attr("countDownStr").replace(/-/g,"/"))).getTime();
        var totalSecond = (countDownTime - nowTime)/1000;
        if(startTime < nowTime && endTime > nowTime){
            timer(totalSecond,'groupBuyIN');
        } else if(startTime > nowTime && endTime > nowTime){
            timer(totalSecond,'previewGroupBuy');
        }
        remTime.show();
    });
</script>

</body>
</html>

